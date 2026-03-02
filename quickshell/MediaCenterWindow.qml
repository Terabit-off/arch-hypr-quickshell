import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Controls

import "./panelWidgets"

PanelWindow {
    id: popupManager

    WlrLayershell.layer: WlrLayershell.Overlay
    visible: false 
    
    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }
    implicitWidth: 400
    Colors {
        id: colors
    }
    //color: "transparent"

    function updateTimeDate(){
        timeDateText.text = Qt.formatDateTime(new Date(), "HH:mm      dd:MM:yyyy-dddd");
    }
    // PANEL
    Rectangle {
        id: myContent
        width: 400
        x: -50
        anchors {
    
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            rightMargin: 25
            topMargin: 15
            bottomMargin: 15
        }
        //focus: true
        color: colors.panelBackground
        //border.color: '#ffffff'
        radius: colors.panelBorderRadius
        
        ColumnLayout {
            anchors.fill: parent
            spacing: 5

            // CALENDAR
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: 40
                border.color: colors.moduleBorderColor
                color: colors.moduleBackgroundColor
                radius: colors.moduleBorderRadius

                ColumnLayout {
                    id: rootCalendar
                    anchors.fill: parent
                    spacing: 5

                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        // TIME, DATE
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.maximumHeight: 30
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            color: 'transparent'
                            
                            Text {
                                id: timeDateText
                                text: Qt.formatDateTime(new Date(), "HH:mm      dd.MM.yyyy-dddd");
                                anchors.centerIn: parent
                                font.pixelSize: 22
                                color: colors.foreground
                                font.bold: true
                            }
                        }
                    }
                }
            }
            // SEPARATOR
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: 1
                Layout.maximumWidth: 300
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                color: colors.separatorColor
            }
            // MUSIC
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: 150
                border.color: colors.moduleBorderColor

                color: colors.moduleBackgroundColor
                visible: MusicSingleton.active
                radius: colors.moduleBorderRadius

                MusicPanelWidget { }

            }
            // SEPARATOR
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: 1
                Layout.maximumWidth: 300
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                color: colors.separatorColor
            }
            // WEATHER
            WhetherPanelWidget {
                id: whetherPanelWidget
            }
            // SEPARATOR
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: 1
                Layout.maximumWidth: 300
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                color: colors.separatorColor
            }
            // SYSTEM MONITORING
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: 70
                //Layout.maximumWidth: 250
                Layout.alignment: Qt.AlignHCenter
                color: colors.moduleBackgroundColor
                border.color: colors.moduleBorderColor
                radius: colors.moduleBorderRadius

                SystemMonitor { }
            }
            // SEPARATOR
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: 1
                Layout.maximumWidth: 300
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                color: colors.separatorColor
            }
            // WI-FI and BLUETOOTH
            Rectangle {
                id: wifiBluetoothControl
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter
                color: colors.moduleBackgroundColor
                border.color: colors.moduleBorderColor
                radius: colors.moduleBorderRadius
                Layout.maximumHeight: 70

                ColumnLayout {
                    anchors.fill: parent
                    anchors.centerIn: parent

                    RowLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumHeight: 30
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.maximumHeight: 30
                            Layout.maximumWidth: 50
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            color: '#ff0000'
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    wifiBluetoothControl.Layout.maximumHeight === 250 ? 
                                        wifiBluetoothControl.Layout.maximumHeight = 70 : wifiBluetoothControl.Layout.maximumHeight = 250
                                    
                                    menus.visible = !menus.visible
                                }
                            }
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.maximumHeight: 30
                            Layout.maximumWidth: 50
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            color: '#0040ff'
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    wifiBluetoothControl.Layout.maximumHeight === 250 ? 
                                        wifiBluetoothControl.Layout.maximumHeight = 70 : wifiBluetoothControl.Layout.maximumHeight = 250
                                    
                                    menus.visible = !menus.visible
                                }
                            }
                        }
                    }
                    Rectangle {
                        id: menus
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        visible: false
                    }
                }
                //BluetoothPanel { }
            }

            // NOTIFICATIONS
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                //Layout.maximumHeight: 70
                //Layout.maximumWidth: 250
                Layout.alignment: Qt.AlignHCenter
                color: 'transparent'
                //border.color: colors.moduleBorderColor
                radius: colors.moduleBorderRadius
            }
        }
    }

    // HyprlandFocusGrab {
    //     windows: [testPopup]
    //     active: true

    //     onCleared: {
    //         testPopup.visible = false
    //         console.log("close")
    //     }
    // }

    Timer {
        id: hourlyTimer
        running: true
        repeat: true
        triggeredOnStart: true

        onTriggered: {
            // 1. Выполняем обновление погоды
            whetherPanelWidget.weatherProcesss.running = true;

            // 2. Рассчитываем время до следующего часа
            var now = new Date();
            var nextHour = new Date(
                now.getFullYear(),
                now.getMonth(),
                now.getDate(),
                now.getHours() + 1, // Следующий час
                0, 0, 0             // 00 минут, 00 секунд
            );

            var msToNextHour = nextHour.getTime() - now.getTime();
            
            // 3. Устанавливаем новый интервал
            // Добавляем небольшой запас (например, 1 сек), чтобы не попасть в 59:59
            interval = msToNextHour + 1000;
        }
    }
}
