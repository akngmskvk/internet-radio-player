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

    property bool isEdit: false

    property var station: {
        'index': -1,
        'id': -1,
        'name': -1,
        'url': -1,
        'image': -1
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
            clearTextFields()
        }
    }

    Image {
        id: newStationImg
        width: 220
        height: 220
        source: resourcePath + ((isEdit) ? "edit-station.png" : "new-station.png")
        anchors.horizontalCenter: textColumn.horizontalCenter
        y: 100
    }

    Column {
        id: textColumn
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
        visible: !isEdit
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 150
        anchors.horizontalCenter: parent.horizontalCenter
        width: 200
        height: 60
        textSize: 25
        text: "Add Station"
        onClicked: {
            copyTextFieldsToStationObject()
            dbm.insertStation(station)
            clearTextFields()
            newStationDrawer.close()
        }
    }

    ItemButton {
        id: saveButton
        visible: isEdit
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 150
        anchors.horizontalCenter: parent.horizontalCenter
        width: 200
        height: 60
        textSize: 25
        text: "Save"
        onClicked: {
            copyTextFieldsToStationObject()
            dbm.updateStation(station)
            clearTextFields()
            newStationDrawer.close()
            isEdit = false
        }
    }
    function copyTextFieldsToStationObject()
    {
        station.name = nameField.text
        station.url = streamUrlField.text
    }

    function copyStationInfosToTextFields()
    {
        nameField.text = station.name;
        streamUrlField.text = station.url
    }

    function clearTextFields()
    {
        nameField.clear()
        streamUrlField.clear()
        nameField.focus = true
    }

}
