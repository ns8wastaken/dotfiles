pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.Config
import qs.Theme

PanelWindow {
    id: root

    property bool open: false

    default property list<LogoutButton> buttons

    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    anchors {
        top: true
        left: true
        bottom: true
        right: true
    }

    visible: open
    color: "transparent"

    contentItem {
        focus: true

        Keys.onPressed: function(event) {
            for (const button of buttons) {
                if (event.key == button.keybind) {
                    button.exec();
                    open = false;
                }
            }
        }
    }

    // Fullscreen rect
    Rectangle {
        color: Theme.backgroundPrimary.alpha(Config.wlogout.bgAlpha)
        anchors.fill: parent

        MouseArea {
            anchors.fill: parent

            onClicked: root.open = false

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
                                root.open = false;
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
                            fillMode: Image.PreserveAspectFit

                            smooth: true
                            antialiasing: true
                            mipmap: true
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
        }
    }

    Shortcut {
        sequence: "Escape"
        onActivated: root.open = false
    }

    IpcHandler {
        target: "wlogout"

        function toggle(): void {
            root.open = !root.open;
        }
    }
}
