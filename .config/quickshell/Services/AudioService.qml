pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
    id: root

    // readonly property var _nodes: Pipewire.nodes.values.reduce((acc, node) => {
    //     if (!node.isStream) {
    //         if (node.isSink) {
    //             acc.sinks.push(node);
    //         } else if (node.audio) {
    //             acc.sources.push(node);
    //         }
    //     }
    //     return acc;
    // }, {
    //     sources: [],
    //     sinks: []
    // });

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

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource

    // Check if sink is ready for operations - use safe checks
    readonly property bool sinkReady: sink !== null && sink.audio !== null
    readonly property bool sourceReady: source !== null && source.audio !== null

    readonly property bool muted: sinkReady ? (sink.audio.muted ?? false) : false
    readonly property real volume: {
        if (!sinkReady) return 0
        const vol = sink.audio.volume
        if (vol === undefined || vol === null || isNaN(vol)) return 0
        return Math.max(0, Math.min(1.5, vol))
    }
    readonly property int percentage: Math.round(volume * 100)

    readonly property bool sourceMuted: sourceReady ? (source.audio.muted ?? false) : false
    readonly property real sourceVolume: sourceReady ? (source.audio.volume ?? 0) : 0
    readonly property int sourcePercentage: Math.round(sourceVolume * 100)

    function setVolume(newVolume) {
        if (sinkReady && sink.audio) {
            sink.audio.muted = false
            sink.audio.volume = Math.max(0, Math.min(1.5, newVolume))
        }
    }

    function toggleMute() {
        if (sinkReady && sink.audio) {
            sink.audio.muted = !sink.audio.muted;
        }
    }

    function increaseVolume() {
        setVolume(volume + 0.05);
    }

    function decreaseVolume() {
        setVolume(volume - 0.05);
    }

    function setSourceVolume(newVolume) {
        if (sourceReady && source.audio) {
            source.audio.muted = false;
            source.audio.volume = Math.max(0, Math.min(1.5, newVolume));
        }
    }

    function toggleSourceMute() {
        if (sourceReady && source.audio) {
            source.audio.muted = !source.audio.muted;
        }
    }

    PwObjectTracker {
        objects: [...root.sinks, ...root.sources]
    }
}
