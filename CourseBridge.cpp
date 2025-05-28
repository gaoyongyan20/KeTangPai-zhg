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

void CourseBridge::loadCoursesFor(int student_id)
{
    qDebug() << "hh";
    qDebug() << student_id;
    if (!m_service) {
        qDebug() << "CourseService not initialized";
        return;
    }

    QJsonArray arr = m_service->getCoursesesJsonForStudent(student_id);
    m_jsonResoult = QJsonDocument(arr).toJson(QJsonDocument::Compact);
    emit coursesLoaded(m_jsonResoult);
    qDebug() << arr;
}
