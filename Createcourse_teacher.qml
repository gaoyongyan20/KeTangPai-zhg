// 创建课程-老师界面
// date: 2025-5-9 author:何泳珊
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    // 退出创建课程时发出的信号
    signal exitCreateCoursePage
    header: Rectangle {
        id: header
        Layout.alignment: Qt.AlignHCenter
        implicitHeight: 35
        border.color: "transparent"
        // 单独的下边框
        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            height: 1 // 边框高度
            color: "lightgrey" // 下边框颜色
        }
        width: parent.width
        RowLayout {
            id: topLayout
            spacing: 200
            anchors.top: parent.top
            RoundButton {
                id: return_but
                icon.color: "black"
                contentItem: Text {
                    text: "<"
                    anchors.fill: parent
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                }

                background: Rectangle {
                    implicitHeight: 30
                    implicitWidth: 30
                    radius: 50
                    color: "transparent"
                    opacity: 0.9
                }
                onClicked: {
                    exitCreateCoursePage() // 发出信号
                    console.log("退出加入课程界面....")
                }
            }
            Label {
                text: "新建课程"
                Layout.alignment: Qt.AlignVCenter
            }
        }
    }
    Rectangle {
        id: content_rec
        height: parent.height
        width: parent.width
        ColumnLayout {
            width: parent.width
            spacing: 2
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: content_rec.width - 20
                Layout.preferredHeight: 40
                border.color: "transparent"
                // 设置边框颜色
                Rectangle {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: 0.5 // 边框高度
                    color: "lightgrey" // 下边框颜色
                }
                RowLayout {
                    width: parent.width
                    Label {
                        anchors.leftMargin: 5
                        text: "*"
                        color: "red"
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter // 左对齐+垂直居中
                    }
                    Label {
                        anchors.leftMargin: 5
                        text: "课堂名称"
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter // 左对齐+垂直居中
                    }
                    TextField {
                        id: courseName_field
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter // 右对齐+垂直居中
                        placeholderText: "请输入课堂名称"
                        placeholderTextColor: "grey"
                        Layout.fillWidth: true // 填充父布局宽度
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: 40
                        horizontalAlignment: Text.AlignRight // 文字右对齐
                        // 取消边框
                        background: Rectangle {
                            color: "transparent" // 透明背景
                            implicitHeight: 40
                        }
                    }
                }
            }
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: content_rec.width - 20
                Layout.preferredHeight: 40
                // 设置边框颜色
                Rectangle {
                    anchors.bottom: parent.bottom
                    height: 0.5 // 边框高度
                    width: parent.width
                    color: "lightgrey" // 下边框颜色
                }
                RowLayout {
                    width: parent.width
                    Label {
                        anchors.leftMargin: 5
                        text: "*"
                        color: "red"
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter // 左对齐+垂直居中
                    }
                    Label {
                        anchors.leftMargin: 5
                        text: "教学班级名称"
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter // 左对齐+垂直居中
                    }
                    TextField {
                        id: className_field
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter // 右对齐+垂直居中
                        placeholderText: "请输入教学班级名称"
                        placeholderTextColor: "grey"
                        Layout.fillWidth: true // 填充父布局宽度
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: 40
                        horizontalAlignment: Text.AlignRight // 文字右对齐
                        // 取消边框
                        background: Rectangle {
                            color: "transparent" // 透明背景
                            implicitHeight: 40
                        }
                    }
                }
            }
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: content_rec.width - 20
                Layout.preferredHeight: 40
                border.color: "transparent"
                // 设置边框颜色
                Rectangle {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: 0.5 // 边框高度
                    color: "lightgrey" // 下边框颜色
                }
                RowLayout {
                    width: parent.width
                    Label {
                        anchors.leftMargin: 5
                        text: "*"
                        color: "red"
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter // 左对齐+垂直居中
                    }
                    Label {
                        anchors.leftMargin: 5
                        text: "选择学年"
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter // 左对齐+垂直居中
                    }
                    Button {
                        id: chooseYear_but
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter // 右对齐+垂直居中
                        text: "请选择 > "
                        Layout.fillWidth: true // 填充父布局宽度
                        Layout.preferredWidth: parent.width
                        contentItem: Text {
                            text: parent.text
                            color: "grey"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignRight // 关键：文本右对齐
                        }
                        background: Rectangle {
                            implicitWidth: 100 // 设置按钮宽度
                            implicitHeight: 40 // 设置按钮高度
                            color: "transparent"
                        }
                    }
                }
            }
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: content_rec.width - 20
                Layout.preferredHeight: 40
                // border.color: "transparent"
                // 设置边框颜色
                Rectangle {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: 0.5 // 边框高度
                    color: "lightgrey" // 下边框颜色
                }
                RowLayout {
                    width: parent.width
                    Label {
                        anchors.leftMargin: 5
                        text: "*"
                        color: "red"
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter // 左对齐+垂直居中
                    }
                    Label {
                        anchors.leftMargin: 5
                        text: "选择学期"
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter // 左对齐+垂直居中
                    }
                    Button {
                        id: chooseTerm_but
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter // 右对齐+垂直居中
                        text: "请选择 > "
                        Layout.fillWidth: true // 填充父布局宽度
                        Layout.preferredWidth: parent.width
                        contentItem: Text {
                            text: parent.text
                            color: "grey"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignRight // 关键：文本右对齐
                        }
                        background: Rectangle {
                            implicitWidth: 100 // 设置按钮宽度
                            implicitHeight: 40 // 设置按钮高度
                            color: "transparent"
                        }
                    }
                }
            }
            Rectangle {
                color: "lightgrey"
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: content_rec.width
                Layout.preferredHeight: 500
                ColumnLayout {
                    width: parent.width
                    Rectangle {
                        color: "white"
                        height: 40
                        width: parent.width
                        // anchors.horizontalCenter: parent.horizontalCenter // 水平居中
                        Layout.topMargin: 10

                        RowLayout {
                            width: parent.width
                            // anchors.centerIn: parent
                            Label {
                                anchors.leftMargin: 5
                                text: "*"
                                color: "transparent"
                                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter // 左对齐+垂直居中
                            }
                            Label {
                                anchors.leftMargin: 5
                                text: "   更多信息"
                                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                                                  | Qt.AlignHCenter // 左对齐+垂直居中
                            }
                            Button {
                                id: moreInfo_but
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter // 右对齐+垂直居中
                                text: "﹀   "
                                Layout.fillWidth: true // 填充父布局宽度
                                Layout.preferredWidth: parent.width
                                contentItem: Text {
                                    text: parent.text
                                    color: "grey"
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignRight // 关键：文本右对齐
                                }
                                background: Rectangle {
                                    implicitWidth: 100 // 设置按钮宽度
                                    implicitHeight: 40 // 设置按钮高度
                                    color: "transparent"
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    footer: Button {
        anchors.leftMargin: 5
        text: "确认"
        width: content_rec - 20
        Layout.fillWidth: true
        Layout.preferredHeight: 200
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
        }
    }
}
