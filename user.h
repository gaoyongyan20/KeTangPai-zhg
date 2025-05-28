// 这是一个用户实体类
#pragma once
#include <QObject>

class User : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)

public:
    User(QObject* parent = nullptr);
    //用户名的获取与设置
    QString name() const;
    Q_INVOKABLE void setName(const QString&);

    //用户id的获取和设置
    int id() const;
    Q_INVOKABLE void setId(const int&);

signals:
    void nameChanged();
    void idChanged();

private:
    QString m_name;
    int user_id;
};
