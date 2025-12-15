import QtQuick
import qs.Config
import qs.Theme

Window {
    id: root

    required property string text
    required property Item targetItem
    required property int delay

    property bool tooltipVisible: false

    flags: Qt.ToolTip | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint

    visible: tooltipVisible

    color: "transparent"

    minimumWidth: tooltipText.width + 24
    minimumHeight: tooltipText.height + 16

    Component.onCompleted: _hideNow()

    Timer {
        id: tooltipDelayTimer
        interval: root.delay
        repeat: false
        running: root.tooltipVisible && root.delay > 0
        onTriggered: root._showNow()
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
        target: root.targetItem
        function onXChanged()      { if (root.visible) root._showNow(); }
        function onYChanged()      { if (root.visible) root._showNow(); }
        function onWidthChanged()  { if (root.visible) root._showNow(); }
        function onHeightChanged() { if (root.visible) root._showNow(); }
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

        font.family: Config.fonts.sans
        font.pixelSize: Config.fontSizeSmall
        text: root.text

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
