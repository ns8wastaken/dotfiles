pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Services
import qs.Theme

ColumnLayout {
    DayOfWeekRow {
        Layout.fillWidth: true
        // Layout.topMargin: 8
        Layout.leftMargin: 8
        Layout.rightMargin: 8

        locale: monthGrid.locale

        delegate: Text {
            required property var model

            horizontalAlignment: Text.AlignHCenter

            text: model.shortName

            font.family: Theme.fonts.sans
            font.pixelSize: Theme.fontSize.small
            font.weight: 500

            color: Theme.colors.textPrimary
        }
    }

    Item {
        id: monthGridWrapper

        Layout.fillWidth: true
        Layout.leftMargin: 8
        Layout.rightMargin: 8
        Layout.bottomMargin: 8

        implicitHeight: monthGrid.implicitHeight

        Rectangle {
            readonly property Item todayItem: monthGrid
                .contentItem
                .children
                .find(c => c.model.today) ?? null;

            implicitWidth: todayItem?.implicitWidth ?? 0
            implicitHeight: todayItem?.implicitHeight ?? 0

            x: todayItem ? todayItem.x + (todayItem.width - implicitWidth) / 2 : 0
            y: todayItem?.y ?? 0

            // radius: Math.min(implicitWidth, implicitHeight) / 2
            radius: 10000
            color: Theme.colors.highlight

            visible: todayItem
        }

        MonthGrid {
            id: monthGrid

            anchors.fill: parent

            month: TimeService.date.getMonth()
            year: TimeService.date.getFullYear()
            locale: Qt.locale()

            delegate: Item {
                id: monthGridEntry

                required property var model

                implicitWidth: implicitHeight
                implicitHeight: monthGridEntryText.height + 4 * 2

                Text {
                    id: monthGridEntryText

                    anchors.centerIn: parent

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    text: monthGridEntry.model.day

                    font.family: Theme.fonts.sans
                    font.pixelSize: Theme.fontSize.small

                    color: Theme.colors.textPrimary
                    opacity: monthGridEntry.model.month === monthGrid.month ? 1 : 0.4
                }
            }
        }
        // Rectangle {
        //     readonly property Item todayItem: monthGrid
        //         .contentItem
        //         .children
        //         .find(c => c.model.today) ?? null;
        //
        //     implicitWidth: todayItem?.implicitWidth ?? 0
        //     implicitHeight: todayItem?.implicitHeight ?? 0
        //
        //     x: todayItem ? todayItem.x + (todayItem.implicitWidth - implicitWidth) / 2 : 0
        //     y: todayItem?.y ?? 0
        //
        //     // radius: Math.min(implicitWidth, implicitHeight) / 2
        //     radius: 10000
        //     color: Theme.colors.highlight
        //
        //     visible: todayItem
        // }
    }
}
