sub init()
    initNodes()
    initObservers()
    setupViewModels()
    loadContent()
    m.top.setFocus(true)
end sub

sub initNodes()
    m.grid = m.top.findNode("watchLaterGrid")
    m.emptyLabel = m.top.findNode("emptyLabel")
end sub


sub initObservers()
    m.top.observeField("focusedChild","onFocusRequest")
    m.grid.observeField( "itemSelected","onItemSelected")

    m.global.observeField("watchLaterList","loadContent")
end sub

sub setupViewModels()
    m.viewModel = WatchLaterViewModel()
    m.watchLaterModel = WatchLaterModel()
end sub

sub onFocusRequest()
    if m.global.watchLaterList.count() > 0
        m.grid.setFocus(true)
    end if
end sub


sub loadContent()
    ' list = m.global.watchLaterList

    ' if list.count() = 0
    '     m.emptyLabel.visible = true
    '     m.grid.visible       = false
    '     speak("Your Watch Later is empty") 
    '     return
    ' end if

    ' m.emptyLabel.visible = false
    ' m.grid.visible       = true

    ' gridContent = createContentNode()
    ' for each item in list
    '     m.itemNode =createContentNode()
    '     m.itemNode.ShortDescriptionLine1 = item.title
    '     m.itemNode.ShortDescriptionLine2 = item.description
    '     m.itemNode.HDPosterUrl           = item.poster
    '     m.itemNode.url                   = item.url
    '     gridContent.appendChild(m.itemNode)
    ' end for

    ' m.grid.content = gridContent
    list = m.global.watchLaterList

    m.viewModel.setWatchLaterList(list)


    if m.viewModel.isEmpty

        m.emptyLabel.visible = true

        m.grid.visible = false

        speak("Your Watch Later is empty")

        return

    end if


    m.emptyLabel.visible = false

    m.grid.visible = true

    m.grid.content = m.viewModel.getGridContent()

end sub


sub onItemSelected()
    if m.global.watchLaterList.count()  = 0 then return
    m.selectedItem = m.grid.content.getChild(m.grid.itemSelected)
    if m.selectedItem = invalid then return
    speak(m.selectedItem.ShortDescriptionLine1 + " selected")
    ' m.top.events = {
    '     type   : "navigate",
    '     screen : "DetailScreen",
    '     payload: m.selectedItem
    ' }
    m.top.events = m.viewModel.getNavigationPayload(m.selectedItem)
end sub

function onKeyEvent(key as string, press as boolean)as boolean
    if not press then return false
    if key = "options"
        list = m.global.watchLaterList
        if not isValid(list) or list.count() = 0 then return true
        focusedIndex = m.grid.itemFocused
        if focusedIndex < 0 or focusedIndex >= list.count() then return true
        removedItem = list[focusedIndex]
        list.delete(focusedIndex)
        m.global.watchLaterList = list
        
        speak("Removed from Watch Later")
        m.global.toast = {
            message :removedItem.title +" Successfully removed from watch later :)",
            duration: 2
        }
        print "toast set: "+ FormatJson(m.global.toast)
        ' loadContent()

        newCount = m.global.watchLaterList.count()
        if newCount > 0
            m.grid.setFocus(true)
            m.grid.jumpToItem = min(focusedIndex, newCount - 1)
        end if

        return true
    end if
    return false
end function
function min(a as integer, b as integer) as integer
    if a < b then return a
    return b
end function