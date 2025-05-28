// 处理登录的业务逻辑
#pragma once

#include <QHttpServerRequest>
#include <QHttpServerResponse>
#include <QObject>

class LoginService : public QObject
{
    Q_OBJECT
public:
    explicit LoginService(QObject *parent = nullptr);
    QHttpServerResponse handleLogin(const QHttpServerRequest &request);

private:
    QHttpServerResponse errorResponse(const QString &message);
};
