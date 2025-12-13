import Quickshell
import QtQuick
import QtQuick.Controls
import qs.Components

PanelWindow {
    width: 400
    height: 600
    color: "#222222"

    Column {
        spacing: 5
        anchors.centerIn: parent

        SearchBar {
            implicitWidth: 200
        }

        ListView {
            id: menu
            width: parent.width
            height: parent.height - input.height
            model: ["Firefox", "Terminal", "Code", "Files"]

            delegate: Item {
                width: parent.width
                height: 40

                Text {
                    text: modelData
                    anchors.verticalCenter: parent.verticalCenter
                    color: "#ffffff"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        launch(modelData)
                    }
                }
            }

            function filter(query) {
                for (let i = 0; i < model.length; i++) {
                    let item = get(i)
                    item.visible = model[i].toLowerCase().includes(query.toLowerCase())
                }
            }
        }

        function launch(name) {
            // Quickshell.run(name)
            // Qt.quit()
        }
    }
}
