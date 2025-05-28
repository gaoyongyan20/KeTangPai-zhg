// <<<<<<< HEAD
// // 这是一个用户实体类
// #pragma once
// #include <QObject>

// class User : public QObject
// {
//     Q_OBJECT
//     Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
//     Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)

// public:
//     User(QObject* parent = nullptr);
//     //用户名的获取与设置
//     QString name() const;
//     Q_INVOKABLE void setName(const QString&);

//     //用户id的获取和设置
//     int id() const;
//     Q_INVOKABLE void setId(const int&);

// signals:
//     void nameChanged();
//     void idChanged();

// private:
//     QString m_name;
//     int user_id;
// };
// =======
// user.h
#ifndef USER_H
#define USER_H

#include <QDateTime>
#include <QObject>
#include <QString>
class User : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int userId READ userId WRITE setUserId NOTIFY userIdChanged)
    Q_PROPERTY(QString account READ account WRITE setAccount NOTIFY accountChanged)
    Q_PROPERTY(QString password READ password WRITE setPassword NOTIFY passwordChanged)
    Q_PROPERTY(QString role READ role WRITE setRole NOTIFY roleChanged)
    Q_PROPERTY(QDateTime created_at READ created_at WRITE setCreatedAt NOTIFY created_atChanged)

public:
    ~User();
    User(QObject *parent = nullptr);
    // Getters
    Q_INVOKABLE int userId() const;
    Q_INVOKABLE QString account() const;
    Q_INVOKABLE QString password() const;
    Q_INVOKABLE QString role() const;
    Q_INVOKABLE QDateTime created_at() const;

    // Setters
    void setUserId(int userId);
    void setAccount(const QString &account);
    void setPassword(const QString &password);
    void setRole(const QString &role);
    void setCreatedAt(const QDateTime &createdAt);

    Q_INVOKABLE void clear();            // 清空用户数据
    Q_INVOKABLE bool isLoggedIn() const; // 判断用户是否已登录

signals:
    void userIdChanged();
    void accountChanged();
    void passwordChanged();
    void roleChanged();
    void created_atChanged();

private:
    Q_DISABLE_COPY(User) // 禁止拷贝

    int m_userId;
    QString m_account;
    QString m_password;
    QString m_role;
    QDateTime m_createdAt;
};

#endif // USER_H
