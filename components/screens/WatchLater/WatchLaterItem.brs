sub init()
    m.poster     = m.top.findNode("itemPoster")
    m.title      = m.top.findNode("itemTitle")
    m.focusBorder = m.top.findNode("focusBorder")
end sub


sub onContentSet()
    content = m.top.itemContent
    if not isValid(content) then return

    m.title.text  = content.ShortDescriptionLine1
    m.poster.uri  = content.HDPosterUrl
end sub


