sub init()
    RBS_CC_11_reportLine("1", 1)
    initNodes()
    RBS_CC_11_reportLine("2", 1)
    initObservers()
    RBS_CC_11_reportLine("3", 1)
    initUIState()
    if RBS_CC_11_reportLine("5", 2) and (isValid(m.top.itemContent))
        RBS_CC_11_reportLine("5", 3)
        RBS_CC_11_reportLine("6", 1)
        showContent()
    else
        RBS_CC_11_reportLine("7", 3)
        RBS_CC_11_reportLine("8", 1)
        showShimmer()
    end if
end sub

sub initNodes()
    RBS_CC_11_reportLine("13", 1)
    m.poster = m.top.findNode("poster")
    RBS_CC_11_reportLine("14", 1)
    m.titleLabel = m.top.findNode("titlelabel")
    RBS_CC_11_reportLine("15", 1)
    m.descLabel = m.top.findNode("descLabel")
    RBS_CC_11_reportLine("16", 1)
    m.details = m.top.findNode("details")
    RBS_CC_11_reportLine("17", 1)
    m.progressBar = m.top.findNode("progressBar")
    RBS_CC_11_reportLine("18", 1)
    m.progressFill = m.top.findNode("progressFill")
    RBS_CC_11_reportLine("19", 1)
    m.shimmer = m.top.findNode("shimmer")
end sub

sub initObservers()
    RBS_CC_11_reportLine("23", 1)
    m.top.observeField("rowItemFocused", "onRowItemFocused")
    RBS_CC_11_reportLine("24", 1)
    m.top.observeField("focused", "onFocusChange")
    RBS_CC_11_reportLine("26", 1)
    m.global.observeField("stopAllPreviews", "onStopPreview")
    RBS_CC_11_reportLine("27", 1)
    m.global.observeField("startPreview", "onStartPreview")
end sub

sub initUIState()
    RBS_CC_11_reportLine("31", 1)
    m.poster.scale = [
        1.0
        1.0
    ]
    RBS_CC_11_reportLine("32", 1)
    m.titleLabel.opacity = 1.0
end sub

sub showShimmer()
    RBS_CC_11_reportLine("36", 1)
    m.shimmer.visible = true
    RBS_CC_11_reportLine("37", 1)
    m.shimmer.rectHeight = m.top.height
    RBS_CC_11_reportLine("38", 1)
    m.shimmer.rectWidth = m.top.width
    RBS_CC_11_reportLine("39", 1)
    m.shimmer.clippingRect = [
        0
        0
        m.top.width
        m.top.height
    ]
    RBS_CC_11_reportLine("40", 1)
    m.timer = CreateObject("roSGNode", "Timer")
    RBS_CC_11_reportLine("41", 1)
    m.timer.duration = 1
    RBS_CC_11_reportLine("42", 1)
    m.timer.repeat = false
    RBS_CC_11_reportLine("43", 1)
    m.timer.observeField("fire", "showContent")
    RBS_CC_11_reportLine("44", 1)
    m.timer.control = "start"
end sub

sub showContent()
    RBS_CC_11_reportLine("48", 1)
    m.shimmer.visible = false
    RBS_CC_11_reportLine("49", 1)
    c = m.top.itemContent
    if RBS_CC_11_reportLine("50", 2) and (c <> invalid)
        RBS_CC_11_reportLine("50", 3)
        RBS_CC_11_reportLine("52", 1)
        m.poster.uri = c.HDPosterUrl
        RBS_CC_11_reportLine("53", 1)
        m.titlelabel.text = c.ShortDescriptionLine1
        RBS_CC_11_reportLine("54", 1)
        m.descLabel.text = c.ShortDescriptionLine2
        if RBS_CC_11_reportLine("56", 2) and (m.top.height > 0) then
            RBS_CC_11_reportLine("56", 3)
            RBS_CC_11_reportLine("57", 1)
            titleOffset = 20
            RBS_CC_11_reportLine("58", 1)
            descOffset = 60
            RBS_CC_11_reportLine("59", 1)
            m.titlelabel.translation = [
                0
                m.top.height + titleOffset
            ]
            RBS_CC_11_reportLine("60", 1)
            m.descLabel.translation = [
                0
                m.top.height + descOffset
            ]
            if RBS_CC_11_reportLine("61", 2) and (m.top.height = 200)
                RBS_CC_11_reportLine("61", 3)
                RBS_CC_11_reportLine("62", 1)
                m.descLabel.visible = false
                RBS_CC_11_reportLine("63", 1)
                m.titlelabel.width = "330"
            end if
        end if
        RBS_CC_11_reportLine("67", 1)
        progress = 0
        if RBS_CC_11_reportLine("68", 2) and (c.hasField("watchProgress")) then
            RBS_CC_11_reportLine("68", 3)
            RBS_CC_11_reportLine("69", 1)
            progress = c.watchProgress
        end if
        if RBS_CC_11_reportLine("71", 2) and (progress > 0 and progress <= 100)
            RBS_CC_11_reportLine("71", 3)
            RBS_CC_11_reportLine("72", 1)
            m.progressBar.visible = true
            RBS_CC_11_reportLine("73", 1)
            fillWidth = 512 * (progress / 100.0)
            RBS_CC_11_reportLine("74", 1)
            m.progressFill.width = fillWidth
        else
            RBS_CC_11_reportLine("75", 3)
            RBS_CC_11_reportLine("76", 1)
            m.progressBar.visible = false
        end if
    end if
    ' c.addField("compHeight", "float", false)
    ' c.compHeight = m.top.height
    ' c.addField("compWidth", "float", false)
    ' c.compWidth = m.top.width
    RBS_CC_11_reportLine("84", 1)
    m.shimmer.callFunc("stopAnim")
end sub

sub onFocus()
    if RBS_CC_11_reportLine("88", 2) and (m.top.itemHasFocus)
        RBS_CC_11_reportLine("88", 3)
        RBS_CC_11_reportLine("89", 1)
        startPreview()
    else
        RBS_CC_11_reportLine("90", 3)
        RBS_CC_11_reportLine("91", 1)
        stopPreview()
    end if
end sub

sub onStartPreview()
    if RBS_CC_11_reportLine("97", 2) and (m.top.focusPercent <> 1) then
        RBS_CC_11_reportLine("97", 3)
        RBS_CC_11_reportLine("97", 1)
        return
    end if
    RBS_CC_11_reportLine("98", 1)
    startPreview()
end sub

sub onStopPreview()
    RBS_CC_11_reportLine("103", 1)
    stopPreview()
end sub

sub stopPreview()
    if RBS_CC_11_reportLine("107", 2) and (m.video <> invalid)
        RBS_CC_11_reportLine("107", 3)
        RBS_CC_11_reportLine("108", 1)
        m.video.control = "stop"
        RBS_CC_11_reportLine("109", 1)
        m.video.content = invalid
        RBS_CC_11_reportLine("110", 1)
        m.video.visible = false
        RBS_CC_11_reportLine("111", 1)
        m.top.removeChild(m.video)
        RBS_CC_11_reportLine("112", 1)
        m.video = invalid
    end if
end sub

sub startPreview()
    RBS_CC_11_reportLine("116", 1)
    c = m.top.itemContent
    if RBS_CC_11_reportLine("117", 2) and (c.screenType <> "home")
        RBS_CC_11_reportLine("117", 3)
        RBS_CC_11_reportLine("118", 1)
        return
    end if
    if RBS_CC_11_reportLine("120", 2) and (m.video <> invalid) then
        RBS_CC_11_reportLine("120", 3)
        RBS_CC_11_reportLine("120", 1)
        return
    end if
    RBS_CC_11_reportLine("122", 1)
    m.video = CreateObject("roSGNode", "Video")
    RBS_CC_11_reportLine("123", 1)
    m.top.appendChild(m.video)
    RBS_CC_11_reportLine("124", 1)
    m.video.width = m.top.width
    RBS_CC_11_reportLine("125", 1)
    m.video.height = m.top.height
    RBS_CC_11_reportLine("126", 1)
    m.video.mute = true
    RBS_CC_11_reportLine("127", 1)
    content = createContentNode()
    RBS_CC_11_reportLine("128", 1)
    content.url = "https://storage.googleapis.com/shaka-demo-assets/angel-one-hls/hls.m3u8"
    RBS_CC_11_reportLine("129", 1)
    content.streamformat = "hls"
    RBS_CC_11_reportLine("130", 1)
    m.video.content = content
    RBS_CC_11_reportLine("131", 1)
    m.video.control = "play"
    RBS_CC_11_reportLine("132", 1)
    m.video.visible = true
end sub

function RBS_CC_11_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "11"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "11"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./UIRowListItem.brs.map