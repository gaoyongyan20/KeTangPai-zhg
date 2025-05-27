// 处理课程相关的业务逻辑
// 2025-5-26
#include "courseservice.h"
#include <QJsonDocument> // 提供读写JSON文档的方法
#include <QJsonObject>   // 封装了一个JSON对象
#include <QRandomGenerator>
#include "databasemanagement.h"
#include <algorithm>

CourseService::CourseService(QObject *parent)
    : QObject(parent)
{}

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
QHttpServerResponse CourseService::errorResponse(const QString &message)
{
    QJsonObject res;
    res["status"] = "error";
    res["message"] = message;
    QJsonDocument doc(res);
    // 第三个参数是状态码，这里返回的状态码表示的是客户端的错误请求
    return QHttpServerResponse("application/json",
                               doc.toJson(),
                               QHttpServerResponder::StatusCode::BadRequest);
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
