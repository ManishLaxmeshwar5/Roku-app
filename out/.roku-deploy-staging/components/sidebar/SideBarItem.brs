sub init()
    m.bg = m.top.findNode("bg")
    m.icon = m.top.findNode("icon")
    m.label = m.top.findNode("label")


    m.top.observeField("itemContent", "onItemContentChanged")
    m.top.observeField("focusPercent", "onFocusChanged")
end sub

sub onItemContentChanged()
    item = m.top.itemContent
    if item = invalid then return

    if item.label <> invalid
        m.label.text = item.label
    end if

    if item.icon <> invalid
        m.icon.uri = item.icon
    end if
end sub


sub onFocusChanged()

    if m.top.focusPercent = 1
        m.icon.opacity = "1.0"
        m.label.opacity = "1.0"
    else
        m.icon.opacity = "0.5"
        m.label.opacity = "0.5"
    end if
end sub