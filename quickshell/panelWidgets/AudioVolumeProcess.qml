import QtQuick.Controls
import Quickshell.Io
import QtQuick
import Quickshell
import QtQuick.Layouts

import ".."


RowLayout {
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.minimumHeight: 30
    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

    Text {
        text: "󰕾"
        color: colors.foreground
        Layout.fillWidth: true
        font.pixelSize: 14
        Layout.alignment: Qt.AlignHCenter
        Layout.maximumWidth: 30
    }
    Slider {
        id: volumeSlider
        from: 0
        to: 100
        value: 2
        Layout.fillWidth: true
        Layout.maximumWidth: 200

        background: Rectangle {
            x: parent.leftPadding
            y: parent.topPadding + parent.availableHeight / 2 - height / 2
            implicitWidth: 200
            implicitHeight: 4
            width: parent.availableWidth
            height: implicitHeight
            radius: 2
            color: colors.sliderBackgroundColor

            Rectangle {
                width: parent.parent.visualPosition * parent.width
                height: parent.height
                color: colors.sliderBackgroundFillColor
                radius: 2
            }
        }


        handle: Rectangle {
            x: parent.leftPadding + parent.visualPosition * (parent.availableWidth - width)
            y: parent.topPadding + parent.availableHeight / 2 - height / 2
            implicitWidth: 5
            implicitHeight: 13
            radius: colors.sliderHandlerBorderRadius
            color: colors.sliderHandlerColor
            border.color: colors.sliderHandlerBorderColor
        }
        
        onMoved: {
            volumeUpdate.running = true
        }
    }
    Text {
        text: Math.round(volumeSlider.value) + "%"
        color: colors.foreground
        font.bold: true
        Layout.fillWidth: true
        font.pixelSize: 14
        Layout.alignment: Qt.AlignHCenter
        Layout.maximumWidth: 30
    }

    Process {
        id: volumeUpdate
        running: false
        command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", volumeSlider.value/100]
        stdout: StdioCollector {
            onStreamFinished: {
                //brightnessUpdateProcess.running = true
            }
        }
    }
    Process {
        id: volumeLoad
        running: true
        command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
        stdout: StdioCollector {
            onStreamFinished: {
                let vol = parseFloat(this.text.trim().replace(/[^\d,.]/g, "").replace(",", "."))
                volumeSlider.value = vol * 100
            }
        }
    }
}