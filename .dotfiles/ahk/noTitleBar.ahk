#SingleInstance Force

remove := true
Programs := [
    "ahk_exe Neovide.exe",
    ;"ahk_exe Neo.exe",
    "ahk_class ConsoleWindowClass"
]

SetTimer(removeTitleBar, 500)

removeTitleBar() {
    global remove
    if remove { 
        Loop Programs.length {
            if WinExist(Programs[A_Index]) {
                Try {
                    WinSetStyle(-0xC00000, Programs[A_Index])
                }
            }
        }
    } 
}

restoreTitleBar() {
    global remove
    remove := false
    ;WinSetStyle("+0xC00000", "A")
    Loop Programs.length {
        if WinExist(Programs[A_Index]) {
            Try {
                WinSetStyle(+0xC00000, Programs[A_Index])
            }
        }
    }
}

;- Remove Caption (Title Bar)
;^e::{
;    global remove
;
;    if remove == true {
;        remove := false
;        restoreTitleBar()
;    } else {
;        remove := true
;    }
;}
