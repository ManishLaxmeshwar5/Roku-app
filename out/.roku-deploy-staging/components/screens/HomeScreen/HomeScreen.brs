' sub init()
'     m.TOP_MARGIN = 20
'     m.LEFT_MARGIN = 60
'     m.SECTION_GAP = 20
'     initNodes()
'     initObservers()

'     m.carouselHeight = 0
'     m.cwHeight = 0
'     m.hpHeight = 0
'     m.currentSection = 0
'     m.RowListItem = CreateObject("roSGNode", "RowListItem")

'     m.startupTimer = m.top.findNode("startupTimer")
'     m.startupTimer.observeField("fire", "onStartupTimerFired")

'     m.allRowData = []
'     m.laodedRows = {}
'     m.bookmarks = {}

'     m.registry = CreateObject("roRegistrySection", "VideoBookmarks")
'     keys = m.registry.GetKeyList()

'     loadContent()
'     loadContinueWatching()
' end sub

' sub initNodes()
'     m.rowList = m.top.findNode("rowList")
'     m.carousel = m.top.findNode("carousel")
'     m.continueWatching = m.top.findNode("continueWatching")
'     m.mainLayout = m.top.findNode("mainLayout")
'     m.carouselbutton = m.top.findNode("carouselbutton")
'     m.heroPreview = m.top.findNode("HeroPreview")
' end sub

' sub initObservers()
'     m.rowList.observeField("rowItemFocused", "onItemFocused")
'     m.rowList.observeField("rowItemSelected", "onItemSelected")
'     m.carousel.observeField("itemSelected", "onCarouselSelected")
'     m.continueWatching.observeField("rowItemSelected", "onContinueWatchingSelected")
'     m.top.observeField("focusedChild", "onFocusRequest")
'     m.rowList.observeField("focusedItemRect", "onFocusedRectChanged")
' end sub

' sub onFocusRequest()
'     if not m.top.hasFocus() then return

'     if m.currentSection = 0
'         if isValid(m.carousel) and m.carousel.visible
'             m.carouselbutton.setFocus(true)
'             m.carousel.findNode("autoTimer").control = "start"
'         end if

'     else if m.currentSection = 1
'         if isValid(m.continueWatching) and m.continueWatching.visible
'             m.continueWatching.setFocus(true)
'         else
'             ' fallback if CW hidden
'             m.currentSection = 2
'             m.rowList.setFocus(true)
'         end if

'     else if m.currentSection = 2
'         if isValid(m.rowList)
'             m.rowList.setFocus(true)
'         end if
'     end if
' end sub

' sub scrollToSection(sectionIndex as integer)
'     m.currentSection = sectionIndex 'sectionindex =2
'     targetY = getYForSection(sectionIndex) 'targetY =20
'     m.mainLayout.translation = [m.LEFT_MARGIN, targetY] ' [60,20]
' end sub


' function getYForSection(sectionIndex as integer) as integer
'     offset = 0
'     'stop

'     if sectionIndex > 0
'         offset += m.carouselHeight + m.SECTION_GAP
'     end if

'     if sectionIndex > 1
'         ' stop
'         if m.continueWatching.visible
'             offset += m.cwHeight + m.SECTION_GAP
'         end if
'     end if
'     if sectionIndex > 2
'         offset += m.hpHeight + m.SECTION_GAP
'     end if

'     return m.TOP_MARGIN - offset
' end function

' sub focusCurrentSection()
'     if m.currentSection = 0
'         m.carouselbutton.setFocus(true)
'         m.carousel.findNode("autoTimer").control = "start"
'     else if m.currentSection = 1
'         m.continueWatching.setFocus(true)
'     else if m.currentSection = 2
'         targetY = getYForSection(2)
'         m.mainLayout.translation = [m.LEFT_MARGIN, targetY]
'         m.rowList.setFocus(true)
'     end if
' end sub

' sub onStartupTimerFired()
'     m.carouselHeight = m.carousel.boundingRect().height
'     m.cwHeight = m.continueWatching.boundingRect().height
'     m.hpHeight = m.heroPreview.boundingRect().height

'     scrollToSection(0)
'     focusCurrentSection()
' end sub

' function onKeyEvent(key as string, press as boolean) as boolean
'     if not press then return false

'     if key = "down"
'         nextSection = getNextVisibleSection(m.currentSection, 1)
'         if nextSection <> -1
'             scrollToSection(nextSection)
'             focusCurrentSection()
'             return true
'         end if

'     else if key = "up"
'         if m.currentSection = 2
'             if m.rowList.rowItemFocused[0] <> 0 then return false
'         end if

'         prevSection = getNextVisibleSection(m.currentSection, -1)
'         if prevSection <> -1
'             scrollToSection(prevSection)
'             focusCurrentSection()
'             return true
'         end if

'     else if key = "options" and m.currentSection = 1
'         ' stop
'         selected = m.continueWatching.rowItemFocused
'         if selected = invalid then return true
'         col = selected [1]
'         rowNode = m.continueWatching.content.getChild(0)
'         item = rowNode.getChild(col)
'         title = item.ShortDescriptionLine1
'         keys = m.registry.GetKeyList()
'         for each k in keys
'             value = m.registry.Read(k)
'             if value <> ""
'                 parsed = ParseJSON(value)
'                 if parsed <> invalid and parsed.title = title
'                     m.registry.Delete(k)
'                     m.registry.Flush()
'                     exit for
'                 end if
'             end if
'         end for
'         speak(title + " removed from Continue Watching")
'         m.global.toast = {
'             message: title + " removed from Continue Watching"
'             duration: 2
'         }
'         ' stop
'         loadContinueWatching()
'         scrollToSection(m.currentSection)

'         ' 🔁 Handle focus
'         if m.continueWatching.visible
'             rowNode = m.continueWatching.content.getChild(0)

'             if rowNode <> invalid and rowNode.getChildCount() > 0
'                 count = rowNode.getChildCount()

'                 ' manual boundary check instead of min()
'                 if col >= count
'                     newCol = count - 1
'                 else
'                     newCol = col
'                 end if

'                 m.continueWatching.jumpToRowItem = [0, newCol]
'                 m.continueWatching.setFocus(true)
'             else
'                 ' No items left → move to RowList
'                 m.currentSection = 2
'                 ' m.cwHeight =0
'                 scrollToSection(2)
'                 m.rowList.setFocus(true)
'             end if
'         else
'             scrollToSection(2)
'             m.rowList.setFocus(true)
'         end if
'     end if
'     return false
' end function


' function getNextVisibleSection(current as integer, direction as integer) as integer
'     idx = current + direction
'     while idx >= 0 and idx <= 2
'         if idx = 0 then return idx
'         if idx = 1 and m.continueWatching.visible then return idx
'         if idx = 2 then return idx
'         idx += direction
'     end while
'     return -1
' end function


' ' ─────────────────────────────────────────────
' ' Continue Watching
' ' ─────────────────────────────────────────────
' sub loadContinueWatching()
'     if not isValid(m.registry) then return

'     m.bookmarks = {}
'     keys = m.registry.GetKeyList()
'     for each key in keys
'         print "key:"key
'         value = m.registry.Read(key)
'         if value <> ""
'             parsed = ParseJSON(value)
'             if isValid(parsed) and parsed.DoesExist("position") and parsed.position > 0
'                 titleKey = LCase(parsed.title.Trim())
'                 m.bookmarks[titleKey] = parsed
'                 print parsed
'             end if
'         end if
'     end for

'     if m.bookmarks.Count() = 0
'         m.continueWatching.visible = false
'         m.mainLayout.removeChild(m.continueWatching)
'         scrollToSection(m.currentSection)
'         return
'     end if

'     jsonText = ReadAsciiFile("pkg:/source/search1.json")
'     if jsonText = "" then return
'     searchData = ParseJson(jsonText)
'     if searchData = invalid then return

'     ' continueRow = CreateObject("roSGNode", "ContentNode")
'     continueRow = createContentNode()
'     for each rowData in searchData.rows
'         row = continueRow.createChild("ContentNode")
'         row.addField("icon", "string", false)
'         row.addField("title", "string", false)
'         row.title = rowData.title
'         row.icon = rowData.icon
'         for each data in rowData.content
'             videoTitle = LCase(data.name.Trim())
'             if m.bookmarks.DoesExist(videoTitle)
'                 itemNode = row.createChild("ContentNode")
'                 itemNode.url = data.url
'                 print data.url
'                 itemNode.ShortDescriptionLine1 = data.name
'                 itemNode.ShortDescriptionLine2 = data.description
'                 itemNode.HDPosterUrl = data.thumbnail
'                 ' stop
'             end if
'         end for
'     end for

'     m.continueWatching.content = continueRow
'     m.continueWatching.visible = true
'     if m.continueWatching.getParent() = invalid
'         m.mainLayout.insertChild(m.continueWatching, 1)
'     end if

'     m.cwHeight = m.continueWatching.boundingRect().height
'     m.continueWatching.visible = true
'     scrollToSection(m.currentSection)
' end sub


' sub onContinueWatchingSelected()
'     selected = m.continueWatching.rowItemSelected
'     item = m.continueWatching.content.getChild(selected[0]).getChild(selected[1])
'     if not isValid(item) then return
'     m.top.events = { type: "navigate", screen: "DetailScreen", payload: item }
' end sub


' ' ─────────────────────────────────────────────
' ' Main Content
' ' ─────────────────────────────────────────────
' sub loadContent()
'     jsonText = ReadAsciiFile("pkg:/source/gridContent.json")
'     data = ParseJson(jsonText)

'     ' carouselRoot = CreateObject("roSGNode", "ContentNode")
'     carouselRoot = createContentNode()
'     for each item in data.featured
'         ' node = CreateObject("roSGNode", "ContentNode")
'         node = createContentNode()
'         node.ShortDescriptionLine1 = item.name
'         node.ShortDescriptionLine2 = item.description
'         node.HDPosterUrl = item.thumbnail
'         node.url = item.url
'         carouselRoot.appendChild(node)
'     end for
'     m.carousel.content = carouselRoot

'     m.allRowData = data.rows
'     ' root = CreateObject("roSGNode", "ContentNode")
'     root = createContentNode()
'     for each rowData in data.rows
'         ' row = CreateObject("roSGNode", "ContentNode")
'         row = createContentNode()
'         row.addField("icon", "string", false)
'         row.addField("title", "string", false)
'         row.title = rowData.title
'         row.icon = rowData.icon
'         root.appendChild(row)
'     end for

'     m.rowList.content = root
'     loadRowData(0)
'     loadRowData(1)
'     loadRowData(2)
'     loadRowData(3)
'     m.startupTimer.control = "start"
' end sub


' sub loadRowData(rowIndex as integer)
'     if m.laodedRows[rowIndex.ToStr()] = true then return
'     if rowIndex >= m.allRowData.Count() then return

'     rowData = m.allRowData[rowIndex]
'     row = m.rowList.content.getChild(rowIndex)
'     if row = invalid then return

'     for each video in rowData.videos
'         ' itemNode = CreateObject("roSGNode", "ContentNode")
'         itemNode = createContentNode()
'         itemNode.ShortDescriptionLine1 = video.name
'         itemNode.ShortDescriptionLine2 = video.description
'         itemNode.HDPosterUrl = video.thumbnail
'         itemNode.url = "https://storage.googleapis.com/shaka-demo-assets/angel-one-hls/hls.m3u8"
'         row.appendChild(itemNode)
'     end for
'     m.laodedRows[rowIndex.ToStr()] = true
' end sub


' ' ─────────────────────────────────────────────
' ' RowList events
' ' ─────────────────────────────────────────────
' sub onItemFocused(msg as object)
'     focused = m.rowList.rowItemFocused
'     loadRowData(focused[0])
'     loadRowData(focused[0] + 1)
'     loadRowData(focused[0] + 2)

'     currentRow = focused[0]
'     if currentRow <> m.lastFocusedRow
'         m.lastFocusedRow = currentRow
'     end if
'     item = m.rowList.content.getChild(focused[0]).getChild(focused[1])
'     if not isValid(item) then return
'     text = item.ShortDescriptionLine1
'     if text = invalid or text = "" then text = item.title
'     if text <> invalid and text <> "" then speak(text)
'     if currentRow = 0
'         updateHero(item)
'         targetY = getYForSection(2)
'         m.mainLayout.translation = [m.LEFT_MARGIN, targetY]
'     else
'         targetY = getYForSection(2) - m.hpHeight - m.SECTION_GAP
'         m.mainLayout.translation = [m.LEFT_MARGIN, targetY]
'     end if
' end sub


' sub onItemSelected()
'     selected = m.rowList.rowItemSelected
'     item = m.rowList.content.getChild(selected[0]).getChild(selected[1])
'     if not isValid(item) then return

'     m.RowListItem.callFunc("onStopPreview")
'     speak(item.ShortDescriptionLine1 + " selected")
'     m.top.events = { type: "navigate", screen: "DetailScreen", payload: item }
' end sub


' sub onCarouselSelected()
'     idx = m.carousel.itemSelected
'     if idx < 0 then return
'     item = m.carousel.content.getChild(idx)
'     if not isValid(item) then return
'     speak(item.ShortDescriptionLine1 + " selected")
'     m.top.events = { type: "navigate", screen: "DetailScreen", payload: item }
' end sub

' sub updateHero(item)
'     if isValid(item) then
'         m.heroPreview.posterUrl = item.HDPosterUrl
'         m.heroPreview.heroTitle = item.ShortDescriptionLine1
'         m.heroPreview.heroDesc = item.ShortDescriptionLine2
'     end if
' end sub
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

    m.RowListItem = CreateObject("roSGNode", "RowListItem")

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