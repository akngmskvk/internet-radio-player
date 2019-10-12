import QtQuick 2.0
import QtQuick.Controls 2.2

import "components"

Drawer {
    id: newStationDrawer
    width: mainPage.width * 0.3
    height: mainPage.height
    edge: Qt.RightEdge
    interactive: false
    dim: false
    background: Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.5
    }
    scale: mainPage.scale
    onClosed: {
        mainPage.focus = true
    }

    ItemButton {
        id: closeDrawer
        x: 20
        y: 20
        text: "➠"
        textSize: 40
        width: 50
        height: 50
        onClicked: {
            newStationDrawer.close()
        }
    }

    Column {
        anchors.centerIn: parent
        spacing: 50
        Column {
            spacing: 15
            Text {
                id: nameText
                text: "Station Name:"
                font.letterSpacing: 2
                font.pixelSize: 20
                color: "#39c7e3"

            }

            TextField {
                id: nameField
                background: Rectangle {
                    anchors.fill: parent
                    color: "#212121"
                    opacity: 0.5
                    radius: 8
                }
                placeholderText: "Please enter station name"
                horizontalAlignment: TextInput.AlignLeft
                width: newStationDrawer.width * 0.8
                color: "#ebebeb"
                font.pixelSize: 20
                height: 50
            }
        }

        Column {
            spacing: 15
            Text {
                id: streamUrlText
                text: "Station Stream URL:"
                font.letterSpacing: 2
                font.pixelSize: 20
                color: "#39c7e3"

            }

            TextField {
                id: streamUrlField
                background: Rectangle {
                    anchors.fill: parent
                    color: "#212121"
                    opacity: 0.5
                    radius: 8
                }
                placeholderText: "Please enter stream URL of station"
                horizontalAlignment: TextInput.AlignLeft
                width: newStationDrawer.width * 0.8
                color: "#ebebeb"
                font.pixelSize: 20
                height: 50
            }
        }
    }

    ItemButton {
        id: addButton
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 150
        anchors.horizontalCenter: parent.horizontalCenter
        width: 200
        height: 60
        textSize: 25
        text: "Add Station"
    }


}
