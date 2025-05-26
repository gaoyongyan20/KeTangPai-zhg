#pragma once

#include <QJsonObject>
#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
class DatabaseManagement : public QObject
{
    Q_OBJECT
public:
    static DatabaseManagement &instance(); // 单例
    bool connectToDatabase();
    //身份验证
    bool identityVerification(const QString &role,
                              const QString &account,
                              const QString &password,
                              QJsonObject &userData);

signals:

private:
    QSqlDatabase m_db;
    explicit DatabaseManagement(QObject *parent = nullptr); // 单例模式要求私有构造方法，公共静态方法
};
