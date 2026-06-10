sub init()
    RBS_CC_41_reportLine("1", 1)
    m.movieRowList = m.top.findNode("rowList")
    RBS_CC_41_reportLine("2", 1)
    m.movieRowList.setFocus(true)
    RBS_CC_41_reportLine("3", 1)
    initObservers()
    RBS_CC_41_reportLine("4", 1)
    initViewModel()
    RBS_CC_41_reportLine("5", 1)
    m.contentType = ""
    RBS_CC_41_reportLine("6", 1)
    m.deepLinkId = invalid
    RBS_CC_41_reportLine("7", 1)
    m.isDeepLink = false
    RBS_CC_41_reportLine("8", 1)
    m.itemSize = m.movieRowList.rowItemSize
end sub

sub initViewModel()
    RBS_CC_41_reportLine("12", 1)
    m.viewModel = CreateObject("roSGNode", "MovieViewModel")
    RBS_CC_41_reportLine("13", 1)
    m.viewModel.observeField("movieContent", "onMovieContentLoaded")
    RBS_CC_41_reportLine("14", 1)
    m.viewModel.observeField("deepLinkItem", "onDeepLinkItemFound")
end sub

sub initObservers()
    RBS_CC_41_reportLine("18", 1)
    m.movieRowList.observeField("rowItemFocused", "onMovieFocused")
    RBS_CC_41_reportLine("19", 1)
    m.movieRowList.observeField("rowItemSelected", "onMovieSelected")
    RBS_CC_41_reportLine("20", 1)
    m.top.observeField("screenData", "onScreenDataChanged")
    RBS_CC_41_reportLine("21", 1)
    m.top.observeField("focusedChild", "onFocusRequest")
    RBS_CC_41_reportLine("22", 1)
    m.top.observeField("deepLinkPayload", "onDeepLinkPayloadChanged")
end sub

sub onMovieContentLoaded()
    RBS_CC_41_reportLine("26", 1)
    m.movieRowList.content = invalid
    RBS_CC_41_reportLine("27", 1)
    m.movieRowList.content = m.viewModel.movieContent
    if RBS_CC_41_reportLine("28", 2) and (m.isDeepLink = true and m.deepLinkId <> invalid)
        RBS_CC_41_reportLine("28", 3)
        RBS_CC_41_reportLine("29", 1)
        m.viewModel.callFunc("handleDeepLink", m.deepLinkId, m.contentType)
    end if
end sub

sub onDeepLinkItemFound()
    RBS_CC_41_reportLine("35", 1)
    item = m.viewModel.deepLinkItem
    if RBS_CC_41_reportLine("37", 2) and (not isValid(item)) then
        RBS_CC_41_reportLine("37", 3)
        RBS_CC_41_reportLine("37", 1)
        return
    end if
    RBS_CC_41_reportLine("39", 1)
    m.top.events = {
        type: "navigate"
        screen: "DetailScreen"
        payload: item
    }
    RBS_CC_41_reportLine("44", 1)
    m.isDeepLink = false
    RBS_CC_41_reportLine("45", 1)
    m.deepLinkId = invalid
    RBS_CC_41_reportLine("46", 1)
    m.top.deepLinkPayload = invalid
end sub

sub onScreenDataChanged()
    RBS_CC_41_reportLine("50", 1)
    payload = m.top.screenData
    if RBS_CC_41_reportLine("51", 2) and (not isValid(payload)) then
        RBS_CC_41_reportLine("51", 3)
        RBS_CC_41_reportLine("51", 1)
        return
    end if
    if RBS_CC_41_reportLine("53", 2) and (isValid(payload.contentType))
        RBS_CC_41_reportLine("53", 3)
        RBS_CC_41_reportLine("54", 1)
        m.contentType = payload.contentType
    end if
    RBS_CC_41_reportLine("56", 1)
    m.viewModel.callFunc("loadContent", m.contentType)
end sub

sub onDeepLinkPayloadChanged()
    RBS_CC_41_reportLine("60", 1)
    payload = m.top.deepLinkPayload
    if RBS_CC_41_reportLine("61", 2) and (not isValid(payload)) then
        RBS_CC_41_reportLine("61", 3)
        RBS_CC_41_reportLine("61", 1)
        return
    end if
    if RBS_CC_41_reportLine("63", 2) and (isValid(payload.contentType))
        RBS_CC_41_reportLine("63", 3)
        RBS_CC_41_reportLine("64", 1)
        m.contentType = payload.contentType
    end if
    if RBS_CC_41_reportLine("67", 2) and (isValid(payload.deepLinkId))
        RBS_CC_41_reportLine("67", 3)
        RBS_CC_41_reportLine("68", 1)
        m.deepLinkId = payload.deepLinkId
        RBS_CC_41_reportLine("69", 1)
        m.isDeepLink = true
    end if
    RBS_CC_41_reportLine("71", 1)
    m.viewModel.callFunc("loadContent", m.contentType)
end sub

sub onFocusRequest()
    RBS_CC_41_reportLine("75", 1)
    m.movieRowList.setFocus(true)
end sub

sub onMovieFocused()
    RBS_CC_41_reportLine("79", 1)
    focusedIndices = m.movieRowList.rowItemFocused
    RBS_CC_41_reportLine("80", 1)
    itemIndex = focusedIndices[1]
    RBS_CC_41_reportLine("81", 1)
    rowIndex = focusedIndices[0]
    RBS_CC_41_reportLine("82", 1)
    item = m.movieRowList.content.getChild(rowIndex).getChild(itemIndex)
    RBS_CC_41_reportLine("83", 1)
    text = item.ShortDescriptionLine1
    if RBS_CC_41_reportLine("85", 2) and (text = invalid or text = "")
        RBS_CC_41_reportLine("85", 3)
        RBS_CC_41_reportLine("86", 1)
        text = item.title
    end if
    if RBS_CC_41_reportLine("89", 2) and (text = invalid or text = "") then
        RBS_CC_41_reportLine("89", 3)
        RBS_CC_41_reportLine("89", 1)
        return
    end if
    RBS_CC_41_reportLine("90", 1)
    speak(text)
end sub

sub onMovieSelected()
    RBS_CC_41_reportLine("94", 1)
    selectedIndices = m.movieRowList.rowItemSelected
    RBS_CC_41_reportLine("95", 1)
    itemIndex = selectedIndices[1]
    RBS_CC_41_reportLine("96", 1)
    rowIndex = selectedIndices[0]
    if RBS_CC_41_reportLine("98", 2) and (itemIndex >= 0)
        RBS_CC_41_reportLine("98", 3)
        RBS_CC_41_reportLine("99", 1)
        content = m.movieRowList.content.getChild(rowIndex)
        if RBS_CC_41_reportLine("100", 2) and (content <> invalid)
            RBS_CC_41_reportLine("100", 3)
            RBS_CC_41_reportLine("101", 1)
            selectedItem = content.getChild(itemIndex)
            if RBS_CC_41_reportLine("102", 2) and (selectedItem <> invalid)
                RBS_CC_41_reportLine("102", 3)
                RBS_CC_41_reportLine("103", 1)
                speak(selectedItem.ShortDescriptionLine1 + " selected")
                RBS_CC_41_reportLine("104", 1)
                event = {
                    type: "navigate"
                    screen: "DetailScreen"
                    payload: selectedItem
                }
                RBS_CC_41_reportLine("109", 1)
                m.top.events = event
                RBS_CC_41_reportLine("110", 1)
                print "payload:" event.payload
            end if
        end if
    end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if RBS_CC_41_reportLine("117", 2) and (not press) then
        RBS_CC_41_reportLine("117", 3)
        RBS_CC_41_reportLine("117", 1)
        return false
    end if
    if RBS_CC_41_reportLine("119", 2) and (key = "left")
        RBS_CC_41_reportLine("119", 3)
        RBS_CC_41_reportLine("120", 1)
        m.top.goback = true
    end if
    RBS_CC_41_reportLine("122", 1)
    return false
end function

function RBS_CC_41_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "41"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "41"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./MovieScreen.brs.map