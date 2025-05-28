#include "loginservice.h"
#include <QDebug>
#include <QJsonDocument> // 提供读写JSON文档的方法
#include <QJsonObject>   // 封装了一个JSON对象
#include "databasemanagement.h"
LoginService::LoginService(QObject *parent)
    : QObject(parent)
{}

//处理登录请求的核心方法，接收一个 HTTP 请求，返回 HTTP 响应
QHttpServerResponse LoginService::handleLogin(const QHttpServerRequest &request)
{
    QJsonParseError parseError; // 报告JSON解析过程中的错误

    // 解析json数据（这里解析http请求中的请求内容），如果解析失败，就把失败的信息存储到parseError中
    QJsonDocument doc = QJsonDocument::fromJson(request.body(), &parseError);

    // 错误检查
    if (parseError.error != QJsonParseError::NoError || !doc.isObject()) {
        return errorResponse("请求格式错误");
    }

    QJsonObject obj = doc.object(); // 返回doc文档中包含的JSON对象
    QString username = obj.value("username").toString();
    QString password = obj.value("password").toString();

    auto [success, role] = checkCredentials(username, password);

    if (success) {
        return successResponse(username, role); // 传入role参数
    } else {
        return errorResponse("用户名或密码错误");
    }
    // if (checkCredentials(username, password)) {
    //     return successResponse(username);
    // } else {
    //     return errorResponse("用户名或密码错误");
    // }
}

QPair<bool, QString> LoginService::checkCredentials(const QString &username, const QString &password)
{
    // 模拟登录认证 - 这里可替换成查询数据库的相关操作，将查询后的结果与请求数据比较
    // return username == "student01" && password == "123456";

    QSqlQuery query = DatabaseManagement::instance()
                          .execute("SELECT role FROM users WHERE username=? AND password_hash=?",
                                   {username, password});

    // 将查询结果游标移动到第一条记录，对于COUNT查询，结果只有一行一列
    if (query.next()) {
        // int count = query.value(0).toInt(); // 因为是COUNT(*),所以第一列是计数值
        // return count > 0;
        QString role = query.value("role").toString();
        return QPair<bool, QString>(true, role); // 返回一个值的对，第一个返回
    }

    // return false;
    return QPair<bool, QString>(false, "");
}

QHttpServerResponse LoginService::successResponse(const QString &username, const QString &role)
{
    QJsonObject res;
    res["status"] = "success";
    res["user"] = username;
    res["role"] = role; // 添加角色字段
    QJsonDocument doc(res);
    // 返回JSON响应
    return QHttpServerResponse("application/json", doc.toJson());
}

QHttpServerResponse LoginService::errorResponse(const QString &message)
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
