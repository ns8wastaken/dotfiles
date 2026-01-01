import Quickshell
import QtQuick
import qs.Widgets
import qs.Config

Scope {
    FontLoader {
        id: bgTextFont
        source: Config.shellFont("HanyiSentyScholar.ttf")
    }

    BackgroundText {
        anchors {
            right: true
            bottom: true
        }

        margins {
            right: 50
            bottom: 50
        }

        text.text: "吃\n喝\n拉\n撒\n睡"
        text.color: "#000000"
        text.font.family: bgTextFont.name
        text.font.pointSize: 40
    }

    BackgroundText {
        anchors {
            right: true
            bottom: true
        }

        margins {
            right: 120
            bottom: 50
        }

        text.text: "我\n操\n你\n妈"
        text.color: "#000000"
        text.font.family: bgTextFont.name
        text.font.pointSize: 40
    }

    BackgroundText {
        anchors {
            right: true
            bottom: true
        }

        margins {
            right: 190
            bottom: 50
        }

        text.text: "自\n强\n不\n息"
        text.color: "#000000"
        text.font.family: bgTextFont.name
        text.font.pointSize: 40
    }
}
