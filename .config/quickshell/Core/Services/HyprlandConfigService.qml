pragma Singleton

import QtQuick
import Quickshell.Io

QtObject {
    id: root

    property string gapsOutStr: "0 0 0 0"

    property int gapsOutTop: 0
    property int gapsOutRight: 0
    property int gapsOutBottom: 0
    property int gapsOutLeft: 0

    property Process configReader: Process {
        command: ["hyprctl", "getoption", "general:gaps_out", "-j"]

        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    let json = JSON.parse(text);

                    if (json && json.css) {
                        root.gapsOutStr = json.css;

                        let parts = json.css.split(" ").map(Number);
                        if (parts.length === 4) {
                            root.gapsOutTop = parts[0];
                            root.gapsOutRight = parts[1];
                            root.gapsOutBottom = parts[2];
                            root.gapsOutLeft = parts[3];
                        }
                    }
                } catch(e) {
                    console.error("HyprConfig: Failed to parse hyprctl CSS output.", e);
                }
            }
        }
    }

    // --- Public Control Method ---
    function updateGaps() {
        if (configReader.running) {
            configReader.running = false;
        }
        configReader.running = true;
    }

    Component.onCompleted: {
        updateGaps();
    }
}
