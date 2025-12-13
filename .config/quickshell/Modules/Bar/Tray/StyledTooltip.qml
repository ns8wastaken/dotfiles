import QtQuick
import qs.Settings

Window {
    id: tooltipWindow
    color: "transparent"

    required property string text
    required property Item targetItem
    required property int delay

    property bool tooltipVisible: false

    flags: Qt.ToolTip | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint

    visible: tooltipVisible

    minimumWidth: tooltipText.width + 24
    minimumHeight: tooltipText.height + 16

    Component.onCompleted: _hideNow()

    Timer {
        id: tooltipDelayTimer
        interval: tooltipWindow.delay
        repeat: false
        running: tooltipWindow.tooltipVisible && tooltipWindow.delay > 0
        onTriggered: tooltipWindow._showNow()
    }

    onTooltipVisibleChanged: {
        if (!tooltipVisible)
            _hideNow()
    }

    function _showNow() {
        if (!targetItem) return;
        var pos = targetItem.mapToGlobal(0, targetItem.height);
        x = pos.x + (targetItem.width - width) / 2;
        y = pos.y + 12;
        visible = true;
    }

    function _hideNow() {
        visible = false;
        tooltipDelayTimer.stop();
    }

    Connections {
        target: tooltipWindow.targetItem
        function onXChanged()      { if (tooltipWindow.visible) tooltipWindow._showNow(); }
        function onYChanged()      { if (tooltipWindow.visible) tooltipWindow._showNow(); }
        function onWidthChanged()  { if (tooltipWindow.visible) tooltipWindow._showNow(); }
        function onHeightChanged() { if (tooltipWindow.visible) tooltipWindow._showNow(); }
    }

    Rectangle {
        anchors.fill: parent

        radius: 6
        color: Theme.backgroundPrimary
        border.color: Theme.outline
        border.width: 1

        opacity: 0.9
        z: 1
    }

    Text {
        id: tooltipText

        color: Theme.textPrimary

        font.family: Settings.bar.fontFamily
        font.pixelSize: Settings.fontSizeSmall
        text: tooltipWindow.text

        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.Wrap

        padding: 8
        z: 2
    }

    onTextChanged: {
        width = Math.max(width, tooltipText.width + 24)
        height = Math.max(height, tooltipText.height + 16)
    }
}
