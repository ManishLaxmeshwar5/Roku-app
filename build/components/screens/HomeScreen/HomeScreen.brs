sub init()
    RBS_CC_40_reportLine("2", 1)
    m.TOP_MARGIN = 20
    RBS_CC_40_reportLine("3", 1)
    m.LEFT_MARGIN = 60
    RBS_CC_40_reportLine("4", 1)
    m.SECTION_GAP = 20
    RBS_CC_40_reportLine("6", 1)
    initNodes()
    RBS_CC_40_reportLine("7", 1)
    initObservers()
    RBS_CC_40_reportLine("8", 1)
    initViewModel()
    RBS_CC_40_reportLine("10", 1)
    m.carouselHeight = 0
    RBS_CC_40_reportLine("11", 1)
    m.cwHeight = 0
    RBS_CC_40_reportLine("12", 1)
    m.hpHeight = 0
    RBS_CC_40_reportLine("14", 1)
    m.currentSection = 0
    RBS_CC_40_reportLine("16", 1)
    m.RowListItem = CreateObject("roSGNode", "UIRowListItem")
    RBS_CC_40_reportLine("18", 1)
    m.startupTimer = m.top.findNode("startupTimer")
    RBS_CC_40_reportLine("20", 1)
    m.startupTimer.observeField("fire", "onStartupTimerFired")
    RBS_CC_40_reportLine("22", 1)
    m.bookmarks = {}
    RBS_CC_40_reportLine("24", 1)
    m.registry = CreateObject("roRegistrySection", "VideoBookmarks")
    RBS_CC_40_reportLine("26", 1)
    keys = m.registry.GetKeyList()
    RBS_CC_40_reportLine("27", 1)
    m.viewModel.callFunc("loadContent")
    RBS_CC_40_reportLine("28", 1)
    m.viewModel.callFunc("loadContinueWatching")
end sub

sub initNodes()
    RBS_CC_40_reportLine("33", 1)
    m.rowList = m.top.findNode("rowList")
    RBS_CC_40_reportLine("34", 1)
    m.carousel = m.top.findNode("carousel")
    RBS_CC_40_reportLine("35", 1)
    m.continueWatching = m.top.findNode("continueWatching")
    RBS_CC_40_reportLine("36", 1)
    m.mainLayout = m.top.findNode("mainLayout")
    RBS_CC_40_reportLine("37", 1)
    m.carouselbutton = m.top.findNode("carouselbutton")
    RBS_CC_40_reportLine("38", 1)
    m.heroPreview = m.top.findNode("HeroPreview")
end sub

function initNodesT() as boolean
    RBS_CC_40_reportLine("42", 1)
    return true
end function

sub initObservers()
    RBS_CC_40_reportLine("46", 1)
    m.rowList.observeField("rowItemFocused", "onItemFocused")
    RBS_CC_40_reportLine("47", 1)
    m.rowList.observeField("rowItemSelected", "onItemSelected")
    RBS_CC_40_reportLine("48", 1)
    m.carousel.observeField("itemSelected", "onCarouselSelected")
    RBS_CC_40_reportLine("49", 1)
    m.continueWatching.observeField("rowItemSelected", "onContinueWatchingSelected")
    RBS_CC_40_reportLine("50", 1)
    m.top.observeField("focusedChild", "onFocusRequest")
    RBS_CC_40_reportLine("51", 1)
    m.rowList.observeField("focusedItemRect", "onFocusedRectChanged")
end sub

sub initViewModel()
    RBS_CC_40_reportLine("55", 1)
    m.viewModel = CreateObject("roSGNode", "HomeScreenViewModel")
    RBS_CC_40_reportLine("56", 1)
    m.viewModel.observeField("carouselContent", "onCarouselContentLoaded")
    RBS_CC_40_reportLine("57", 1)
    m.viewModel.observeField("rowListContent", "onRowListContentLoaded")
    RBS_CC_40_reportLine("58", 1)
    m.viewModel.observeField("continueWatchingContent", "onContinueWatchingLoaded")
    RBS_CC_40_reportLine("59", 1)
    m.viewModel.observeField("continueWatchingVisible", "onContinueWatchingVisibilityChanged")
end sub

sub onCarouselContentLoaded()
    RBS_CC_40_reportLine("63", 1)
    m.carousel.content = m.viewModel.carouselContent
end sub

sub onRowListContentLoaded()
    if RBS_CC_40_reportLine("67", 2) and (m.rowList.content = invalid)
        RBS_CC_40_reportLine("67", 3)
        RBS_CC_40_reportLine("68", 1)
        m.rowList.content = m.viewModel.rowListContent
        RBS_CC_40_reportLine("69", 1)
        m.startupTimer.control = "start"
    end if
end sub

sub onContinueWatchingLoaded()
    RBS_CC_40_reportLine("74", 1)
    m.continueWatching.content = m.viewModel.continueWatchingContent
end sub

sub onContinueWatchingVisibilityChanged()
    RBS_CC_40_reportLine("78", 1)
    m.continueWatching.visible = m.viewModel.continueWatchingVisible
    if RBS_CC_40_reportLine("80", 2) and (not m.continueWatching.visible)
        RBS_CC_40_reportLine("80", 3)
        if RBS_CC_40_reportLine("81", 2) and (m.continueWatching.getParent() <> invalid)
            RBS_CC_40_reportLine("81", 3)
            RBS_CC_40_reportLine("82", 1)
            m.mainLayout.removeChild(m.continueWatching)
        end if
    else
        RBS_CC_40_reportLine("84", 3)
        if RBS_CC_40_reportLine("85", 2) and (m.continueWatching.getParent() = invalid)
            RBS_CC_40_reportLine("85", 3)
            RBS_CC_40_reportLine("86", 1)
            m.mainLayout.insertChild(m.continueWatching, 1)
        end if
    end if
    RBS_CC_40_reportLine("90", 1)
    m.cwHeight = m.continueWatching.boundingRect().height
    RBS_CC_40_reportLine("91", 1)
    scrollToSection(m.currentSection)
end sub

sub onFocusRequest()
    if RBS_CC_40_reportLine("96", 2) and (not m.top.hasFocus()) then
        RBS_CC_40_reportLine("96", 3)
        RBS_CC_40_reportLine("96", 1)
        return
    end if
    if RBS_CC_40_reportLine("97", 2) and (m.currentSection = 0)
        RBS_CC_40_reportLine("97", 3)
        if RBS_CC_40_reportLine("98", 2) and (isValid(m.carousel) and m.carousel.visible)
            RBS_CC_40_reportLine("98", 3)
            RBS_CC_40_reportLine("99", 1)
            m.carouselbutton.setFocus(true)
            RBS_CC_40_reportLine("100", 1)
            m.carousel.findNode("autoTimer").control = "start"
        end if
    else if RBS_CC_40_reportLine("102", 2) and (m.currentSection = 1)
        RBS_CC_40_reportLine("102", 3)
        if RBS_CC_40_reportLine("103", 2) and (isValid(m.continueWatching) and m.continueWatching.visible)
            RBS_CC_40_reportLine("103", 3)
            RBS_CC_40_reportLine("104", 1)
            m.continueWatching.setFocus(true)
        else
            RBS_CC_40_reportLine("105", 3)
            RBS_CC_40_reportLine("106", 1)
            m.currentSection = 2
            RBS_CC_40_reportLine("107", 1)
            m.rowList.setFocus(true)
        end if
    else if RBS_CC_40_reportLine("109", 2) and (m.currentSection = 2)
        RBS_CC_40_reportLine("109", 3)
        if RBS_CC_40_reportLine("110", 2) and (isValid(m.rowList))
            RBS_CC_40_reportLine("110", 3)
            RBS_CC_40_reportLine("111", 1)
            m.rowList.setFocus(true)
        end if
    end if
end sub

sub scrollToSection(sectionIndex as integer)
    RBS_CC_40_reportLine("118", 1)
    m.currentSection = sectionIndex
    RBS_CC_40_reportLine("120", 1)
    targetY = getYForSection(sectionIndex)
    RBS_CC_40_reportLine("121", 1)
    m.mainLayout.translation = [
        m.LEFT_MARGIN
        targetY
    ]
end sub

function getYForSection(sectionIndex as integer) as integer
    RBS_CC_40_reportLine("130", 1)
    offset = 0
    if RBS_CC_40_reportLine("132", 2) and (sectionIndex > 0)
        RBS_CC_40_reportLine("132", 3)
        RBS_CC_40_reportLine("133", 1)
        offset += m.carouselHeight + m.SECTION_GAP
    end if
    if RBS_CC_40_reportLine("136", 2) and (sectionIndex > 1)
        RBS_CC_40_reportLine("136", 3)
        if RBS_CC_40_reportLine("137", 2) and (m.continueWatching.visible)
            RBS_CC_40_reportLine("137", 3)
            RBS_CC_40_reportLine("138", 1)
            offset += m.cwHeight + m.SECTION_GAP
        end if
    end if
    if RBS_CC_40_reportLine("142", 2) and (sectionIndex > 2)
        RBS_CC_40_reportLine("142", 3)
        RBS_CC_40_reportLine("143", 1)
        offset += m.hpHeight + m.SECTION_GAP
    end if
    RBS_CC_40_reportLine("145", 1)
    return m.TOP_MARGIN - offset
end function

sub focusCurrentSection()
    if RBS_CC_40_reportLine("151", 2) and (m.currentSection = 0)
        RBS_CC_40_reportLine("151", 3)
        RBS_CC_40_reportLine("152", 1)
        m.carouselbutton.setFocus(true)
        RBS_CC_40_reportLine("153", 1)
        m.carousel.findNode("autoTimer").control = "start"
    else if RBS_CC_40_reportLine("154", 2) and (m.currentSection = 1)
        RBS_CC_40_reportLine("154", 3)
        RBS_CC_40_reportLine("155", 1)
        m.continueWatching.setFocus(true)
    else if RBS_CC_40_reportLine("156", 2) and (m.currentSection = 2)
        RBS_CC_40_reportLine("156", 3)
        RBS_CC_40_reportLine("157", 1)
        targetY = getYForSection(2)
        RBS_CC_40_reportLine("159", 1)
        m.mainLayout.translation = [
            m.LEFT_MARGIN
            targetY
        ]
        RBS_CC_40_reportLine("163", 1)
        m.rowList.setFocus(true)
    end if
end sub

sub onStartupTimerFired()
    RBS_CC_40_reportLine("169", 1)
    m.carouselHeight = m.carousel.boundingRect().height
    RBS_CC_40_reportLine("170", 1)
    m.cwHeight = m.continueWatching.boundingRect().height
    RBS_CC_40_reportLine("171", 1)
    m.hpHeight = m.heroPreview.boundingRect().height
    RBS_CC_40_reportLine("172", 1)
    scrollToSection(0)
    RBS_CC_40_reportLine("173", 1)
    focusCurrentSection()
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if RBS_CC_40_reportLine("179", 2) and (not press) then
        RBS_CC_40_reportLine("179", 3)
        RBS_CC_40_reportLine("179", 1)
        return false
    end if
    if RBS_CC_40_reportLine("181", 2) and (key = "down")
        RBS_CC_40_reportLine("181", 3)
        RBS_CC_40_reportLine("183", 1)
        nextSection = getNextVisibleSection(m.currentSection, 1)
        if RBS_CC_40_reportLine("185", 2) and (nextSection <> -1)
            RBS_CC_40_reportLine("185", 3)
            RBS_CC_40_reportLine("186", 1)
            scrollToSection(nextSection)
            RBS_CC_40_reportLine("187", 1)
            focusCurrentSection()
            RBS_CC_40_reportLine("188", 1)
            return true
        end if
    else if RBS_CC_40_reportLine("191", 2) and (key = "up")
        RBS_CC_40_reportLine("191", 3)
        if RBS_CC_40_reportLine("193", 2) and (m.currentSection = 2)
            RBS_CC_40_reportLine("193", 3)
            if RBS_CC_40_reportLine("194", 2) and (m.rowList.rowItemFocused[0] <> 0)
                RBS_CC_40_reportLine("194", 3)
                RBS_CC_40_reportLine("195", 1)
                return false
            end if
        end if
        RBS_CC_40_reportLine("199", 1)
        prevSection = getNextVisibleSection(m.currentSection, -1)
        if RBS_CC_40_reportLine("201", 2) and (prevSection <> -1)
            RBS_CC_40_reportLine("201", 3)
            RBS_CC_40_reportLine("202", 1)
            scrollToSection(prevSection)
            RBS_CC_40_reportLine("203", 1)
            focusCurrentSection()
            RBS_CC_40_reportLine("204", 1)
            return true
        end if
    else if RBS_CC_40_reportLine("207", 2) and (key = "options" and m.currentSection = 1)
        RBS_CC_40_reportLine("207", 3)
        RBS_CC_40_reportLine("208", 1)
        selected = m.continueWatching.rowItemFocused
        if RBS_CC_40_reportLine("210", 2) and (selected = invalid) then
            RBS_CC_40_reportLine("210", 3)
            RBS_CC_40_reportLine("210", 1)
            return true
        end if
        RBS_CC_40_reportLine("211", 1)
        col = selected[1]
        RBS_CC_40_reportLine("212", 1)
        rowNode = m.continueWatching.content.getChild(0)
        RBS_CC_40_reportLine("213", 1)
        item = rowNode.getChild(col)
        RBS_CC_40_reportLine("214", 1)
        title = item.ShortDescriptionLine1
        RBS_CC_40_reportLine("215", 1)
        keys = m.registry.GetKeyList()
        RBS_CC_40_reportLine("217", 1): for each k in keys
            RBS_CC_40_reportLine("218", 1)
            value = m.registry.Read(k)
            if RBS_CC_40_reportLine("219", 2) and (value <> "")
                RBS_CC_40_reportLine("219", 3)
                RBS_CC_40_reportLine("221", 1)
                parsed = ParseJSON(value)
                if RBS_CC_40_reportLine("223", 2) and (parsed <> invalid and parsed.title = title)
                    RBS_CC_40_reportLine("223", 3)
                    RBS_CC_40_reportLine("224", 1)
                    m.registry.Delete(k)
                    RBS_CC_40_reportLine("225", 1)
                    m.registry.Flush()
                    exit for
                end if
            end if
        end for
        RBS_CC_40_reportLine("231", 1)
        speak(title + " removed from Continue Watching")
        RBS_CC_40_reportLine("232", 1)
        m.global.toast = {
            message: title + " removed from Continue Watching"
            duration: 2
        }
        RBS_CC_40_reportLine("237", 1)
        m.viewModel.callFunc("loadContinueWatching")
        RBS_CC_40_reportLine("238", 1)
        scrollToSection(m.currentSection)
        if RBS_CC_40_reportLine("239", 2) and (m.continueWatching.visible)
            RBS_CC_40_reportLine("239", 3)
            RBS_CC_40_reportLine("241", 1)
            rowNode = m.continueWatching.content.getChild(0)
            if RBS_CC_40_reportLine("243", 2) and (rowNode <> invalid and rowNode.getChildCount() > 0)
                RBS_CC_40_reportLine("243", 3)
                RBS_CC_40_reportLine("244", 1)
                count = rowNode.getChildCount()
                if RBS_CC_40_reportLine("246", 2) and (col >= count)
                    RBS_CC_40_reportLine("246", 3)
                    RBS_CC_40_reportLine("247", 1)
                    newCol = count - 1
                else
                    RBS_CC_40_reportLine("248", 3)
                    RBS_CC_40_reportLine("249", 1)
                    newCol = col
                end if
                RBS_CC_40_reportLine("252", 1)
                m.continueWatching.jumpToRowItem = [
                    0
                    newCol
                ]
                RBS_CC_40_reportLine("253", 1)
                m.continueWatching.setFocus(true)
            else
                RBS_CC_40_reportLine("254", 3)
                RBS_CC_40_reportLine("255", 1)
                m.currentSection = 2
                RBS_CC_40_reportLine("256", 1)
                scrollToSection(2)
                RBS_CC_40_reportLine("257", 1)
                m.rowList.setFocus(true)
            end if
        else
            RBS_CC_40_reportLine("259", 3)
            RBS_CC_40_reportLine("260", 1)
            scrollToSection(2)
            RBS_CC_40_reportLine("261", 1)
            m.rowList.setFocus(true)
        end if
    end if
    RBS_CC_40_reportLine("264", 1)
    return false
end function

function getNextVisibleSection(current as integer, direction as integer) as integer
    RBS_CC_40_reportLine("270", 1)
    idx = current + direction
    RBS_CC_40_reportLine("272", 1): while idx >= 0 and idx <= 2
        if RBS_CC_40_reportLine("273", 2) and (idx = 0) then
            RBS_CC_40_reportLine("273", 3)
            RBS_CC_40_reportLine("273", 1)
            return idx
        end if
        if RBS_CC_40_reportLine("274", 2) and (idx = 1 and m.continueWatching.visible)
            RBS_CC_40_reportLine("274", 3)
            RBS_CC_40_reportLine("275", 1)
            return idx
        end if
        if RBS_CC_40_reportLine("278", 2) and (idx = 2) then
            RBS_CC_40_reportLine("278", 3)
            RBS_CC_40_reportLine("278", 1)
            return idx
        end if
        RBS_CC_40_reportLine("279", 1)
        idx += direction
    end while
    RBS_CC_40_reportLine("281", 1)
    return -1
end function

sub onContinueWatchingSelected()
    RBS_CC_40_reportLine("287", 1)
    selected = m.continueWatching.rowItemSelected
    RBS_CC_40_reportLine("289", 1)
    item = m.continueWatching.content.getChild(selected[0]).getChild(selected[1])
    if RBS_CC_40_reportLine("291", 2) and (not isValid(item)) then
        RBS_CC_40_reportLine("291", 3)
        RBS_CC_40_reportLine("291", 1)
        return
    end if
    RBS_CC_40_reportLine("293", 1)
    m.top.events = {
        type: "navigate"
        screen: "DetailScreen"
        payload: item
    }
end sub

sub onItemFocused(msg as object)
    RBS_CC_40_reportLine("302", 1)
    focused = m.rowList.rowItemFocused
    RBS_CC_40_reportLine("304", 1)
    m.viewModel.callFunc("loadRowData", focused[0])
    RBS_CC_40_reportLine("305", 1)
    m.viewModel.callFunc("loadRowData", focused[0] + 1)
    RBS_CC_40_reportLine("306", 1)
    m.viewModel.callFunc("loadRowData", focused[0] + 2)
    RBS_CC_40_reportLine("307", 1)
    currentRow = focused[0]
    if RBS_CC_40_reportLine("309", 2) and (currentRow <> m.lastFocusedRow)
        RBS_CC_40_reportLine("309", 3)
        RBS_CC_40_reportLine("310", 1)
        m.lastFocusedRow = currentRow
    end if
    RBS_CC_40_reportLine("313", 1)
    item = m.rowList.content.getChild(focused[0]).getChild(focused[1])
    if RBS_CC_40_reportLine("315", 2) and (not isValid(item)) then
        RBS_CC_40_reportLine("315", 3)
        RBS_CC_40_reportLine("315", 1)
        return
    end if
    RBS_CC_40_reportLine("316", 1)
    text = item.ShortDescriptionLine1
    if RBS_CC_40_reportLine("318", 2) and (text = invalid or text = "")
        RBS_CC_40_reportLine("318", 3)
        RBS_CC_40_reportLine("319", 1)
        text = item.title
    end if
    if RBS_CC_40_reportLine("322", 2) and (text <> invalid and text <> "")
        RBS_CC_40_reportLine("322", 3)
        RBS_CC_40_reportLine("323", 1)
        speak(text)
    end if
    if RBS_CC_40_reportLine("326", 2) and (currentRow = 0)
        RBS_CC_40_reportLine("326", 3)
        RBS_CC_40_reportLine("327", 1)
        updateHero(item)
        RBS_CC_40_reportLine("328", 1)
        targetY = getYForSection(2)
        RBS_CC_40_reportLine("330", 1)
        m.mainLayout.translation = [
            m.LEFT_MARGIN
            targetY
        ]
    else
        RBS_CC_40_reportLine("334", 3)
        RBS_CC_40_reportLine("335", 1)
        targetY = getYForSection(2) - m.hpHeight - m.SECTION_GAP
        RBS_CC_40_reportLine("337", 1)
        m.mainLayout.translation = [
            m.LEFT_MARGIN
            targetY
        ]
    end if
end sub

sub onItemSelected()
    RBS_CC_40_reportLine("346", 1)
    selected = m.rowList.rowItemSelected
    RBS_CC_40_reportLine("348", 1)
    item = m.rowList.content.getChild(selected[0]).getChild(selected[1])
    if RBS_CC_40_reportLine("350", 2) and (not isValid(item)) then
        RBS_CC_40_reportLine("350", 3)
        RBS_CC_40_reportLine("350", 1)
        return
    end if
    RBS_CC_40_reportLine("351", 1)
    m.RowListItem.callFunc("onStopPreview")
    RBS_CC_40_reportLine("352", 1)
    speak(item.ShortDescriptionLine1 + " selected")
    RBS_CC_40_reportLine("354", 1)
    m.top.events = {
        type: "navigate"
        screen: "DetailScreen"
        payload: item
    }
end sub

sub onCarouselSelected()
    RBS_CC_40_reportLine("364", 1)
    idx = m.carousel.itemSelected
    if RBS_CC_40_reportLine("366", 2) and (idx < 0) then
        RBS_CC_40_reportLine("366", 3)
        RBS_CC_40_reportLine("366", 1)
        return
    end if
    RBS_CC_40_reportLine("367", 1)
    item = m.carousel.content.getChild(idx)
    if RBS_CC_40_reportLine("369", 2) and (not isValid(item)) then
        RBS_CC_40_reportLine("369", 3)
        RBS_CC_40_reportLine("369", 1)
        return
    end if
    RBS_CC_40_reportLine("370", 1)
    speak(item.ShortDescriptionLine1 + " selected")
    RBS_CC_40_reportLine("372", 1)
    m.top.events = {
        type: "navigate"
        screen: "DetailScreen"
        payload: item
    }
end sub

sub updateHero(item)
    if RBS_CC_40_reportLine("381", 2) and (isValid(item))
        RBS_CC_40_reportLine("381", 3)
        RBS_CC_40_reportLine("382", 1)
        m.heroPreview.posterUrl = item.HDPosterUrl
        RBS_CC_40_reportLine("383", 1)
        m.heroPreview.heroTitle = item.ShortDescriptionLine1
        RBS_CC_40_reportLine("384", 1)
        m.heroPreview.heroDesc = item.ShortDescriptionLine2
    end if
end sub

function RBS_CC_40_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "40"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "40"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./HomeScreen.brs.map