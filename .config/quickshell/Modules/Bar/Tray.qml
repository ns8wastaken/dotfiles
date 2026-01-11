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

            onClicked: function(mouse) {
                if (mouse.button === Qt.LeftButton) {
                    if (!modelData.onlyMenu)
                        modelData.activate();
                }

                else if (mouse.button === Qt.RightButton) {
                    if (menuAvailable)
                        root.menu.update(trayEntry);
                }
            }
        }
    }
}
