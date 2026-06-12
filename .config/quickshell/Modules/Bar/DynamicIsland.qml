import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Modules.Bar
import qs.Modules.Bar.Clock
import qs.Components
import qs.Components.Animations
import qs.Components.Icons
import qs.Core.Services
import qs.Core.Config
import qs.Theme

// Middle - dynamic island
FancyRoundedPanel {
    id: root

    required property int rounding

    panelWidth: clock.width + (2 * rounding)

    topLeftRadius: -rounding
    topRightRadius: -rounding
    bottomLeftRadius: rounding
    bottomRightRadius: rounding

    color: Theme.color.surface

    Behavior on panelWidth {
        NAnim { easing.type: Easing.OutCubic }
    }

    Item {
        id: barMiddleContainer

        anchors.fill: parent
        anchors.leftMargin: 2 * root.rounding
        anchors.rightMargin: 2 * root.rounding

        Clock {
            id: clock
            anchors.centerIn: parent

            HoverHandler { id: clockHoverHandler }
        }

        Rectangle {
            id: popup

            // WARNING: `popupHoverHandler` doesnt work (its outside the bar so the mask ignores it)
            readonly property bool isHovered: popupHoverHandler.hovered || clockHoverHandler.hovered

            visible: isHovered
            color: Theme.color.surface
            radius: 12

            HoverHandler { id: popupHoverHandler }

            anchors.horizontalCenter: barMiddleContainer.horizontalCenter

            width: innerPopup.implicitWidth + (2 * Theme.spacing.normal)
            height: innerPopup.implicitHeight + (2 * Theme.spacing.normal)

            state: isHovered ? "visible" : "hidden"

            states: [
                State {
                    name: "hidden"
                    PropertyChanges { popup { opacity: 0.0; visible: false } }
                },
                State {
                    name: "visible"
                    PropertyChanges { popup { y: barMiddleContainer.height + 6; opacity: 1.0; visible: true } }
                }
            ]

            transitions: [
                Transition {
                    from: "hidden"; to: "visible"

                    SequentialAnimation {
                        PropertyAction { target: popup; property: "y"; value: barMiddleContainer.height - 15 }
                        PropertyAction { target: popup; property: "visible" }

                        ParallelAnimation {
                            NAnim {
                                property: "y"
                                easing.type: Easing.OutBack
                                easing.overshoot: 3
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
                                to: barMiddleContainer.height + 15
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
    }
}
