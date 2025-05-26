// user.cpp
#include "user.h"

User::User(QObject *parent)
    : QObject(parent)
{}

User::~User() {}

int User::userId() const
{
    return m_userId;
}

QString User::account() const
{
    return m_account;
}

QString User::password() const
{
    return m_password;
}

QString User::role() const
{
    return m_role;
}

QDateTime User::created_at() const
{
    return m_createdAt;
}

void User::setUserId(int userId)
{
    if (m_userId == userId)
        return;
    m_userId = userId;
    emit userIdChanged();
}

void User::setAccount(const QString &account)
{
    if (m_account == account)
        return;
    m_account = account;
    emit accountChanged();
}

void User::setPassword(const QString &password)
{
    if (m_password == password)
        return;
    m_password = password;
    emit passwordChanged();
}

void User::setRole(const QString &role)
{
    if (m_role == role)
        return;
    m_role = role;
    emit roleChanged();
}
void User::setCreatedAt(const QDateTime &createdAt)
{
    if (m_createdAt == createdAt)
        return;
    m_createdAt = createdAt;
    emit created_atChanged();
}

void User::clear()
{
    setUserId(0);
    setAccount("");
    setPassword("");
    setRole("");
    setCreatedAt(QDateTime());
}

bool User::isLoggedIn() const
{
    return !m_account.isEmpty();
}
