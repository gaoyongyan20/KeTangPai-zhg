// 课程对象实体
// 2025-5-26

#pragma once

#include <QJsonObject>
#include <QObject>
#include <QQmlEngine>

class Course : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString className READ className WRITE setclassName NOTIFY classNameChanged FINAL)
    Q_PROPERTY(int teacherId READ teacherId WRITE setTeacherId NOTIFY teacherIdChanged FINAL)
public:
    explicit Course(QObject *parent = nullptr);
    // JSON转换方法
    Q_INVOKABLE QJsonObject toJson() const; // 转换为json
    // json转换
    Q_INVOKABLE static Course *fromJson(const QJsonObject &json, QObject *parent = nullptr);

    // setter & getter函数
    int id() const;
    void setId(const int &id);

    QString name() const;
    void setName(const QString &name);

    QString className() const;
    void setclassName(const QString &classname);

    int teacherId() const;
    void setTeacherId(const int &teacherid);

signals:
    void idChanged();
    void nameChanged();
    void classNameChanged();
    void teacherIdChanged();

private:
    int m_id;            // 课程id
    QString m_name;      // 课程名
    QString m_className; // 班级名
    QString m_code;      // 加课码
    // QString m_description; // 课程描述
    int m_teacherId; // 教师id
    // 创建时间
};
