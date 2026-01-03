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

        color: Theme.colors.textPrimary

        font.pixelSize: Theme.fontSize.normal
        font.family: Theme.fonts.sans
        text: TimeService.time

        HoverHandler { id: hoverHandler }
    }

    Popup {
        id: popup

        visible: hoverHandler.hovered

        background: Rectangle {
            id: popupBg

            color: Theme.colors.backgroundPrimary
            radius: 16
            border.color: Theme.colors.outline
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
                anchors.horizontalCenter: parent.horizontalCenter

                LucideIcon {
                    source: "calendar"
                    size: Theme.fontSize.normal
                    color: Theme.colors.textPrimary
                }

                Text {
                    text: Qt.formatDate(TimeService.date, "dddd, MMMM d, yyyy")

                    color: Theme.colors.textPrimary

                    font.family: Theme.fonts.sans
                    font.pixelSize: Theme.fontSize.normal

                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Rectangle {
                Layout.preferredWidth: calendar.implicitWidth
                Layout.preferredHeight: calendar.implicitHeight

                color: Theme.colors.backgroundSecondary
                radius: popupBg.radius - popup.padding

                Calendar { id: calendar }
            }
        }
    }
}
