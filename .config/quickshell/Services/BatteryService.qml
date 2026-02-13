pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.UPower
import qs.Utils

Singleton {
    readonly property UPowerDevice device: UPower.displayDevice

    readonly property bool isValidBattery: device.isLaptopBattery
    readonly property bool isCharging: _safeBool(device.state === UPowerDeviceState.Charging)

    readonly property int percentage: _safeInt(device.percentage)

    readonly property string timeToEmpty: Format.seconds(_safeInt(device.timeToEmpty))
    readonly property string timeToFull: Format.seconds(_safeInt(device.timeToFull))

    function _safeInt(x: int): int {
        return isValidBattery ? x : 0;
    }

    function _safeBool(x: bool): bool {
        return isValidBattery ? x : false;
    }
}
