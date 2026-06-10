sub init()
    m.base = m.top.findNode("rect")
    m.bar = m.top.findNode("bar")
    m.offset = 0

    m.top.observeField("rectWidth", "updateSize")
    m.top.observeField("rectHeight", "updateSize")
    m.top.observeField("rectColor","updateSize")

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
    w = m.top.rectWidth
    h = m.top.rectHeight

    if m.top.rectColor <> invalid and m.top.rectColor <> "" then
        m.base.color = m.top.rectColor
    else
        m.base.color = "0x696969FF"
    end if

    m.base.width = w
    m.base.height = h
    m.bar.height = h
end sub

sub startAnimation()
    m.timer = createObject("roSGNode", "Timer")
    m.timer.duration = 0.03
    m.timer.repeat = true
    m.timer.observeField("fire", "onTick")
    m.timer.control = "start"
end sub

sub onTick()
    m.offset = m.offset + 8
    if m.offset > m.base.width + 100 then
        m.offset = -100
    end if
    m.bar.translation = [m.offset, 0]
end sub

sub stopAnim()
    if m.timer <> invalid then
        m.timer.control = "stop"
        m.timer = invalid
    end if
end sub