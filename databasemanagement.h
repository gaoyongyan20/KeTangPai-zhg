#pragma once
#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QVariant>

class DatabaseManagement : public QObject
{
    Q_OBJECT
public:
    static DatabaseManagement &instance(); // 单例
    bool connect();                        // 连接数据库
    // QVariantList可以存储各种不同类型的对象
    QSqlQuery execute(const QString &sql, const QVariantList &parms = {}); // 执行查询操作

private:
    explicit DatabaseManagement(QObject *parent = nullptr); // 单例模式要求私有构造方法，公共静态方法
    QSqlDatabase m_db;
};
