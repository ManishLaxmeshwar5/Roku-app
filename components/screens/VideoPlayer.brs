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