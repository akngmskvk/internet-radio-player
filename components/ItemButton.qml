import QtQuick 2.0

Item {
    id: itemButton

    property string text: ""
    property int textSize: 20
    property int letterSpacing: 2
    property string passiveTextColor: "#ebebeb"
    property string activeTextColor: "#39c7e3"
    property string passiveBackgroundColor: "#212121"
    property string activeBackgroundColor: "#0b1f24"

    property bool isReleased: true

    signal clicked();
    signal pressAndHold();
    signal pressed();
    signal released();

    Rectangle {
        id: backgroundRect
        anchors.fill: parent
        color: itemButton.isReleased ? passiveBackgroundColor : activeBackgroundColor
        radius: 15
        border.width: 1
        border.color: "#3d3d3d"
    }

    Text {
        id: itemButtonText
        text: itemButton.text
        width: itemButton.width * 0.9
        height: itemButton.height * 0.9
        anchors.centerIn: parent
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: itemButton.isReleased ? passiveTextColor : activeTextColor
        font.pixelSize: itemButton.textSize
        font.letterSpacing: itemButton.letterSpacing

        MouseArea {
            id: itemButtonMouseArea
            anchors.fill: parent
            onClicked: {
                itemButton.clicked();
            }

            onPressAndHold: {
                itemButton.pressAndHold();
            }
            onPressed: {
                itemButton.pressed();
                isReleased = false
            }
            onReleased: {
                itemButton.released();
                isReleased = true
            }
        }
    }
}
