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
    m_db.setDatabaseName("DRIVER={MariaDB ODBC 3.1 Driver};" // 驱动名必须与ini文件严格一致
                         "SERVER=localhost;"
                         "DATABASE=KeTangPai;" // 修改为ini中的数据库名
                         "UID=mysql;"          // 修改为ini中的用户名
                         "PWD=root;");         // 修改为ini中的密码

    if (m_db.open()) {
        qDebug() << "数据库连接成功!";
        return true;
    } else {
        qDebug() << "数据库连接失败:" << m_db.lastError().text();
        return false;
    }
}
// 执行查询操作
QSqlQuery DatabaseManagement::execute(const QString &sql, const QVariantList &parms)
{
    QSqlQuery query;
    query.prepare(sql); // sql语句中占位符可以是？或者是：username
    for (int i = 0; i != parms.size(); i++) {
        // 将参数值绑定到预编译SQL的占位符
        query.bindValue(i, parms[i]);
    }
    // exec()表示执行sql语句
    if (!query.exec()) {
        qWarning() << "SQL执行失败" << query.lastError().text();

        // 特殊处理序列错误
        if (query.lastError().nativeErrorCode() == "S1010") {
            // 重置数据库连接
            m_db.close();
            if (!connectToDatabase()) {
                qCritical() << "数据库重连失败";
            }
        }
    }

    return query;
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

// 执行创建课程相关sql语句
bool DatabaseManagement::createCourse(const QString &name,
                                      const QString &classname,
                                      const QString &joinCode,
                                      const int &teacherId)
{
    QSqlQuery query;
    // :name - :是占位符的一种表现形式
    query.prepare(
        "INSERT INTO courses (course_name, course_code, class_name, teacher_id) VALUES (:name, "
        ":code, :classname, :teacherid)");
    query.bindValue(":name", name); // 将值绑定到占位符上
    query.bindValue(":code", joinCode);
    query.bindValue(":classname", classname);
    query.bindValue(":teacherid", teacherId); // 同上

    // // exec()表示执行sql语句
    // if (!query.exec()) {
    //     qWarning() << "SQL执行失败" << query.lastError().text();
    // }

    return query.exec(); // 返回bool值，true表示执行sql语句成功
}
// 判断加课码是否唯一
bool DatabaseManagement::isJoinCodeExists(const QString &courseCode)
{
    QSqlQuery query;
    query.prepare("SELECT COUNT(*) FROM courses WHERE course_code = ?");
    query.addBindValue(courseCode);

    if (!query.exec()) {
        qDebug() << "查询执行失败:" << query.lastError().text();
        return false;
    } // 如果查询出错，假设不存在

    // 如果查询成功
    if (query.next()) {
        return query.value(0).toInt() > 0;
    }
    // 查询出错的情况
    return false;
}
