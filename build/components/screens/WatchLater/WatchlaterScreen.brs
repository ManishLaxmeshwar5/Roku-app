sub init()
    RBS_CC_45_reportLine("1", 1)
    initNodes()
    RBS_CC_45_reportLine("2", 1)
    initObservers()
    RBS_CC_45_reportLine("3", 1)
    setupViewModels()
    RBS_CC_45_reportLine("5", 1)
    loadContent()
    RBS_CC_45_reportLine("6", 1)
    m.top.setFocus(true)
    RBS_CC_45_reportLine("7", 1)
    m.emptyLabel.text = m.json["messages"]["watchlater_empty"][m.global.currentLang]
end sub

sub initNodes()
    RBS_CC_45_reportLine("11", 1)
    m.grid = m.top.findNode("watchLaterGrid")
    RBS_CC_45_reportLine("12", 1)
    m.emptyLabel = m.top.findNode("emptyLabel")
    RBS_CC_45_reportLine("13", 1)
    m.screenTitle = m.top.findNode("screenTitle")
end sub

sub initObservers()
    RBS_CC_45_reportLine("18", 1)
    m.top.observeField("focusedChild", "onFocusRequest")
    RBS_CC_45_reportLine("19", 1)
    m.grid.observeField("rowItemSelected", "onItemSelected")
    RBS_CC_45_reportLine("21", 1)
    m.global.observeField("watchLaterList", "loadContent")
end sub

sub setupViewModels()
    RBS_CC_45_reportLine("25", 1)
    m.viewModel = WatchLaterViewModel()
    RBS_CC_45_reportLine("26", 1)
    m.watchLaterModel = WatchLaterModel()
end sub

sub onFocusRequest()
    if RBS_CC_45_reportLine("30", 2) and (m.global.watchLaterList.count() > 0)
        RBS_CC_45_reportLine("30", 3)
        RBS_CC_45_reportLine("31", 1)
        m.grid.setFocus(true)
    end if
end sub

sub loadContent()
    RBS_CC_45_reportLine("37", 1)
    list = m.global.watchLaterList
    RBS_CC_45_reportLine("38", 1)
    m.json = translate()
    RBS_CC_45_reportLine("39", 1)
    m.screenTitle.text = m.json["messages"]["watchlater_title"][m.global.currentLang]
    RBS_CC_45_reportLine("40", 1)
    m.viewModel.setWatchLaterList(list)
    if RBS_CC_45_reportLine("43", 2) and (m.viewModel.isEmpty)
        RBS_CC_45_reportLine("43", 3)
        RBS_CC_45_reportLine("44", 1)
        m.emptyLabel.visible = true
        RBS_CC_45_reportLine("45", 1)
        m.grid.visible = false
        RBS_CC_45_reportLine("46", 1)
        speak("Your Watch Later is empty")
        RBS_CC_45_reportLine("47", 1)
        return
    end if
    RBS_CC_45_reportLine("49", 1)
    m.emptyLabel.visible = false
    RBS_CC_45_reportLine("51", 1)
    m.grid.visible = true
    RBS_CC_45_reportLine("53", 1)
    m.grid.content = m.viewModel.getGridContent()
end sub

sub onItemSelected()
    if RBS_CC_45_reportLine("59", 2) and (m.global.watchLaterList.count() = 0) then
        RBS_CC_45_reportLine("59", 3)
        RBS_CC_45_reportLine("59", 1)
        return
    end if
    RBS_CC_45_reportLine("61", 1)
    rowIndex = m.grid.rowItemSelected[0]
    RBS_CC_45_reportLine("62", 1)
    itemIndex = m.grid.rowItemSelected[1]
    RBS_CC_45_reportLine("64", 1)
    row = m.grid.content.getChild(rowIndex)
    if RBS_CC_45_reportLine("65", 2) and (row = invalid) then
        RBS_CC_45_reportLine("65", 3)
        RBS_CC_45_reportLine("65", 1)
        return
    end if
    RBS_CC_45_reportLine("67", 1)
    m.selectedItem = row.getChild(itemIndex)
    if RBS_CC_45_reportLine("68", 2) and (m.selectedItem = invalid) then
        RBS_CC_45_reportLine("68", 3)
        RBS_CC_45_reportLine("68", 1)
        return
    end if
    RBS_CC_45_reportLine("70", 1)
    speak(m.selectedItem.ShortDescriptionLine1 + " selected")
    RBS_CC_45_reportLine("71", 1)
    m.top.events = m.viewModel.getNavigationPayload(m.selectedItem)
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if RBS_CC_45_reportLine("77", 2) and (not press) then
        RBS_CC_45_reportLine("77", 3)
        RBS_CC_45_reportLine("77", 1)
        return false
    end if
    if RBS_CC_45_reportLine("78", 2) and (key = "options")
        RBS_CC_45_reportLine("78", 3)
        RBS_CC_45_reportLine("79", 1)
        list = m.global.watchLaterList
        if RBS_CC_45_reportLine("80", 2) and (not isValid(list) or list.count() = 0) then
            RBS_CC_45_reportLine("80", 3)
            RBS_CC_45_reportLine("80", 1)
            return true
        end if
        RBS_CC_45_reportLine("81", 1)
        focusedIndex = m.grid.itemFocused
        if RBS_CC_45_reportLine("82", 2) and (focusedIndex < 0 or focusedIndex >= list.count()) then
            RBS_CC_45_reportLine("82", 3)
            RBS_CC_45_reportLine("82", 1)
            return true
        end if
        RBS_CC_45_reportLine("83", 1)
        removedItem = list[focusedIndex]
        RBS_CC_45_reportLine("84", 1)
        list.delete(focusedIndex)
        RBS_CC_45_reportLine("85", 1)
        m.global.watchLaterList = list
        RBS_CC_45_reportLine("87", 1)
        speak("Removed from Watch Later")
        RBS_CC_45_reportLine("88", 1)
        m.global.toast = {
            message: removedItem.title + m.json["messages"]["watchlater_removed"][m.global.currentLang]
            duration: 2
        }
        RBS_CC_45_reportLine("92", 1)
        print "toast set: " + FormatJson(m.global.toast)
        RBS_CC_45_reportLine("94", 1)
        newCount = m.global.watchLaterList.count()
        if RBS_CC_45_reportLine("95", 2) and (newCount > 0)
            RBS_CC_45_reportLine("95", 3)
            RBS_CC_45_reportLine("96", 1)
            m.grid.setFocus(true)
            RBS_CC_45_reportLine("97", 1)
            m.grid.jumpToItem = min(focusedIndex, newCount - 1)
        end if
        RBS_CC_45_reportLine("100", 1)
        return true
    end if
    RBS_CC_45_reportLine("102", 1)
    return false
end function

function min(a as integer, b as integer) as integer
    if RBS_CC_45_reportLine("105", 2) and (a < b) then
        RBS_CC_45_reportLine("105", 3)
        RBS_CC_45_reportLine("105", 1)
        return a
    end if
    RBS_CC_45_reportLine("106", 1)
    return b
end function

function RBS_CC_45_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "45"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "45"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./WatchlaterScreen.brs.map