sub init()
    RBS_CC_44_reportLine("1", 1)
    initNodes()
    RBS_CC_44_reportLine("2", 1)
    initObservers()
    RBS_CC_44_reportLine("3", 1)
    setupViewModels()
    RBS_CC_44_reportLine("4", 1)
    setupTimer()
end sub

sub initNodes()
    RBS_CC_44_reportLine("8", 1)
    m.video = m.top.findNode("videoNode")
end sub

sub initObservers()
    RBS_CC_44_reportLine("12", 1)
    m.top.observeField("videoContent", "onContentSet")
    if RBS_CC_44_reportLine("14", 2) and (m.video <> invalid)
        RBS_CC_44_reportLine("14", 3)
        RBS_CC_44_reportLine("15", 1)
        m.video.observeField("state", "onVideoStateChange")
    end if
end sub

sub setupViewModels()
    RBS_CC_44_reportLine("20", 1)
    m.viewModel = VideoPlayerViewModel()
    RBS_CC_44_reportLine("21", 1)
    m.bookmarkModel = BookmarkModel()
    RBS_CC_44_reportLine("22", 1)
    m.muxModel = MuxModel()
end sub

sub setupTimer()
    RBS_CC_44_reportLine("26", 1)
    m.progressUpdateTimer = CreateObject("roSGNode", "Timer")
    RBS_CC_44_reportLine("27", 1)
    m.progressUpdateTimer.duration = 5
    RBS_CC_44_reportLine("28", 1)
    m.progressUpdateTimer.repeat = true
    RBS_CC_44_reportLine("29", 1)
    m.progressUpdateTimer.observeField("fire", "onProgressTimerFire")
end sub

sub onContentSet()
    RBS_CC_44_reportLine("33", 1)
    content = m.top.videoContent
    if RBS_CC_44_reportLine("34", 2) and (not isValid(content))
        RBS_CC_44_reportLine("34", 3)
        RBS_CC_44_reportLine("35", 1)
        return
    end if
    RBS_CC_44_reportLine("38", 1)
    videoContent = m.viewModel.prepareVideoContent(content)
    RBS_CC_44_reportLine("39", 1)
    m.video.content = videoContent
    RBS_CC_44_reportLine("41", 1)
    bookmarkData = m.bookmarkModel.getBookmark(videoContent.title)
    RBS_CC_44_reportLine("43", 1)
    m.viewModel.setupResumeState(content, bookmarkData)
    RBS_CC_44_reportLine("45", 1)
    m.mux = m.muxModel.startTracking(m.video, content)
    RBS_CC_44_reportLine("46", 1)
    m.video.setFocus(true)
    RBS_CC_44_reportLine("47", 1)
    m.video.control = "play"
end sub

sub onProgressTimerFire()
    RBS_CC_44_reportLine("51", 1)
    updateBookmark()
end sub

sub updateBookmark()
    if RBS_CC_44_reportLine("55", 2) and (not isValid(m.video))
        RBS_CC_44_reportLine("55", 3)
        RBS_CC_44_reportLine("56", 1)
        return
    end if
    RBS_CC_44_reportLine("59", 1)
    position = m.video.position
    if RBS_CC_44_reportLine("61", 2) and (position <= 0)
        RBS_CC_44_reportLine("61", 3)
        RBS_CC_44_reportLine("62", 1)
        return
    end if
    RBS_CC_44_reportLine("65", 1)
    content = m.top.videoContent
    if RBS_CC_44_reportLine("67", 2) and (m.video.state = "finished")
        RBS_CC_44_reportLine("67", 3)
        RBS_CC_44_reportLine("68", 1)
        return
    end if
    if RBS_CC_44_reportLine("71", 2) and (m.video.position >= m.video.duration - 5)
        RBS_CC_44_reportLine("71", 3)
        RBS_CC_44_reportLine("72", 1)
        return
    end if
    RBS_CC_44_reportLine("75", 1)
    m.bookmarkModel.saveBookmark(content.url, content.title, position)
    RBS_CC_44_reportLine("77", 1)
    m.top.events = {
        type: "bookmark"
        videoUrl: content.url
        title: content.title
        bookmarkPosition: position
    }
end sub

sub onVideoStateChange()
    RBS_CC_44_reportLine("87", 1)
    state = m.video.state
    if RBS_CC_44_reportLine("89", 2) and (state = "playing")
        RBS_CC_44_reportLine("89", 3)
        RBS_CC_44_reportLine("90", 1)
        m.progressUpdateTimer.control = "start"
        if RBS_CC_44_reportLine("92", 2) and (m.viewModel.shouldSeek(m.video.duration))
            RBS_CC_44_reportLine("92", 3)
            RBS_CC_44_reportLine("93", 1)
            m.video.seek = m.viewModel.savedBookmarkPosition
            RBS_CC_44_reportLine("94", 1)
            m.viewModel.markResumed()
        end if
    else if RBS_CC_44_reportLine("97", 2) and (state = "paused" or state = "stopped" or state = "finished")
        RBS_CC_44_reportLine("97", 3)
        RBS_CC_44_reportLine("99", 1)
        m.progressUpdateTimer.control = "stop"
        if RBS_CC_44_reportLine("100", 2) and (state = "finished")
            RBS_CC_44_reportLine("100", 3)
            RBS_CC_44_reportLine("101", 1)
            m.bookmarkModel.clearBookmark(m.top.videoContent.title)
            RBS_CC_44_reportLine("103", 1)
            m.top.events = {
                type: "bookmark"
                videoId: m.top.videoContent.title
                bookmarkPosition: 0
            }
            if RBS_CC_44_reportLine("109", 2) and (isValid(m.mux))
                RBS_CC_44_reportLine("109", 3)
                RBS_CC_44_reportLine("110", 1)
                m.mux.view = "end"
            end if
        else
            RBS_CC_44_reportLine("112", 3)
            RBS_CC_44_reportLine("113", 1)
            updateBookmark()
        end if
    end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    if RBS_CC_44_reportLine("120", 2) and (not press)
        RBS_CC_44_reportLine("120", 3)
        RBS_CC_44_reportLine("121", 1)
        return false
    end if
    if RBS_CC_44_reportLine("124", 2) and (not isValid(m.video))
        RBS_CC_44_reportLine("124", 3)
        RBS_CC_44_reportLine("125", 1)
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
    if RBS_CC_44_reportLine("137", 2) and (key = "back")
        RBS_CC_44_reportLine("137", 3)
        if RBS_CC_44_reportLine("138", 2) and (isValid(m.mux))
            RBS_CC_44_reportLine("138", 3)
            RBS_CC_44_reportLine("139", 1)
            m.mux.view = "end"
        end if
        RBS_CC_44_reportLine("141", 1)
        m.video.control = "stop"
        RBS_CC_44_reportLine("142", 1)
        m.video.content = invalid
        RBS_CC_44_reportLine("143", 1)
        updateBookmark()
        RBS_CC_44_reportLine("144", 1)
        m.top.events = {
            type: "backPress"
        }
        RBS_CC_44_reportLine("147", 1)
        return true
    end if
    RBS_CC_44_reportLine("149", 1)
    return false
end function

sub handleFocus()
    RBS_CC_44_reportLine("153", 1)
    m.video.setFocus(true)
end sub

function RBS_CC_44_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "44"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "44"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./VideoPlayer.brs.map