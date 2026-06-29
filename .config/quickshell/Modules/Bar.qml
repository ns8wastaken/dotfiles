import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Modules.Bar
import qs.Modules.Bar.Clock
import qs.Components
import qs.Components.Animations
import qs.Components.Icons
import qs.Components.Effects
import qs.Core.Services
import qs.Core.Config
import qs.Theme

// // Right
// Row {
//     anchors {
//         verticalCenter: parent.verticalCenter
//         right: parent.right
//         rightMargin: 10
//     }
//     spacing: Config.bar.spacing
//
//     MediaPlayer { anchors.verticalCenter: parent.verticalCenter }
//     // Tray { anchors.verticalCenter: parent.verticalCenter }
//     Controls { anchors.verticalCenter: parent.verticalCenter }
//     Battery { anchors.verticalCenter: parent.verticalCenter }
//     Backlight { anchors.verticalCenter: parent.verticalCenter }
//     ExtraMenu { anchors.verticalCenter: parent.verticalCenter }
// }

Item {
    id: root

    height: 30
    readonly property real rounding: height / 2
    readonly property real bottomRounding: 18 // hyprland rounding + outer gap (12 + 6)

    // Left
    FancyRoundedPanel {
        id: barLeft

        anchors.left: parent.left
        anchors.top: parent.top

        panelWidth: barLeftContainer.width + (2 * root.rounding)
        panelHeight: root.height

        topRightRadius: -root.rounding
        bottomLeftRadius: -root.bottomRounding
        isBottomLeftVertical: true
        bottomRightRadius: root.rounding

        color: Theme.color.surface

        Behavior on panelWidth {
            NAnim { easing.type: Easing.OutCubic }
        }

        Item {
            id: barLeftContainer

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: root.rounding

            width: workspaces.width
            height: root.height

            Workspaces {
                id: workspaces

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    // Middle - dynamic island
    FancyRoundedPanel {
        id: barMiddle

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        panelWidth: clock.width + (2 * root.rounding)
        panelHeight: root.height

        topLeftRadius: -root.rounding
        topRightRadius: -root.rounding
        bottomLeftRadius: root.rounding
        bottomRightRadius: root.rounding

        color: Theme.color.surface

        Behavior on panelWidth {
            NAnim { easing.type: Easing.OutCubic }
        }

        // WARNING: for some fucking reason if i click and drag from the clock to the calendar then the popup stays open?

        Item {
            id: barMiddleContainer

            anchors.fill: parent
            anchors.leftMargin: 2 * root.rounding
            anchors.rightMargin: 2 * root.rounding

            Clock {
                id: clock
                anchors.centerIn: parent
                z: 1

                HoverHandler {
                    id: clockHoverHandler
                    cursorShape: Qt.SizeVerCursor
                }
            }

        }
    }

    Rectangle {
        id: popup

        // WARNING: `popupHoverHandler` doesnt work (its outside the bar so the mask ignores it)
        readonly property bool isHovered: clockHoverHandler.hovered || popupHoverHandler.hovered

        visible: isHovered
        color: Theme.color.surface
        radius: 12

        HoverHandler { id: popupHoverHandler }

        width: innerPopup.implicitWidth + (2 * Theme.spacing.normal)
        height: innerPopup.implicitHeight + (2 * Theme.spacing.normal)

        x: barMiddle.x + (barMiddle.width - width) / 2

        state: isHovered ? "visible" : "hidden"

        states: [
            State {
                name: "hidden"
                PropertyChanges { popup { y: barMiddleContainer.height - 20; opacity: 0.0; visible: false } }
            },
            State {
                name: "visible"
                // +6 because hyprland outer gap
                PropertyChanges { popup { y: barMiddleContainer.height + 6; opacity: 1.0; visible: true } }
            }
        ]

        transitions: [
            Transition {
                from: "hidden"; to: "visible"

                SequentialAnimation {
                    PropertyAction { target: popup; property: "visible" }

                    ParallelAnimation {
                        NumberAnimation {
                            property: "y"
                            easing.type: Easing.OutCubic
                        }
                        NAnim {
                            property: "opacity"
                        }
                    }
                }
            },

            Transition {
                from: "visible"; to: "hidden"

                SequentialAnimation {
                    ParallelAnimation {
                        NAnim {
                            property: "y"
                            to: barMiddleContainer.height + 20
                            easing.type: Easing.InCubic
                        }
                        NAnim {
                            property: "opacity"
                        }
                    }

                    PropertyAction { target: popup; property: "visible" }
                }
            }
        ]

        ColumnLayout {
            id: innerPopup

            anchors.fill: parent
            anchors.margins: Theme.spacing.normal

            // Date
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

            // Calendar
            Rectangle {
                Layout.preferredWidth: calendar.implicitWidth
                Layout.preferredHeight: calendar.implicitHeight

                color: Theme.color.surface_container
                radius: 8

                Calendar { id: calendar }
            }
        }
    }

    // Right
    FancyRoundedPanel {
        id: barRight

        anchors.right: parent.right
        anchors.top: parent.top

        panelWidth: barRightContainer.width + (2 * root.rounding)
        panelHeight: root.height

        topLeftRadius: -root.rounding
        bottomLeftRadius: root.rounding
        bottomRightRadius: -root.bottomRounding
        isBottomRightVertical: true

        color: Theme.color.surface

        Behavior on panelWidth {
            NAnim { easing.type: Easing.OutCubic }
        }

        Item {
            id: barRightContainer

            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: root.rounding

            width: childrenRect.width
            height: root.height

            Controls { anchors.verticalCenter: parent.verticalCenter }
        }
    }

    // Tray
    Pill {
        id: barTray

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: barRight.left
        anchors.rightMargin: -(root.rounding + root.height) / 4

        width: tray.width + (2 * tray.spacing)
        height: 24

        color: Theme.color.surface

        Tray {
            id: tray
            anchors.centerIn: parent
        }
    }


    PanelShadow { target: barLeft }
    PanelShadow { target: barMiddle }
    PanelShadow { target: barRight }
    PanelShadow { target: barTray }
}
