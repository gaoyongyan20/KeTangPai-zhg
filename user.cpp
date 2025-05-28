#include "user.h"

User::User(QObject* parent)
    : QObject(parent)
    , m_name("")
{}

QString User::name() const
{
    return m_name;
}
void User::setName(const QString& name)
{
    if (m_name != name) {
        m_name = name;
        emit nameChanged();
    }
}

int User::id() const
{
    return user_id;
}
void User::setId(const int& id)
{
    if (user_id != id) {
        user_id = id;
        emit idChanged();
    }
}
