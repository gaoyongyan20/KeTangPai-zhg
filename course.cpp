// 课程对象实体
#include "course.h"

Course::Course(QObject *parent)
    : QObject(parent)
{}

QJsonObject Course::toJson() const
{
    return {{"course_id", m_id},
            {"course_name", m_name},
            {"class_name", m_className},
            {"teacher_id", m_teacherId}};
}

Course *Course::fromJson(const QJsonObject &json, QObject *parent)
{
    Course *course = new Course(parent);
    course->setId(json["course_id"].toInt());
    course->setName(json["course_name"].toString());
    course->setclassName(json["class_name"].toString());
    course->setTeacherId(json["teacher_id"].toInt());
    return course;
}

int Course::id() const
{
    return m_id;
}

void Course::setId(const int &id)
{
    if (id != m_id) {
        m_id = id;
        emit idChanged();
    }
}

QString Course::name() const
{
    return m_name;
}

void Course::setName(const QString &name)
{
    if (name != m_name) {
        m_name = name;
        emit nameChanged();
    }
}

QString Course::className() const
{
    return m_className;
}

void Course::setclassName(const QString &classname)
{
    if (classname != m_className) {
        m_className = classname;
        emit classNameChanged();
    }
}

int Course::teacherId() const
{
    return m_teacherId;
}

void Course::setTeacherId(const int &teacherid)
{
    if (teacherid != m_teacherId) {
        m_teacherId = teacherid;
        emit teacherIdChanged();
    }
}
