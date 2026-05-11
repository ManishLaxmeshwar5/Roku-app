sub init()
    m.heroPoster = m.top.findNode("heroPoster")
    m.titleLabel = m.top.findNode("titleLabel")
    m.descLabel = m.top.findNode("descLabel")
    m.dotsGroup = m.top.findNode("dotsGroup")
    m.arrowLeft = m.top.findNode("arrowLeft")
    m.arrowRight = m.top.findNode("arrowRight")
    m.autoTimer = m.top.findNode("autoTimer")
    m.fadeAnim = m.top.findNode("fadeAnim")
    m.shimmer = m.top.findNode("shimmer") 
    m.shimmerTitle  = m.top.findNode("shimmerTitle") 
    m.shimmerDesc   = m.top.findNode("shimmerDesc") 
    m.carouselbutton = m.top.findNode("carouselbutton")
    m.carouselbutton.observeField("buttonSelected", "onWatchPressed")
    m.currentIndex = 0
    m.totalItems = 0
    m.items = []

    m.autoTimer.observeField("fire", "onTimerFire")
end sub

sub onWatchPressed()
    m.autoTimer.control = "stop"
    m.top.itemSelected = -1
    m.top.itemSelected = m.currentIndex
end sub

sub showShimmer()
    m.shimmer.clippingRect      = [0, 0, 1280, 450]
    m.shimmerTitle.clippingRect = [0, 0, 500, 40]
    m.shimmerDesc.clippingRect  = [0, 0, 700, 28]

    m.shimmer.visible      = true
    m.shimmerTitle.rectColor="#696969"
    m.shimmerTitle.visible = true
    m.shimmerDesc.visible  = true
    m.shimmerDesc.rectColor= "#696969"
    m.timer = createObject("roSGNode", "Timer")
    m.timer.duration = 1
    m.timer.repeat = false
    m.timer.observeField("fire", "onContentSet")
    m.timer.control = "start"
end sub

sub onContentSet()
    m.shimmer.visible = false
    m.shimmerTitle.visible = false
    m.shimmerDesc.visible  = false
    m.shimmer.clippingRect      = [0, 0, 0, 0]
    m.timer = invalid
    content = m.top.content
    if content = invalid then return
    
    m.items = []
    m.totalItems = content.getChildCount()

    for i = 0 to m.totalItems - 1
        m.items.push(content.getChild(i))
    end for
    m.currentIndex = 0
    buildDots()
    showSlide(m.currentIndex)
    m.shimmer.callFunc("stopAnim")
    m.shimmerTitle.callFunc("stopAnim")
    m.shimmerDesc.callFunc("stopAnim")
    m.autoTimer.control = "start"
end sub

sub showSlide(index as integer)
    if m.totalItems = 0 then return

    item = m.items[index]
    if item = invalid then return

    ' Fade out then swap
    m.fadeAnim.control = "stop" 
    m.heroPoster.opacity = 0
    m.heroPoster.uri = item.HDPosterUrl
    m.titleLabel.text = item.ShortDescriptionLine1
    m.descLabel.text = item.ShortDescriptionLine2

    ' Fade in
    m.fadeAnim.control = "start"

    updateDots()
    m.top.focusedIndex = index
end sub

sub onTimerFire()
    advanceSlide(1)
end sub

sub advanceSlide(direction as integer)
    m.currentIndex = m.currentIndex + direction
    if m.currentIndex < 0 then m.currentIndex = m.totalItems - 1
    if m.currentIndex >= m.totalItems then m.currentIndex = 0
    showSlide(m.currentIndex)
end sub

sub buildDots()
    ' Remove old dots
    while m.dotsGroup.getChildCount() > 0
        m.dotsGroup.removeChildIndex(0)
    end while

    dotSize = 10
    dotSpacing = 18

    for i = 0 to m.totalItems - 1
        dot = createObject("roSGNode", "Rectangle")
        dot.width = dotSize
        dot.height = dotSize
        dot.translation = [i * dotSpacing, 0]
        dot.color = "0x888888FF"
        m.dotsGroup.appendChild(dot)
    end for
end sub

sub updateDots()
    for i = 0 to m.dotsGroup.getChildCount() - 1
        dot = m.dotsGroup.getChild(i)
        if i = m.currentIndex
            dot.color = "0xFFFFFFFF"
        else
            dot.color = "0x888888FF"
        end if
    end for
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if not press then return false

    if key = "left"
        if m.currentIndex = 0
            return false
        else
            m.autoTimer.control = "stop"
            advanceSlide(-1)
            m.autoTimer.control = "start"
            ' showArrow("left")
            return true
        end if

    else if key = "right"
        m.autoTimer.control = "stop"
        advanceSlide(1)
        m.autoTimer.control = "start"
        ' showArrow("right")
        return true

    else if key = "OK"
        m.autoTimer.control = "stop"
        m.top.itemSelected = -1
        m.top.itemSelected = m.currentIndex
        return true

    else if key = "down"
        m.autoTimer.control = "start"
        return false ' let HomeScreen pass focus to RowList
    end if

    return false
end function