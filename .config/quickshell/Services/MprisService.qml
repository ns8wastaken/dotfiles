pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Singleton {
    id: root

    readonly property list<MprisPlayer> players: Mpris.players.values
    readonly property MprisPlayer active: players[0] ?? null
    readonly property bool isPlaying: active?.playbackState == MprisPlaybackState.Playing

    FrameAnimation {
        running: !!root.active && root.isPlaying
        onTriggered: {
            if (root.active) {
                root.active.positionChanged();
            }
        }
    }
}
