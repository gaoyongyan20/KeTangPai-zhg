//当学生在首页点击加入课程按钮后会弹出三个选择的对话框，其中一个选择是“加入课程”，当学生点击“加入课程”后会显示课程码页面
//本页为显示加入课程码页面
//高永艳
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    //退出本页面
    signal exitThisPage

    //返回按钮（绝对定位在左上角）
    header: Rectangle {
        Layout.alignment: Qt.AlignHCenter
        implicitHeight: 35
        border.color: "transparent"
        //单独的下边框
        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            height: 1 //边框高度
            color: "lightgrey"
        }
        Button {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: 5
            contentItem: Text {
                text: "<"
                horizontalAlignment: Text.AlignHCenter // 水平居中
                verticalAlignment: Text.AlignVCenter // 垂直居中
                anchors.fill: parent // 填满按钮区域
            }
            // 背景样式
            background: Rectangle {
                opacity: 0.1
                implicitWidth: 20
                implicitHeight: 30
            }
            onClicked: exitThisPage()
        }
        // 标题文本（绝对定位在顶部中间）
        Text {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 10
            text: qsTr("加入课程")
        }
    }
    //中间部分显示
    ColumnLayout {
        spacing: 15
        anchors.top: parent.top
        anchors.margins: 150
        anchors.left: parent.left
        Text {
            text: qsTr("输入课堂的6位加课码")
            font.pixelSize: 20
            Layout.alignment: Qt.AlignHCenter
        }
        Text {
            text: qsTr("也可以使用微信扫一扫扫描课堂二维码加入")
            Layout.alignment: Qt.AlignHCenter
            font.pixelSize: 12
            color: "grey"
        }
        //输入课程码
        RowLayout {
            id: inputRow
            spacing: 7
            Layout.alignment: Qt.AlignLeft
            property var fields: [] // 保存所有输入框引用
            //单个输入数字框
            Repeater {
                model: 6 // 有6个模型输入框
                Rectangle {
                    id: inputField
                    width: 30
                    height: 40
                    color: "transparent"
                    border.width: 1
                    //当这个框完成初始化后，将这个框加入其父的fileds,用于保存所有框的引用
                    Component.onCompleted: inputRow.fields.push(inputField)
                    TextInput {
                        id: textInput
                        anchors.fill: parent
                        anchors.margins: 6
                        font.pixelSize: 16
                        //限制用户只能输入1个数字
                        maximumLength: 1
                        //合法器：
                        validator: RegularExpressionValidator {
                            regularExpression: /^[a-zA-Z0-9]$/
                        }
                        horizontalAlignment: TextInput.AlignHCenter
                        verticalAlignment: TextInput.AlignVCenter
                        focus: index === 0 // 默认第一个获得焦点
                        // 输入后跳转到下一个
                        onTextChanged: {
                            //当前输入框已输入1个字符，且不是最后一个输入框（index从0开始，model总数为6
                            if (text.length === 1 && index < 5) {
                                //获取下一个textInput的焦点
                                inputRow.fields[index + 1].children[0].forceActiveFocus()
                                //--------------------------------------------------验证输入的课程码的正确性-----------------------------------------------------
                            } else if (index === 5 && text.length === 1) {
                                //当输入到第6个字符时（因为index从0开始，text.length=5表示第6个框有内容）
                                //验证输入的课程码的正确性
                                const courseCode = inputRow.fields.map(
                                                     field => field.children[0].text).join(
                                                     '')
                                console.log("完整课程码:", courseCode)
                                console.log("调试6位加课码都已全部输入")
                            }
                        }
                        //回退输入
                        Keys.onPressed: function (event) {
                            if (event.key === Qt.Key_Backspace) {
                                if (text.length === 0 && index > 0) {
                                    //当前输入框为空：跳转到前一个输入框并清空内容。
                                    if (inputRow.fields
                                            && inputRow.fields[index - 1]) {
                                        let prevField = inputRow.fields[index - 1].children[0]
                                        prevField.text = ""
                                        //延迟设置焦点
                                        Qt.callLater(() => {
                                                         prevField.forceActiveFocus()
                                                         prevField.cursorPosition = 1
                                                     })
                                    }
                                } else if (text.length > 0) {
                                    //当前输入框有内容：直接清空当前框内容
                                    text = "" // 清空当前字段
                                }
                                event.accepted = true
                            }
                        }
                    }
                }
            }
        }
    }
}
