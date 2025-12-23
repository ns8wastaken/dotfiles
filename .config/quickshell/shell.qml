import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.Modules
import qs.Config
import qs.Theme

ShellRoot {
    readonly property bool disableHotReload:
        Quickshell.env("QS_DISABLE_HOT_RELOAD") === "1"
        || Quickshell.env("QS_DISABLE_HOT_RELOAD") === "true"

    Component.onCompleted: {
        Quickshell.watchFiles = !disableHotReload;
    }

    PanelWindow {
        id: fsPanelWindow

        // We love inclusion
        exclusionMode: ExclusionMode.Ignore

        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }

        // Where clicky is allowed to happen
        Variants {
            id: clickyRegions
            model: fsPanelWindow.contentItem.children

            delegate: Region {
                required property Item modelData
                item: modelData.visible ? modelData : null
            }
        }

        // No clicky outside of the clicky places
        mask: Region { regions: clickyRegions.instances }

        color: "transparent"

        PanelWindow {
            id: barExclusiveZone
            anchors.top: true
            implicitWidth: 0
            implicitHeight: 0
            // -4 because its hyprland's outer gap
            exclusiveZone: bar.height + bar.anchors.topMargin + bar.anchors.bottomMargin - 4
        }
        Bar {
            id: bar

            height: 32

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                topMargin: Config.bar.margins.top
                bottomMargin: Config.bar.margins.bottom
                leftMargin: Config.bar.margins.left
                rightMargin: Config.bar.margins.right
            }
        }

        NotificationsPopup {
            anchors {
                right: parent.right
                top: parent.top
                // +4 because its hyprland's outer gap
                topMargin: barExclusiveZone.exclusiveZone + Config.notifications.marginTop + 4
                rightMargin: Config.notifications.marginRight
            }
        }

        // Toggleable menus
        WlrLayershell.keyboardFocus: (launcher.visible || wallpaperPicker.visible)
            ? WlrKeyboardFocus.Exclusive
            : WlrKeyboardFocus.None;

        Launcher {
            id: launcher
            anchors.centerIn: parent
        }

        WallpaperPicker {
            id: wallpaperPicker
            anchors.centerIn: parent
        }
    }
    WLogout {}

    // "Activate Linux" watermark
    Loader {
        active: false
        sourceComponent: Watermark {}
    }

    // Text that is overlayed on the background
    Loader {
        active: true
        sourceComponent: Scope {
            FontLoader {
                id: bgTextFont
                source: Config.shellFont("HanyiSentyScholar.ttf")
            }

            BackgroundText {
                anchors {
                    right: true
                    bottom: true
                }

                margins {
                    right: 50
                    bottom: 50
                }

                text.text: "吃\n喝\n拉\n撒\n睡"
                text.color: Theme.textPrimary
                text.font.family: bgTextFont.name
                text.font.pointSize: 40
            }

            BackgroundText {
                anchors {
                    right: true
                    bottom: true
                }

                margins {
                    right: 120
                    bottom: 50
                }

                text.text: "我\n操\n你\n妈"
                text.color: Theme.textPrimary
                text.font.family: bgTextFont.name
                text.font.pointSize: 40
            }
        }
    }
}

// import Quickshell
// import Quickshell.Wayland
// import QtQuick
// import QtQuick.Effects
//
// PanelWindow {
//     id: root
//
//     color: "transparent"
//     visible: true
//     WlrLayershell.layer: WlrLayer.Top
//
//     mask: Region {
//         item: container;
//         intersection: Intersection.Xor
//     }
//
//     anchors {
//         top: true
//         left: true
//         bottom: true
//         right: true
//     }
//
//     Item {
//         id: container
//         anchors.fill: parent
//
//         Rectangle {
//             anchors.fill: parent
//
//             color: "#FFFFFF"
//
//             layer.enabled: true
//             layer.effect: MultiEffect {
//                 maskSource: mask
//                 maskEnabled: true
//                 maskInverted: true
//                 maskThresholdMin: 0.5
//                 maskSpreadAtMin: 1
//             }
//         }
//
//         Item {
//             id: mask
//
//             anchors.fill: parent
//             layer.enabled: true
//             visible: false
//
//             Rectangle {
//                 anchors.fill: parent
//                 anchors.leftMargin: 12
//                 anchors.rightMargin: 12
//                 anchors.topMargin: 12
//                 anchors.bottomMargin: 12
//
//                 radius: 16
//             }
//         }
//     }
// }
