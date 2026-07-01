import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import "../../Shared/Components"
import "../../Shared/Animations"
import "../../Shared/Icons"
import "../../Shared/Effects"
import "../../Services"
import "../../Services/Config"
import "../../Shared/Theme"

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
    required property var calendarState
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
        layer.enabled: true
        layer.effect: MultiEffect {
            source: barLeft
            shadowEnabled: true
            shadowColor: Theme.color.shadow
            shadowOpacity: 1
            shadowVerticalOffset: 0
            shadowHorizontalOffset: 0
            shadowBlur: 0.5
        }

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
        layer.enabled: true
        layer.effect: MultiEffect {
            source: barMiddle
            shadowEnabled: true
            shadowColor: Theme.color.shadow
            shadowOpacity: 1
            shadowVerticalOffset: 0
            shadowHorizontalOffset: 0
            shadowBlur: 0.5
        }

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
                    onHoveredChanged: root.calendarState.clockHovered = hovered
                }
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
        layer.enabled: true
        layer.effect: MultiEffect {
            source: barRight
            shadowEnabled: true
            shadowColor: Theme.color.shadow
            shadowOpacity: 1
            shadowVerticalOffset: 0
            shadowHorizontalOffset: 0
            shadowBlur: 0.5
        }

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
        layer.enabled: true
        layer.effect: MultiEffect {
            source: barTray
            shadowEnabled: true
            shadowColor: Theme.color.shadow
            shadowOpacity: 1
            shadowVerticalOffset: 0
            shadowHorizontalOffset: 0
            shadowBlur: 0.5
        }

        Tray {
            id: tray
            anchors.centerIn: parent
        }
    }
}
