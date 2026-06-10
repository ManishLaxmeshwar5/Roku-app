sub init()
    RBS_CC_43_reportLine("1", 1)
    m.settingsMenuList = m.top.findNode("settingsMenuList")
    RBS_CC_43_reportLine("2", 1)
    m.settingsDetailList = m.top.findNode("settingsDetailList")
    RBS_CC_43_reportLine("3", 1)
    m.settingsMenuList.observeField("itemFocused", "onMenuItemFocused")
    RBS_CC_43_reportLine("4", 1)
    m.settingsDetailList.observeField("itemSelected", "onDetailSelected")
    RBS_CC_43_reportLine("5", 1)
    m.settingsDetailList.observeField("itemFocused", "onDetailsItemFocused")
    RBS_CC_43_reportLine("6", 1)
    initViewModel()
    RBS_CC_43_reportLine("7", 1)
    m.viewModel.callFunc("loadMenu")
    RBS_CC_43_reportLine("8", 1)
    m.settingsMenuList.setFocus(true)
    RBS_CC_43_reportLine("9", 1)
    m.isopen = false
end sub

sub initViewModel()
    RBS_CC_43_reportLine("14", 1)
    m.viewModel = CreateObject("roSGNode", "SettingsViewModel")
    RBS_CC_43_reportLine("15", 1)
    m.viewModel.observeField("menuContent", "onMenuLoaded")
    RBS_CC_43_reportLine("16", 1)
    m.viewModel.observeField("detailContent", "onDetailLoaded")
    RBS_CC_43_reportLine("17", 1)
    m.viewModel.observeField("ttsEnabled", "onTTSChanged")
    RBS_CC_43_reportLine("18", 1)
    m.viewModel.observeField("toastData", "onToastData")
end sub

sub onMenuLoaded()
    ' stop
    RBS_CC_43_reportLine("24", 1)
    m.settingsMenuList.content = m.viewModel.menuContent
end sub

sub onDetailLoaded()
    RBS_CC_43_reportLine("29", 1)
    m.settingsDetailList.content = m.viewModel.detailContent
end sub

sub onTTSChanged()
    RBS_CC_43_reportLine("35", 1)
    m.global.ttsEnabled = m.viewModel.ttsEnabled
    if RBS_CC_43_reportLine("36", 2) and (m.viewModel.ttsEnabled)
        RBS_CC_43_reportLine("36", 3)
        RBS_CC_43_reportLine("37", 1)
        m.top.events = {
            type: "speak"
            text: "Text to speech enabled"
        }
    else
        RBS_CC_43_reportLine("41", 3)
        RBS_CC_43_reportLine("42", 1)
        m.top.events = {
            type: "speak"
            text: "Text to speech disabled"
        }
    end if
end sub

sub onToastData()
    RBS_CC_43_reportLine("51", 1)
    m.global.toast = m.viewModel.toastData
end sub

sub onDetailsItemFocused()
    RBS_CC_43_reportLine("56", 1)
    speakFocused(m.settingsDetailList)
end sub

sub onMenuItemFocused()
    RBS_CC_43_reportLine("61", 1)
    speakFocused(m.settingsMenuList)
    RBS_CC_43_reportLine("62", 1)
    m.isopen = true
    RBS_CC_43_reportLine("63", 1)
    index = m.settingsMenuList.itemFocused
    RBS_CC_43_reportLine("64", 1)
    item = m.settingsMenuList.content.getChild(index)
    if RBS_CC_43_reportLine("65", 2) and (not isValid(item)) then
        RBS_CC_43_reportLine("65", 3)
        RBS_CC_43_reportLine("65", 1)
        return
    end if
    RBS_CC_43_reportLine("66", 1)
    m.viewModel.callFunc("loadDetails", item.title)
    RBS_CC_43_reportLine("67", 1)
    m.settingsDetailList.visible = true
end sub

sub onDetailSelected()
    RBS_CC_43_reportLine("72", 1)
    index = m.settingsDetailList.itemSelected
    RBS_CC_43_reportLine("73", 1)
    item = m.settingsDetailList.content.getChild(index)
    if RBS_CC_43_reportLine("74", 2) and (not isValid(item)) then
        RBS_CC_43_reportLine("74", 3)
        RBS_CC_43_reportLine("74", 1)
        return
    end if
    RBS_CC_43_reportLine("75", 1)
    title = item.title
    RBS_CC_43_reportLine("76", 1)
    m.viewModel.callFunc("handleDetailSelection", title)
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if RBS_CC_43_reportLine("82", 2) and (not press) then
        RBS_CC_43_reportLine("82", 3)
        RBS_CC_43_reportLine("82", 1)
        return false
    end if
    if RBS_CC_43_reportLine("84", 2) and ((key = "left" or key = "back") and m.settingsDetailList.hasFocus())
        RBS_CC_43_reportLine("84", 3)
        RBS_CC_43_reportLine("85", 1)
        m.settingsMenuList.setFocus(true)
        RBS_CC_43_reportLine("86", 1)
        return true
    else if RBS_CC_43_reportLine("88", 2) and (key = "right")
        RBS_CC_43_reportLine("88", 3)
        if RBS_CC_43_reportLine("89", 2) and (m.settingsMenuList.hasFocus() and m.isopen)
            RBS_CC_43_reportLine("89", 3)
            RBS_CC_43_reportLine("90", 1)
            m.settingsDetailList.setFocus(true)
            RBS_CC_43_reportLine("91", 1)
            return true
        end if
    else if RBS_CC_43_reportLine("94", 2) and (key = "OK")
        RBS_CC_43_reportLine("94", 3)
        RBS_CC_43_reportLine("95", 1)
        m.settingsDetailList.setFocus(true)
        RBS_CC_43_reportLine("96", 1)
        return true
    end if
    RBS_CC_43_reportLine("98", 1)
    return false
end function

function RBS_CC_43_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "43"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "43"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./SettingsScreen.brs.map