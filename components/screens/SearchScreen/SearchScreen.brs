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