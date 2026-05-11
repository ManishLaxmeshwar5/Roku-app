' sub init()
    
'     m.movieRowList = m.top.findNode("rowList")
'     m.movieRowList.setFocus(true)
'     initObservers()
'     m.contentType = ""
'     m.deepLinkId = invalid
'     m.isDeepLink = false
'     m.itemSize = m.movieRowList.rowItemSize
' end sub

' sub initObservers()
'     m.movieRowList.observeField("rowItemFocused", "onMovieFocused")
'     m.movieRowList.observeField("rowItemSelected", "onMovieSelected")
'     m.top.observeField("screenData", "onScreenDataChanged")
'     m.top.observeField("focusedChild", "onFocusRequest")
'     m.top.observeField("deepLinkPayload", "onDeepLinkPayloadChanged")
' end sub

' sub onScreenDataChanged()
'     payload = m.top.screenData
'     if not isValid(payload) then return
'     if isValid(payload.contentType)
'         m.contentType = payload.contentType
'     end if
'     loadContent()
' end sub

' sub onFocusRequest()
'     m.movieRowList.setFocus(true)
' end sub

' sub onMovieFocused()
'     focusedIndices = m.movieRowList.rowItemFocused
'     itemIndex = focusedIndices[1]
'     rowIndex = focusedIndices[0]

'     item = m.movieRowList.content.getChild(rowIndex).getChild(itemIndex)
'     text = item.ShortDescriptionLine1
'     if text = invalid or text = "" then text = item.title
'     if text = invalid or text = "" then return
'     speak(text)
' end sub

' sub onDeepLinkPayloadChanged()

'     payload = m.top.deepLinkPayload
'     if not isValid(payload) then return

'     print "Deep link payload received in MovieScreen: "; payload

'     if isValid(payload.contentType)
'         m.contentType = payload.contentType
'     end if

'     if isValid(payload.deepLinkId)
'         m.deepLinkId = payload.deepLinkId
'         m.isDeepLink = true
'     end if

'     loadContent()
' end sub

' sub loadContent()

'     if m.contentType = "series"
'         loadSeriesContent()
'     else
'         loadMoviesContent()
'     end if

' end sub

' sub loadMoviesContent()

'     jsonText = ReadAsciiFile("pkg:/source/moviesContent.json")
'     if jsonText = invalid or jsonText = "" then return

'     data = ParseJson(jsonText)

'     root = createObject("roSGNode", "ContentNode")

'     actionRow = createObject("roSGNode", "ContentNode")
'     actionRow.title = "Action Movies"

'     dramaRow = createObject("roSGNode", "ContentNode")
'     dramaRow.title = "Drama Movies"

'     comedyRow = createObject("roSGNode", "ContentNode")
'     comedyRow.title = "Comedy Movies"

'     for each movie in data.movies
'         itemNode = createObject("roSGNode", "ContentNode")
'         itemNode.ShortDescriptionLine1 = movie.name
'         itemNode.HDPosterUrl = movie.thumbnail
'         itemNode.url = movie.url
'         itemNode.ShortDescriptionLine2 = movie.description

'         if movie.genre = "Action"
'             actionRow.appendChild(itemNode)
'         else if movie.genre = "Drama"
'             dramaRow.appendChild(itemNode)
'         else if movie.genre = "Comedy"
'             comedyRow.appendChild(itemNode)
'         end if
'     end for

'     if actionRow.getChildCount() > 0 then root.appendChild(actionRow)
'     if dramaRow.getChildCount() > 0 then root.appendChild(dramaRow)
'     if comedyRow.getChildCount() > 0 then root.appendChild(comedyRow)

'     m.movieRowList.content = invalid
'     m.movieRowList.content = root

'     if m.isDeepLink = true and m.deepLinkId <> invalid
'         handleDeepLink()
'     end if
' end sub



' sub loadSeriesContent()

'     jsonText = ReadAsciiFile("pkg:/source/seriesContent.json")
'     if jsonText = invalid or jsonText = ""then return

'     data = ParseJson(jsonText)
'     if data = invalid or data.series = invalid then return

'     root = CreateObject("roSGNode", "ContentNode")

'     actionRow = CreateObject("roSGNode", "ContentNode")
'     actionRow.title = "Action Series"

'     dramaRow = createObject("roSGNode", "ContentNode")
'     dramaRow.title = "Drama Series"

'     comedyRow = createObject("roSGNode", "ContentNode")
'     comedyRow.title = "Comedy Series"

'     for each series in data.series
'         itemNode = CreateObject("roSGNode", "ContentNode")
'         itemNode.ShortDescriptionLine1 = series.name
'         itemNode.HDPosterUrl = series.thumbnail
'         itemNode.url = series.url
'         itemNode.ShortDescriptionLine2 = series.description

'         if series.genre = "Action"
'             actionRow.appendChild(itemNode)
'         else if series.genre = "Drama"
'             dramaRow.appendChild(itemNode)
'         else if series.genre = "Comedy"
'             comedyRow.appendChild(itemNode)
'         end if
'     end for

'     if actionRow.getChildCount() > 0 then root.appendChild(actionRow)
'     if dramaRow.getChildCount() > 0 then root.appendChild(dramaRow)
'     if comedyRow.getChildCount() > 0 then root.appendChild(comedyRow)

'     m.movieRowList.content = invalid
'     m.movieRowList.content = root

'     if m.isDeepLink = true and m.deepLinkId <> invalid
'         handleDeepLink()
'     end if

' end sub

' sub handleDeepLink()
'     print "deeplink handled from moviesceen" ; m.deepLinkId

'     root = m.movieRowList.content
'     if not isValid(root) then return
'     for rowIndex = 0 to root.getChildCount() - 1
'         row = root.getChild(rowIndex)
'         for itemIndex = 0 to row.getChildCount() - 1
'             item = row.getChild(itemIndex)
'             if isValid(item) and item.ShortDescriptionLine1 = m.deepLinkId
'                 print "Deeplink match found"
'                 'navigate to detailscreen
'                 item.addField("mediaType", "string", false)
'                 item.mediaType = m.contentType
'                 m.top.events = {
'                     type: "navigate"
'                     screen: "DetailScreen"
'                     payload: item
'                 }
'                 print "deeplink item" m.top.events
'                 m.isDeepLink = false
'                 m.deepLinkId = invalid
'                 m.top.deepLinkPayload = invalid
'                 return
'             end if
'         end for
'     end for
'     print "deeplink data not found"
' end sub

' sub onMovieSelected()
'     selectedIndices = m.movieRowList.rowItemSelected
'     itemIndex = selectedIndices[1]
'     rowIndex = selectedIndices[0]

'     if itemIndex >= 0 then
'         content = m.movieRowList.content.getChild(rowIndex)
'         if content <> invalid then
'             selectedItem = content.getChild(itemIndex)
'             if selectedItem <> invalid then
'                 speak(selectedItem.ShortDescriptionLine1 + " selected")
'                 event = {
'                     type: "navigate"
'                     screen: "DetailScreen"
'                     payload: selectedItem
'                 }
'                 m.top.events = event
'             end if
'         end if
'     end if
' end sub

' function onKeyEvent(key as string, press as boolean) as boolean
'     if not press then return false
'     if key = "left"
'         m.top.goback = true
'     end if
'     return false
' end function

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