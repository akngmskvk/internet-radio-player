import QtQuick 2.0
import QtQuick.Controls 2.2
import QtMultimedia 5.7

import "components"

Item {
    id: stationsList
    width: 1650
    height: 700
    transformOrigin: Item.Left

    property int itemCount: 6
    property int itemSpacing: 30
    property int itemWidth: (stationsList.width - (itemCount * itemSpacing)) / 6 //250
    property int itemHeight: stationsList.height * 0.68 // ~470

    // Global constructs
    property var stationsListView: stationsListView

    function minimize()
    {
        minimizeAction.start()
    }
    function maximize()
    {
        maximizeAction.start()
    }

    PropertyAnimation {
        id: minimizeAction
        target: stationsList
        properties: "scale"
        to: 0.79
        duration: 250
    }
    PropertyAnimation {
        id: maximizeAction
        target: stationsList
        properties: "scale"
        to: 1
        duration: 250
    }

    ListView {
        id: stationsListView
        width: parent.width
        height: parent.height
        currentIndex: -1
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        orientation: ListView.Horizontal
        spacing: 30
        model: dbm.stationsListModel
        property int playingIndex: -1
        delegate: ItemDelegate {
            id: stationItem
            anchors.verticalCenter: parent.verticalCenter
            property bool isSelected: ListView.isCurrentItem
            property bool isPressAndHold: false
            height: stationsListView.height
            width: (stationItem.isSelected) ? (itemWidth + itemSpacing) : (itemWidth)
            background: Rectangle {
                height: (stationItem.isSelected) ? (itemHeight + itemSpacing) : (itemHeight)
                width: (stationItem.isSelected) ? (itemWidth + itemSpacing) : (itemWidth)
                color: "#000000"
                radius: 10
                opacity: (stationItem.isSelected) ? 0.8 : 0.5
                border.width: (stationItem.isSelected ? 5 : 1)
                border.color: (stationItem.isSelected) ? "#39c7e3" : "#ebebeb"
            }
            onClicked: {
                if(stationsListView.playingIndex == index && radioPlayer.playbackState === Audio.PlayingState)
                {
                    radioPlayer.stop()
                }
                else
                {
                    radioPlayer.playStation(index)
                    stationsListView.playingIndex = index
                    newStationDrawer.station = dbm.getStationFromLM(index)
                }
                stationsListView.currentIndex = index
            }
            onPressAndHold: {
                stationItem.isPressAndHold = true
            }

            Image {
                id: playPauseIcon
                width: itemWidth * 0.8
                height: itemWidth * 0.8
                opacity: 0.3
                anchors.top: parent.top
                anchors.topMargin: itemWidth / 2
                anchors.horizontalCenter: parent.horizontalCenter
                source: resourcePath + ((stationItem.isSelected && radioPlayer.playbackState === Audio.PlayingState) ?
                                            "pause-icon.png" :
                                            "play-icon.png")
            }
            Text {
                id: stationText
                text: model.name
                width: itemWidth * 0.8
                height: itemWidth * 0.4
                wrapMode: Text.WordWrap
                elide: Text.ElideRight
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: playPauseIcon.bottom
                anchors.topMargin: 50
                font.pixelSize: (stationItem.isSelected) ? 42 : 35
                font.letterSpacing: 5
                color: (stationItem.isSelected) ? "#39c7e3" : "#ebebeb"
            }
            Column {
                visible: stationItem.isPressAndHold
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 15
                ItemButton{
                    id: closeBtn
                    width: 30
                    height: 30
                    textSize: 30
                    text: "☓"
                    anchors.right: parent.right
                    onClicked: {
                        stationItem.isPressAndHold = false
                    }
                }

                ItemButton {
                    id: editBtn
                    width: 200
                    height: 60
                    textSize: 25
                    text: "Edit"
                    onClicked: {
                        newStationDrawer.station = dbm.getStationFromLM(index)
                        newStationDrawer.copyStationInfosToTextFields()
                        newStationDrawer.isEdit = true
                        newStationDrawer.open()
                        stationItem.isPressAndHold = false
                    }
                }
                ItemButton {
                    id: deleteBtn
                    width: 200
                    height: 60
                    textSize: 25
                    text: "Remove"
                    onClicked: {
                        if ((radioPlayer.playbackState === Audio.PlayingState) &&
                                radioPlayer.stationData.name === model.name)
                        {
                            radioPlayer.stop()
                        }

                        if (stationsListView.currentIndex == index)
                        {
                            stationsListView.currentIndex = -1
                        }
                        dbm.removeStation(dbm.getStationFromLM(index))
                        stationItem.isPressAndHold = false
                    }
                }
            }
        }
    }
}
