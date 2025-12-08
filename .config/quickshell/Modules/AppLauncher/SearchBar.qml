import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Components
import qs.Settings

Pill {
    id: searchBar

    // radius: GlobalState.ThemeManager.radiusMedium
    // color: GlobalState.Colors.surface_variant
    // border.color: GlobalState.Colors.outline
    color: Theme.backgroundPrimary
    border.color: Theme.outline
    border.width: 1

    property alias text: textInput.text

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: searchBar.implicitHeight / 4
        spacing: 8

        // Search icon
        MaterialIcon {
            text: "search"
            font.pixelSize: Settings.fontSizeLarge
            color: Theme.textPrimary
        }

        // Search field
        TextField {
            id: textInput

            Layout.fillWidth: true

            placeholderText: "Run program..."
            placeholderTextColor: Theme.textPrimary

            font.family: Settings.appLauncher.fontFamily
            font.pixelSize: Settings.fontSizeNormal

            background: Rectangle { color: "transparent" }
            color: Theme.textPrimary
        }
    }

    // Same as Ctrl+Backspace
    Shortcut {
        sequence: "Ctrl+W"
        onActivated: {
            if (textInput.cursorPosition === 0) return;

            const end = textInput.cursorPosition - 1;

            let start = end;
            while (start > 0 && textInput.text[start - 1] !== " ") {
                start--;
            }

            textInput.text = textInput.text.slice(0, start) + textInput.text.slice(end + 1);
            textInput.cursorPosition = start;
        }
    }

    function clear() {
        textInput.clear();
    }

    function setFocus() {
        textInput.forceActiveFocus();
    }
}
