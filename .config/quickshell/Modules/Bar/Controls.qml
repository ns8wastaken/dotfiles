import QtQuick
import qs.Modules.Bar.Controls
import qs.Components
import qs.Theme

Pill {
    id: controls

    width: row.implicitWidth
    height: 18

    color: Theme.color.primary_container

    MouseArea {
        id: mouseArea

        hoverEnabled: true
        anchors.fill: parent
    }

    Row {
        id: row

        property int padding: 8

        anchors.fill: parent
        leftPadding: padding
        rightPadding: padding
        spacing: Theme.spacing.normal

        Audio { anchors.verticalCenter: parent.verticalCenter }
        Microphone { anchors.verticalCenter: parent.verticalCenter }
        Network { anchors.verticalCenter: parent.verticalCenter }
    }
}
