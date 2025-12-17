import Quickshell
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

    Bar {}
    NotificationsPopup {}
    WallpaperPicker {}
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

    AppLauncher {}
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
