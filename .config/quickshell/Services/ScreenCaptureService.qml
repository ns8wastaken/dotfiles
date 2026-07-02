pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import "../Shared/Utils"
import "Config"

Singleton {
    id: root

    readonly property string screenshotsDir: FsPaths.resolved(Config.screenCapture.screenshotsDir)

    property string lastScreenshotPath: ""
    property string lastOcrText: ""
    property string lastError: ""

    Process {
        id: proc
        running: false
        workingDirectory: Quickshell.shellPath("Native/Programs/bin")

        stdout: SplitParser {
            onRead: data => {
                let result;
                try {
                    result = JSON.parse(data);
                } catch (e) {
                    return;
                }

                switch (result.type) {
                    case "screenshot":
                        root.lastScreenshotPath = result.path || "";
                        root.lastOcrText = "";
                        root.lastError = "";
                        break;

                    case "ocr":
                        root.lastOcrText = result.text || "";
                        root.lastScreenshotPath = "";
                        root.lastError = "";
                        break;

                    case "error":
                        root.lastError = result.message || "";
                        root.lastScreenshotPath = "";
                        root.lastOcrText = "";
                        break;
                }
            }
        }
    }

    function screenshot(target) {
        proc.command = ["./screencap", "screenshot", target];
        proc.running = true;
    }

    function ocr(target) {
        proc.command = ["./screencap", "ocr", target];
        proc.running = true;
    }
}
