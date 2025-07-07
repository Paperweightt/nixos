#SingleInstance Force

F19Down := false

*~F19::
{
    global F19Down

    F19Down := true
    return
}

*~F19 up::
{
    global F19Down

    F19Down := false
    return
}

~D::
{
    global F19Down

    if !F19Down {
       return
    }

    hwnd := WinExist("ahk_exe discord.exe")

    if hwnd {
        WinActivate(hwnd)
    } else {
        Run("C:\Users\henry\AppData\Local\Discord\Update.exe")
    }
}

~S::
{
    global F19Down

    if !F19Down {
       return
    }

    hwnd := WinExist("ahk_exe spotify.exe")

    if hwnd {
        WinActivate(hwnd)
    } else {
        Run("C:\Users\henry\AppData\Roaming\Spotify\Spotify.exe")
    }
}

~C:: 
{
    global F19Down

    if !F19Down {
       return
    }

    hwnd := WinExist("ahk_exe neovide.exe")

    if hwnd {
        WinActivate(hwnd)
    } else {
        Run("C:\Users\henry\.dotfiles\neo\neo.exe")
    }
}

~Z::
{
    global F19Down

    if !F19Down {
       return
    }

    hwnd := WinExist("ahk_exe zen.exe")

    if hwnd {
        WinActivate(hwnd)
    } else {
        Run("C:\Program Files\Zen Browser\zen.exe")
    }
}
