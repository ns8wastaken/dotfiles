import QtQuick
import qs.Managers

Loader {
    id: root

    required final property string handle
    property bool opened: false

    Component.onCompleted: {
        active = false;
        WindowManager.register(handle, root);
    }

    visible: active
    focus: active

    /* ---- Animation ---- */
    opacity: 0
    scale: 0.9

    states: State {
        name: "ACTIVE"
        when: root.opened && root.status === Loader.Ready

        PropertyChanges {
            root.opacity: 1
            root.scale: 1
        }
    }

    transitions: Transition {
        to: "ACTIVE"
        reversible: true

        SequentialAnimation {
            PropertyAction {
                target: root
                property: "active"
                value: root.state === "ACTIVE"
            }

            PropertyAnimation {
                target: root
                properties: "opacity, scale"
                duration: 100
                easing.type: Easing.InOutCubic
            }
        }
    }

    /* ---- Functions ---- */
    function open() { WindowManager.open(handle); }
    function close() { WindowManager.close(handle); }
    function toggle() { state === "" ? open() : close(); }

    /* ---- Delegated Updates ---- */
    onStatusChanged: {
        if (status === Loader.Ready) {
            item._handle = handle;
        }
    }
}
