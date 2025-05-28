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
    QPair<bool, QString> checkCredentials(const QString &username, const QString &password);
    QHttpServerResponse successResponse(const QString &username, const QString &role);
    QHttpServerResponse errorResponse(const QString &message);
};
