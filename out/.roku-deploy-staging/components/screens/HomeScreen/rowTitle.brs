sub init()
    m.titleLabel = m.top.findNode("rowLabel")
    m.icon = m.top.findNode("rowImage")
end sub

sub onSetData()
    content = m.top.content
    if content <> invalid

        title = content.TITLE
        if title <> invalid and title <> ""
            m.titleLabel.text = title
        end if

        iconUri = content.icon
        if iconUri <> invalid and iconUri <> ""
            m.icon.uri = iconUri
            m.icon.visible = true
        else
            m.icon.visible = false
        end if
    end if
end sub