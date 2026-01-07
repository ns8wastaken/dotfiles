pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Modules.Bar.Clock
import qs.Components
import qs.Services
import qs.Theme

Item {
    id: root

    width: clockText.width
    height: clockText.height

    Text {
        id: clockText

        anchors.centerIn: parent

        color: Theme.color.on_surface

        font.pixelSize: Theme.fontSize.normal
        font.family: Theme.fonts.sans
        text: TimeService.format("hh:mm")

        HoverHandler { id: hoverHandler }
    }

    Popup {
        id: popup

        visible: hoverHandler.hovered

        background: Rectangle {
            id: popupBg

            color: Theme.color.surface
            radius: 16
            border.color: Theme.color.outline
            border.width: 1
        }

        padding: 8

        x: (parent.width - width) / 2
        y: 30

        ColumnLayout {
            id: innerPopup

            anchors.fill: parent

            RowLayout {
                spacing: 6
                Layout.alignment: Qt.AlignHCenter

                LucideIcon {
                    source: "calendar"
                    size: Theme.fontSize.normal
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
}
