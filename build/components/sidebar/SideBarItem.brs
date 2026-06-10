sub init()
    RBS_CC_47_reportLine("1", 1)
    m.bg = m.top.findNode("bg")
    RBS_CC_47_reportLine("2", 1)
    m.icon = m.top.findNode("icon")
    RBS_CC_47_reportLine("3", 1)
    m.label = m.top.findNode("label")
    RBS_CC_47_reportLine("6", 1)
    m.top.observeField("itemContent", "onItemContentChanged")
    RBS_CC_47_reportLine("7", 1)
    m.top.observeField("focusPercent", "onFocusChanged")
end sub

sub onItemContentChanged()
    RBS_CC_47_reportLine("11", 1)
    item = m.top.itemContent
    if RBS_CC_47_reportLine("12", 2) and (item = invalid) then
        RBS_CC_47_reportLine("12", 3)
        RBS_CC_47_reportLine("12", 1)
        return
    end if
    if RBS_CC_47_reportLine("14", 2) and (item.label <> invalid)
        RBS_CC_47_reportLine("14", 3)
        RBS_CC_47_reportLine("15", 1)
        m.label.text = item.label
    end if
    if RBS_CC_47_reportLine("18", 2) and (item.icon <> invalid)
        RBS_CC_47_reportLine("18", 3)
        RBS_CC_47_reportLine("19", 1)
        m.icon.uri = item.icon
    end if
end sub

sub onFocusChanged()
    if RBS_CC_47_reportLine("26", 2) and (m.top.focusPercent = 1)
        RBS_CC_47_reportLine("26", 3)
        RBS_CC_47_reportLine("27", 1)
        m.icon.opacity = "1.0"
        RBS_CC_47_reportLine("28", 1)
        m.label.opacity = "1.0"
    else
        RBS_CC_47_reportLine("29", 3)
        RBS_CC_47_reportLine("30", 1)
        m.icon.opacity = "0.5"
        RBS_CC_47_reportLine("31", 1)
        m.label.opacity = "0.5"
    end if
end sub

function RBS_CC_47_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "47"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "47"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./SideBarItem.brs.map