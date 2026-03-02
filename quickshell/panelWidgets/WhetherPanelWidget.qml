import Quickshell.Io
import QtQuick
import Quickshell
import QtQuick.Layouts

import ".."


Rectangle {
    id: weatherRect
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.maximumHeight: 150
    color: colors.moduleBackgroundColor
    border.color: colors.moduleBorderColor
    radius: colors.moduleBorderRadius

    property var weatherIcons: {
        "0": "󰖨",
        "1": "󰖕", "2": "󰖕", "3": "󰖕",
        "45": "󰖑", "48": "󰖑",
        "51": "󰖗", "53": "󰖗", "55": "󰖗",
        "61": "󰖖", "63": "󰖖", "65": "󰖖",
        "71": "󰼶", "73": "󰼶", "75": "󰼶",
        "80": "󰖖", "81": "󰖖", "82": "󰖖",
        "95": "󰖓", "96": "󰖓", "99": "󰖓"
    }
    property var temps
    property var codes
    property var currentHour: 12

    property alias weatherProcesss: whetherProcess
    Process {
        id: whetherProcess
        command: ["curl", "-s", "https://api.open-meteo.com/v1/forecast?latitude=44.2233&longitude=42.0578&hourly=temperature_2m,weather_code&forecast_days=1"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                try{
                    let response = JSON.parse(this.text)
                    //console.log(response)
                    let now = new Date();
                    weatherRect.temps = response.hourly.temperature_2m
                    weatherRect.codes = response.hourly.weather_code
                    weatherRect.currentHour = now.getHours()
                    weatherRect.fillWhether()

                } catch(e){
                    console.log("error: " + e)
                    weatherRect.errorWether()
                }
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.topMargin: 20
        spacing: 5

        // CURRENT
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.maximumHeight: 30
            anchors.bottomMargin: 10

            // WHETHER ICON
            Text {
                id: currentWhetherIcon
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumWidth: 80
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                text: "󰖨"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: '#ffffff'
                font.pixelSize: 66
                font.bold: true
            }

            // WHETHER TEMP
            Text {
                id: currentWhetherTemp
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumWidth: 80
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                text: "-- \n --:--"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: '#ffffff'
                font.pixelSize: 18
                font.bold: true
            }
            Text {
                id: whetherUpdate
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumWidth: 80
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                text: "RELOAD"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: '#ffd3d3'
                font.pixelSize: 18
                font.bold: true
                visible: false
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        whetherProcess.running = true
                        whetherUpdate.visible = false
                        console.log("whether reload")
                    }
                }
            }
        }
        //SEPARATOR
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumHeight: 1
            Layout.maximumWidth: 150
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.topMargin: 10
            color: colors.separatorColor
        }
        // FUTURE WHETHER
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.maximumHeight: 50

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: 'transparent'

                ColumnLayout {
                    anchors.fill: parent
                    //Layout.maximumHeight: 30
                    RowLayout {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.maximumWidth: 60

                        Text {
                            id: currentWhetherIcon1
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            text: "󰖨"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            color: '#ffffff'
                            font.pixelSize: 20
                            font.bold: true
                        }
                        // WHETHER TEMP
                        Text {
                            id: currentWhetherTemp1
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            text: "--"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            color: '#ffffff'
                            font.pixelSize: 14
                            font.bold: true
                        }
                    }
                    Text {
                        id: currentWhetherTime1
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        text: '--:--'
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: '#ffffff'
                        font.pixelSize: 12
                        font.bold: true
                    }
                }
            }
            // SEPARATOR
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: 20
                Layout.maximumWidth: 1
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                color: colors.separatorColor
            }
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: 'transparent'

                ColumnLayout {
                    anchors.fill: parent
                    Layout.maximumHeight: 30
                    RowLayout {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.maximumWidth: 60

                        Text {
                            id: currentWhetherIcon2
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            text: "󰖨"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            color: '#ffffff'
                            font.pixelSize: 20
                            font.bold: true
                        }
                        // WHETHER TEMP
                        Text {
                            id: currentWhetherTemp2
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            text: "--"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            color: '#ffffff'
                            font.pixelSize: 14
                            font.bold: true
                        }
                    }
                    Text {
                        id: currentWhetherTime2
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        text: '--:--'
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: '#ffffff'
                        font.pixelSize: 12
                        font.bold: true
                    }
                }
            }
            // SEPARATOR
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: 20
                Layout.maximumWidth: 1
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                color: colors.separatorColor
            }
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: 'transparent'

                ColumnLayout {
                    anchors.fill: parent
                    Layout.maximumHeight: 30
                    RowLayout {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.maximumWidth: 60

                        Text {
                            id: currentWhetherIcon3
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            text: "󰖨"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            color: '#ffffff'
                            font.pixelSize: 20
                            font.bold: true
                        }
                        // WHETHER TEMP
                        Text {
                            id: currentWhetherTemp3
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            text: "--"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            color: '#ffffff'
                            font.pixelSize: 14
                            font.bold: true
                        }
                    }
                    Text {
                        id: currentWhetherTime3
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        text: '--:--'
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: '#ffffff'
                        font.pixelSize: 12
                        font.bold: true
                    }
                }
            }
            // SEPARATOR
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: 20
                Layout.maximumWidth: 1
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                color: colors.separatorColor
            }
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: 'transparent'

                ColumnLayout {
                    anchors.fill: parent
                    Layout.maximumHeight: 30
                    RowLayout {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.maximumWidth: 60

                        Text {
                            id: currentWhetherIcon4
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            text: "󰖨"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            color: '#ffffff'
                            font.pixelSize: 20
                            font.bold: true
                        }
                        // WHETHER TEMP
                        Text {
                            id: currentWhetherTemp4
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            text: "--"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            color: '#ffffff'
                            font.pixelSize: 14
                            font.bold: true
                        }
                    }
                    Text {
                        id: currentWhetherTime4
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        text: '--:--'
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: '#ffffff'
                        font.pixelSize: 12
                        font.bold: true
                    }
                }
            }
        }
    }
    function errorWether(){
        currentWhetherIcon.text = "󰖨"
        currentWhetherTemp.text = "-- \n error"

        currentWhetherIcon1.text = "󰖨"
        currentWhetherIcon2.text = "󰖨"
        currentWhetherIcon3.text = "󰖨"
        currentWhetherIcon4.text = "󰖨"

        currentWhetherTemp1.text = "--"
        currentWhetherTemp2.text = "--"
        currentWhetherTemp3.text = "--"
        currentWhetherTemp4.text = "--"

        currentWhetherTime1.text = "--:--"
        currentWhetherTime2.text = "--:--"
        currentWhetherTime3.text = "--:--"
        currentWhetherTime4.text = "--:--"

        whetherUpdate.visible = true
    }

    function fillWhether(){
        currentWhetherIcon.text = weatherRect.weatherIcons[weatherRect.codes[weatherRect.currentHour]] + ""
        currentWhetherTemp.text = weatherRect.temps[weatherRect.currentHour] + "° \n" + weatherRect.currentHour + ":00"

        currentWhetherIcon1.text = weatherRect.weatherIcons[weatherRect.codes[is24(weatherRect.currentHour + 1)]] + ""
        currentWhetherIcon2.text = weatherRect.weatherIcons[weatherRect.codes[is24(weatherRect.currentHour + 2)]] + ""
        currentWhetherIcon3.text = weatherRect.weatherIcons[weatherRect.codes[is24(weatherRect.currentHour + 3)]] + ""
        currentWhetherIcon4.text = weatherRect.weatherIcons[weatherRect.codes[is24(weatherRect.currentHour + 4)]] + ""

        currentWhetherTemp1.text = weatherRect.temps[is24(weatherRect.currentHour + 1)] + "°"
        currentWhetherTemp2.text = weatherRect.temps[is24(weatherRect.currentHour + 2)] + "°"
        currentWhetherTemp3.text = weatherRect.temps[is24(weatherRect.currentHour + 3)] + "°"
        currentWhetherTemp4.text = weatherRect.temps[is24(weatherRect.currentHour + 4)] + "°"

        currentWhetherTime1.text = is24(weatherRect.currentHour + 1) + ":00"
        currentWhetherTime2.text = is24(weatherRect.currentHour + 2) + ":00"
        currentWhetherTime3.text = is24(weatherRect.currentHour + 3) + ":00"
        currentWhetherTime4.text = is24(weatherRect.currentHour + 4) + ":00"

        whetherUpdate.visible = false
    }

    function is24(n){
        if(n >= 24) return n - 24
        return n
    }
}