import QtQuick 2.0
import QtQuick.Controls 2.2
import QtMultimedia 5.7

Column {
    id: stationInfo
    spacing: 7
    Text {
        id: stationName
        visible: (radioPlayer.playbackState === Audio.PlayingState)
        text: newStationDrawer.station.name
        width: 650
        height: 60
        anchors.horizontalCenter: parent.horizontalCenter
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "#39c7e3"
        opacity: 0.8
        font.pixelSize: 45
        font.letterSpacing: 2
    }
    Text {
        id: mediaInfo
        visible: (radioPlayer.playbackState === Audio.PlayingState)
        text: radioPlayer.songName
        width: 1000
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "#ebebeb"
        opacity: 0.8
        font.pixelSize: 35
        font.letterSpacing: 2
    }
}

