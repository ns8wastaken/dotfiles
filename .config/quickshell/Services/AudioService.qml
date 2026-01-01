pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
    id: root

    component AudioNode: QtObject {
        required property PwNode node

        readonly property bool _ready: node !== null && node.audio !== null

        readonly property bool muted: _ready ? (node.audio.muted ?? false) : false
        readonly property real volume: {
            if (!_ready) return 0;
            const vol = node.audio.volume;
            if (!vol) return 0;
            return Math.round(vol * 100) / 100;
        }
        readonly property int percentage: volume * 100

        function setVolume(vol: real) {
            if (_ready && node.audio) {
                node.audio.volume = Math.max(0, Math.min(1, vol));
            }
        }

        function toggleMute() {
            if (_ready && node.audio) {
                node.audio.muted = !node.audio.muted;
            }
        }

        function increaseVolume() { setVolume(volume + 0.05); }
        function decreaseVolume() { setVolume(volume - 0.05); }
    }

    readonly property var _nodes: {
        const sinks = [];
        const sources = [];

        for (const node of Pipewire.nodes.values) {
            if (node.isStream) continue;

            if (node.isSink)
                sinks.push(node);
            else if (node.audio)
                sources.push(node);
        }

        return { sources, sinks };
    }

    readonly property list<PwNode> sinks: _nodes.sinks
    readonly property list<PwNode> sources: _nodes.sources

    readonly property AudioNode sink: AudioNode { node: Pipewire.defaultAudioSink }
    readonly property AudioNode source: AudioNode { node: Pipewire.defaultAudioSource }

    PwObjectTracker {
        objects: [...root.sinks, ...root.sources]
    }
}
