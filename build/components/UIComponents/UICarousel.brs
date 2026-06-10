sub init()
    RBS_CC_9_reportLine("1", 1)
    m.heroPoster = m.top.findNode("heroPoster")
    RBS_CC_9_reportLine("2", 1)
    m.titleLabel = m.top.findNode("titleLabel")
    RBS_CC_9_reportLine("3", 1)
    m.descLabel = m.top.findNode("descLabel")
    RBS_CC_9_reportLine("4", 1)
    m.dotsGroup = m.top.findNode("dotsGroup")
    RBS_CC_9_reportLine("5", 1)
    m.arrowLeft = m.top.findNode("arrowLeft")
    RBS_CC_9_reportLine("6", 1)
    m.arrowRight = m.top.findNode("arrowRight")
    RBS_CC_9_reportLine("7", 1)
    m.autoTimer = m.top.findNode("autoTimer")
    RBS_CC_9_reportLine("8", 1)
    m.fadeAnim = m.top.findNode("fadeAnim")
    RBS_CC_9_reportLine("9", 1)
    m.shimmer = m.top.findNode("shimmer")
    RBS_CC_9_reportLine("10", 1)
    m.shimmerTitle = m.top.findNode("shimmerTitle")
    RBS_CC_9_reportLine("11", 1)
    m.shimmerDesc = m.top.findNode("shimmerDesc")
    RBS_CC_9_reportLine("12", 1)
    m.carouselbutton = m.top.findNode("carouselbutton")
    RBS_CC_9_reportLine("13", 1)
    m.carouselbutton.observeField("buttonSelected", "onWatchPressed")
    RBS_CC_9_reportLine("14", 1)
    m.currentIndex = 0
    RBS_CC_9_reportLine("15", 1)
    m.totalItems = 0
    RBS_CC_9_reportLine("16", 1)
    m.items = []
    RBS_CC_9_reportLine("17", 1)
    m.autoTimer.observeField("fire", "onTimerFire")
end sub

sub onWatchPressed()
    RBS_CC_9_reportLine("21", 1)
    m.autoTimer.control = "stop"
    RBS_CC_9_reportLine("22", 1)
    m.top.itemSelected = -1
    RBS_CC_9_reportLine("23", 1)
    m.top.itemSelected = m.currentIndex
end sub

sub showShimmer()
    RBS_CC_9_reportLine("27", 1)
    m.shimmer.clippingRect = [
        0
        0
        1280
        450
    ]
    RBS_CC_9_reportLine("28", 1)
    m.shimmerTitle.clippingRect = [
        0
        0
        500
        40
    ]
    RBS_CC_9_reportLine("29", 1)
    m.shimmerDesc.clippingRect = [
        0
        0
        700
        28
    ]
    RBS_CC_9_reportLine("31", 1)
    m.shimmer.visible = true
    ' m.shimmerTitle.rectColor="#696969"
    RBS_CC_9_reportLine("33", 1)
    m.shimmerTitle.visible = true
    RBS_CC_9_reportLine("34", 1)
    m.shimmerDesc.visible = true
    ' m.shimmerDesc.rectColor= "#696969"
    RBS_CC_9_reportLine("36", 1)
    m.shimmerTitle.rectColor = "0x696969FF"
    RBS_CC_9_reportLine("37", 1)
    m.shimmerDesc.rectColor = "0x696969FF"
    RBS_CC_9_reportLine("38", 1)
    m.timer = createObject("roSGNode", "Timer")
    RBS_CC_9_reportLine("39", 1)
    m.timer.duration = 1
    RBS_CC_9_reportLine("40", 1)
    m.timer.repeat = false
    RBS_CC_9_reportLine("41", 1)
    m.timer.observeField("fire", "onContentSet")
    RBS_CC_9_reportLine("42", 1)
    m.timer.control = "start"
end sub

sub onContentSet()
    RBS_CC_9_reportLine("46", 1)
    m.json = translate()
    RBS_CC_9_reportLine("47", 1)
    m.carouselbutton.text = m.json["buttons"]["watch_now"][m.global.currentLang]
    RBS_CC_9_reportLine("48", 1)
    m.shimmer.visible = false
    RBS_CC_9_reportLine("49", 1)
    m.shimmerTitle.visible = false
    RBS_CC_9_reportLine("50", 1)
    m.shimmerDesc.visible = false
    RBS_CC_9_reportLine("51", 1)
    m.shimmer.clippingRect = [
        0
        0
        0
        0
    ]
    RBS_CC_9_reportLine("52", 1)
    m.timer = invalid
    RBS_CC_9_reportLine("53", 1)
    content = m.top.content
    if RBS_CC_9_reportLine("54", 2) and (content = invalid) then
        RBS_CC_9_reportLine("54", 3)
        RBS_CC_9_reportLine("54", 1)
        return
    end if
    RBS_CC_9_reportLine("56", 1)
    m.items = []
    RBS_CC_9_reportLine("57", 1)
    m.totalItems = content.getChildCount()
    RBS_CC_9_reportLine("59", 1): for i = 0 to m.totalItems - 1
        RBS_CC_9_reportLine("60", 1)
        m.items.push(content.getChild(i))
    end for
    RBS_CC_9_reportLine("62", 1)
    m.currentIndex = 0
    RBS_CC_9_reportLine("63", 1)
    buildDots()
    RBS_CC_9_reportLine("64", 1)
    showSlide(m.currentIndex)
    RBS_CC_9_reportLine("65", 1)
    m.shimmer.callFunc("stopAnim")
    RBS_CC_9_reportLine("66", 1)
    m.shimmerTitle.callFunc("stopAnim")
    RBS_CC_9_reportLine("67", 1)
    m.shimmerDesc.callFunc("stopAnim")
    RBS_CC_9_reportLine("68", 1)
    m.autoTimer.control = "start"
end sub

sub showSlide(index as integer)
    if RBS_CC_9_reportLine("72", 2) and (m.totalItems = 0) then
        RBS_CC_9_reportLine("72", 3)
        RBS_CC_9_reportLine("72", 1)
        return
    end if
    RBS_CC_9_reportLine("74", 1)
    item = m.items[index]
    if RBS_CC_9_reportLine("75", 2) and (item = invalid) then
        RBS_CC_9_reportLine("75", 3)
        RBS_CC_9_reportLine("75", 1)
        return
    end if
    ' Fade out then swap
    RBS_CC_9_reportLine("78", 1)
    m.fadeAnim.control = "stop"
    RBS_CC_9_reportLine("79", 1)
    m.heroPoster.opacity = 0
    RBS_CC_9_reportLine("80", 1)
    m.heroPoster.uri = item.HDPosterUrl
    RBS_CC_9_reportLine("81", 1)
    m.titleLabel.text = item.ShortDescriptionLine1
    RBS_CC_9_reportLine("82", 1)
    m.descLabel.text = item.ShortDescriptionLine2
    ' Fade in
    RBS_CC_9_reportLine("85", 1)
    m.fadeAnim.control = "start"
    RBS_CC_9_reportLine("87", 1)
    updateDots()
    RBS_CC_9_reportLine("88", 1)
    m.top.focusedIndex = index
end sub

sub onTimerFire()
    RBS_CC_9_reportLine("92", 1)
    advanceSlide(1)
end sub

sub advanceSlide(direction as integer)
    RBS_CC_9_reportLine("96", 1)
    m.currentIndex = m.currentIndex + direction
    if RBS_CC_9_reportLine("97", 2) and (m.currentIndex < 0) then
        RBS_CC_9_reportLine("97", 3)
        RBS_CC_9_reportLine("97", 1)
        m.currentIndex = m.totalItems - 1
    end if
    if RBS_CC_9_reportLine("98", 2) and (m.currentIndex >= m.totalItems) then
        RBS_CC_9_reportLine("98", 3)
        RBS_CC_9_reportLine("98", 1)
        m.currentIndex = 0
    end if
    RBS_CC_9_reportLine("99", 1)
    showSlide(m.currentIndex)
end sub

sub buildDots()
    ' Remove old dots
    RBS_CC_9_reportLine("104", 1): while m.dotsGroup.getChildCount() > 0
        RBS_CC_9_reportLine("105", 1)
        m.dotsGroup.removeChildIndex(0)
    end while
    RBS_CC_9_reportLine("108", 1)
    dotSize = 10
    RBS_CC_9_reportLine("109", 1)
    dotSpacing = 18
    RBS_CC_9_reportLine("111", 1): for i = 0 to m.totalItems - 1
        RBS_CC_9_reportLine("112", 1)
        dot = createObject("roSGNode", "Rectangle")
        RBS_CC_9_reportLine("113", 1)
        dot.width = dotSize
        RBS_CC_9_reportLine("114", 1)
        dot.height = dotSize
        RBS_CC_9_reportLine("115", 1)
        dot.translation = [
            i * dotSpacing
            0
        ]
        RBS_CC_9_reportLine("116", 1)
        dot.color = "0x888888FF"
        RBS_CC_9_reportLine("117", 1)
        m.dotsGroup.appendChild(dot)
    end for
end sub

sub updateDots()
    RBS_CC_9_reportLine("122", 1): for i = 0 to m.dotsGroup.getChildCount() - 1
        RBS_CC_9_reportLine("123", 1)
        dot = m.dotsGroup.getChild(i)
        if RBS_CC_9_reportLine("124", 2) and (i = m.currentIndex)
            RBS_CC_9_reportLine("124", 3)
            RBS_CC_9_reportLine("125", 1)
            dot.color = "0xFFFFFFFF"
        else
            RBS_CC_9_reportLine("126", 3)
            RBS_CC_9_reportLine("127", 1)
            dot.color = "0x888888FF"
        end if
    end for
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if RBS_CC_9_reportLine("133", 2) and (not press) then
        RBS_CC_9_reportLine("133", 3)
        RBS_CC_9_reportLine("133", 1)
        return false
    end if
    if RBS_CC_9_reportLine("135", 2) and (key = "left")
        RBS_CC_9_reportLine("135", 3)
        if RBS_CC_9_reportLine("136", 2) and (m.currentIndex = 0)
            RBS_CC_9_reportLine("136", 3)
            RBS_CC_9_reportLine("137", 1)
            return false
        else
            RBS_CC_9_reportLine("138", 3)
            RBS_CC_9_reportLine("139", 1)
            m.autoTimer.control = "stop"
            RBS_CC_9_reportLine("140", 1)
            advanceSlide(-1)
            RBS_CC_9_reportLine("141", 1)
            m.autoTimer.control = "start"
            ' showArrow("left")
            RBS_CC_9_reportLine("143", 1)
            return true
        end if
    else if RBS_CC_9_reportLine("146", 2) and (key = "right")
        RBS_CC_9_reportLine("146", 3)
        RBS_CC_9_reportLine("147", 1)
        m.autoTimer.control = "stop"
        RBS_CC_9_reportLine("148", 1)
        advanceSlide(1)
        RBS_CC_9_reportLine("149", 1)
        m.autoTimer.control = "start"
        ' showArrow("right")
        RBS_CC_9_reportLine("151", 1)
        return true
    else if RBS_CC_9_reportLine("153", 2) and (key = "OK")
        RBS_CC_9_reportLine("153", 3)
        RBS_CC_9_reportLine("154", 1)
        m.autoTimer.control = "stop"
        RBS_CC_9_reportLine("155", 1)
        m.top.itemSelected = -1
        RBS_CC_9_reportLine("156", 1)
        m.top.itemSelected = m.currentIndex
        RBS_CC_9_reportLine("157", 1)
        return true
    else if RBS_CC_9_reportLine("159", 2) and (key = "down")
        RBS_CC_9_reportLine("159", 3)
        RBS_CC_9_reportLine("160", 1)
        m.autoTimer.control = "start"
        RBS_CC_9_reportLine("161", 1)
        return false ' let HomeScreen pass focus to RowList
    end if
    RBS_CC_9_reportLine("164", 1)
    return false
end function

function RBS_CC_9_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "9"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "9"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./UICarousel.brs.map