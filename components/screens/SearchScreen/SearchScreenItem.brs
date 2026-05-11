sub init()
    m.poster = m.top.findNode("poster")
    m.title = m.top.findNode("title")
    m.top.observeField("focused","onFocusChanged")
end sub

sub onItemContentChanged()
    if isValid(m.top.itemContent) 
        m.title.text = m.top.itemContent.ShortDescriptionLine1
        m.poster.uri = m.top.itemContent.hdPosterUrl
    end if
end sub

sub onFocusChanged()
end sub

