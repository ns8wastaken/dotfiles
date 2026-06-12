pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import Quickshell.Wayland

PanelWindow {
    id: root

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    color: "transparent"

    // Give the window an empty mask so all clicks pass through it.
    mask: Region {}

    WlrLayershell.layer: WlrLayer.Background

    property color col: "#000000"

    // BackgroundText {
    //     anchors.right: parent.right
    //     anchors.bottom: parent.bottom
    //     anchors.rightMargin: 50
    //     anchors.bottomMargin: 50
    //
    //     text.text: "吃\n喝\n拉\n撒\n睡"
    // }
    //
    // BackgroundText {
    //     anchors.right: parent.right
    //     anchors.bottom: parent.bottom
    //     anchors.rightMargin: 120
    //     anchors.bottomMargin: 50
    //
    //     text.text: "我\n操\n你\n妈"
    // }
    //
    // BackgroundText {
    //     anchors.right: parent.right
    //     anchors.bottom: parent.bottom
    //     anchors.rightMargin: 190
    //     anchors.bottomMargin: 50
    //
    //     text.text: "自\n强\n不\n息"
    // }

    component BackgroundText: Item {
        id: item

        property alias text: bgText

        width: bgText.width
        height: bgText.height

        Text {
            id: bgText

            color: root.col
            font.family: "Zhi Mang Xing"
            font.pointSize: 32
        }
    }

    CText { str: "庄\n子\n妻\n死\n，\n惠\n子\n吊\n之\n，\n庄\n子\n则\n方\n箕\n踞\n鼓\n盆\n而\n歌\n。\n惠\n子"; margin: 0; }
    CText { str: "曰\n：\n「\n与\n人\n居\n，\n长\n子\n老\n身\n，\n死\n不\n哭\n亦\n足\n矣\n，\n又\n鼓\n盆\n而"; margin: 60; }
    CText { str: "歌\n，\n不\n亦\n甚\n乎\n？\n」\n庄\n子\n曰\n：\n「\n不\n然\n。\n是\n其\n始\n死\n \n也\n，"; margin: 120; }
    CText { str: "我\n独\n何\n能\n无\n慨\n然\n！\n察\n其\n始\n而\n本\n无\n生\n；\n非\n徒\n无\n生\n也\n，\n而"; margin: 180; }
    CText { str: "本\n无\n形\n；\n非\n徒\n无\n形\n也\n，\n而\n本\n无\n气\n。\n杂\n乎\n芒\n芴\n之\n间\n，\n变"; margin: 240; }
    CText { str: "而\n有\n气\n，\n气\n变\n而\n有\n形\n，\n形\n变\n而\n有\n生\n，\n今\n又\n双\n而\n之\n死\n，"; margin: 300; }
    CText { str: "是\n相\n与\n为\n春\n秋\n冬\n夏\n四\n时\n行\n也\n。\n人\n且\n偃\n然\n寝\n于\n巨\n室\n，\n而"; margin: 360; }
    CText { str: "我\n嗷\n嗷\n然\n随\n而\n哭\n之\n，\n自\n以\n为\n不\n通\n乎\n命\n，\n故\n止\n也\n。"; margin: 420; }

    component CText: Item {
        id: item

        required property string str
        required property int margin

        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 20
        anchors.rightMargin: 20 + margin

        width: bgText.width
        height: bgText.height

        Text {
            id: bgText

            text: item.str
            color: root.col
            font.family: "Zhi Mang Xing"
            font.pointSize: 32
        }
    }
}
