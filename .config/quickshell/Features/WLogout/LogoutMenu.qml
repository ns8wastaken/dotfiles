pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import "../../Shared/Components"
import "../../Shared/Animations"
import "../../Services/WindowManager"
import "../../Services/Config"
import "../../Shared/Theme"
import "../../Shared/Utils"

WmWindow {
    id: root

    default property list<LogoutButton> buttons

    color: Theme.color.surface.alpha(Config.wlogout.bgAlpha)

    focus: true

    MouseArea {
        anchors.fill: parent
        onClicked: root.close()
    }

    // Button layout
    GridLayout {
        anchors.centerIn: parent

        width: Config.wlogout.width
        height: Config.wlogout.height

        columns: 3
        columnSpacing: 48
        rowSpacing: 64

        Repeater {
            model: root.buttons

            delegate: Item {
                id: logoutButton

                required property LogoutButton modelData

                readonly property real cardRadius:       38
                readonly property real cardBorderWidth:  2.5
                readonly property real cardBorderAlpha:  0.18
                readonly property real hoverBorderAlpha: 0.35
                readonly property real hoverLightFactor: 1.25
                readonly property real hoverScale:       1.03

                readonly property int iconSize: 250

                Layout.fillWidth: true
                Layout.fillHeight: true

                Item {
                    id: cardItem

                    anchors.fill: parent

                    scale: mouseArea.containsMouse ? logoutButton.hoverScale : 1.0

                    antialiasing: true

                    Behavior on scale { NAnim { easing.type: Easing.OutCubic } }

                    // Card body
                    Rectangle {
                        id: cardBody
                        anchors.fill: parent

                        rotation: logoutButton.modelData.rotationAngle

                        radius: logoutButton.cardRadius

                        layer.enabled: true
                        layer.smooth: true
                        layer.effect: Component {
                            ShaderEffect {
                                required property variant source

                                property color colorTop:    logoutButton.modelData.cardColor1
                                property color colorBottom: logoutButton.modelData.cardColor2
                                property real  angle:       logoutButton.modelData.gradientAngle * Math.PI / 180.0
                                property real  hovered:     mouseArea.containsMouse ? 1.0 : 0.0

                                property vector2d cardSize:     Qt.point(cardBody.width, cardBody.height)
                                property real     cornerRadius: logoutButton.cardRadius

                                Behavior on hovered { NAnim { easing.type: Easing.OutCubic } }

                                fragmentShader: Qt.resolvedUrl(
                                    Quickshell.shellPath("Shaders/Qsb/WLogoutCardGradient.frag.qsb")
                                )
                            }
                        }

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                logoutButton.modelData.exec();
                                root.close();
                            }
                        }
                    }

                    // Icon
                    Image {
                        id: icon

                        anchors.centerIn: parent

                        source: Qt.resolvedUrl(
                            Quickshell.shellPath("Assets/WLogout/" + logoutButton.modelData.iconSource)
                        )

                        width: logoutButton.iconSize
                        height: logoutButton.iconSize

                        fillMode: Image.PreserveAspectFit
                        asynchronous: true
                        mipmap: true

                        // Alt text (in case img fails to load)
                        Rectangle {
                            anchors.fill: parent

                            visible: icon.status === Image.Null || icon.status === Image.Error
                            color: "transparent"

                            radius: 24
                            border.color: Qt.rgba(1, 1, 1, logoutButton.cardBorderAlpha)
                            border.width: logoutButton.cardBorderWidth

                            Text {
                                anchors.centerIn: parent
                                text: "?"
                                color: "#ffffff"
                                font.pixelSize: Theme.fontSize.larger
                            }
                        }
                    }
                }

                StyledText {
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        top: parent.bottom
                        topMargin: 5
                    }

                    text: logoutButton.modelData.labelText

                    font.family: Theme.fonts.cute
                    font.pixelSize: Theme.fontSize.larger

                    color: "#ffffff"
                }
            }
        }
    }

    Keys.onPressed: function(event: KeyEvent) {
        if (!focused)
            return;

        // Escape -> close
        if (Key.match(event, Qt.Key_Escape)) {
            close();
            event.accepted = true;
            return;
        }

        // Handle button keybinds
        for (const button of buttons) {
            if (event.key === button.keybind) {
                button.exec();
                close();
            }
        }
    }
}
