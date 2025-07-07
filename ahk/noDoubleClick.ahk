~RButton::
{
    static lastRClick := 0
    currentTime := A_TickCount
    if (currentTime - lastRClick < 250)
        return
    lastRClick := currentTime
}

~LButton::
{
    static lastClick := 0
    currentTime := A_TickCount
    if (currentTime - lastClick < 250) ; Ignore if within 250ms
        return
    lastClick := currentTime
}
