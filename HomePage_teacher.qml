//HomePage_teacher,老师首页界面
//高永艳
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Page {
    property alias text: _text
    id: _homePage_student

    //学生当点击加入课程时，发出信号-以显示加入课程页面
    signal joinCourses_student
    //老师当点击加入课程时，发出信号-以显示加入课程页面
    signal joinCourses_teacher
    //点击顶置课程的区域会触发这个信号
    signal clickCourse_teacher
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ColumnLayout {
        //-----------------------------
        //置顶课程
        Rectangle {
            id: sticky_Course
            width: 500
            height: 150
            //--------------------------------------------------------------------------
            //记录置顶课程文本显示和加入课程按钮
            RowLayout {
                id: show
                spacing: 280
                anchors.top: sticky_Course.top
                anchors.topMargin: 10
                //置顶课程文本显示
                Rectangle {
                    width: 100
                    height: 30
                    Text {
                        text: qsTr("置顶课程")
                        font.pixelSize: 20
                        anchors.centerIn: parent
                    }
                }
                //加入课程按钮
                Button {
                    width: 100
                    height: 30
                    // 内容文本（已经正确居中）
                    contentItem: Text {
                        id: _text
                        text: "创建/加入课程"
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter // 水平居中
                        verticalAlignment: Text.AlignVCenter // 垂直居中
                        anchors.fill: parent // 填满按钮区域
                    }
                    // 背景样式
                    background: Rectangle {
                        color: "#1e90ff"
                        radius: 20
                        implicitWidth: 100 // 建议使用implicitWidth/Height
                        implicitHeight: 30
                    }
                    //当学生点击加入课程时，发出信号-以显示四个选择的对话框
                    onClicked: joinCourses_teacher()
                }
            }
            //--------------------------------------------------------------------------------------
            //滚动置顶课程
            Rectangle {
                width: 500
                height: parent.height - show.implicitHeight
                anchors.top: show.bottom
                anchors.topMargin: 10
                ScrollView {
                    anchors.fill: parent
                    ScrollBar.horizontal.policy: ScrollBar.AlwaysOn
                    ScrollBar.vertical.policy: ScrollBar.AlwaysOff
                    ListView {
                        orientation: ListView.Horizontal
                        width: 20
                        height: parent.height
                        spacing: 10
                        model: 5
                        // ListModel {}
                        delegate: ListDelegate {}
                    }
                    component ListDelegate: Rectangle {
                        id: course
                        width: 140
                        height: parent.height
                        color: Qt.rgba(Math.random(), Math.random(),
                                       Math.random(), 1)
                        TapHandler {
                            onTapped: clickCourse_teacher()
                        }
                        Column {
                            //存放课程图片，因为资源文件不太可以，所以
                            Rectangle {
                                width: 140
                                height: 80
                                Text {
                                    text: "这里存放课程图片"
                                }
                                color: "#1e90ff"
                                Button {
                                    text: ":"
                                    anchors.right: parent.right
                                    width: 20
                                    height: 20
                                    background: Rectangle {
                                        color: "#1e90ff"
                                    }
                                }
                            }
                            //显示课程名称
                            Text {
                                //后续使用id修改text
                                id: courseName
                                text: qsTr("课程名称")
                            }
                            //显示课程所属班级
                            Text {
                                //后续使用id修改text
                                id: classs
                                text: qsTr("课程所属班级")
                            }
                        }
                    }
                }
            }
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //页脚
    footer: Rectangle {
        Layout.alignment: Qt.AlignBottom
        implicitHeight: 35
        RowLayout {
            spacing: 65
            anchors.top: parent.top
            anchors.topMargin: 5
            //首页
            Button {
                contentItem: Text {
                    text: "首页"
                    horizontalAlignment: Text.AlignHCenter // 水平居中
                    verticalAlignment: Text.AlignVCenter // 垂直居中
                    anchors.fill: parent // 填满按钮区域
                }
                // 背景样式
                background: Rectangle {
                    implicitWidth: 30
                    implicitHeight: 30
                }
                Layout.alignment: Qt.AlignLeft
                Layout.leftMargin: 18
            }
            //代办按钮
            Button {
                contentItem: Text {
                    text: "代办"
                    horizontalAlignment: Text.AlignHCenter // 水平居中
                    verticalAlignment: Text.AlignVCenter // 垂直居中
                    anchors.fill: parent // 填满按钮区域
                }
                // 背景样式
                background: Rectangle {
                    implicitWidth: 30
                    implicitHeight: 30
                }
                Layout.alignment: Qt.AlignLeft
            }
            //课堂按钮
            Button {
                contentItem: Text {
                    text: "课堂"
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter // 水平居中
                    verticalAlignment: Text.AlignVCenter // 垂直居中
                    anchors.fill: parent // 填满按钮区域
                }
                // 背景样式
                background: Rectangle {
                    color: "black"
                    opacity: 0.7
                    implicitWidth: 30
                    implicitHeight: 30
                }
                Layout.alignment: Qt.AlignLeft
            }

            //私信按钮
            Button {
                contentItem: Text {
                    text: "私信"
                    horizontalAlignment: Text.AlignHCenter // 水平居中
                    verticalAlignment: Text.AlignVCenter // 垂直居中
                    anchors.fill: parent // 填满按钮区域
                }
                // 背景样式
                background: Rectangle {
                    implicitWidth: 30
                    implicitHeight: 30
                }
                Layout.alignment: Qt.AlignRight
            }
            //我的按钮
            Button {
                contentItem: Text {
                    text: "我的"
                    horizontalAlignment: Text.AlignHCenter // 水平居中
                    verticalAlignment: Text.AlignVCenter // 垂直居中
                    anchors.fill: parent // 填满按钮区域
                }
                // 背景样式
                background: Rectangle {
                    implicitWidth: 30
                    implicitHeight: 30
                }
                Layout.alignment: Qt.AlignRight
            }
        }
    }
}
