sub init()
    m.poster = m.top.findNode("heroPreview")
    m.titleLabel = m.top.findNode("titleLabel")
    m.descLabel = m.top.findNode("descLabel")
end sub

sub onPosterUrlChanged()
    m.poster.uri = m.top.posterUrl
end sub

sub onHeroTitleChanged()
    m.titleLabel.text = m.top.heroTitle
end sub

sub onHeroDescChanged()
    m.descLabel.text = m.top.heroDesc
end sub