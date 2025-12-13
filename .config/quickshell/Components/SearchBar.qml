import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Settings

Rectangle {
    id: searchBar
    implicitHeight: 50

    // radius: GlobalState.ThemeManager.radiusMedium
    // color: GlobalState.Colors.surface_variant
    // border.color: GlobalState.Colors.outline
    radius: 8
    color: Theme.backgroundPrimary
    border.color: Theme.outline
    border.width: 1

    RowLayout {
        anchors.fill: parent
        // anchors.margins: GlobalState.ThemeManager.spacingMedium
        // spacing: GlobalState.ThemeManager.spacingMedium
        anchors.margins: 8
        spacing: 8

        // Text {
        //     text: "🔍"
        //     // font.pixelSize: GlobalState.ThemeManager.fontSizeLarge
        //     font.pixelSize: 16
        //     Layout.alignment: Qt.AlignVCenter
        // }

        TextField {
            Layout.fillWidth: true
            placeholderText: "chicken"
            // font.family: GlobalState.ThemeManager.fontFamily
            // font.pixelSize: GlobalState.ThemeManager.fontSizeMedium
            font.pixelSize: 14
            background: Rectangle { color: "transparent" }
            onTextChanged: searchBar.textChanged(text)
        }
    }
}
