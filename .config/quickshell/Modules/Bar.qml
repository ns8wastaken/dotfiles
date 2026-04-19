import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Modules.Bar
import qs.Modules.Bar.Clock
import qs.Components
import qs.Services
import qs.Config
import qs.Theme

Rectangle {
    id: root

    color: Theme.color.surface
    radius: 8

    border.color: Theme.color.outline
    border.width: 1

    // Left
    Row {
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 10
        }
        spacing: Config.bar.spacing

        Workspaces { anchors.verticalCenter: parent.verticalCenter }
    }

    // Center
    Row {
        anchors.centerIn: parent
        spacing: Config.bar.spacing

        Clock {
            id: clock
            anchors.verticalCenter: parent.verticalCenter

            HoverHandler { id: clockHoverHandler }

            Popup {
                id: popup

                // WARNING: `popupHoverHandler` doesnt work (its outside the bar so the mask ignores it)
                readonly property bool isHovered: popupHoverHandler.hovered || clockHoverHandler.hovered

                visible: isHovered

                closePolicy: Popup.NoAutoClose

                HoverHandler { id: popupHoverHandler }

                background: Rectangle {
                    id: popupBg

                    // color: Theme.color.surface
                    color: popup.isHovered ? "green" : "red"
                    radius: 16
                    border.color: Theme.color.outline
                    border.width: 1
                }

                x: (parent.width - width) / 2
                Component.onCompleted: y = 38

                topInset: -8
                leftInset: -8
                rightInset: -8
                bottomInset: -8

                padding: 0

                enter: Transition { PropertyAnimation { property: "opacity"; to: 1 } }
                exit: Transition { PropertyAnimation { property: "opacity"; to: 0 } }

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

                        StyledText {
                            text: TimeService.format("dddd, MMMM d, yyyy")
                            color: Theme.color.on_surface

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
        }
    }

    // Right
    Row {
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 10
        }
        spacing: Config.bar.spacing

        MediaPlayer { anchors.verticalCenter: parent.verticalCenter }
        Tray { anchors.verticalCenter: parent.verticalCenter }
        Controls { anchors.verticalCenter: parent.verticalCenter }
        Battery { anchors.verticalCenter: parent.verticalCenter }
        Backlight { anchors.verticalCenter: parent.verticalCenter }
        ExtraMenu { anchors.verticalCenter: parent.verticalCenter }
    }
}
