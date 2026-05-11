sub init()
    m.menu = m.top.findNode("menu")
    m.gradientBg = m.top.findNode("gradientBg")
    m.bg = m.top.findNode("bg")
    m.sidebarAnim = m.top.findNode("sidebarAnim")
    m.widthInterp = m.top.findNode("widthInterp")
    m.gradientInterp = m.top.findNode("gradientInterp")

    m.activepage = 0
    buildGradiant()
    setupMenu()
    m.menu.observeField("itemSelected", "onItemSelected")
    m.menu.observeField("itemFocused",  "onItemFocused") 
    m.activepage = 0

end sub

sub animateSlide(targetWidth as float)
    m.widthInterp.keyValue = [m.bg.width, targetWidth]
    m.widthAnim.control = "start"
end sub

sub onItemFocused()
    speakFocused(m.menu)  
end sub



sub buildGradiant()
    gardientBg = m.gradientBg
    numStrips = 370
    totalWidth = 370
    totalHeight = 720

    r = 0 : g = 0 : b = 0

    stripWidth = totalWidth / numStrips

    for i = 0 to numStrips - 1
        t = i / numStrips

        ' smoother alpha falloff
        alpha = int(255 * (1 - t) * 0.9)

        strip = CreateObject("roSGNode", "Rectangle")
        strip.width = stripWidth + 1
        strip.height = totalHeight
        strip.translation = [i * stripWidth, 0]
        strip.color = rgbaToHex(r, g, b, alpha)


        gardientBg.appendChild(strip)
    end for
end sub

function rgbaToHex(r as integer, g as integer, b as integer, a as integer) as string
    return "0x" + toHex2(r) + toHex2(g) + toHex2(b) + toHex2(a)
end function

function toHex2(n as integer) as string
    digits = "0123456789ABCDEF"
    hi = int(n / 16)
    lo = n mod 16
    return mid(digits, hi + 1, 1) + mid(digits, lo + 1, 1)
end function




sub setupMenu()
    content = CreateObject("roSGNode", "ContentNode")
    items = [
        { label: "Home", icon: "pkg:/images/homef.png" },
        { label: "Search", icon: "pkg:/images/searchf.png" },
        { label: "Movies", icon: "pkg:/images/movief.png" },
        { label: "Series", icon: "pkg:/images/seriesf.png" },
        { label: "Watch Later", icon: "pkg:/images/watch_later.png" },
        { label: "Settings", icon: "pkg:/images/settingsf.png" }

    ]


    for each item in items
        node = CreateObject("roSGNode", "ContentNode")
        node.addField("label", "string", false)
        node.addField("icon", "string", false)
        node.addField("fullLabel", "string", false)
        node.label = item.label
        node.icon = item.icon
        node.fullLabel = item.label
        content.appendChild(node)
    end for
    m.menu.content = content
end sub



sub onItemSelected()
    m.top.selectedIndex = m.menu.itemSelected
    ' stop
    speakSelected(m.menu)  
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if not press then return false

    if key = "OK"
        selectedIndex = m.menu.itemSelected
        m.menu.itemSelected = selectedIndex
        m.activepage = selectedIndex
        m.top.collapsed = true
        return true
    end if
    return false
end function

sub onCollapsedChanged()
    if m.top.collapsed then
        collapseSidebar()
    else
        expandSidebar()
        m.menu.setFocus(true)
    end if
end sub

sub collapseSidebar()
    m.top.isOpen = false
    setLabels(false)
    m.widthInterp.keyValue = [m.bg.width, 50.0]
    m.gradientInterp.keyValue = [m.gradientBg.opacity, 0.0]
    m.sidebarAnim.control = "start"
    m.top.findNode("menu").jumpToItem = m.activepage
end sub

sub expandSidebar()
    m.top.isOpen = true
    setLabels(true)
    m.widthInterp.keyValue = [m.bg.width, 370.0]
    m.gradientInterp.keyValue = [m.gradientBg.opacity, 1.0]
    m.sidebarAnim.control = "start"
    m.menu.setFocus(true)
end sub

sub setLabels(show as boolean)
    content = m.menu.content
    if content = invalid then return
    for i = 0 to content.getChildCount() - 1
        item = content.getChild(i)
        if show
            item.label = item.fullLabel
        else
            item.label = ""
        end if
    end for
end sub
