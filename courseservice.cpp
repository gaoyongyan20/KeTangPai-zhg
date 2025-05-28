// 处理课程相关的业务逻辑
// 2025-5-26

#include "courseservice.h"
#include <QDebug>
#include <QJsonArray>
#include <QJsonDocument>    // 提供读写JSON文档的方法
#include <QJsonObject>      // 封装了一个JSON对象
#include <QRandomGenerator> // 随机数生成器
#include <QSqlError>
#include "databasemanagement.h"
#include <algorithm>

CourseService::CourseService(QObject *parent)
    : QObject(parent)
{}

// 处理创建课程的逻辑
QHttpServerResponse CourseService::handleCreateCourse(const QHttpServerRequest &request)
{
    QJsonParseError parseError; // 报告JSON解析过程中的错误
        // 解析json数据（这里解析http请求中的请求内容），如果解析失败，就把失败的信息存储到parseError中
    QJsonDocument doc = QJsonDocument::fromJson(request.body(), &parseError);

    // 错误检查
    if (parseError.error != QJsonParseError::NoError || !doc.isObject()) {
        return errorResponse("请求格式错误");
    }

    QJsonObject obj = doc.object(); // 返回doc文档中包含的JSON对象
    QString name = obj["course_name"].toString();
    QString classname = obj["class_name"].toString();
    int teacherid = obj["teacher_id"].toInt();

    // 随机生成加课码-确保生成的加课码唯一
    QString result;
    int maxAttempts = 10; // 防止无限循环的安全措施
    do {
        result = generateJoinCode();
        if (--maxAttempts <= 0) {
            qWarning() << "随机生成加课码失败！";
            break;
        }
    } while (DatabaseManagement::instance().isJoinCodeExists(result));
    QString courseCode = result;

    // 执行sql语句进行插入操作
    bool success = DatabaseManagement::instance().createCourse(name,
                                                               classname,
                                                               courseCode,
                                                               teacherid);

    QJsonObject res;
    if (success) // 执行成功
    {
        res["status"] = "success";
    } else {
        res["status"] = "failure";
    }

    return QHttpServerResponse("application/json", QJsonDocument(res).toJson());
}

// 处理加入课程的业务逻辑
QHttpServerResponse CourseService::handleJoin(const QHttpServerRequest &request)
{
    QJsonParseError parseError; // 报告JSON解析过程中的错误
    QJsonDocument doc = QJsonDocument::fromJson(request.body(), &parseError);

    // 错误检查
    if (parseError.error != QJsonParseError::NoError || !doc.isObject()) {
        return errorResponse("请求格式错误");
    }

    QJsonObject obj = doc.object(); // 返回doc文档中包含的JSON对象
    int user_id = obj.value("user_id").toInt();
    qDebug() << "用户是：";
    qDebug() << user_id;
    QString course_code = obj.value("course_code").toString();
    qDebug() << course_code;

    auto [success, message] = checkCredentials(user_id, course_code);

    if (success) {
        return successResponse();
    } else {
        return errorResponse(message);
    }
}
// 处理加入课程查询数据库的返回数据
QPair<bool, QString> CourseService::checkCredentials(const int &user_id, const QString &course_code)
{
    int courseId = -1;

    //查课程表里面是不是有输入的课程码对应的课程id
    QSqlQuery query_course_id = DatabaseManagement::instance()
                                    .execute("SELECT course_id FROM courses WHERE course_code = ?",
                                             {course_code});

    if (!query_course_id.next()) {
        // 课程码不存在，返回错误
        return QPair<bool, QString>(false, "课程码不存在");
    }

    courseId = query_course_id.value("course_id").toInt();
    qDebug() << "课程代码对应的ID是:" << courseId;

    qDebug() << "检查用户是否已选课: user_id =" << user_id << ", course_id =" << courseId;

    //再检查关联是否存在
    QSqlQuery checkQuery = DatabaseManagement::instance().execute(
        "SELECT 1 FROM course_students WHERE student_id = ? AND course_id = ?", {user_id, courseId});

    if (checkQuery.next()) {
        QString message = "该用户已加入此课程:";
        qDebug() << message;
        return QPair<bool, QString>(false, message);
    }

    QSqlQuery insertQuery = DatabaseManagement::instance().execute(
        "INSERT INTO course_students (student_id, course_id) VALUES (?, ?)", {user_id, courseId});
    if (!insertQuery.isActive()) {
        // 插入失败（如外键约束错误），返回具体错误信息
        return QPair<bool, QString>(false, "加入课程失败：" + insertQuery.lastError().text());
    }
    QString message = "成功添加学生到课程:";
    qDebug() << message;
    return QPair<bool, QString>(true, message);
}
// 加入课程成功返回的响应
QHttpServerResponse CourseService::successResponse()
{
    QJsonObject res;
    res["status"] = "success";

    QJsonDocument doc(res);

    // 返回JSON响应
    return QHttpServerResponse("application/json", doc.toJson());
}
// 加入课程失败返回的响应
QHttpServerResponse CourseService::errorResponse(const QString &message)
{
    QJsonObject res;
    res["status"] = "error";
    res["message"] = message;
    QJsonDocument doc(res);
    // 第三个参数是状态码，这里返回的状态码表示的是客户端的错误请求
    return QHttpServerResponse(
        "application/json",
        doc.toJson(),
        QHttpServerResponder::StatusCode::BadRequest); //BadRequest（400），表示客户端请求错误
}

//----------------------------------------处理课程显示---------------------------------------------------
//学生界面课程详细信息显示
QJsonArray CourseService::getCoursesesJsonForStudent(int student_id)
{
    qDebug() << "hh";

    QJsonArray array;
    QSqlQuery queryCourses = DatabaseManagement::instance().execute(
        R"(
    SELECT
        c.course_id,
        c.course_name,
        c.course_code,
        c.class_name
    FROM
        course_students cs
    JOIN
        courses c ON cs.course_id = c.course_id
    WHERE
        cs.student_id = ?;
    )",
        {student_id});

    while (queryCourses.next()) {
        QJsonObject obj;
        obj["course_id"] = queryCourses.value(0).toInt();
        obj["course_name"] = queryCourses.value(1).toString();
        obj["course_code"] = queryCourses.value(2).toString();
        obj["class_name"] = queryCourses.value(3).toString();
        array.append(obj);
    }
    return array;
}

//教师界面详细课程显示
QJsonArray CourseService::getCoursesesJsonForTeacher(int teacher_id)
{
    qDebug() << "hh";

    QJsonArray array;
    QSqlQuery queryCourses = DatabaseManagement::instance().execute(
        R"(
    SELECT
        c.course_id,
        c.course_name,
        c.course_code,
        c.class_name
    FROM
        courses c
    WHERE
        c.teacher_id = ?;
    )",
        {teacher_id});

    while (queryCourses.next()) {
        QJsonObject obj;
        obj["course_id"] = queryCourses.value(0).toInt();
        obj["course_name"] = queryCourses.value(1).toString();
        obj["course_code"] = queryCourses.value(2).toString();
        obj["class_name"] = queryCourses.value(3).toString();
        array.append(obj);
    }
    return array;
}

// 随机生成加课码
QString CourseService::generateJoinCode()
{
    // 确保至少包含一个数字、一个大写字母和一个小写字母
    const QString digits = "0123456789";
    const QString upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const QString lower = "abcdefghijklmnopqrstuvwxyz";
    const QString allChars = digits + upper + lower;

    // 初始化随机数生成器
    const auto &random = QRandomGenerator::global();

    // 先生成每种类型的一个字符
    QString result;
    result.append(digits.at(random->bounded(digits.size()))); // 数字
    result.append(upper.at(random->bounded(upper.size())));   // 大写字母
    result.append(lower.at(random->bounded(lower.size())));   // 小写字母

    // 生成剩余的字符
    const int remainingLength = 3;
    for (int i = 0; i < remainingLength; ++i) {
        result.append(allChars.at(random->bounded(allChars.size())));
    }

    // 随机打乱字符串顺序
    std::random_shuffle(result.begin(), result.end(), [&](int n) { return random->bounded(n); });

    return result;
}
