import QtQuick 2.0
import QtQuick.Controls 2.2
import QtMultimedia 5.7

Audio {
    id: radioPlayer
    playlist: Playlist{
        playbackMode: Playlist.Loop
    }
    onError: {
        console.log("Radio Playback Error = " + errorString)
    }

    property var stationData
    property string songName: (metaData.title) ? metaData.title : ""


    function playStation(index)
    {
        updateStationDataByIndex(index)
        radioPlayer.playlist.clear()
        radioPlayer.playlist.addItem(radioPlayer.stationData.url)
        radioPlayer.play()
    }

    function updateStationDataByIndex(index)
    {
        radioPlayer.stationData = dbm.getStationFromLM(index)
    }
}

