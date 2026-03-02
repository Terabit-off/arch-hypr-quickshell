import QtQuick
import QtQuick.Layouts
import Quickshell
import Qt5Compat.GraphicalEffects

import ".."

RowLayout {
    spacing: 0
    anchors.fill: parent

    Colors {
        id: colors
    }
    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        //Layout.maximumHeight: 150
        //Layout.maximumWidth: 150
        color: "transparent"

        Rectangle {
            id: shadowRec
            anchors.fill: parent
            anchors.rightMargin: 0
            radius: colors.moduleBorderRadius - 7
            anchors.margins: 10
            color: '#ffffff'
        }

        AnimatedImage {
            id: catGif
            anchors.centerIn: parent
            anchors.margins: 10
            anchors.fill: parent
            source: "bongo-cat.gif"
            fillMode: Image.PreserveAspectFit
            paused: !MusicSingleton.isPlaying

            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Rectangle {
                    width: catGif.width
                    height: catGif.height
                    radius: colors.moduleBorderRadius - 7
                }
            }
        }
    }
    // CONTROLS
    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        color: 'transparent'
        ColumnLayout {
            spacing: 5
            anchors {
                fill: parent
                topMargin: 15
            }

            //TRACK
            Text {
                id: musicNameText
                Layout.fillWidth: true
                Layout.maximumHeight: 10
                Layout.maximumWidth: 160
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                text: MusicSingleton.active ? MusicSingleton.active.metadata["xesam:title"] : "Пусто"
                horizontalAlignment: Text.AlignHCenter
                color: '#ffffff'
                font.pixelSize: 18
                elide: Text.ElideRight
                font.bold: true
            }
            //ARTIST
            Text {
                id: musicArtistText
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: 25
                Layout.maximumWidth: 160
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                text: MusicSingleton.active ? MusicSingleton.active.trackArtist : "Пусто"
                horizontalAlignment: Text.AlignHCenter
                color: "#ffffff"
                font.pixelSize: 12
                elide: Text.ElideRight
                font.bold: true
            }
            //Controls
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 10
                Text {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillWidth: true
                    Layout.maximumWidth: 35
                    horizontalAlignment: Text.AlignHCenter
                    height: 30
                    color: '#ffffff'
                    text: "󰒮"
                    font.pixelSize: 30

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (MusicSingleton.active && MusicSingleton.active.canGoPrevious) {
                                MusicSingleton.active.previous()
                            }
                        }
                    }
                }
                //PAUSE
                Text {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillWidth: true
                    Layout.maximumWidth: 35
                    horizontalAlignment: Text.AlignHCenter
                    height: 30
                    color: '#ffffff'
                    text: MusicSingleton.isPlaying ? "󰏤" : "󰐊"
                    font.pixelSize: 30

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (MusicSingleton.active) {
                                MusicSingleton.active.togglePlaying()
                            }
                        }
                    }
                }
                Text {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillWidth: true
                    Layout.maximumWidth: 35
                    horizontalAlignment: Text.AlignHCenter
                    height: 30
                    color: '#ffffff'
                    text: "󰒭"
                    font.pixelSize: 30

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (MusicSingleton.active && MusicSingleton.active.canGoNext) {
                                MusicSingleton.active.next()
                            }
                        }
                    }
                }
            }
        }
    }
}