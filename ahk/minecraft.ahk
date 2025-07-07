#SingleInstance Force

HotIfWinActive "Minecraft"

^f:: {
    sendInput "^a"
    sendInput "{Delete}"

    sendInput "/"
    sleep(100)
    sendInput "reload"
    sleep(100)

    sendInput "{Enter}"
    ; sends in an update to trigger the previous input via mouse movement
    DllCall("mouse_event", "UInt", 0x0001, "Int", 1, "Int", 0, "UInt", 0, "UPtr", 0)
}
