pragma ComponentBehavior: Bound

import MyShellModule
import Quickshell.Widgets
import QtQuick

IconImage {
    id: root

    required property color color

    asynchronous: true

    layer.enabled: true
    layer.effect: Colorizer {
        sourceColor: analyser.dominantColour
        colorizationColor: root.color
    }

    layer.onEnabledChanged: {
        if (layer.enabled && status === Image.Ready)
            analyser.requestUpdate();
    }

    onStatusChanged: {
        if (layer.enabled && status === Image.Ready)
            analyser.requestUpdate();
    }

    ImageAnalyser {
        id: analyser
        sourceItem: root
    }
}
