import QtQuick
import qs.Managers

Loader {
    id: root

    required property string handle
    property bool opened: false
    property bool focused: false

    property bool draggable: false
    property bool resetPosition: true // TODO

    Component.onCompleted: {
        active = false;
        WindowManager.register(handle, root);
    }

    Component.onDestruction: {
        WindowManager.unregister(handle);
    }

    DragHandler { enabled: root.draggable }

    visible: active
    focus: active

    /* ---- Animation ---- */
    opacity: 0
    scale: 0.75

    states: State {
        name: "VISIBLE"
        when: root.opened && root.status === Loader.Ready

        PropertyChanges {
            root {
                opacity: 1
                scale: 1
            }
        }
    }

    transitions: Transition {
        to: "VISIBLE"
        reversible: true

        SequentialAnimation {
            PropertyAction {
                target: root
                property: "active"
                value: root.state === "VISIBLE"
            }

            PropertyAnimation {
                target: root
                properties: "opacity, scale"
                duration: 130
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
