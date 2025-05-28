#include "CourseBridge.h"
#include <QDebug>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>

CourseBridge::CourseBridge(QObject *parent)
    : QObject(parent)
{
    initializeService(); // 构造时自动初始化服务
}

void CourseBridge::initializeService()
{
    m_service = new CourseService();
    // 可以在这里进行额外的初始化
}
// 学生界面调用了课程业务逻辑层获取课程相关信息
void CourseBridge::load_StudnetCoursesFor(int student_id)
{
    // qDebug() << "hh";
    qDebug() << student_id;
    if (!m_service) {
        qDebug() << "CourseService not initialized";
        return;
    }

    QJsonArray arr = m_service->getCoursesesJsonForStudent(student_id);
    m_jsonResoult = QJsonDocument(arr).toJson(QJsonDocument::Compact);
    emit studentCoursesLoaded(m_jsonResoult); // 直接把json数据发送给qml端
    qDebug() << " 查询到的课程数据： " << arr;
}

// 老师界面调用了课程业务逻辑层获取课程相关信息
void CourseBridge::load_TeacherCoursesFor(int teacher_id)
{
    // qDebug() << "hh";
    qDebug() << teacher_id;
    if (!m_service) {
        qDebug() << "CourseService not initialized";
        return;
    }

    QJsonArray arr = m_service->getCoursesesJsonForTeacher(teacher_id);
    m_jsonResoult = QJsonDocument(arr).toJson(QJsonDocument::Compact);
    emit teacherCoursesLoaded(m_jsonResoult); // 直接把json数据发送给qml端
    qDebug() << " 查询到的课程数据： " << arr;
}
