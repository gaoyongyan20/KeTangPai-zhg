#include "databasemanagement.h"
#include <QJsonArray>
#include <QSqlDriver>
#include <QSqlError>
#include <QSqlRecord>
DatabaseManagement::DatabaseManagement(QObject *parent)
    : QObject{parent}
{}

//将数据库设置为单例
DatabaseManagement &DatabaseManagement::instance()
{
    static DatabaseManagement _instance;
    return _instance;
}

//连接数据库
bool DatabaseManagement::connectToDatabase()
{
    m_db = QSqlDatabase::addDatabase("QODBC");
    m_db.setDatabaseName("DRIVER={MariaDB ODBC 3.1 Driver};"
                         "SERVER=localhost;"
                         "DATABASE=KeTangPai;"
                         "UID=mysql;"
                         "PWD=root;");

    if (m_db.open()) {
        qDebug() << "数据库连接成功!";
        return true;
    } else {
        qDebug() << "数据库连接失败:" << m_db.lastError().text();
        return false;
    }
}
//用户身份验证
bool DatabaseManagement::identityVerification(const QString &role,
                                              const QString &account,
                                              const QString &password,
                                              QJsonObject &userData)
{
    QSqlQuery query;
    query.prepare("SELECT * FROM users WHERE role = ? AND account = ? AND password = ?");

    // 按顺序绑定参数
    query.addBindValue(role);
    query.addBindValue(account);
    query.addBindValue(password);

    if (!query.exec()) {
        qDebug() << "查询执行失败:" << query.lastError().text();
        return false;
    }

    // 检查是否有结果
    if (query.next()) {
        // 将查询结果转换为 JSON 对象
        QSqlRecord record = query.record();
        for (int i = 0; i < record.count(); ++i) {
            userData[record.fieldName(i)] = QJsonValue::fromVariant(record.value(i));
        }
        return true;
    } else {
        qDebug() << "未找到匹配的用户记录";
        return false;
    }
}
