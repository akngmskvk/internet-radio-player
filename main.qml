import QtQuick 2.10
import QtQuick.Window 2.10

Window {
    id: root
    visible: true
    width: 1920
    height: 1080
    title: qsTr("Internet Radio Player")
    visibility: "FullScreen"

    // Global constructs
    property string resourcePath: "qrc:/resources/"

    MainPage {
        id: mainPage
        anchors.fill: parent
    }
}
