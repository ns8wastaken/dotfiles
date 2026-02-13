import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Modules.Bar.Clock
import qs.Components
import qs.Services
import qs.Theme

Popup {
    id: popup

    readonly property bool isHovered: popupHoverHandler.hovered

    visible: true

    closePolicy: Popup.NoAutoClose

    HoverHandler { id: popupHoverHandler }

    background: Rectangle {
        id: popupBg

        // color: Theme.color.surface
        color: popup.isHovered ? "red" : "blue"
        radius: 16
        border.color: Theme.color.outline
        border.width: 1
    }

    x: 1000
    y: 10

    padding: 6

    // enter: Transition {
    //     PropertyAnimation {
    //         property: "y"
    //         to: 30
    //     }
    // }
    //
    // exit: Transition {
    //     PropertyAnimation {
    //         property: "y"
    //         to: -300
    //     }
    // }

    ColumnLayout {
        id: innerPopup

        anchors.fill: parent

        RowLayout {
            spacing: 6
            Layout.alignment: Qt.AlignHCenter

            MaterialIcon {
                text: "calendar_month"
                font.pixelSize: Theme.fontSize.normal
                color: Theme.color.on_surface
            }

            Text {
                text: TimeService.format("dddd, MMMM d, yyyy")

                color: Theme.color.on_surface

                font.family: Theme.fonts.sans
                font.pixelSize: Theme.fontSize.normal

                horizontalAlignment: Text.AlignHCenter
            }
        }

        Rectangle {
            Layout.preferredWidth: calendar.implicitWidth
            Layout.preferredHeight: calendar.implicitHeight

            color: Theme.color.surface_container
            radius: popupBg.radius - popup.padding

            Calendar { id: calendar }
        }
    }
}
