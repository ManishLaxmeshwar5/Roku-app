sub init()

    m.TOP_MARGIN = 20
    m.LEFT_MARGIN = 60
    m.SECTION_GAP = 20

    initNodes()
    initObservers()
    initViewModel()

    m.carouselHeight = 0
    m.cwHeight = 0
    m.hpHeight = 0

    m.currentSection = 0

    m.RowListItem = CreateObject("roSGNode", "UIRowListItem")

    m.startupTimer = m.top.findNode("startupTimer")

    m.startupTimer.observeField("fire", "onStartupTimerFired")

    m.bookmarks = {}

    m.registry = CreateObject("roRegistrySection", "VideoBookmarks")

    keys = m.registry.GetKeyList()
    m.viewModel.callFunc("loadContent")
    m.viewModel.callFunc("loadContinueWatching")
end sub


sub initNodes()
    m.rowList = m.top.findNode("rowList")
    m.carousel = m.top.findNode("carousel")
    m.continueWatching = m.top.findNode("continueWatching")
    m.mainLayout = m.top.findNode("mainLayout")
    m.carouselbutton = m.top.findNode("carouselbutton")
    m.heroPreview = m.top.findNode("HeroPreview")
end sub


sub initObservers()
    m.rowList.observeField("rowItemFocused", "onItemFocused")
    m.rowList.observeField("rowItemSelected", "onItemSelected")
    m.carousel.observeField("itemSelected", "onCarouselSelected")
    m.continueWatching.observeField( "rowItemSelected","onContinueWatchingSelected")
    m.top.observeField("focusedChild", "onFocusRequest")
    m.rowList.observeField("focusedItemRect","onFocusedRectChanged")
end sub

sub initViewModel()
    m.viewModel = CreateObject("roSGNode","HomeScreenViewModel")
    m.viewModel.observeField("carouselContent","onCarouselContentLoaded")
    m.viewModel.observeField("rowListContent","onRowListContentLoaded")
    m.viewModel.observeField("continueWatchingContent","onContinueWatchingLoaded")
    m.viewModel.observeField("continueWatchingVisible","onContinueWatchingVisibilityChanged")
end sub

sub onCarouselContentLoaded()
    m.carousel.content = m.viewModel.carouselContent
end sub

sub onRowListContentLoaded()
    if m.rowList.content = invalid
        m.rowList.content = m.viewModel.rowListContent
        m.startupTimer.control = "start"
    end if
end sub

sub onContinueWatchingLoaded()
    m.continueWatching.content = m.viewModel.continueWatchingContent
end sub

sub onContinueWatchingVisibilityChanged()
    m.continueWatching.visible = m.viewModel.continueWatchingVisible

    if not m.continueWatching.visible
        if m.continueWatching.getParent() <> invalid
            m.mainLayout.removeChild(m.continueWatching)
        end if
    else
        if m.continueWatching.getParent() = invalid
            m.mainLayout.insertChild(m.continueWatching, 1)
        end if
    end if

    m.cwHeight = m.continueWatching.boundingRect().height
    scrollToSection(m.currentSection)
end sub


sub onFocusRequest()
    if not m.top.hasFocus() then return
    if m.currentSection = 0
        if isValid(m.carousel) and m.carousel.visible
            m.carouselbutton.setFocus(true)
            m.carousel.findNode("autoTimer").control = "start"
        end if
    else if m.currentSection = 1
        if isValid(m.continueWatching)and m.continueWatching.visible
            m.continueWatching.setFocus(true)
        else
            m.currentSection = 2
            m.rowList.setFocus(true)
        end if
    else if m.currentSection = 2
        if isValid(m.rowList)
            m.rowList.setFocus(true)
        end if
    end if
end sub


sub scrollToSection(sectionIndex as integer)
    m.currentSection = sectionIndex

    targetY = getYForSection(sectionIndex)
    m.mainLayout.translation = [
        m.LEFT_MARGIN,
        targetY
    ]
end sub


function getYForSection(sectionIndex as integer) as integer

    offset = 0

    if sectionIndex > 0
        offset += m.carouselHeight + m.SECTION_GAP
    end if

    if sectionIndex > 1
        if m.continueWatching.visible
            offset += m.cwHeight + m.SECTION_GAP
        end if
    end if

    if sectionIndex > 2
        offset += m.hpHeight + m.SECTION_GAP
    end if
    return m.TOP_MARGIN - offset 

end function


sub focusCurrentSection()
    if m.currentSection = 0
        m.carouselbutton.setFocus(true)
        m.carousel.findNode("autoTimer").control = "start"
    else if m.currentSection = 1
        m.continueWatching.setFocus(true)
    else if m.currentSection = 2
        targetY = getYForSection(2)

        m.mainLayout.translation = [
            m.LEFT_MARGIN,
            targetY
        ]
        m.rowList.setFocus(true)
    end if
end sub


sub onStartupTimerFired()
    m.carouselHeight = m.carousel.boundingRect().height
    m.cwHeight = m.continueWatching.boundingRect().height
    m.hpHeight = m.heroPreview.boundingRect().height
    scrollToSection(0)
    focusCurrentSection()
end sub


function onKeyEvent(key as string,press as boolean) as boolean

    if not press then return false

    if key = "down"

        nextSection = getNextVisibleSection(m.currentSection,1)

        if nextSection <> -1
            scrollToSection(nextSection)
            focusCurrentSection()
            return true
        end if

    else if key = "up"

        if m.currentSection = 2
            if m.rowList.rowItemFocused[0] <> 0
                return false
            end if
        end if

        prevSection = getNextVisibleSection(m.currentSection,-1)

        if prevSection <> -1
            scrollToSection(prevSection)
            focusCurrentSection()
            return true
        end if

    else if key = "options" and m.currentSection = 1
        selected = m.continueWatching.rowItemFocused

        if selected = invalid then return true
        col = selected[1]
        rowNode = m.continueWatching.content.getChild(0)
        item = rowNode.getChild(col)
        title = item.ShortDescriptionLine1
        keys = m.registry.GetKeyList()

        for each k in keys
            value = m.registry.Read(k)
            if value <> ""

                parsed = ParseJSON(value)

                if parsed <> invalid and parsed.title = title
                    m.registry.Delete(k)
                    m.registry.Flush()
                    exit for
                end if
            end if
        end for

        speak(title + " removed from Continue Watching")
        m.global.toast = {
            message: title + " removed from Continue Watching"
            duration: 2
        }

        m.viewModel.callFunc("loadContinueWatching")
        scrollToSection(m.currentSection)
        if m.continueWatching.visible

            rowNode = m.continueWatching.content.getChild(0)

            if rowNode <> invalid and rowNode.getChildCount() > 0
                count = rowNode.getChildCount()

                if col >= count
                    newCol = count - 1
                else
                    newCol = col
                end if

                m.continueWatching.jumpToRowItem = [0,newCol]
                m.continueWatching.setFocus(true)
            else
                m.currentSection = 2
                scrollToSection(2)
                m.rowList.setFocus(true)
            end if
        else
            scrollToSection(2)
            m.rowList.setFocus(true)
        end if
    end if
    return false
end function


function getNextVisibleSection(current as integer,direction as integer) as integer

    idx = current + direction

    while idx >= 0 and idx <= 2
        if idx = 0 then return idx
        if idx = 1 and m.continueWatching.visible
            return idx
        end if

        if idx = 2 then return idx
        idx += direction
    end while
    return -1
end function


sub onContinueWatchingSelected()

    selected = m.continueWatching.rowItemSelected

    item = m.continueWatching.content.getChild(selected[0]).getChild(selected[1])

    if not isValid(item) then return

    m.top.events = {
        type: "navigate"
        screen: "DetailScreen"
        payload: item
    }
end sub


sub onItemFocused(msg as object)
    focused = m.rowList.rowItemFocused

    m.viewModel.callFunc("loadRowData", focused[0])
    m.viewModel.callFunc("loadRowData", focused[0] + 1)
    m.viewModel.callFunc("loadRowData", focused[0] + 2)
    currentRow = focused[0]

    if currentRow <> m.lastFocusedRow
        m.lastFocusedRow = currentRow
    end if

    item = m.rowList.content.getChild(focused[0]).getChild(focused[1])

    if not isValid(item) then return
    text = item.ShortDescriptionLine1

    if text = invalid or text = ""
        text = item.title
    end if

    if text <> invalid and text <> ""
        speak(text)
    end if

    if currentRow = 0
        updateHero(item)
        targetY = getYForSection(2)

        m.mainLayout.translation = [
            m.LEFT_MARGIN,
            targetY
        ]
    else
        targetY = getYForSection(2) - m.hpHeight - m.SECTION_GAP

        m.mainLayout.translation = [
            m.LEFT_MARGIN,
            targetY
        ]
    end if
end sub


sub onItemSelected()
    selected = m.rowList.rowItemSelected

    item = m.rowList.content.getChild(selected[0]).getChild(selected[1])

    if not isValid(item) then return
    m.RowListItem.callFunc("onStopPreview")
    speak(item.ShortDescriptionLine1 + " selected")

    m.top.events = {
        type: "navigate"
        screen: "DetailScreen"
        payload: item
    }
end sub

sub manish()
end sub


sub onCarouselSelected()

    idx = m.carousel.itemSelected

    if idx < 0 then return
    item = m.carousel.content.getChild(idx)

    if not isValid(item) then return
    speak(item.ShortDescriptionLine1 + " selected")

    m.top.events = {
        type: "navigate"
        screen: "DetailScreen"
        payload: item
    }
end sub


sub updateHero(item)
    if isValid(item)
        m.heroPreview.posterUrl = item.HDPosterUrl
        m.heroPreview.heroTitle = item.ShortDescriptionLine1
        m.heroPreview.heroDesc = item.ShortDescriptionLine2
    end if
end sub