import QtQuick
import QtQuick.Controls

Item {
    //学生在在首页点击加入课程后弹出的对话框
    property alias joinCourseDialog_student: _joinCourseDialog_student
    //学生在在首页点击加入课程后弹出的对话框中， 取消按钮
    property alias cancelJoinCourse_student: _cancelJoinCourse_student
    //老师在在首页点击加入课程后弹出的对话框
    property alias joinCourseDialog_teacher: _joinCourseDialog_teacher
    //老师在在首页点击加入课程后弹出的对话框中， 取消按钮
    property alias cancelJoinCourse_teacher: _cancelJoinCourse_teacher
    //当学生点击加入课程，页面会弹出输入课程码的页面
    signal displayCourseCode
    //老师点击创建课程按钮
    signal createCourse

    //学生当点击加入课程按钮时，显示加入课程对话框
    Dialog {
        id: _joinCourseDialog_student
        opacity: 0.8
        Column {
            spacing: 10
            //这个Rectangle只是为了设置透明度，无其它作用
            Rectangle {
                width: 500
                height: 435
                color: "black"
                opacity: 0.7
            }
            //加入课程的弹出页面中  加入课程 按钮
            Button {
                width: 500
                height: 40
                contentItem: Text {
                    text: "加入课程"
                    horizontalAlignment: Text.AlignHCenter // 水平居中
                    verticalAlignment: Text.AlignVCenter // 垂直居中
                    anchors.fill: parent // 填满按钮区域
                }
                onClicked: displayCourseCode()
            }
            //加入课程的弹出页面中  归档管理 按钮
            Button {
                width: 500
                height: 40
                contentItem: Text {
                    text: "归档管理"
                    horizontalAlignment: Text.AlignHCenter // 水平居中
                    verticalAlignment: Text.AlignVCenter // 垂直居中
                    anchors.fill: parent // 填满按钮区域
                }
            }
            //加入课程的弹出页面中 取消 按钮，已实现
            Button {
                id: _cancelJoinCourse_student
                width: 500
                height: 40
                contentItem: Text {
                    text: "取消"
                    horizontalAlignment: Text.AlignHCenter // 水平居中
                    verticalAlignment: Text.AlignVCenter // 垂直居中
                    anchors.fill: parent // 填满按钮区域
                }
            }
        }
    }

    //老师当点击加入课程按钮时，显示加入课程对话框
    Dialog {
        id: _joinCourseDialog_teacher
        opacity: 0.8
        Column {
            spacing: 10
            //这个Rectangle只是为了设置透明度，无其它作用
            Rectangle {
                width: 500
                height: 390
                color: "black"
                opacity: 0.7
            }
            //加入课程的弹出页面中  加入课程 按钮
            Button {
                width: 500
                height: 40
                contentItem: Text {
                    text: "创建课程"
                    horizontalAlignment: Text.AlignHCenter // 水平居中
                    verticalAlignment: Text.AlignVCenter // 垂直居中
                    anchors.fill: parent // 填满按钮区域
                }
                onClicked: {
                    createCourse()
                }
            }
            //加入课程的弹出页面中  加入课程 按钮
            Button {
                width: 500
                height: 40
                contentItem: Text {
                    text: "加入课程"
                    horizontalAlignment: Text.AlignHCenter // 水平居中
                    verticalAlignment: Text.AlignVCenter // 垂直居中
                    anchors.fill: parent // 填满按钮区域
                }
                onClicked: displayCourseCode()
            }
            //加入课程的弹出页面中  归档管理 按钮
            Button {
                width: 500
                height: 40
                contentItem: Text {
                    text: "归档管理"
                    horizontalAlignment: Text.AlignHCenter // 水平居中
                    verticalAlignment: Text.AlignVCenter // 垂直居中
                    anchors.fill: parent // 填满按钮区域
                }
            }
            //加入课程的弹出页面中 取消 按钮，已实现
            Button {
                id: _cancelJoinCourse_teacher
                width: 500
                height: 40
                contentItem: Text {
                    text: "取消"
                    horizontalAlignment: Text.AlignHCenter // 水平居中
                    verticalAlignment: Text.AlignVCenter // 垂直居中
                    anchors.fill: parent // 填满按钮区域
                }
            }
        }
    }
}
