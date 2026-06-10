sub init()
    RBS_CC_8_reportLine("1", 1)
    m.toastBg = m.top.findNode("toastBg")
    RBS_CC_8_reportLine("2", 1)
    m.toastLabel = m.top.findNode("toastLabel")
    RBS_CC_8_reportLine("3", 1)
    m.slideIn = m.top.findNode("slideIn")
    RBS_CC_8_reportLine("4", 1)
    m.slideOut = m.top.findNode("slideOut")
    RBS_CC_8_reportLine("5", 1)
    m.top.visible = false
    RBS_CC_8_reportLine("7", 1)
    m.global.addField("toast", "assocarray", false)
    RBS_CC_8_reportLine("8", 1)
    m.global.observeField("toast", "onToastRequested")
    RBS_CC_8_reportLine("10", 1)
    m.hideTimer = CreateObject("roSGNode", "Timer")
    RBS_CC_8_reportLine("11", 1)
    m.hideTimer.repeat = false
    RBS_CC_8_reportLine("12", 1)
    m.hideTimer.observeField("fire", "onHideTimer")
    RBS_CC_8_reportLine("13", 1)
    m.top.appendChild(m.hideTimer)
    RBS_CC_8_reportLine("15", 1)
    m.hideAfterSlideTimer = CreateObject("roSGNode", "Timer")
    RBS_CC_8_reportLine("16", 1)
    m.hideAfterSlideTimer.duration = 1
    RBS_CC_8_reportLine("17", 1)
    m.hideAfterSlideTimer.repeat = false
    RBS_CC_8_reportLine("18", 1)
    m.hideAfterSlideTimer.observeField("fire", "onSlideOutDone")
    RBS_CC_8_reportLine("19", 1)
    m.top.appendChild(m.hideAfterSlideTimer)
end sub

sub onToastRequested()
    RBS_CC_8_reportLine("25", 1)
    request = m.global.toast
    if RBS_CC_8_reportLine("26", 2) and (request = invalid) then
        RBS_CC_8_reportLine("26", 3)
        RBS_CC_8_reportLine("26", 1)
        return
    end if
    RBS_CC_8_reportLine("28", 1)
    message = request.message
    RBS_CC_8_reportLine("29", 1)
    duration = request.duration
    RBS_CC_8_reportLine("30", 1)
    style = request.style
    if RBS_CC_8_reportLine("32", 2) and (message = invalid or message = "") then
        RBS_CC_8_reportLine("32", 3)
        RBS_CC_8_reportLine("32", 1)
        return
    end if
    if RBS_CC_8_reportLine("33", 2) and (duration = invalid or duration <= 0) then
        RBS_CC_8_reportLine("33", 3)
        RBS_CC_8_reportLine("33", 1)
        duration = 3
    end if
    RBS_CC_8_reportLine("35", 1)
    m.toastBg.translation = [
        350
        -270
    ]
    RBS_CC_8_reportLine("37", 1)
    m.toastLabel.text = message
    RBS_CC_8_reportLine("38", 1)
    m.top.visible = true
    RBS_CC_8_reportLine("40", 1)
    m.slideOut.control = "stop"
    RBS_CC_8_reportLine("41", 1)
    m.hideTimer.control = "stop"
    RBS_CC_8_reportLine("42", 1)
    m.hideAfterSlideTimer.control = "stop"
    RBS_CC_8_reportLine("44", 1)
    m.slideIn.control = "start"
    RBS_CC_8_reportLine("45", 1)
    m.hideTimer.duration = duration
    RBS_CC_8_reportLine("46", 1)
    m.hideTimer.control = "start"
end sub

sub onHideTimer()
    RBS_CC_8_reportLine("51", 1)
    m.slideIn.control = "stop"
    RBS_CC_8_reportLine("52", 1)
    m.slideOut.control = "start"
    RBS_CC_8_reportLine("53", 1)
    m.hideAfterSlideTimer.control = "start"
end sub

sub onSlideOutDone()
    RBS_CC_8_reportLine("57", 1)
    m.top.visible = false
end sub

function RBS_CC_8_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "8"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "8"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./Toast.brs.map