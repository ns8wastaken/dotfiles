pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs.Managers
import qs.Config
import qs.Theme
import "../../Utils/Keys.js" as KeyUtils

WindowManager.WmWindow {
    id: root
    handle: "wlogout"

    Component.onCompleted: {
        WindowManager.register(handle, root);
    }

    onWmFocused: focus = true

    default property list<LogoutButton> buttons

    color: Theme.backgroundPrimary.alpha(Config.wlogout.bgAlpha)

    MouseArea {
        anchors.fill: parent
        onClicked: root.close()
    }

    // Button layout
    GridLayout {
        anchors.centerIn: parent

        width: Config.wlogout.width
        height: Config.wlogout.height

        columns: Config.wlogout.nCols
        columnSpacing: Config.wlogout.spacing
        rowSpacing: Config.wlogout.spacing

        Repeater {
            model: root.buttons

            delegate: Rectangle {
                id: logoutButton

                required property LogoutButton modelData

                Layout.fillWidth: true
                Layout.fillHeight: true

                radius: 16

                color: mouseArea.containsMouse ? Theme.highlight : Theme.backgroundPrimary

                border.color: Theme.outline
                border.width: mouseArea.containsMouse ? 0 : 1

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        logoutButton.modelData.exec();
                        root.close();
                    }
                }

                Image {
                    id: icon

                    readonly property int size: Math.min(parent.width, parent.height) * 0.75

                    anchors.centerIn: parent
                    // TODO: not offset manually
                    anchors.verticalCenterOffset: -20
                    source: Qt.resolvedUrl(Quickshell.shellPath("Assets/WLogout/" + logoutButton.modelData.icon))

                    width: size
                    height: size
                    scale: mouseArea.containsMouse ? 1.05 : 1

                    fillMode: Image.PreserveAspectFit

                    smooth: true
                    antialiasing: true
                    mipmap: true

                    Behavior on scale {
                        NumberAnimation {
                            duration: 100
                            easing.type: Easing.InOutQuad
                        }
                    }
                }

                Text {
                    anchors {
                        bottom: logoutButton.bottom
                        bottomMargin: 20
                        horizontalCenter: parent.horizontalCenter
                    }

                    text: logoutButton.modelData.text

                    font.family: Config.fonts.cute
                    font.pixelSize: Config.fontSizeLarger

                    color: "#ffffff"
                }
            }
        }
    }

    Keys.onPressed: function(event) {
        if (!shortcutsEnabled)
            return;

        // Escape -> close
        if (KeyUtils.key(event, Qt.Key_Escape)) {
            close()
            event.accepted = true;
            return;
        }

        // Handle button keybinds
        for (const button of buttons) {
            if (event.key == button.keybind) {
                button.exec();
                close();
            }
        }
    }

    GlobalShortcut {
        name: "wlogout"
        onPressed: root.toggle()
    }
}
