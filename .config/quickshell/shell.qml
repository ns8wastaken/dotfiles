import Quickshell
import QtQuick
import qs.Modules

ShellRoot {
    readonly property bool disableHotReload:
        Quickshell.env("QS_DISABLE_HOT_RELOAD") === "1"
        || Quickshell.env("QS_DISABLE_HOT_RELOAD") === "true"

    Component.onCompleted: {
        Quickshell.watchFiles = !disableHotReload;
    }

    Bar {}
    NotificationsPopup {}

    // "Activate Linux" watermark
    Loader {
        active: false
        sourceComponent: Watermark {}
    }

    // Text that is overlayed on the background
    Loader {
        active: true
        sourceComponent: BackgroundText {
            borderAnchors {
                right: true
                bottom: true
            }

            borderMargins {
                right: 50
                bottom: 50
            }

            text: "我\n操\n你\n妈"
            fontFamily: "HanyiSentyScholar"
            color: "#ffffff"
            size: 40
        }
    }

    AppLauncher {}

    // PanelWindow {
    //     Text {
    //         color: "#000000"
    //         text: SysInfoService.cpuUsageStr
    //         anchors.centerIn: parent
    //         anchors.verticalCenterOffset: -40
    //     }
    //     Text {
    //         color: "#000000"
    //         text: SysInfoService.cpuTempStr
    //         anchors.centerIn: parent
    //         anchors.verticalCenterOffset: -20
    //     }
    //     Text {
    //         color: "#000000"
    //         text: SysInfoService.memoryUsageStr
    //         anchors.centerIn: parent
    //     }
    //     Text {
    //         color: "#000000"
    //         text: SysInfoService.memoryUsagePerStr
    //         anchors.centerIn: parent
    //         anchors.verticalCenterOffset: 20
    //     }
    //     Text {
    //         color: "#000000"
    //         text: SysInfoService.diskUsageStr
    //         anchors.centerIn: parent
    //         anchors.verticalCenterOffset: 40
    //     }
    // }
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
//                 radius: 14
//             }
//         }
//     }
// }
