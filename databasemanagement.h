// 数据管理层，访问数据库
#pragma once
#include <QJsonObject>
#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QVariant>

class DatabaseManagement : public QObject
{
    Q_OBJECT
public:
    static DatabaseManagement &instance(); // 单例
    // QVariantList可以存储各种不同类型的对象
    QSqlQuery execute(const QString &sql, const QVariantList &parms = {}); // 执行查询操作
    bool connectToDatabase();                                              // 连接数据库

    //身份验证
    bool identityVerification(const QString &role,
                              const QString &account,
                              const QString &password,
                              QJsonObject &userData);
    // 执行创建课程操作
    bool createCourse(const QString &name,
                      const QString &classname,
                      const QString &joinCode,
                      const int &teacherId);
    // 判断加课码是否存在
    bool isJoinCodeExists(const QString &courseCode);

private:
    explicit DatabaseManagement(QObject *parent = nullptr); // 单例模式要求私有构造方法，公共静态方法
    QSqlDatabase m_db;
};
