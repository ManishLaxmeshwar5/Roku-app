' sub init()
'     initNodes()
'     initObservers()

'     m.watchLaterFocused = false
'     m.autoPlayTimer = CreateObject("roSGNode", "Timer")
'     m.autoPlayTimer.duration = 0
'     m.autoPlayTimer.repeat = false
'     m.autoPlayTimer.observeField("fire", "onAutoPlayTimer")

'     if m.top.itemContent <> invalid
'         onContentChanged()
'     end if
' end sub

' sub initNodes()
'     m.poster = m.top.findNode("detailPoster")
'     m.background = m.top.findNode("background")
'     m.bgPoster = m.top.findNode("bgPoster")
'     m.title = m.top.findNode("detailTitle")
'     m.desc = m.top.findNode("detailDescription")
'     m.playBtn = m.top.findNode("rowList")
'     m.mainLayout = m.top.findNode("mainLayout")
'     m.contentLayout = m.top.findNode("contentLayout")
'     m.watchLaterBg = m.top.findNode("watchLaterBg")
'     m.watchLaterGroup = m.top.findNode("watchLaterGroup")
'     m.watchLaterIcon = m.top.findNode("watchLaterIcon")
' end sub

' sub initObservers()
'     m.top.observeField("focusedChild", "onFocusRequest")
'     m.playBtn.observeField("buttonSelected", "onPlayButtonSelected")
'     m.top.observeField("itemContent", "onContentChanged")
' end sub

' sub onFocusRequest()
'     if m.watchLaterFocused
'         m.watchLaterGroup.setFocus(true)
'     else
'         m.playBtn.setFocus(true)
'     end if
' end sub


' sub onContentChanged()
'     content = m.top.itemContent

'     if not isValid(content) then return

'     if isValid(content.HDPosterUrl)
'         m.poster.uri = content.HDPosterUrl
'         m.bgPoster.uri = content.HDPosterUrl
'     end if

'     m.title.text = content.ShortDescriptionLine1
'     m.desc.text = content.ShortDescriptionLine2

'     watchLaterList = m.global.watchLaterList
'     isInList = false
'     for i = 0 to watchLaterList.count() - 1
'         if watchLaterList[i].title = content.ShortDescriptionLine1
'             isInList = true
'             exit for
'         end if
'     end for

'     if isInList
'         m.watchLaterIcon.opacity = 1.0
'     else
'         m.watchLaterIcon.opacity = 0.5
'     end if

'     if content.DoesExist("mediaType") and content.mediaType = "movies"
'         content.mediaType = ""
'         m.autoPlayTimer.control = "start"
'     end if

' end sub

' sub onAutoPlayTimer()

'     content = m.top.itemContent
'     if not isValid(content) then return

'     m.top.events = {
'         type: "navigate",
'         screen: "VideoPlayer",

'         payload: {
'             url: content.url,
'             title: content.ShortDescriptionLine1
'         }
'     }
' end sub


' sub onPlayButtonSelected()
'     content = m.top.itemContent
'     if not isValid(content) then return
'     m.top.events = {
'         type: "navigate",
'         screen: "VideoPlayer",
'         payload: {
'             url: content.url,
'             title: content.ShortDescriptionLine1
'         }
'     }
' end sub

' sub watchlater()
'     content = m.top.itemContent
'     if not isValid(content) then return

'     item = {
'         title: content.ShortDescriptionLine1
'         description: content.ShortDescriptionLine2
'         url: content.url
'         poster: content.HDPosterUrl
'     }
'     updatedList = m.global.watchLaterList

'     for i = 0 to updatedList.count() - 1
'         if updatedList[i].title = item.title
'             ' Found — remove it
'             updatedList.delete(i)

'             m.global.watchLaterList = updatedList
'             speak ("Removed from Watch Later")
'             m.global.toast = {
'                 message: item.title + " removed from Watch later :(",
'                 duration: 2
'             }
'             m.watchLaterIcon.opacity = 0.5
'             return
'         end if
'     end for

'     updatedList = m.global.watchLaterList
'     updatedList.push(item)
'     m.watchLaterIcon.opacity = 1.0
'     m.global.watchLaterList = updatedList
'     speak("added to watch later")
'     m.global.toast = {
'         message: item.title + " successfully added to Watch later :)",
'         duration: 2
'     }

' end sub



' function onKeyEvent(key as string, press as boolean) as boolean
'     if not press then return false


'     if key = "right"
'         if not m.watchLaterFocused
'             speak("WatchLater")
'             m.watchLaterFocused = true
'             m.playBtn.setFocus(false)
'             m.watchLaterGroup.setFocus(true)
'             m.watchLaterBg.color = "#988f8fff "
'         end if
'         return true
'     end if
'     if key = "left"
'         if m.watchLaterFocused
'             speak("Watch Now")
'             m.watchLaterFocused = false
'             m.playBtn.setFocus(true)
'             m.watchLaterBg.color = "0x00000000"
'         end if
'         return true
'     end if

'     if key = "OK"
'         if m.watchLaterFocused
'             watchlater()
'         else
'             onPlayButtonSelected()
'             speak("Video is playing")
'         end if
'         return true
'     end if

'     if key = "back"
'         m.top.events = { type: "backPress" }
'         m.continueWatching = true
'         return true
'     end if

'     return false
' end function

sub init()
    initNodes()
    initObservers()

    setupViewModels()
    setupAutoPlay()

    m.watchLaterFocused = false

    if m.top.itemContent <> invalid
        onContentChanged()
    end if

end sub


sub initNodes()
    m.poster = m.top.findNode("detailPoster")
    m.bgPoster = m.top.findNode("bgPoster")
    m.title = m.top.findNode("detailTitle")
    m.desc = m.top.findNode("detailDescription")
    m.playBtn = m.top.findNode("rowList")
    m.watchLaterGroup = m.top.findNode("watchLaterGroup")
    m.watchLaterBg = m.top.findNode("watchLaterBg")
    m.watchLaterIcon = m.top.findNode("watchLaterIcon")
end sub

sub initObservers()
    m.top.observeField("itemContent", "onContentChanged")
    m.playBtn.observeField("buttonSelected", "onPlayButtonSelected")
    m.top.observeField("focusedChild", "onFocusRequest")
end sub

sub setupViewModels()
    m.viewModel = DetailViewModel()
    m.watchLaterModel = WatchLaterModel()
end sub

sub setupAutoPlay()
    m.autoPlayTimer = CreateObject("roSGNode", "Timer")
    m.autoPlayTimer.duration = 0
    m.autoPlayTimer.repeat = false
    m.autoPlayTimer.observeField("fire", "onAutoPlayTimer")
end sub

sub onContentChanged()

    content = m.top.itemContent
    if not isValid(content) then return
    m.viewModel.setContent(content, m.global.watchLaterList)
    updateUI()
    if content.DoesExist("mediaType")
        if content.mediaType = "movies"
            m.autoPlayTimer.control = "start"
        end if
    end if
end sub



' =========================================
' UPDATE UI
' =========================================

sub updateUI()

    content = m.viewModel.content
    if isValid(content.HDPosterUrl)
        m.poster.uri = content.HDPosterUrl
        m.bgPoster.uri = content.HDPosterUrl
    end if

    m.title.text = content.ShortDescriptionLine1
    m.desc.text = content.ShortDescriptionLine2

    if m.viewModel.isInWatchLater
        m.watchLaterIcon.opacity = 1.0
    else
        m.watchLaterIcon.opacity = 0.5
    end if
end sub

sub onPlayButtonSelected()
    m.top.events = m.viewModel.getNavigationPayload()
end sub

sub onAutoPlayTimer()
    m.top.events = m.viewModel.getNavigationPayload()
end sub

sub watchLater()

    content = m.top.itemContent
    if not isValid(content) then return

    result = m.watchLaterModel.toggleWatchLater(content,m.global.watchLaterList)
    m.global.watchLaterList = result.updatedList

    if result.added
        m.watchLaterIcon.opacity = 1.0
        speak("Added to watch later")
    else
        m.watchLaterIcon.opacity = 0.5
        speak("Removed from watch later")
    end if
end sub

sub onFocusRequest()
    if m.watchLaterFocused
        m.watchLaterGroup.setFocus(true)
    else
        m.playBtn.setFocus(true)
    end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    if not press then return false

    if key = "right"
        if not m.watchLaterFocused
            m.watchLaterFocused = true
            m.playBtn.setFocus(false)
            m.watchLaterGroup.setFocus(true)
            m.watchLaterBg.color = "#988f8fff"
        end if
        return true
    end if

    if key = "left"
        if m.watchLaterFocused
            m.watchLaterFocused = false
            m.playBtn.setFocus(true)
            m.watchLaterBg.color = "0x00000000"
        end if
        return true
    end if

    if key = "OK"
        if m.watchLaterFocused
            watchLater()
        else
            onPlayButtonSelected()
        end if
        return true
    end if

    if key = "back"
        m.top.events = {
            type: "backPress"
        }
        return true
    end if
    return false
end function
