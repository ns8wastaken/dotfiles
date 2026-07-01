pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications
import QtQuick
import "../../Shared/Components"
import "../../Shared/Icons"
import "../../Shared/Effects"
import "../../Shared/Animations"
import "../../Shared/Utils"
import "../../Services"
import "../../Services/Config"
import "../../Shared/Theme"

Rectangle {
    id: root

    required property NotificationService.Notif modelData

    readonly property bool hasImage: modelData.image.length > 0
    readonly property bool hasAppIcon: modelData.appIcon.length > 0
    property bool expanded: false

    Component.onCompleted: {
        x = 0;
        modelData.lock(this);
    }
    Component.onDestruction: modelData.unlock(this)

    height: Config.notifs.iconSize + 2 * Theme.spacing.normal
    width: Config.notifs.width

    color: Theme.color.surface

    border.color: Theme.color.outline
    border.width: 1

    radius: 8

    Item {
        id: inner

        anchors.fill: parent
        anchors.margins: Theme.spacing.normal

        /* ---- Icon / Image ---- */
        Loader {
            id: image

            active: root.hasImage
            visible: root.hasImage || root.hasAppIcon

            anchors.top: parent.top
            anchors.left: parent.left

            width: Config.notifs.iconSize
            height: Config.notifs.iconSize

            sourceComponent: ClippingRectangle {
                implicitWidth: Config.notifs.iconSize
                implicitHeight: Config.notifs.iconSize

                radius: 9999

                color: "transparent"

                Image {
                    anchors.fill: parent
                    source: root.modelData
                        ? Qt.resolvedUrl(root.modelData.image)
                        : "";
                    fillMode: Image.PreserveAspectCrop
                    cache: false
                    asynchronous: true
                }
            }
        }

        Loader {
            id: appIcon

            active: root.hasAppIcon || !root.hasImage

            anchors.horizontalCenter: root.hasImage ? undefined    : image.horizontalCenter
            anchors.verticalCenter:   root.hasImage ? undefined    : image.verticalCenter
            anchors.right:            root.hasImage ? image.right  : undefined
            anchors.bottom:           root.hasImage ? image.bottom : undefined

            sourceComponent: StyledRect {
                radius: 9999

                color: root.modelData
                    ? root.modelData.urgency === NotificationUrgency.Critical
                        ? Theme.color.error
                        : root.modelData.urgency === NotificationUrgency.Low
                            // TODO: Colors.layer
                            // ? Colors.layer(Theme.color.surface_container_highest, 2)
                            ? Theme.color.secondary_container
                            : Theme.color.secondary_container
                    : "";

                // implicitWidth: root.hasImage ? Config.notifs.sizes.badge : Config.notifs.sizes.image
                // implicitHeight: root.hasImage ? Config.notifs.sizes.badge : Config.notifs.sizes.image
                implicitWidth: inner.height
                implicitHeight: inner.height

                Loader {
                    id: icon

                    active: root.hasAppIcon

                    anchors.centerIn: parent

                    width: Math.round(parent.width * 0.6)
                    height: width

                    sourceComponent: ColoredIcon {
                        anchors.fill: parent
                        source: Quickshell.iconPath(root.modelData.appIcon)
                        color: root.modelData.urgency === NotificationUrgency.Critical
                            ? Theme.color.on_error
                            : root.modelData.urgency === NotificationUrgency.Low
                                ? Theme.color.on_surface
                                : Theme.color.on_secondary_container;
                        layer.enabled: root.modelData.appIcon.endsWith("symbolic")
                    }
                }

                Loader {
                    active: !root.hasAppIcon

                    anchors.centerIn: parent
                    // TODO : figure out how to center ts
                    anchors.horizontalCenterOffset: -Theme.fontSize.large * 0.02
                    anchors.verticalCenterOffset: Theme.fontSize.large * 0.02

                    sourceComponent: MaterialIcon {
                        text: root.modelData
                            ? Icons.getNotifIcon(root.modelData.summary, root.modelData.urgency)
                            : "";
                        color: root.modelData
                            ? root.modelData.urgency === NotificationUrgency.Critical
                                ? Theme.color.on_error
                                : root.modelData.urgency === NotificationUrgency.Low
                                    ? Theme.color.on_surface
                                    : Theme.color.on_secondary_container
                            : "";
                        font.pixelSize: Theme.fontSize.large
                    }
                }
            }
        }

        /* ---- Title ---- */
        StyledText {
            id: title

            anchors.top: inner.top
            anchors.left: image.right
            anchors.leftMargin: Theme.spacing.normal

            text: root.modelData?.summary ?? ""
            font.bold: true
            color: Theme.color.on_surface

            elide: Text.ElideRight
        }

        /* ---- Body ---- */
        StyledText {
            id: body

            anchors.top: title.bottom
            anchors.bottom: inner.bottom
            anchors.left: title.left
            anchors.right: inner.right

            visible: text.length > 0

            text: root.modelData?.body ?? ""
            font.pixelSize: Theme.fontSize.small
            color: Theme.color.on_surface

            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            elide: Text.ElideRight
        }

        MouseArea {
            property int startY

            anchors.fill: parent
            hoverEnabled: true
            // TODO: root.expanded
            cursorShape: (root.expanded && body.hoveredLink)
                ? Qt.PointingHandCursor
                : pressed
                    ? Qt.ClosedHandCursor
                    : undefined;
            acceptedButtons: Qt.LeftButton | Qt.MiddleButton
            preventStealing: true

            onEntered: root.modelData.timer.stop()
            onExited: {
                if (!pressed)
                    root.modelData.timer.start();
            }

            drag.target: parent
            drag.axis: Drag.XAxis

            onPressed: event => {
                root.modelData.timer.stop();
                startY = event.y;
                if (event.button === Qt.MiddleButton)
                    root.modelData.close();
            }
            onReleased: event => {
                if (!containsMouse)
                    root.modelData.timer.start();

                if (Math.abs(root.x) < Config.notifs.width * Config.notifs.clearThreshold)
                    root.x = 0;
                else
                    root.modelData.popup = false;
            }
            onPositionChanged: event => {
                if (pressed) {
                    const diffY = event.y - startY;
                    if (Math.abs(diffY) > Config.notifs.expandThreshold)
                        root.expanded = diffY > 0;
                }
            }
            onClicked: event => {
                if (!Config.notifs.actionOnClick || event.button !== Qt.LeftButton)
                    return;

                const actions = root.modelData.actions;
                if (actions.length === 1)
                    actions[0].invoke();
            }
        }
    }

    // TODO: figure this shit out
    ListView.onRemove: removeAnim.start()

    NAnim {
        id: removeAnim

        target: root
        property: "x"
        to: Config.notifs.width

        easing.type: Easing.InBack

        running: false
    }

    // Behavior on x { NAnim {} }
}
