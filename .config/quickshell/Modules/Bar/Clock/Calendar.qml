pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Services
import qs.Theme

ColumnLayout {
    spacing: 8

    DayOfWeekRow {
        Layout.fillWidth: true
        Layout.topMargin: 8
        Layout.leftMargin: 8
        Layout.rightMargin: 8

        implicitHeight: contentItem.height

        locale: monthGrid.locale

        delegate: Text {
            id: dayOfWeekText

            required property var model

            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: model.shortName

            font.family: Theme.fonts.sans
            font.pixelSize: Theme.fontSize.small
            font.weight: 500

            color: Theme.color.on_background
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
            id: todayIndicator

            readonly property Item todayItem: monthGrid
                .contentItem
                .children
                .find(c => c.model.today) ?? null;

            implicitWidth: todayItem?.implicitWidth ?? 0
            implicitHeight: todayItem?.implicitHeight ?? 0

            x: todayItem ? todayItem.x + (todayItem.width - implicitWidth) / 2 : 0
            y: todayItem?.y ?? 0

            radius: Math.min(implicitWidth, implicitHeight) / 2
            color: Theme.color.primary

            visible: todayItem
        }

        MonthGrid {
            id: monthGrid

            anchors.fill: parent

            month: TimeService.date.getMonth()
            year: TimeService.date.getFullYear()
            locale: Qt.locale("zh_CN")

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

                    color: Theme.color.on_background
                    opacity: monthGridEntry.model.month === monthGrid.month ? 1 : 0.4
                }
            }
        }
    }
}
