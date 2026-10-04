import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Rectangle {
    id: root
    width: 1920
    height: 1080
    color: "#223638"
    property date now: new Date()
    property bool busy: false
    property string message: ""
    readonly property color cream: "#eee8dd"
    readonly property color muted: "#bcb5ab"
    readonly property color red: "#bc3b3b"
    readonly property color dark: "#1c1717"

    FontLoader { id: face; source: "font.ttf" }
    Timer { interval: 1000; running: true; repeat: true; onTriggered: root.now = new Date() }

    function login() {
        if (busy) return
        if (!username.text.trim() || session.count === 0) {
            message = "Enter a username and select a session."
            return
        }
        message = ""
        busy = true
        sddm.login(username.text.trim(), password.text, session.currentIndex)
    }

    Connections {
        target: sddm
        function onLoginFailed() {
            root.busy = false
            root.message = "Login failed. Please try again."
            password.clear()
            password.forceActiveFocus()
        }
        function onLoginSucceeded() { root.message = "Welcome back!" }
        function onInformationMessage(message) { root.message = message }
    }

    Image {
        id: wallpaper
        anchors.fill: parent
        source: "background.jpg"
        fillMode: Image.PreserveAspectCrop
        visible: false
    }
    MultiEffect {
        anchors.fill: parent
        source: wallpaper
        blurEnabled: true
        blurMax: 64
        blur: 1.0
        brightness: -0.2
    }
    Rectangle { anchors.fill: parent; color: "#30223638" }

    component Card: Rectangle {
        radius: 25
        color: "#991c2827"
    }
    component LabelText: Text {
        color: root.cream
        font.family: face.name
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    component Action: Button {
        id: action
        property color fill: "#cda67d"
        font.family: face.name
        font.pixelSize: 18
        background: Rectangle {
            radius: 20
            color: action.down ? Qt.darker(action.fill, 1.2) : action.fill
            border.width: action.activeFocus ? 2 : 0
            border.color: root.cream
            opacity: action.enabled ? 1 : 0.5
        }
        contentItem: Text {
            text: action.text
            font: action.font
            color: root.dark
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    Item {
        width: 760
        height: 650
        anchors.centerIn: parent
        scale: Math.min(1, root.width / 900, root.height / 780)

        Card {
            width: 360; height: 380
            LabelText { x: 20; y: 32; width: 320; text: "NixOS · " + sddm.hostName; color: root.muted }
            LabelText { x: 20; y: 76; width: 320; text: "Log in"; font.pixelSize: 56 }

            Rectangle {
                x: 20; y: 185; width: 320; height: 70; radius: 20; color: root.red
                LabelText { x: 18; y: 6; text: "Username"; color: root.dark; font.pixelSize: 14 }
                TextField {
                    id: username
                    x: 10; y: 25; width: 300; height: 40
                    text: userModel.lastUser
                    color: root.dark
                    font.family: face.name; font.pixelSize: 28
                    selectByMouse: true
                    enabled: !root.busy
                    background: Item {}
                    onAccepted: password.forceActiveFocus()
                    KeyNavigation.tab: password
                }
            }
            Rectangle {
                x: 20; y: 275; width: 320; height: 70; radius: 20; color: root.red
                LabelText { x: 18; y: 6; text: "Password"; color: root.dark; font.pixelSize: 14 }
                TextField {
                    id: password
                    x: 10; y: 25; width: 300; height: 40
                    color: root.dark
                    font.family: face.name; font.pixelSize: 28
                    echoMode: TextInput.Password
                    selectByMouse: true
                    enabled: !root.busy
                    background: Item {}
                    onAccepted: root.login()
                    KeyNavigation.tab: session
                    KeyNavigation.backtab: username
                }
            }
        }

        Card {
            y: 410; width: 360; height: 160
            LabelText { y: 4; width: 360; height: 116; text: Qt.formatDateTime(root.now, "HH:mm"); font.pixelSize: 96 }
            LabelText { y: 122; width: 360; text: "Welcome back"; color: root.muted; font.pixelSize: 18 }
        }

        Card {
            x: 400; width: 360; height: 650
            Rectangle {
                x: 116; y: 26; width: 128; height: 128
                radius: 24; color: root.cream; border.width: 4; border.color: root.red
                Image { anchors.fill: parent; anchors.margins: 6; source: "avatar.png"; fillMode: Image.PreserveAspectFit }
            }
            LabelText { y: 168; width: 360; text: Qt.formatDateTime(root.now, "ddd").toUpperCase(); font.pixelSize: 56; font.bold: true }
            LabelText { y: 236; width: 360; text: Qt.formatDateTime(root.now, "dd MMMM, yyyy"); color: root.muted }
        }

        Card {
            x: 400; y: 330; width: 360; height: 320; color: "#f01c1717"
            LabelText { y: 16; width: 360; text: "Desktop session"; color: root.muted; font.pixelSize: 16 }
            ComboBox {
                id: session
                x: 20; y: 48; width: 320; height: 42
                model: sessionModel
                textRole: "name"
                currentIndex: Math.max(0, sessionModel.lastIndex)
                enabled: !root.busy
                font.family: face.name; font.pixelSize: 18
                palette.button: "#332a29"
                palette.buttonText: root.cream
                palette.text: root.cream
                palette.base: root.dark
                palette.highlight: root.red
                KeyNavigation.tab: loginButton
                KeyNavigation.backtab: password
            }
            Row {
                x: 20; y: 112; spacing: 20
                Action { width: 150; height: 75; text: "Restart"; enabled: sddm.canReboot && !root.busy; onClicked: sddm.reboot() }
                Action { width: 150; height: 75; text: "Power off"; enabled: sddm.canPowerOff && !root.busy; onClicked: sddm.powerOff() }
            }
            Action {
                id: loginButton
                x: 20; y: 205; width: 320; height: 70
                fill: root.red
                text: root.busy ? "Logging in…" : "Log in"
                font.pixelSize: 30
                enabled: !root.busy && session.count > 0
                onClicked: root.login()
                KeyNavigation.tab: username
                KeyNavigation.backtab: session
            }
            LabelText {
                x: 12; y: 282; width: 336; height: 32
                text: root.message
                font.pixelSize: 12
                color: root.cream
                wrapMode: Text.WordWrap
            }
        }
    }

    Component.onCompleted: {
        if (username.text) password.forceActiveFocus()
        else username.forceActiveFocus()
    }
}
