sub init()
    RBS_CC_12_reportLine("1", 1)
    m.base = m.top.findNode("rect")
    RBS_CC_12_reportLine("2", 1)
    m.bar = m.top.findNode("bar")
    RBS_CC_12_reportLine("3", 1)
    m.offset = 0
    RBS_CC_12_reportLine("5", 1)
    m.top.observeField("rectWidth", "updateSize")
    RBS_CC_12_reportLine("6", 1)
    m.top.observeField("rectHeight", "updateSize")
    RBS_CC_12_reportLine("7", 1)
    m.top.observeField("rectColor", "updateSize")
    RBS_CC_12_reportLine("9", 1)
    startAnimation()
end sub
' sub updateSize()
'     w = m.top.rectWidth
'     h = m.top.rectHeight
'     m.base.color = m.top.rectColor
'     m.base.width = w
'     m.base.height = h
'     m.bar.height = h
' end sub
' sub updateSize()
'     w = m.top.rectWidth
'     h = m.top.rectHeight
'     ? "======================"
'     ? "rectColor value = "; m.top.rectColor
'     ? "rectColor type  = "; type(m.top.rectColor)
'     ? "======================"
'     m.base.color = m.top.rectColor

'     m.base.width = w
'     m.base.height = h
'     m.bar.height = h
' end sub
sub updateSize()
    RBS_CC_12_reportLine("36", 1)
    w = m.top.rectWidth
    RBS_CC_12_reportLine("37", 1)
    h = m.top.rectHeight
    if RBS_CC_12_reportLine("39", 2) and (m.top.rectColor <> invalid and m.top.rectColor <> "") then
        RBS_CC_12_reportLine("39", 3)
        RBS_CC_12_reportLine("40", 1)
        m.base.color = m.top.rectColor
    else
        RBS_CC_12_reportLine("41", 3)
        RBS_CC_12_reportLine("42", 1)
        m.base.color = "0x696969FF"
    end if
    RBS_CC_12_reportLine("45", 1)
    m.base.width = w
    RBS_CC_12_reportLine("46", 1)
    m.base.height = h
    RBS_CC_12_reportLine("47", 1)
    m.bar.height = h
end sub

sub startAnimation()
    RBS_CC_12_reportLine("51", 1)
    m.timer = createObject("roSGNode", "Timer")
    RBS_CC_12_reportLine("52", 1)
    m.timer.duration = 0.03
    RBS_CC_12_reportLine("53", 1)
    m.timer.repeat = true
    RBS_CC_12_reportLine("54", 1)
    m.timer.observeField("fire", "onTick")
    RBS_CC_12_reportLine("55", 1)
    m.timer.control = "start"
end sub

sub onTick()
    RBS_CC_12_reportLine("59", 1)
    m.offset = m.offset + 8
    if RBS_CC_12_reportLine("60", 2) and (m.offset > m.base.width + 100) then
        RBS_CC_12_reportLine("60", 3)
        RBS_CC_12_reportLine("61", 1)
        m.offset = -100
    end if
    RBS_CC_12_reportLine("63", 1)
    m.bar.translation = [
        m.offset
        0
    ]
end sub

sub stopAnim()
    if RBS_CC_12_reportLine("67", 2) and (m.timer <> invalid) then
        RBS_CC_12_reportLine("67", 3)
        RBS_CC_12_reportLine("68", 1)
        m.timer.control = "stop"
        RBS_CC_12_reportLine("69", 1)
        m.timer = invalid
    end if
end sub

function RBS_CC_12_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "12"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "12"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./UIShimmerScreen.brs.map