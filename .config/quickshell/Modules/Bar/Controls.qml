import QtQuick
import qs.Components
import qs.Settings
import qs.Modules.Bar.Controls

Pill {
    id: controls

    property int padding: 8
    property int spacing: 6

    implicitWidth: row.implicitWidth
    implicitHeight: 18

    color: Theme.surface

    MouseArea {
        id: mouseArea

        hoverEnabled: true
        anchors.fill: parent
    }

    Row {
        id: row

        anchors.fill: parent
        leftPadding: parent.padding
        rightPadding: parent.padding
        spacing: parent.spacing

        Network {}
        Audio {}
    }
}
