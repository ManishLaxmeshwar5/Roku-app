sub init()
    RBS_CC_39_reportLine("2", 1)
    initNodes()
    RBS_CC_39_reportLine("3", 1)
    initObservers()
    RBS_CC_39_reportLine("5", 1)
    setupViewModels()
    RBS_CC_39_reportLine("6", 1)
    setupAutoPlay()
    RBS_CC_39_reportLine("8", 1)
    m.watchLaterFocused = false
    if RBS_CC_39_reportLine("10", 2) and (m.top.itemContent <> invalid)
        RBS_CC_39_reportLine("10", 3)
        RBS_CC_39_reportLine("11", 1)
        onContentChanged()
    end if
end sub

sub initNodes()
    RBS_CC_39_reportLine("17", 1)
    m.poster = m.top.findNode("detailPoster")
    RBS_CC_39_reportLine("18", 1)
    m.bgPoster = m.top.findNode("bgPoster")
    RBS_CC_39_reportLine("19", 1)
    m.title = m.top.findNode("detailTitle")
    RBS_CC_39_reportLine("20", 1)
    m.desc = m.top.findNode("detailDescription")
    RBS_CC_39_reportLine("21", 1)
    m.playBtn = m.top.findNode("rowList")
    RBS_CC_39_reportLine("22", 1)
    m.watchLaterGroup = m.top.findNode("watchLaterGroup")
    RBS_CC_39_reportLine("23", 1)
    m.watchLaterBg = m.top.findNode("watchLaterBg")
    RBS_CC_39_reportLine("24", 1)
    m.watchLaterIcon = m.top.findNode("watchLaterIcon")
    RBS_CC_39_reportLine("25", 1)
    m.watchNow = m.top.findNode("rowList")
end sub

sub initObservers()
    RBS_CC_39_reportLine("29", 1)
    m.top.observeField("itemContent", "onContentChanged")
    RBS_CC_39_reportLine("30", 1)
    m.playBtn.observeField("buttonSelected", "onPlayButtonSelected")
    RBS_CC_39_reportLine("31", 1)
    m.top.observeField("focusedChild", "onFocusRequest")
end sub

sub setupViewModels()
    RBS_CC_39_reportLine("35", 1)
    m.viewModel = DetailViewModel()
    RBS_CC_39_reportLine("36", 1)
    m.watchLaterModel = WatchLaterModel()
end sub

sub setupAutoPlay()
    RBS_CC_39_reportLine("40", 1)
    m.autoPlayTimer = CreateObject("roSGNode", "Timer")
    RBS_CC_39_reportLine("41", 1)
    m.autoPlayTimer.duration = 0
    RBS_CC_39_reportLine("42", 1)
    m.autoPlayTimer.repeat = false
    RBS_CC_39_reportLine("43", 1)
    m.autoPlayTimer.observeField("fire", "onAutoPlayTimer")
end sub

sub onContentChanged()
    RBS_CC_39_reportLine("47", 1)
    m.json = translate()
    RBS_CC_39_reportLine("48", 1)
    m.watchNow.text = m.json["buttons"]["watch_now"][m.global.currentLang]
    RBS_CC_39_reportLine("49", 1)
    content = m.top.itemContent
    if RBS_CC_39_reportLine("50", 2) and (not isValid(content)) then
        RBS_CC_39_reportLine("50", 3)
        RBS_CC_39_reportLine("50", 1)
        return
    end if
    RBS_CC_39_reportLine("52", 1)
    m.viewModel.setContent(content, m.global.watchLaterList)
    RBS_CC_39_reportLine("53", 1)
    updateUI()
    if RBS_CC_39_reportLine("54", 2) and (content.DoesExist("mediaType"))
        RBS_CC_39_reportLine("54", 3)
        if RBS_CC_39_reportLine("55", 2) and (content.mediaType = "movies")
            RBS_CC_39_reportLine("55", 3)
            RBS_CC_39_reportLine("56", 1)
            m.autoPlayTimer.control = "start"
        end if
    end if
end sub

' =========================================
' UPDATE UI
' =========================================
sub updateUI()
    RBS_CC_39_reportLine("69", 1)
    content = m.viewModel.content
    if RBS_CC_39_reportLine("70", 2) and (isValid(content.HDPosterUrl))
        RBS_CC_39_reportLine("70", 3)
        RBS_CC_39_reportLine("71", 1)
        m.poster.uri = content.HDPosterUrl
        RBS_CC_39_reportLine("72", 1)
        m.bgPoster.uri = content.HDPosterUrl
    end if
    RBS_CC_39_reportLine("75", 1)
    m.title.text = content.ShortDescriptionLine1
    RBS_CC_39_reportLine("76", 1)
    m.desc.text = content.ShortDescriptionLine2
    if RBS_CC_39_reportLine("78", 2) and (m.viewModel.isInWatchLater)
        RBS_CC_39_reportLine("78", 3)
        RBS_CC_39_reportLine("79", 1)
        m.watchLaterIcon.opacity = 1.0
    else
        RBS_CC_39_reportLine("80", 3)
        RBS_CC_39_reportLine("81", 1)
        m.watchLaterIcon.opacity = 0.5
    end if
end sub

sub onPlayButtonSelected()
    RBS_CC_39_reportLine("86", 1)
    m.top.events = m.viewModel.getNavigationPayload()
end sub

sub onAutoPlayTimer()
    RBS_CC_39_reportLine("90", 1)
    m.top.events = m.viewModel.getNavigationPayload()
end sub

sub watchLater()
    RBS_CC_39_reportLine("95", 1)
    content = m.top.itemContent
    if RBS_CC_39_reportLine("96", 2) and (not isValid(content)) then
        RBS_CC_39_reportLine("96", 3)
        RBS_CC_39_reportLine("96", 1)
        return
    end if
    RBS_CC_39_reportLine("98", 1)
    result = m.watchLaterModel.toggleWatchLater(content, m.global.watchLaterList)
    RBS_CC_39_reportLine("99", 1)
    m.global.watchLaterList = result.updatedList
    if RBS_CC_39_reportLine("101", 2) and (result.added)
        RBS_CC_39_reportLine("101", 3)
        RBS_CC_39_reportLine("102", 1)
        m.watchLaterIcon.opacity = 1.0
        RBS_CC_39_reportLine("103", 1)
        speak("Added to watch later")
        RBS_CC_39_reportLine("104", 1)
        m.global.toast = {
            message: m.json["messages"]["watchlater_added"][m.global.currentLang]
            duration: 2
        }
        ' m.global.toast = {
        '     message: m.json.messages.watchlater_added[m.global.currentLang]
        '     duration: 2
        ' }
    else
        RBS_CC_39_reportLine("112", 3)
        RBS_CC_39_reportLine("113", 1)
        m.watchLaterIcon.opacity = 0.5
        RBS_CC_39_reportLine("114", 1)
        speak("Removed from watch later")
        RBS_CC_39_reportLine("115", 1)
        m.global.toast = {
            message: m.json["messages"]["watchlater_removed"][m.global.currentLang]
            duration: 2
        }
        ' m.global.toast = {
        '     message: m.json.messages.watchlater_removed[m.global.currentLang]
        '     duration: 2
        ' }
    end if
end sub

sub onFocusRequest()
    if RBS_CC_39_reportLine("127", 2) and (m.watchLaterFocused)
        RBS_CC_39_reportLine("127", 3)
        RBS_CC_39_reportLine("128", 1)
        m.watchLaterGroup.setFocus(true)
    else
        RBS_CC_39_reportLine("129", 3)
        RBS_CC_39_reportLine("130", 1)
        m.playBtn.setFocus(true)
    end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    if RBS_CC_39_reportLine("135", 2) and (not press) then
        RBS_CC_39_reportLine("135", 3)
        RBS_CC_39_reportLine("135", 1)
        return false
    end if
    if RBS_CC_39_reportLine("137", 2) and (key = "right")
        RBS_CC_39_reportLine("137", 3)
        if RBS_CC_39_reportLine("138", 2) and (not m.watchLaterFocused)
            RBS_CC_39_reportLine("138", 3)
            RBS_CC_39_reportLine("139", 1)
            m.watchLaterFocused = true
            RBS_CC_39_reportLine("140", 1)
            m.playBtn.setFocus(false)
            RBS_CC_39_reportLine("141", 1)
            m.watchLaterGroup.setFocus(true)
            RBS_CC_39_reportLine("142", 1)
            m.watchLaterBg.color = "#988f8fff"
        end if
        RBS_CC_39_reportLine("144", 1)
        return true
    end if
    if RBS_CC_39_reportLine("147", 2) and (key = "left")
        RBS_CC_39_reportLine("147", 3)
        if RBS_CC_39_reportLine("148", 2) and (m.watchLaterFocused)
            RBS_CC_39_reportLine("148", 3)
            RBS_CC_39_reportLine("149", 1)
            m.watchLaterFocused = false
            RBS_CC_39_reportLine("150", 1)
            m.playBtn.setFocus(true)
            RBS_CC_39_reportLine("151", 1)
            m.watchLaterBg.color = "0x00000000"
        end if
        RBS_CC_39_reportLine("153", 1)
        return true
    end if
    if RBS_CC_39_reportLine("156", 2) and (key = "OK")
        RBS_CC_39_reportLine("156", 3)
        if RBS_CC_39_reportLine("157", 2) and (m.watchLaterFocused)
            RBS_CC_39_reportLine("157", 3)
            RBS_CC_39_reportLine("158", 1)
            watchLater()
        else
            RBS_CC_39_reportLine("159", 3)
            RBS_CC_39_reportLine("160", 1)
            onPlayButtonSelected()
        end if
        RBS_CC_39_reportLine("162", 1)
        return true
    end if
    if RBS_CC_39_reportLine("165", 2) and (key = "back")
        RBS_CC_39_reportLine("165", 3)
        RBS_CC_39_reportLine("166", 1)
        m.top.events = {
            type: "backPress"
        }
        RBS_CC_39_reportLine("169", 1)
        return true
    end if
    RBS_CC_39_reportLine("171", 1)
    return false
end function

function RBS_CC_39_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "39"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "39"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./DetailScreen.brs.map