import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Config

Pill {
    id: root

    /* =======================
     * Public API
     * ======================= */

    // Text API
    property alias text: textField.text
    property alias cursorPosition: textField.cursorPosition

    // Appearance
    property color backgroundColor: "transparent"
    property color borderColor: "transparent"
    property int borderWidth: 0

    property color iconColor: "#ffffff"
    property int iconSize: Config.fontSizeLarge
    property string iconText: "search"

    property color textColor: "#ffffff"
    property color placeholderColor: textColor
    property string placeholderText: ""

    property font textFont

    // Layout
    property int horizontalPadding: height / 4
    property int spacing: 8

    // Behavior
    signal accepted(text: string)

    /* =======================
     * Pill styling
     * ======================= */

    color: backgroundColor
    border.color: borderColor
    border.width: borderWidth

    /* =======================
     * Content
     * ======================= */

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: root.horizontalPadding
        anchors.rightMargin: root.horizontalPadding

        spacing: root.spacing

        MaterialIcon {
            text: root.iconText
            font.pixelSize: root.iconSize
            color: root.iconColor
        }

        TextField {
            id: textField

            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter

            placeholderText: root.placeholderText
            placeholderTextColor: root.placeholderColor

            font: root.textFont
            color: root.textColor

            background: Rectangle { color: "transparent" }

            onAccepted: root.accepted(text)
        }
    }

    // Ctrl+Backspace behavior
    function deletePreviousWord() {
        if (textField.cursorPosition === 0) return;

        const end = textField.cursorPosition - 1;
        let start = end;

        while (start > 0 && textField.text[start - 1] !== " ")
            start--;

        textField.text =
            textField.text.slice(0, start)
            + textField.text.slice(end + 1);

        textField.cursorPosition = start;
    }

    function clear() {
        textField.clear();
    }

    function focusField() {
        textField.focus = true;
    }
}
