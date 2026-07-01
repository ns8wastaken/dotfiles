pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.UPower
import "../Shared/Utils"

Singleton {
    readonly property UPowerDevice device: UPower.displayDevice

    readonly property bool isValidBattery: device.isLaptopBattery
    readonly property bool isCharging: !UPower.onBattery

    readonly property real percentage: _safeReal(device.percentage)

    readonly property string timeToEmpty: Format.seconds(_safeInt(device.timeToEmpty))
    readonly property string timeToFull: Format.seconds(_safeInt(device.timeToFull))

    function _safeBool(x: bool): bool { return isValidBattery ? x : false; }
    function _safeInt(x: int): int    { return isValidBattery ? x : 0;     }
    function _safeReal(x: real): real { return isValidBattery ? x : 0.0;   }
}
