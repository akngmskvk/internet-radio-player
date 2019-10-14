import QtQuick 2.0
import QtQuick.Controls 2.2

import "components"

Page {
    id: mainPage
    background: Image {
        id: backgroundImg
        source: resourcePath + "ir-background.jpg"
    }

    RadioPlayer {
        id: radioPlayer
    }

    StationInfo {
        id: stationInfo
        anchors.horizontalCenter: parent.horizontalCenter
        y: 75
    }

    NewStationDrawer {
        id: newStationDrawer
    }

    DBM {
        id: dbm
    }

    StationsList {
        id: stationsList
        x: 30
//        anchors.verticalCenter: parent.verticalCenter
        y: 300
    }

    ItemButton {
        id: addStationBtn
        visible: (!newStationDrawer.opened)
        text: "Add\nNew\nStation\n⬅"
        textSize: 30
        letterSpacing: 5
        width: 180
        height: 350
        anchors.top: parent.top
        anchors.topMargin: 350
        anchors.right: parent.right
        anchors.rightMargin: 20
        onClicked: {
            newStationDrawer.open()
        }
    }
}
