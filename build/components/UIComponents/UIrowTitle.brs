sub init()
    RBS_CC_13_reportLine("1", 1)
    m.titleLabel = m.top.findNode("rowLabel")
    RBS_CC_13_reportLine("2", 1)
    m.icon = m.top.findNode("rowImage")
end sub

sub onSetData()
    RBS_CC_13_reportLine("6", 1)
    content = m.top.content
    if RBS_CC_13_reportLine("7", 2) and (content <> invalid)
        RBS_CC_13_reportLine("7", 3)
        RBS_CC_13_reportLine("9", 1)
        title = content.TITLE
        if RBS_CC_13_reportLine("10", 2) and (title <> invalid and title <> "")
            RBS_CC_13_reportLine("10", 3)
            RBS_CC_13_reportLine("11", 1)
            m.titleLabel.text = title
        end if
        RBS_CC_13_reportLine("14", 1)
        iconUri = content.icon
        if RBS_CC_13_reportLine("15", 2) and (iconUri <> invalid and iconUri <> "")
            RBS_CC_13_reportLine("15", 3)
            RBS_CC_13_reportLine("16", 1)
            m.icon.uri = iconUri
            RBS_CC_13_reportLine("17", 1)
            m.icon.visible = true
        else
            RBS_CC_13_reportLine("18", 3)
            RBS_CC_13_reportLine("19", 1)
            m.icon.visible = false
        end if
    end if
end sub

function RBS_CC_13_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "13"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "13"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./UIrowTitle.brs.map