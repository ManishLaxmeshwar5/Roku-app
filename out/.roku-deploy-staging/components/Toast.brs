sub init()
    m.toastBg = m.top.findNode("toastBg")
    m.toastLabel = m.top.findNode("toastLabel")
    m.slideIn    = m.top.findNode("slideIn")    ' ✅ was missing
    m.slideOut   = m.top.findNode("slideOut") 
    m.top.visible = false

    m.global.addField("toast","assocarray",false)
    m.global.observeField("toast","onToastRequested")

    m.hideTimer = CreateObject("roSGNode","Timer")
    m.hideTimer.repeat=false
    m.hideTimer.observeField("fire","onHideTimer")
    m.top.appendChild(m.hideTimer)
    
    m.hideAfterSlideTimer = CreateObject("roSGNode", "Timer")
    m.hideAfterSlideTimer.duration = 1
    m.hideAfterSlideTimer.repeat   = false
    m.hideAfterSlideTimer.observeField("fire", "onSlideOutDone")
    m.top.appendChild(m.hideAfterSlideTimer)


end sub

sub onToastRequested()
    print "toast requested: "+ FormatJson(m.global.toast)
    request=m.global.toast
    if request = invalid then return

    message = request.message
    duration= request.duration
    style= request.style

    if message = invalid or message ="" then return
    if duration= invalid or duration <= 0 then duration=3

    m.toastBg.translation = [350, -270]

    m.toastLabel.text = message
    m.top.visible     = true

    m.slideOut.control          = "stop"
    m.hideTimer.control         = "stop"
    m.hideAfterSlideTimer.control = "stop"

    m.slideIn.control    = "start"
    m.hideTimer.duration = duration
    m.hideTimer.control  = "start"

end sub

sub onHideTimer()
    m.slideIn.control  = "stop"
    m.slideOut.control = "start"
    m.hideAfterSlideTimer.control = "start"
end sub

sub onSlideOutDone()
        m.top.visible = false
end sub