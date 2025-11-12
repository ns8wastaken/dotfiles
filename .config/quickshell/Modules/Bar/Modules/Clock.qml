import QtQuick
import qs.Settings
import qs.Services

Item {
    Text {
        anchors.centerIn: parent

        text: Time.time
        color: Theme.textPrimary
        font.pixelSize: Settings.fontSizeNormal
        font.family: Settings.fontFamily
    }
}
