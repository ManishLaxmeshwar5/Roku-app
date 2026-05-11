' sub init()
'     m.video = m.top.findNode("videoNode")
'     if m.video <> invalid
'         m.video.observeField("state", "onVideoStateChange")
'     end if

'     m.registry = CreateObject("roRegistrySection", "VideoBookmarks")

'     m.progressUpdateTimer = CreateObject("roSGNode", "Timer")
'     m.progressUpdateTimer.duration = 5
'     m.progressUpdateTimer.repeat = true
'     m.progressUpdateTimer.observeField("fire", "onProgressTimerFire")

'     m.isVideoContentSet = false
'     m.shouldResumeFromBookmark = false
'     m.hasResumedFromBookmark = false
'     m.savedBookmarkPosition = 0

'     if m.top.videoContent <> invalid
'         onContentSet()
'     end if
'     m.top.observeField("videoContent", "onContentSet")

' end sub

' sub mux(content as object)
'     if not isValid(m.mux)
'         m.mux = createObject("roSGNode", "MuxTask")
'     end if
'     m.mux.video = m.video

'     muxConfig = {
'         env_key: "gclsk122j8oqocr7cacau07vm"
'         player_name: "Custom Roku Player"
'         player_version: "1.0"
'         video_title: content.title
'         video_id: content.url
'         video_stream_type: "on-demand"
'     }

'     m.mux.config = muxConfig
'     m.mux.control = "RUN"
'     m.mux.view = "start"
' end sub

' sub onContentSet()
'     content = m.top.videoContent
'     if not isValid(content) or not isValid(m.video) then return

'     if m.isVideoContentSet then
'         return
'     end if

'     videoContent = createContentNode()
'     videoContent.url = content.url
'     videoContent.title = getContentTitle(content)
'     m.video.content = videoContent
'     m.isVideoContentSet = true

'     bookmarkData = getBookmarkFromRegistry(videoContent.title)
'     if content.DoesExist("bookmarkPosition") and content.bookmarkPosition > 5
'         m.savedBookmarkPosition = content.bookmarkPosition
'         m.shouldResumeFromBookmark = true
'         m.hasResumedFromBookmark = false

'     else if bookmarkData.position > 5
'         m.savedBookmarkPosition = bookmarkData.position
'         m.shouldResumeFromBookmark = true
'         m.hasResumedFromBookmark = false

'     end if
'     m.video.setFocus(true)
'     mux(content)
'     m.video.control = "play"
' end sub



' sub onProgressTimerFire()
'     updateBookmark()
' end sub


' sub updateBookmark()
'     if not isValid(m.video) or not isValid(m.top.videoContent) then return

'     position = m.video.position
'     if position <= 0 then return

'     content = m.top.videoContent
'     title = getContentTitle(content)
'     if m.video.state = "finished" or m.video.position >= m.video.duration - 5 then return
'     saveBookmarkToRegistry(content.url, title, position)
'     ' stop
'     m.top.events = {
'         type: "bookmark",
'         videoUrl: content.url,
'         title: content.title,
'         bookmarkPosition: position
'     }
' end sub

' sub saveBookmarkToRegistry(videoUrl as string, title as string, position as integer)
'     if not isValid(m.registry) then return
'     if not isNonEmptyString(title) then return

'     titleKey = LCase(title.Trim())

'     bookmarkData = {
'         url: videoUrl,
'         title: title,
'         position: position
'     }
'     m.registry.Write(titleKey, FormatJSON(bookmarkData))
'     m.registry.Flush()
' end sub

' function getBookmarkFromRegistry(title as string) as object
'     result = { url: "", title: title, position: 0 }
'     if not isValid(m.registry) or not isNonEmptyString(title) then return result
'     key = Lcase(title.Trim())
'     value = m.registry.Read(key)
'     if isNonEmptyString(value)
'         parsed = ParseJSON(value)
'         if isValidAA(parsed)
'             if parsed.DoesExist("url") then result.url = parsed.url
'             if parsed.DoesExist("title") then result.title = parsed.title
'             if parsed.DoesExist("position") then result.position = parsed.position
'         else
'             result.position = value.ToInt()
'         end if
'     end if
'     return result
' end function

' function getContinueWatchingList() as object
'     continueWatching = []
'     if not isValid(m.registry) then return continueWatching

'     keys = m.registry.GetKeyList()
'     for each key in keys
'         value = m.registry.Read(key)
'         if isNonEmptyString(value)
'             parsed = ParseJSON(value)
'             if isValidAA(parsed) and parsed.DoesExist("position") and parsed.position > 0
'                 continueWatching.Push({
'                     url: parsed.url,
'                     title: parsed.title,
'                     position: parsed.position
'                 })
'             end if
'         end if
'     end for
'     return continueWatching
' end function

' sub clearBookmarkFromRegistry(title as string)
'     if isValid(m.registry) and isNonEmptyString(title)
'         key = Lcase(title.Trim())
'         m.registry.Delete(key)
'         m.registry.Flush()
'     end if
' end sub


' function getRegistryKey(videoUrl as string) as string

'     key = videoUrl
'     key = key.Replace("/", "_")
'     key = key.Replace(":", "_")
'     key = key.Replace("?", "_")
'     key = key.Replace("&", "_")
'     key = key.Replace("=", "_")

'     if key.Len() > 255
'         key = key.Left(255)
'     end if
'     return key
' end function


' sub onVideoStateChange()
'     state = m.video.state

'     if state = "playing"
'         m.progressUpdateTimer.control = "start"

'         if m.savedBookmarkPosition > 0 and not m.hasResumedFromBookmark
'             if m.video.duration > m.savedBookmarkPosition
'                 m.video.seek = m.savedBookmarkPosition
'                 m.hasResumedFromBookmark = true
'             else
'                 print "Seek skipped - invalid duration"
'             end if
'         end if

'     else if state = "paused" or state = "stopped" or state = "finished"
'         m.progressUpdateTimer.control = "stop"
'         ' updateBookmark()

'         if state = "finished" or m.video.position >= m.video.duration - 5
'             clearBookmarkFromRegistry(getContentTitle(m.top.videoContent))
'             m.top.events = {
'                 type: "bookmark",
'                 videoId: m.top.videoContent.title,
'                 bookmarkPosition: 0
'             }
'             if isValid(m.mux)
'                 m.mux.view = "end"
'             end if
'         else
'             updateBookmark()
'         end if
'     end if
' end sub



' function onKeyEvent(key as string, press as boolean) as boolean

'     if not press then return false
'     if not isValid(m.video) then return false

'     if key = "OK" then
'         if m.video.state = "playing"
'             m.video.control = "pause"
'         else if m.video.state = "paused"
'             m.video.control = "resume"
'         end if
'         return true
'     end if

'     if key = "back"
'         if m.mux <> invalid
'             m.mux.view = "end"
'         end if

'         m.video.control = "stop"
'         m.video.content = invalid
'         updateBookmark()
'         m.top.events = { type: "backPress" }
'         return true
'     end if

'     return true
' end function

' sub handleFocus()
'     m.video.setFocus(true)
' end sub

sub init()
    initNodes()
    initObservers()
    setupViewModels()
    setupTimer()
end sub

sub initNodes()
    m.video = m.top.findNode("videoNode")
end sub

sub initObservers()
    m.top.observeField("videoContent","onContentSet")

    if m.video <> invalid
        m.video.observeField("state","onVideoStateChange")
    end if
end sub

sub setupViewModels()
    m.viewModel = VideoPlayerViewModel()
    m.bookmarkModel = BookmarkModel()
    m.muxModel =MuxModel()
end sub

sub setupTimer()
    m.progressUpdateTimer = CreateObject("roSGNode","Timer")
    m.progressUpdateTimer.duration = 5
    m.progressUpdateTimer.repeat = true
    m.progressUpdateTimer.observeField("fire","onProgressTimerFire")
end sub

sub onContentSet()
    content = m.top.videoContent
    if not isValid(content)
        return
    end if

    videoContent = m.viewModel.prepareVideoContent(content)
    m.video.content = videoContent

    bookmarkData = m.bookmarkModel.getBookmark(videoContent.title)

    m.viewModel.setupResumeState(content,bookmarkData)

    m.mux = m.muxModel.startTracking(m.video,content)
    m.video.setFocus(true)
    m.video.control = "play"
end sub

sub onProgressTimerFire()
    updateBookmark()
end sub

sub updateBookmark()
    if not isValid(m.video)
        return
    end if

    position = m.video.position

    if position <= 0
        return
    end if

    content = m.top.videoContent

    if m.video.state = "finished"
        return
    end if

    if m.video.position >= m.video.duration - 5
        return
    end if

    m.bookmarkModel.saveBookmark(content.url,content.title,position)

    m.top.events = {
        type: "bookmark"
        videoUrl: content.url
        title: content.title
        bookmarkPosition: position
    }

end sub

sub onVideoStateChange()
    state = m.video.state

    if state = "playing"
        m.progressUpdateTimer.control ="start"

        if m.viewModel.shouldSeek(m.video.duration)
            m.video.seek = m.viewModel.savedBookmarkPosition
            m.viewModel.markResumed()
        end if

    else if state = "paused" or state = "stopped" or state = "finished"

        m.progressUpdateTimer.control ="stop"
        if state = "finished"
            m.bookmarkModel.clearBookmark(m.top.videoContent.title)

            m.top.events = {
                type: "bookmark"
                videoId: m.top.videoContent.title
                bookmarkPosition: 0
            }

            if isValid(m.mux)
                m.mux.view = "end"
            end if
        else
            updateBookmark()
        end if
    end if
end sub

function onKeyEvent(key as String,press as Boolean) as Boolean

    if not press
        return false
    end if

    if not isValid(m.video)
        return false
    end if

    ' if key = "OK"
    '     if m.video.state = "playing"
    '         m.video.control = "pause"
    '     else if m.video.state = "paused"
    '         m.video.control = "resume"
    '     end if
    '     return true
    ' end if

    if key = "back"
        if isValid(m.mux)
            m.mux.view = "end"
        end if
        m.video.control = "stop"
        m.video.content = invalid
        updateBookmark()
        m.top.events = {
            type: "backPress"
        }
        return true
    end if
    return false
end function

sub handleFocus()
    m.video.setFocus(true)
end sub