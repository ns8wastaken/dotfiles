import QtQuick
import qs.Modules.Bar.Controls
import qs.Components
import qs.Theme

Pill {
    id: controls

    property int padding: 8
    property int spacing: 6

    width: row.implicitWidth
    height: 18

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
