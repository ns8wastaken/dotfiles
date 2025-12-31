pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Services.SystemTray
import qs.Modules.Bar.Tray
import qs.Config

Row {
    id: root

    readonly property TrayMenu menu: TrayMenu {}

    spacing: Config.bar.tray.spacing

    Repeater {
        model: SystemTray.items
        delegate: TrayEntry {
            id: trayEntry

            readonly property bool menuAvailable: (
                modelData.hasMenu &&
                modelData.menu &&
                root.menu
            );

            // onClicked: function(mouse) {
            //     if (!modelData) return;
            //
            //     if (mouse.button === Qt.LeftButton) {
            //         // If menu is visible, close it
            //         if (root.menu?.visible) {
            //             root.menu.hideMenu();
            //         }
            //
            //         // Open application
            //         if (!modelData.onlyMenu) {
            //             modelData.activate();
            //         }
            //     }
            //
            //     else if (mouse.button === Qt.RightButton) {
            //         if (!menuAvailable) {
            //             console.log(
            //                 "No menu available for",
            //                 modelData.id,
            //                 "or root.menu not set"
            //             );
            //         }
            //
            //         // Anchor the menu to the root icon item (parent) and position it below the icon
            //         if (root.menu.menu == modelData.menu && root.menu.visible) {
            //             // The same root entry is right clicked (just hide the menu)
            //             root.menu.hideMenu();
            //         } else {
            //             // A different entry is right clicked
            //             // Hide the menu then show it again to remove artifacts
            //             root.menu.hideMenu();
            //             root.menu.update(trayEntry);
            //         }
            //     }
            // }

            onClicked: function(mouse) {
                if (mouse.button === Qt.LeftButton) {
                    // Open application
                    if (!modelData.onlyMenu) {
                        modelData.activate();
                    }
                }

                else if (mouse.button === Qt.RightButton) {
                    root.menu.update(trayEntry);
                }
            }
        }
    }
}
