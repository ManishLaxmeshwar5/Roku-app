sub init()
    RBS_CC_10_reportLine("1", 1)
    m.poster = m.top.findNode("heroPreview")
    RBS_CC_10_reportLine("2", 1)
    m.titleLabel = m.top.findNode("titleLabel")
    RBS_CC_10_reportLine("3", 1)
    m.descLabel = m.top.findNode("descLabel")
    RBS_CC_10_reportLine("4", 1)
    m.Herotitle = m.top.findNode("Herotitle")
    RBS_CC_10_reportLine("5", 1)
    m.json = translate()
    RBS_CC_10_reportLine("6", 1)
    m.Herotitle.text = m.json["messages"]["new_arrivals"][m.global.currentLang]
end sub

sub onPosterUrlChanged()
    RBS_CC_10_reportLine("10", 1)
    m.poster.uri = m.top.posterUrl
end sub

sub onHeroTitleChanged()
    RBS_CC_10_reportLine("14", 1)
    m.titleLabel.text = m.top.heroTitle
end sub

sub onHeroDescChanged()
    RBS_CC_10_reportLine("18", 1)
    m.descLabel.text = m.top.heroDesc
end sub

function RBS_CC_10_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "10"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "10"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./UIHeroPreview.brs.map