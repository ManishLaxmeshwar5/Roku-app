' sub init()
'     initNodes()
'     initObservers()
'     m.keyboard.setFocus(true)
'     m.allItems = []
'     if m.global.ttsEnabled = false
'         m.keyboard.muteAudioGuide="true"
'         m.instructions.muteAudioGuide="true"
'     end if
'     loadSearchData()
'     m.currentFocus = 0
'     m.searchTimer = CreateObject("roSGNode", "Timer")
'     m.searchTimer.duration = 0.5
'     m.searchTimer.repeat = false
'     m.searchTimer.observeField("fire", "performSearch")
' end sub

' sub initNodes()
'     m.keyboard = m.top.findNode("searchkeyboard")
'     m.rowList = m.top.findNode("rowList")
'     m.resultsBg = m.top.findNode("resultBackground")
'     m.noResults = m.top.findNode("noResultsContainer")
'     m.instructions = m.top.findNode("instructionsLabel")
' end sub

' sub initObservers()
'     m.top.observeField("focusedChild", "onFocusChange")
'     m.keyboard.observeField("text", "onSearchTextChanged")
'     m.rowList.observeField("rowItemSelected", "onItemSelected")
'     m.rowList.observeField("rowItemFocused", "onItemFocused")
' end sub

' sub onFocusChange()
'     if m.top.hasFocus()
'         if m.currentFocus = 1
'             m.rowList.setFocus(true)
'         else
'             m.keyboard.setFocus(true)
'         end if
'     end if
' end sub

' sub onItemFocused()
'     indices = m.rowList.rowItemFocused
'     item = m.rowList.content.getChild(indices[0]).getChild(indices[1])
'     if not isValid(item) then return
'     text = getContentTitle(item)
'     if isNonEmptyString(text) then speak(text)
' end sub

' sub onItemSelected()
'     inidices = m.rowList.rowItemFocused
'     row = m.rowList.content.getChild(inidices[0])
'     if not isValid(row) then return
'     item = row.getChild(inidices[1])
'     if not isValid(item) then return
'     speak(getContentTitle(item)+ "selected")
'     m.top.events ={
'         type: "navigate"
'         screen: "DetailScreen"
'         payload: item
'     }
' end sub

' sub loadSearchData()
'     data = readJsonFile("pkg:/source/search.json")
'     if not isValid(data) or not isValid(data.content)
'         m.allItems = []
'         return
'     end if
'     m.allItems = data.content
' end sub

' sub onSearchTextChanged(event as object)
'     m.query = Lcase(event.getData())
'     m.searchTimer.control = "start"
' end sub

' sub performSearch()

'     if m.query = ""
'         hideAll()
'         m.prevResults = []
'         return
'     end if

'     if m.prevQuery <> invalid AND Left(m.query, Len(m.prevQuery)) = m.prevQuery
'         source = m.prevResults
'         print "prevresults searching"
'     else
'         source = m.allItems
'     end if

'     results = []
'     ' maxResults = 20
'     for each item in m.allItems
'         if Instr(Lcase(item.name), m.query) > 0
'             results.push(item)
'             '     if results.count() >= maxResults
'             '         exit for
'             ' end if
'         end if
'     end for

'     m.prevQuery = m.query
'     m.prevResults = results

'     if results.count() > 0
'         showResults(results)
'         speak("Result found press right to go to results")
'     else
'         showNoResults()
'         speak("No results found")
'     end if
' end sub

' sub showResults(items as object)
'     m.resultsBg.visible = true
'     m.rowList.visible = true
'     m.noResults.visible = false
'     m.instructions.visible = false

'     content = createContentNode()
'     row = createContentNode()
'     row.title = "Results"

'     for each item in items
'         node = createContentNode()
'         node.ShortDescriptionLine1 = item.name
'         node.hdPosterUrl = item.thumbnail
'         node.ShortDescriptionLine2 = item.description
'         node.url = item.url
'         row.appendChild(node)
'     end for
'     content.appendChild(row)
'     m.rowList.content = content
'     m.rowList.visible = true
' end sub

' sub showNoResults()
'     m.resultsBg.visible = false
'     m.noResults.visible = true
'     m.instructions.visible = false
'     m.rowList.content = invalid
'     m.rowList.visible = false
' end sub

' sub hideAll()
'     m.resultsBg.visible = false
'     m.noResults.visible = false
'     m.instructions.visible = true
'     m.rowList.content = invalid
'     m.rowList.visible = false
' end sub

' function onKeyEvent(key as string, press as boolean) as boolean
'     if press
'         if key = "right"
'             if m.keyboard.isInFocusChain() and m.rowList.visible
'                 m.rowList.setFocus(true)
'                 m.currentFocus = 1
'                 return true
'             end if
'         else if key = "left"
'             if m.rowList.isInFocusChain()
'                 m.keyboard.setFocus(true)
'                 m.currentFocus = 0
'                 return true
'             end if
'         else if key = "back"
'             if m.rowList.hasFocus()
'                 m.keyboard.setFocus(true)
'                 return true
'             end if
'             return false
'         end if
'     end if
'     return false
' end function

sub init()
    initNodes()
    initObservers()
    initViewModels()
    m.keyboard.setFocus(true)

    m.currentFocus = 0

    if m.global.ttsEnabled = false
        m.keyboard.muteAudioGuide = "true"
        m.instructions.muteAudioGuide = "true"
    end if

    m.searchTimer = CreateObject("roSGNode", "Timer")
    m.searchTimer.duration = 0.5
    m.searchTimer.repeat = false
    m.searchTimer.observeField("fire", "performSearch")
end sub

sub initNodes()
    m.keyboard = m.top.findNode("searchkeyboard")
    m.rowList = m.top.findNode("rowList")
    m.resultsBg = m.top.findNode("resultBackground")
    m.noResults = m.top.findNode("noResultsContainer")
    m.instructions = m.top.findNode("instructionsLabel")
end sub

sub initObservers()
    m.top.observeField("focusedChild", "onFocusChange")
    m.keyboard.observeField("text", "onSearchTextChanged")
    m.rowList.observeField("rowItemSelected", "onItemSelected")
    m.rowList.observeField("rowItemFocused", "onItemFocused")
end sub

sub initViewModels()
    m.viewModel = CreateObject("roSGNode", "SearchViewModel")
    m.viewModel.observeField("searchResults", "onSearchResults")
    m.viewModel.observeField("hasResults", "onResultsStateChanged")
    m.viewModel.observeField("isEmptyQuery", "onEmptyQuery")
end sub

sub onFocusChange()
    if m.top.hasFocus()
        if m.currentFocus = 1
            m.rowList.setFocus(true)
        else
            m.keyboard.setFocus(true)
        end if
    end if
end sub

sub onSearchTextChanged(event as object)
    m.query = LCase(event.getData())
    m.searchTimer.control = "start"
end sub

sub performSearch()
    m.viewModel.callFunc("search", m.query)
end sub


sub onSearchResults()
    content = m.viewModel.searchResults
    if content <> invalid
        m.rowList.content = content
    end if
end sub

sub onResultsStateChanged()
    if m.viewModel.hasResults
        m.resultsBg.visible = true
        m.rowList.visible = true
        m.noResults.visible = false
        m.instructions.visible = false
        speak("Result found press right to go to results")
    else
        m.resultsBg.visible = false
        m.rowList.visible = false
        m.noResults.visible = true
        m.instructions.visible = false
        speak("No results found")
    end if
end sub

sub onEmptyQuery()
    if m.viewModel.isEmptyQuery
        m.resultsBg.visible = false
        m.noResults.visible = false
        m.instructions.visible = true
        m.rowList.visible = false
        m.rowList.content = invalid
    end if
end sub

sub onItemFocused()
    indices = m.rowList.rowItemFocused
    item = m.rowList.content.getChild(indices[0]).getChild(indices[1])
    if not isValid(item) then return
    text = getContentTitle(item)
    if isNonEmptyString(text)
        speak(text)
    end if
end sub

sub onItemSelected()
    indices = m.rowList.rowItemFocused
    row = m.rowList.content.getChild(indices[0])
    if not isValid(row) then return
    item = row.getChild(indices[1])
    if not isValid(item) then return
    speak(getContentTitle(item) + " selected")
    m.top.events = {
        type: "navigate"
        screen: "DetailScreen"
        payload: item
    }
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if press
        if key = "right"
            if m.keyboard.isInFocusChain() and m.rowList.visible
                m.rowList.setFocus(true)
                m.currentFocus = 1
                return true
            end if
        else if key = "left"
            if m.rowList.isInFocusChain()
                m.keyboard.setFocus(true)
                m.currentFocus = 0
                return true
            end if
        else if key = "back"
            if m.rowList.hasFocus()
                m.keyboard.setFocus(true)
                return true
            end if
            return false
        end if
    end if
    return false
end function