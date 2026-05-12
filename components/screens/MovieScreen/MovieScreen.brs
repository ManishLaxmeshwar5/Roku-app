sub init()

    m.movieRowList = m.top.findNode("rowList")

    m.movieRowList.setFocus(true)

    initObservers()

    initViewModel()

    m.contentType = ""

    m.deepLinkId = invalid

    m.isDeepLink = false

    m.itemSize = m.movieRowList.rowItemSize

end sub


sub initViewModel()

    m.viewModel = CreateObject("roSGNode", "MovieViewModel")

    m.viewModel.observeField("movieContent", "onMovieContentLoaded")

    m.viewModel.observeField("deepLinkItem", "onDeepLinkItemFound")

end sub


sub initObservers()

    m.movieRowList.observeField("rowItemFocused", "onMovieFocused")

    m.movieRowList.observeField("rowItemSelected", "onMovieSelected")

    m.top.observeField("screenData", "onScreenDataChanged")

    m.top.observeField("focusedChild", "onFocusRequest")

    m.top.observeField("deepLinkPayload", "onDeepLinkPayloadChanged")

end sub


sub onMovieContentLoaded()

    m.movieRowList.content = invalid

    m.movieRowList.content = m.viewModel.movieContent

    if m.isDeepLink = true and m.deepLinkId <> invalid

        m.viewModel.callFunc("handleDeepLink", m.deepLinkId, m.contentType)

    end if

end sub


sub onDeepLinkItemFound()

    item = m.viewModel.deepLinkItem

    if not isValid(item) then return

    m.top.events = {
        type: "navigate"
        screen: "DetailScreen"
        payload: item
    }

    m.isDeepLink = false

    m.deepLinkId = invalid

    m.top.deepLinkPayload = invalid

end sub


sub onScreenDataChanged()

    payload = m.top.screenData

    if not isValid(payload) then return

    if isValid(payload.contentType)

        m.contentType = payload.contentType

    end if

    m.viewModel.callFunc("loadContent", m.contentType)

end sub


sub onDeepLinkPayloadChanged()

    payload = m.top.deepLinkPayload

    if not isValid(payload) then return

    if isValid(payload.contentType)

        m.contentType = payload.contentType

    end if

    if isValid(payload.deepLinkId)

        m.deepLinkId = payload.deepLinkId

        m.isDeepLink = true

    end if

    m.viewModel.callFunc("loadContent", m.contentType)

end sub


sub onFocusRequest()

    m.movieRowList.setFocus(true)

end sub


sub onMovieFocused()

    focusedIndices = m.movieRowList.rowItemFocused

    itemIndex = focusedIndices[1]

    rowIndex = focusedIndices[0]

    item = m.movieRowList.content.getChild(rowIndex).getChild(itemIndex)

    text = item.ShortDescriptionLine1

    if text = invalid or text = ""

        text = item.title

    end if

    if text = invalid or text = "" then return

    speak(text)

end sub


sub onMovieSelected()

    selectedIndices = m.movieRowList.rowItemSelected

    itemIndex = selectedIndices[1]

    rowIndex = selectedIndices[0]

    if itemIndex >= 0

        content = m.movieRowList.content.getChild(rowIndex)

        if content <> invalid

            selectedItem = content.getChild(itemIndex)

            if selectedItem <> invalid

                speak(selectedItem.ShortDescriptionLine1 + " selected")

                event = {
                    type: "navigate"
                    screen: "DetailScreen"
                    payload: selectedItem
                }

                m.top.events = event

            end if

        end if

    end if

end sub


function onKeyEvent(key as string, press as boolean) as boolean

    if not press then return false

    if key = "left"

        m.top.goback = true

    end if

    return false

end function