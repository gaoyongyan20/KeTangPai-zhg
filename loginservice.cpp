// 处理登录的业务逻辑
#include "loginservice.h"
#include <QDebug>
#include <QJsonObject> // 封装了一个JSON对象
#include <QJsonParseError>
#include <QSqlQuery>
#include "databasemanagement.h"

LoginService::LoginService(QObject *parent)
    : QObject{parent}
{}

QHttpServerResponse LoginService::handleLogin(const QHttpServerRequest &request)
{
    //创建一个错误对象，用于记录JSON解析过程中的错误（如格式错误）。
    QJsonParseError parseError;
    //request.body()    获取HTTP请求的原始Body数据（通常是JSON字符串，如 {"username":"admin"}）.
    //QJsonDocument::fromJson()    将JSON字符串解析为Qt可操作的QJsonDocument对象
    //&parseError    传递错误对象的指针，如果解析失败，错误详情会存入parseError。
    QJsonDocument doc = QJsonDocument::fromJson(request.body(), &parseError);

    // 错误检查
    if (parseError.error != QJsonParseError::NoError || !doc.isObject()) {
        return errorResponse("请求格式错误");
    }

    QJsonObject obj = doc.object(); // 返回doc文档中包含的JSON对象
    QString role = obj.value("role").toString();
    QString account = obj.value("account").toString();
    QString password = obj.value("password").toString();

    QJsonObject userData;
    bool success = DatabaseManagement::instance().identityVerification(role,
                                                                       account,
                                                                       password,
                                                                       userData);

    QJsonObject res;
    res["status"] = success ? "success" : "error";
    if (success) {
        res["userData"] = userData; // 包含完整记录
    } else {
        return errorResponse("未找到匹配的用户记录");
    }
    return QHttpServerResponse("application/json", QJsonDocument(res).toJson());
}

QHttpServerResponse LoginService::errorResponse(const QString &message)
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
