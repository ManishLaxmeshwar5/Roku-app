sub init()
    initNodes()
    initObservers()
    initUIState()

    if isValid(m.top.itemContent)
        showContent()
    else
        showShimmer()
    end if
end sub

sub initNodes()
    m.poster        = m.top.findNode("poster")
    m.titleLabel    = m.top.findNode("titlelabel")
    m.descLabel     = m.top.findNode("descLabel")
    m.details       = m.top.findNode("details")
    m.progressBar   = m.top.findNode("progressBar")
    m.progressFill  = m.top.findNode("progressFill")
    m.shimmer       = m.top.findNode("shimmer")
end sub

sub initObservers()
    m.top.observeField("rowItemFocused", "onRowItemFocused")
    m.top.observeField("focused", "onFocusChange")

    m.global.observeField("stopAllPreviews", "onStopPreview")
    m.global.observeField("startPreview", "onStartPreview")
end sub

sub initUIState()
    m.poster.scale = [1.0, 1.0]
    m.titleLabel.opacity = 1.0
end sub

sub showShimmer()
    m.shimmer.visible = true
    m.shimmer.rectHeight = m.top.height
    m.shimmer.rectWidth = m.top.width
    m.shimmer.clippingRect = [0, 0, m.top.width, m.top.height]
    m.timer = CreateObject("roSGNode", "Timer")
    m.timer.duration = 1
    m.timer.repeat = false
    m.timer.observeField("fire", "showContent")
    m.timer.control = "start"
end sub

sub showContent()
    m.shimmer.visible = false
    c = m.top.itemContent
    if c <> invalid
        
        m.poster.uri = c.HDPosterUrl
        m.titlelabel.text = c.ShortDescriptionLine1
        m.descLabel.text = c.ShortDescriptionLine2

        if m.top.height > 0 then
            titleOffset = 20
            descOffset = 60
            m.titlelabel.translation = [0, m.top.height + titleOffset]
            m.descLabel.translation = [0, m.top.height + descOffset]
            if m.top.height = 200
                m.descLabel.visible = false
                m.titlelabel.width = "330"
            end if

        end if
        progress = 0
        if c.hasField("watchProgress") then
            progress = c.watchProgress
        end if
        if progress > 0 and progress <= 100
            m.progressBar.visible = true
            fillWidth = 512 * (progress / 100.0)
            m.progressFill.width = fillWidth
        else
            m.progressBar.visible = false
        end if

    end if
    ' c.addField("compHeight", "float", false)
    ' c.compHeight = m.top.height
    ' c.addField("compWidth", "float", false)
    ' c.compWidth = m.top.width
    m.shimmer.callFunc("stopAnim")
end sub

sub onFocus()
    if m.top.itemHasFocus
        startPreview()
    else
        stopPreview()
    end if
end sub


sub onStartPreview()
    if m.top.focusPercent <> 1 then return
    startPreview()
end sub


sub onStopPreview()
    stopPreview()
end sub

sub stopPreview()
    if m.video <> invalid
        m.video.control = "stop"
        m.video.content = invalid
        m.video.visible = false
        m.top.removeChild(m.video)
        m.video = invalid
    end if
end sub
sub startPreview()
    c = m.top.itemContent
    if c.screenType <> "home"
            return
        end if
    if m.video <> invalid then return

    m.video = CreateObject("roSGNode", "Video")
    m.top.appendChild(m.video)
    m.video.width = m.top.width
    m.video.height = m.top.height
    m.video.mute = true
    content = createContentNode()
    content.url = "https://storage.googleapis.com/shaka-demo-assets/angel-one-hls/hls.m3u8"
    content.streamformat = "hls"
    m.video.content = content
    m.video.control = "play"
    m.video.visible = true
end sub