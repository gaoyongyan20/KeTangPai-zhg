//这里是用来处理课程相关的请求 向数据库加入东西
#include "courseservice.h"
#include <QDebug>
#include <QJsonArray>
#include <QJsonDocument> // 提供读写JSON文档的方法
#include <QJsonObject>   // 封装了一个JSON对象
#include "databasemanagement.h"

CourseService::CourseService(QObject *parent)
    : QObject(parent)
{}
//接受一个http请求
QHttpServerResponse CourseService::handleJoin(const QHttpServerRequest &request)
{
    QJsonParseError parseError; // 报告JSON解析过程中的错误

    // 解析json数据（这里解析http请求中的请求内容），如果解析失败，就把失败的信息存储到parseError中
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
        return successResponse(user_id, course_code); // 传入role参数
    } else {
        return errorResponse(message);
    }
}

QPair<bool, QString> CourseService::checkCredentials(const int &user_id, const QString &course_code)
{
    int courseId;

    //查课程表里面是不是有输入的课程码对应的课程id
    QSqlQuery query_course_id = DatabaseManagement::instance()
                                    .execute("SELECT course_id FROM courses WHERE course_code = ?",
                                             {course_code});

    if (query_course_id.next()) {
        courseId = query_course_id.value("course_id").toInt();
    }

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

    QString message = "成功添加学生到课程:";
    qDebug() << message;
    return QPair<bool, QString>(true, message);
}

QHttpServerResponse CourseService::successResponse(const int &user_id, const QString &course_code)
{
    QJsonObject res;
    res["status"] = "success";
    res["user_id"] = user_id;
    res["course_code"] = course_code;

    QJsonDocument doc(res);

    // 返回JSON响应
    return QHttpServerResponse("application/json", doc.toJson());
}

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
