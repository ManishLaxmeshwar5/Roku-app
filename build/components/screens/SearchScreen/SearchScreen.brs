sub init()
    RBS_CC_42_reportLine("1", 1)
    initNodes()
    RBS_CC_42_reportLine("2", 1)
    initObservers()
    RBS_CC_42_reportLine("3", 1)
    initViewModels()
    RBS_CC_42_reportLine("4", 1)
    m.keyboard.setFocus(true)
    RBS_CC_42_reportLine("6", 1)
    m.currentFocus = 0
    if RBS_CC_42_reportLine("8", 2) and (m.global.ttsEnabled = false)
        RBS_CC_42_reportLine("8", 3)
        RBS_CC_42_reportLine("9", 1)
        m.keyboard.muteAudioGuide = "true"
        RBS_CC_42_reportLine("10", 1)
        m.instructions.muteAudioGuide = "true"
    end if
    RBS_CC_42_reportLine("13", 1)
    m.searchTimer = CreateObject("roSGNode", "Timer")
    RBS_CC_42_reportLine("14", 1)
    m.searchTimer.duration = 0.5
    RBS_CC_42_reportLine("15", 1)
    m.searchTimer.repeat = false
    RBS_CC_42_reportLine("16", 1)
    m.searchTimer.observeField("fire", "performSearch")
    RBS_CC_42_reportLine("17", 1)
    m.json = translate()
    RBS_CC_42_reportLine("18", 1)
    m.instructions.text = m.json["messages"]["search_placeholder"][m.global.currentLang]
    RBS_CC_42_reportLine("19", 1)
    m.noResultsLabel.text = m.json["messages"]["no_results"][m.global.currentLang]
end sub

sub initNodes()
    RBS_CC_42_reportLine("23", 1)
    m.keyboard = m.top.findNode("searchkeyboard")
    RBS_CC_42_reportLine("24", 1)
    m.rowList = m.top.findNode("rowList")
    RBS_CC_42_reportLine("25", 1)
    m.resultsBg = m.top.findNode("resultBackground")
    RBS_CC_42_reportLine("26", 1)
    m.noResults = m.top.findNode("noResultsContainer")
    RBS_CC_42_reportLine("27", 1)
    m.instructions = m.top.findNode("instructionsLabel")
    RBS_CC_42_reportLine("28", 1)
    m.noResultsLabel = m.top.findNode("noResultsLabel")
end sub

sub initObservers()
    RBS_CC_42_reportLine("32", 1)
    m.top.observeField("focusedChild", "onFocusChange")
    RBS_CC_42_reportLine("33", 1)
    m.keyboard.observeField("text", "onSearchTextChanged")
    RBS_CC_42_reportLine("34", 1)
    m.rowList.observeField("rowItemSelected", "onItemSelected")
    RBS_CC_42_reportLine("35", 1)
    m.rowList.observeField("rowItemFocused", "onItemFocused")
end sub

sub initViewModels()
    RBS_CC_42_reportLine("39", 1)
    m.viewModel = CreateObject("roSGNode", "SearchViewModel")
    RBS_CC_42_reportLine("40", 1)
    m.viewModel.observeField("searchResults", "onSearchResults")
    RBS_CC_42_reportLine("41", 1)
    m.viewModel.observeField("hasResults", "onResultsStateChanged")
    RBS_CC_42_reportLine("42", 1)
    m.viewModel.observeField("isEmptyQuery", "onEmptyQuery")
end sub

sub onFocusChange()
    if RBS_CC_42_reportLine("46", 2) and (m.top.hasFocus())
        RBS_CC_42_reportLine("46", 3)
        if RBS_CC_42_reportLine("47", 2) and (m.currentFocus = 1)
            RBS_CC_42_reportLine("47", 3)
            RBS_CC_42_reportLine("48", 1)
            m.rowList.setFocus(true)
        else
            RBS_CC_42_reportLine("49", 3)
            RBS_CC_42_reportLine("50", 1)
            m.keyboard.setFocus(true)
        end if
    end if
end sub

sub onSearchTextChanged(event as object)
    RBS_CC_42_reportLine("56", 1)
    m.query = LCase(event.getData())
    RBS_CC_42_reportLine("57", 1)
    m.searchTimer.control = "start"
end sub

sub performSearch()
    RBS_CC_42_reportLine("61", 1)
    m.viewModel.callFunc("search", m.query)
end sub

sub onSearchResults()
    RBS_CC_42_reportLine("66", 1)
    content = m.viewModel.searchResults
    if RBS_CC_42_reportLine("67", 2) and (content <> invalid)
        RBS_CC_42_reportLine("67", 3)
        RBS_CC_42_reportLine("68", 1)
        m.rowList.content = content
    end if
end sub

sub onResultsStateChanged()
    if RBS_CC_42_reportLine("73", 2) and (m.viewModel.hasResults)
        RBS_CC_42_reportLine("73", 3)
        RBS_CC_42_reportLine("74", 1)
        m.resultsBg.visible = true
        RBS_CC_42_reportLine("75", 1)
        m.rowList.visible = true
        RBS_CC_42_reportLine("76", 1)
        m.noResults.visible = false
        RBS_CC_42_reportLine("77", 1)
        m.instructions.visible = false
        RBS_CC_42_reportLine("78", 1)
        speak("Result found press right to go to results")
    else
        RBS_CC_42_reportLine("79", 3)
        RBS_CC_42_reportLine("80", 1)
        m.resultsBg.visible = false
        RBS_CC_42_reportLine("81", 1)
        m.rowList.visible = false
        RBS_CC_42_reportLine("82", 1)
        m.noResults.visible = true
        RBS_CC_42_reportLine("83", 1)
        m.instructions.visible = false
        RBS_CC_42_reportLine("84", 1)
        speak("No results found")
    end if
end sub

sub onEmptyQuery()
    if RBS_CC_42_reportLine("89", 2) and (m.viewModel.isEmptyQuery)
        RBS_CC_42_reportLine("89", 3)
        RBS_CC_42_reportLine("90", 1)
        m.resultsBg.visible = false
        RBS_CC_42_reportLine("91", 1)
        m.noResults.visible = false
        RBS_CC_42_reportLine("92", 1)
        m.instructions.visible = true
        RBS_CC_42_reportLine("93", 1)
        m.rowList.visible = false
        RBS_CC_42_reportLine("94", 1)
        m.rowList.content = invalid
    end if
end sub

sub onItemFocused()
    RBS_CC_42_reportLine("99", 1)
    indices = m.rowList.rowItemFocused
    RBS_CC_42_reportLine("100", 1)
    item = m.rowList.content.getChild(indices[0]).getChild(indices[1])
    if RBS_CC_42_reportLine("101", 2) and (not isValid(item)) then
        RBS_CC_42_reportLine("101", 3)
        RBS_CC_42_reportLine("101", 1)
        return
    end if
    RBS_CC_42_reportLine("102", 1)
    text = getContentTitle(item)
    if RBS_CC_42_reportLine("103", 2) and (isNonEmptyString(text))
        RBS_CC_42_reportLine("103", 3)
        RBS_CC_42_reportLine("104", 1)
        speak(text)
    end if
end sub

sub onItemSelected()
    RBS_CC_42_reportLine("109", 1)
    indices = m.rowList.rowItemFocused
    RBS_CC_42_reportLine("110", 1)
    row = m.rowList.content.getChild(indices[0])
    if RBS_CC_42_reportLine("111", 2) and (not isValid(row)) then
        RBS_CC_42_reportLine("111", 3)
        RBS_CC_42_reportLine("111", 1)
        return
    end if
    RBS_CC_42_reportLine("112", 1)
    item = row.getChild(indices[1])
    if RBS_CC_42_reportLine("113", 2) and (not isValid(item)) then
        RBS_CC_42_reportLine("113", 3)
        RBS_CC_42_reportLine("113", 1)
        return
    end if
    RBS_CC_42_reportLine("114", 1)
    speak(getContentTitle(item) + " selected")
    RBS_CC_42_reportLine("115", 1)
    m.top.events = {
        type: "navigate"
        screen: "DetailScreen"
        payload: item
    }
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if RBS_CC_42_reportLine("123", 2) and (press)
        RBS_CC_42_reportLine("123", 3)
        if RBS_CC_42_reportLine("124", 2) and (key = "right")
            RBS_CC_42_reportLine("124", 3)
            if RBS_CC_42_reportLine("125", 2) and (m.keyboard.isInFocusChain() and m.rowList.visible)
                RBS_CC_42_reportLine("125", 3)
                RBS_CC_42_reportLine("126", 1)
                m.rowList.setFocus(true)
                RBS_CC_42_reportLine("127", 1)
                m.currentFocus = 1
                RBS_CC_42_reportLine("128", 1)
                return true
            end if
        else if RBS_CC_42_reportLine("130", 2) and (key = "left")
            RBS_CC_42_reportLine("130", 3)
            if RBS_CC_42_reportLine("131", 2) and (m.rowList.isInFocusChain())
                RBS_CC_42_reportLine("131", 3)
                RBS_CC_42_reportLine("132", 1)
                m.keyboard.setFocus(true)
                RBS_CC_42_reportLine("133", 1)
                m.currentFocus = 0
                RBS_CC_42_reportLine("134", 1)
                return true
            end if
        else if RBS_CC_42_reportLine("136", 2) and (key = "back")
            RBS_CC_42_reportLine("136", 3)
            if RBS_CC_42_reportLine("137", 2) and (m.rowList.hasFocus())
                RBS_CC_42_reportLine("137", 3)
                RBS_CC_42_reportLine("138", 1)
                m.keyboard.setFocus(true)
                RBS_CC_42_reportLine("139", 1)
                return true
            end if
            RBS_CC_42_reportLine("141", 1)
            return false
        end if
    end if
    RBS_CC_42_reportLine("144", 1)
    return false
end function

function RBS_CC_42_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "42"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "42"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./SearchScreen.brs.map