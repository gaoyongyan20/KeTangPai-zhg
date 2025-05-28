//author: 周杨康丽
import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

Page {
    id:submithomework

    signal exitThisPage()

    header:Rectangle{
        width:parent.width
        height: 35
        Text {
            text: qsTr("   <                                  提交作业")
             anchors.verticalCenter: parent.verticalCenter
        }
        TapHandler{
            onTapped:{
                exitThisPage()
            }
        }
        Button{
            id:submit
            text:"提交"
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            background: Rectangle{
                color:"blue"
            }
            contentItem: Text {
                text:submit.text
                color: "white"
                font.pixelSize: 12
            }
            onClicked: {
                console.log("已提交")
            }
        }
    }

    Rectangle{
        width: parent.width
        height: parent.height

        Column{
            spacing: 5
            //作业的简介
            Rectangle{
                width: submithomework.width
                height: 70
                color: "grey"
                Column{
                    spacing: 10
                    Text {
                        text:"  作业简介："
                        font.pixelSize: 30
                    }
                    Row{
                        spacing: 20
                        Text{
                            text:"  个人作业|"
                            font.pixelSize: 10

                        }
                        Text{
                            text:"  作业截至时间"
                            font.pixelSize: 10
                        }
                    }
                    Text{
                        text:"  *系统默认查看"
                        font.pixelSize: 10
                    }
                }
            }

            //提交详情
            Rectangle{
                id:submit_detail
                width: submithomework.width
                height: 30
                color:"lightgrey"
                Row{
                    Rectangle{
                        width: submit_detail.width*0.5
                        height: submit_detail.height
                        Text{
                            text:"  提交详情"
                            font.pixelSize: 10
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    Rectangle{
                        width: submit_detail.width*0.5
                        height: submit_detail.height
                        Text{
                            text:"  看谁提交了       >"
                            font.pixelSize: 10
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            color: "blue"
                        }
                    }
                }
            }

            //添加作业
            Rectangle{
                width: submithomework.width
                height: 400

                Column{
                        Text{
                            text:"提交作业"
                        }
                        Text{
                            text:"*作业必须以附件的方式提交"
                            color:"orange"
                        }
                        Image{
                            width: 100
                            height: 100
                            clip: true
                            source: "qrc:/fujian.png"
                            fillMode: Image.Stretch  // 拉伸填充

                            FileDialog {
                                   id: selectHomework
                                   title: "选择作业文件"
                                   nameFilters: ["所有文件 (*.*)", "文档 (*.doc *.docx *.pdf)", "图片 (*.jpg *.png)"]

                                   onAccepted: {
                                       console.log("选择的文件:", selectedFiles)
                                       console.log("选择的文件:", selectedFiles.toString().substring(7))
                                   }

                                   onRejected: {
                                       console.log("用户取消选择")
                                   }
                               }
                            TapHandler{
                                onTapped: {
                                    selectHomework.open()
                                }
                            }
                        }
                        Text{
                            text: "作业留言"
                        }
                        TextArea{
                            width:submithomework.width-20
                            height: 200
                            placeholderText: "添加留言，作业要以附件的形式提交,而不是写在留言里"    // 占位提示文本
                            color: "black"                     // 文本颜色
                            font.pointSize: 12
                            // 可选：设置自动换行
                            wrapMode: TextEdit.Wrap

                            // 自定义背景（纯色 + 边框）
                            background: Rectangle {
                                color: "lightgrey"    // 浅灰色背景
                                border.color: "black"
                                border.width: 1
                                radius: 4
                            }

                        }
                }
            }
        }
    }



}
