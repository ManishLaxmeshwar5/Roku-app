sub init()
    m.poster = m.top.findNode("poster")
    m.title = m.top.findNode("title")
    m.focusBg = m.top.findNode("focusBg")
    m.shimmer = m.top.findNode("shimmer")
    if m.top.itemContent <> invalid
        showPoster()
    else 
        showShimmer()
    end if
    m.top.observeField("focused", "onFocusChanged")
end sub


sub showShimmer()
    m.shimmer.visible = true
    m.shimmer.clippingRect = [0, 0, 200, 250]
    m.timer = createObject("roSGNode", "Timer")
    m.timer.duration = 1
    m.timer.repeat = false
    m.timer.observeField("fire", "showPoster")
    m.timer.control = "start"
end sub

sub showPoster()
    content = m.top.itemContent
    if content = invalid then return

    if content.HDPosterUrl <> invalid
        m.poster.uri = content.HDPosterUrl
    end if

    m.shimmer.visible = false
    if content.ShortDescriptionLine1 <> invalid
        m.title.text = content.ShortDescriptionLine1
    end if
    m.shimmer.callFunc("stopAnim")
end sub


sub onFocusChanged()
    if m.top.focused
        m.focusBg.visible = true
        m.top.scale = [1.05, 1.05]
    else
        m.focusBg.visible = false
        m.top.scale = [1.0, 1.0]
    end if
end sub