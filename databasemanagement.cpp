#include "databasemanagement.h"
#include <QSqlError>

DatabaseManagement::DatabaseManagement(QObject *parent)
    : QObject(parent)
{}

DatabaseManagement &DatabaseManagement::instance()
{
    static DatabaseManagement _instance;
    return _instance;
}

bool DatabaseManagement::connect()
{
    m_db = QSqlDatabase::addDatabase("QODBC");
    m_db.setDatabaseName("DRIVER={MariaDB ODBC 3.1 Driver};" // 驱动名必须与ini文件严格一致
                         "SERVER=localhost;"
                         "DATABASE=KeTangPai;" // 修改为ini中的数据库名
                         "USER=mysql;"         // 修改为ini中的用户名
                         "PASSWORD=root;"      // 修改为ini中的密码
                         "PORT=3306;"
                         "OPTION=3;" // 添加ini中的Option参数
    );

    if (m_db.open()) {
        qDebug() << "数据库连接成功!";
        return true;
    } else {
        qDebug() << "数据库连接失败:" << m_db.lastError().text();
        return false;
    }
}

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
            if (!connect()) {
                qCritical() << "数据库重连失败";
            }
        }
    }

    return query;
}
