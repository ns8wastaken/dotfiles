import QtQuick
import qs.Managers

Loader {
    id: animatedLoaderRoot

    required final property string handle

    Component.onCompleted: {
        active = false;
        WindowManager.register(handle, animatedLoaderRoot);
    }

    visible: active
    focus: active

    /* ---- Animation ---- */
    opacity: 0
    scale: 0.9

    states: State {
        name: "ACTIVE"

        PropertyChanges {
            animatedLoaderRoot.active: true
            animatedLoaderRoot.opacity: 1
            animatedLoaderRoot.scale: 1
        }
    }

    transitions: Transition {
        to: "ACTIVE"
        reversible: true

        SequentialAnimation {
            PropertyAction {
                target: animatedLoaderRoot
                property: "active"
            }

            PropertyAnimation {
                target: animatedLoaderRoot
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
            item.wmOpened();
        }
    }
}
