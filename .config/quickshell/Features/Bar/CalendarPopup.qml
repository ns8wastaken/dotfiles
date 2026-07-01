import Quickshell
import QtQuick
import QtQuick.Layouts
import "../../Shared/Components"
import "../../Shared/Icons"
import "../../Shared/Animations"
import "../../Shared/Theme"
import "../../Services"

PanelWindow {
    id: root

    required property var calendarState

    anchors.top: true
    margins.top: 36
    exclusionMode: ExclusionMode.Ignore
    aboveWindows: true
    focusable: false
    color: "transparent"

    readonly property real popupWidth: innerPopup.implicitWidth + 2 * Theme.spacing.normal
    implicitWidth: popupWidth
    implicitHeight: innerPopup.implicitHeight + 2 * Theme.spacing.normal

    HoverHandler {
        onHoveredChanged: root.calendarState.popupHovered = hovered
    }

    Rectangle {
        id: popupBody
        anchors.fill: parent
        color: Theme.color.surface
        radius: 12

        ColumnLayout {
            id: innerPopup

            anchors.fill: parent
            anchors.margins: Theme.spacing.normal

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
                Layout.preferredWidth: datePicker.implicitWidth
                Layout.preferredHeight: datePicker.implicitHeight

                color: Theme.color.surface_container
                radius: 8

                DatePicker { id: datePicker }
            }
        }
    }
}
