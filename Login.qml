// 登录界面
// date: 2025-5-9 author:何泳珊
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    // 老师登录成功后发出的信号
    signal teacherLoginSuccessfully
    // 学生登录成功后发出的信号
    signal studentLoginSuccessfully

    background: Rectangle {
        width: parent.width
        height: parent.height
        // color: "yellow"
        opacity: 0.5
    }
    Rectangle {
        anchors.centerIn: parent
        width: layout.width + 50 // 留出边距
        height: layout.height + 50
        color: "transparent" // 透明背景
        border.color: "lightgray" // 边框颜色
        border.width: 1 // 边框宽度
        radius: 10 // 圆角（可选）
        ColumnLayout {
            id: layout
            anchors.centerIn: parent
            Label {
                Layout.alignment: Qt.AlignCenter
                text: "账号登录"
                font.pixelSize: 24
                font.bold: true
            }
            RowLayout {
                spacing: 35
                RadioButton {
                    id: choose_teacher
                    checked: true
                    text: qsTr("老师")
                    font.pixelSize: 18
                }
                RadioButton {
                    id: choose_student
                    text: qsTr("学生")
                    font.pixelSize: 18
                }
            }
            ColumnLayout {
                spacing: 15
                TextField {
                    placeholderText: qsTr("请输入邮箱/账号/手机号")
                    placeholderTextColor: "grey"
                    Layout.fillWidth: true // 填充父布局宽度
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 30
                }
                TextField {
                    placeholderText: "请输入密码"
                    placeholderTextColor: "grey"
                    Layout.fillWidth: true // 填充父布局宽度
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 30
                }
                Button {
                    text: "登录"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 30
                    // 正确设置文字颜色的方式
                    contentItem: Text {
                        text: parent.text
                        font: parent.font
                        color: "white" // 这里设置文字颜色
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                    background: Rectangle {
                        color: parent.enabled ? "#1E90FF" : "gray"
                        border.color: "#1E90FF"
                        opacity: parent.pressed ? 0.7 : 1.0
                        radius: 5
                    }
                    onClicked: choose_teacher.checked
                               === true ? teacherLoginSuccessfully(
                                              ) : studentLoginSuccessfully()
                }
            }
        }
    }
}
