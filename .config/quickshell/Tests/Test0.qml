import QtQuick
import QtQuick.Layouts
import qs.Core.Services

Rectangle {
    id: rootPage
    width: 680
    height: 420
    color: "#11111b" // Deep dark background
    radius: 16
    border.color: "#313244"
    border.width: 1

    // Main Layout Container
    GridLayout {
        anchors.fill: parent
        anchors.margins: 24
        columns: 2
        columnSpacing: 20
        rowSpacing: 20

        // ================= CPU CARD =================
        StatCard {
            Layout.fillWidth: true
            Layout.fillHeight: true
            title: "CPU"
            accentColor: "#f38ba8" // Soft Red
            valueText: Math.round(SysInfoService.cpu.percent) + "%"
            subText: SysInfoService.cpu.temp.toFixed(1) + "°C"
            progress: SysInfoService.cpu.percent / 100.0
        }

        // ================= GPU CARD =================
        StatCard {
            Layout.fillWidth: true
            Layout.fillHeight: true
            title: "GPU"
            accentColor: "#a6e3a1" // Soft Green
            valueText: SysInfoService.gpu.percent + "%"
            subText: SysInfoService.gpu.temp + "°C"
            progress: SysInfoService.gpu.percent / 100.0
        }

        // ================= RAM CARD =================
        StatCard {
            Layout.fillWidth: true
            Layout.fillHeight: true
            title: "MEMORY"
            accentColor: "#fab387" // Orange
            valueText: (SysInfoService.ram.used_mb / 1024).toFixed(1) + " / " + (SysInfoService.ram.total_mb / 1024).toFixed(0) + " GB"
            subText: SysInfoService.ram.swap_used_mb > 0 
                     ? "Swap: " + (SysInfoService.ram.swap_used_mb / 1024).toFixed(1) + " GB" 
                     : "Swap Clear"
            progress: SysInfoService.ram.total_mb > 0 ? (SysInfoService.ram.used_mb / SysInfoService.ram.total_mb) : 0
        }

        // ================= DISK CARD =================
        StatCard {
            Layout.fillWidth: true
            Layout.fillHeight: true
            title: "STORAGE"
            accentColor: "#cba6f7" // Mauve/Purple
            valueText: SysInfoService.disk.used_gb + " / " + SysInfoService.disk.total_gb + " GB"
            subText: Math.round((SysInfoService.disk.used_gb / SysInfoService.disk.total_gb) * 100) + "% Utilized"
            progress: SysInfoService.disk.total_gb > 0 ? (SysInfoService.disk.used_gb / SysInfoService.disk.total_gb) : 0
        }

        // ================= NETWORK CARD (Spans 2 columns) =================
        Rectangle {
            Layout.columnSpan: 2
            Layout.fillWidth: true
            implicitHeight: 80
            color: "#181825"
            radius: 12
            border.color: "#313244"
            border.width: 1

            RowLayout {
                anchors.fill: parent
                anchors.margins: 16
                spacing: 30

                Text {
                    text: "NETWORK"
                    font.pixelSize: 12
                    font.bold: true
                    color: "#cdd6f4"
                    Layout.alignment: Qt.AlignVCenter
                }

                // Down Speed
                ColumnLayout {
                    spacing: 4
                    Layout.fillWidth: true
                    Text { text: "DOWNLOAD"; font.pixelSize: 10; color: "#a6adc8" }
                    Text { 
                        text: SysInfoService.network.rx_kbps > 1024 
                              ? (SysInfoService.network.rx_kbps / 1024).toFixed(1) + " Mbps" 
                              : SysInfoService.network.rx_kbps + " Kbps"
                        font.pixelSize: 16
                        font.bold: true
                        color: "#89b4fa" // Blue
                    }
                }

                // Up Speed
                ColumnLayout {
                    spacing: 4
                    Layout.fillWidth: true
                    Text { text: "UPLOAD"; font.pixelSize: 10; color: "#a6adc8" }
                    Text { 
                        text: SysInfoService.network.tx_kbps > 1024 
                              ? (SysInfoService.network.tx_kbps / 1024).toFixed(1) + " Mbps" 
                              : SysInfoService.network.tx_kbps + " Kbps"
                        font.pixelSize: 16
                        font.bold: true
                        color: "#b4befe" // Lavender
                    }
                }
            }
        }
    }

    // ================= REUSABLE CARD COMPONENT =================
    component StatCard: Rectangle {
        property string title: ""
        property string valueText: ""
        property string subText: ""
        property real progress: 0.0
        property color accentColor: "#ffffff"

        color: "#181825" // Card background
        radius: 12
        border.color: "#313244"
        border.width: 1

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 8

            // Header Row
            RowLayout {
                Layout.fillWidth: true
                Text {
                    text: title
                    font.pixelSize: 11
                    font.bold: true
                    color: "#a6adc8"
                }
                Item { Layout.fillWidth: true } // Spacer
                Text {
                    text: subText
                    font.pixelSize: 11
                    color: "#bac2de"
                }
            }

            // Big Stat Display
            Text {
                text: valueText
                font.pixelSize: 22
                font.bold: true
                color: "#cdd6f4"
            }

            Item { Layout.fillHeight: true } // Spacer to push progress bar down

            // Progress Bar Track
            Rectangle {
                Layout.fillWidth: true
                height: 6
                color: "#313244"
                radius: 3

                // Progress Fill
                Rectangle {
                    width: parent.width * Math.min(Math.max(rootPage.progress, 0), 1)
                    height: parent.height
                    color: accentColor
                    radius: 3

                    // Smooth animation transition when backend values update
                    Behavior on width {
                        NumberAnimation { duration: 250; easing.type: Easing.OutQuad }
                    }
                }
            }
        }
    }
}
