import QtQuick
import QtQuick.Controls

Page {
    id:homeworkDetail_student

    signal popHomework()

    header: Rectangle{
        width:parent.width
        height: 35
        Text{
            text:"   <                                  作业详情"
            anchors.verticalCenter: parent.verticalCenter
        }
        MouseArea{
            anchors.fill: parent
            onClicked:{
                popHomework()
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
                width: homeworkDetail_student.width
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
                            text:"  作业截至时间"
                            font.pixelSize: 10

                        }
                        Text{
                            text:"  个人作业"
                            font.pixelSize: 10
                        }
                        Text{
                            text:"  分数"
                            font.pixelSize: 10
                        }
                    }
                }
            }

            //作业的发布者简介
            Rectangle{
                width: homeworkDetail_student.width
                height: 30
                color:"lightgrey"
                Row{
                    spacing: 20
                    anchors.verticalCenter: parent.verticalCenter
                    Text{
                        text:"  作者创建于"
                        font.pixelSize: 10
                    }
                    Text{
                        text:"创建日期"
                        font.pixelSize: 10
                    }
                    Text{
                        text:"创建具体时间"
                        font.pixelSize: 10
                    }
                }
            }

            //作业评价
            Rectangle{
                width: homeworkDetail_student.width
                height: 200
                color: "blue"
            }
        }
    }
    footer:Rectangle{
        id:submit_and_comment
        width: homeworkDetail_student.width
        height: 40
        color: "grey"
        Row{
            anchors.fill: parent
            Rectangle{
                width: submit_and_comment.width*0.3
                height: submit_and_comment.height
                color: "white"
                Text{
                    text:"发表评论"
                    anchors.centerIn: parent
                }
            }
            Rectangle{
                width: submit_and_comment.width*0.7
                height: submit_and_comment.height
                color: "blue"
                Text{
                    text:"提交作业"
                    anchors.centerIn: parent
                }
            }
        }
    }
}
