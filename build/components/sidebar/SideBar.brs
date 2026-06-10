sub init()
    RBS_CC_46_reportLine("1", 1)
    deviceInfo = CreateObject("roDeviceInfo")
    RBS_CC_46_reportLine("2", 1)
    locale = deviceInfo.GetCurrentLocale()
    RBS_CC_46_reportLine("3", 1)
    langParts = locale.Tokenize("_")
    RBS_CC_46_reportLine("4", 1)
    detectedLang = "en"
    if RBS_CC_46_reportLine("5", 2) and (langParts.Count() > 0)
        RBS_CC_46_reportLine("5", 3)
        RBS_CC_46_reportLine("6", 1)
        detectedLang = LCase(langParts[0])
    end if
    if RBS_CC_46_reportLine("9", 2) and (detectedLang <> "en" and detectedLang <> "pt" and detectedLang <> "fr" and detectedLang <> "es")
        RBS_CC_46_reportLine("9", 3)
        RBS_CC_46_reportLine("10", 1)
        detectedLang = "en"
    end if
    RBS_CC_46_reportLine("12", 1)
    m.selectedlang = detectedLang
    RBS_CC_46_reportLine("14", 1)
    m.menu = m.top.findNode("menu")
    RBS_CC_46_reportLine("15", 1)
    m.gradientBg = m.top.findNode("gradientBg")
    RBS_CC_46_reportLine("16", 1)
    m.bg = m.top.findNode("bg")
    RBS_CC_46_reportLine("17", 1)
    m.sidebarAnim = m.top.findNode("sidebarAnim")
    RBS_CC_46_reportLine("18", 1)
    m.widthInterp = m.top.findNode("widthInterp")
    RBS_CC_46_reportLine("19", 1)
    m.gradientInterp = m.top.findNode("gradientInterp")
    RBS_CC_46_reportLine("21", 1)
    m.activepage = 0
    RBS_CC_46_reportLine("22", 1)
    buildGradiant()
    RBS_CC_46_reportLine("23", 1)
    setupMenu()
    RBS_CC_46_reportLine("24", 1)
    m.menu.observeField("itemSelected", "onItemSelected")
    RBS_CC_46_reportLine("25", 1)
    m.menu.observeField("itemFocused", "onItemFocused")
    RBS_CC_46_reportLine("26", 1)
    m.activepage = 0
end sub

sub animateSlide(targetWidth as float)
    RBS_CC_46_reportLine("31", 1)
    m.widthInterp.keyValue = [
        m.bg.width
        targetWidth
    ]
    RBS_CC_46_reportLine("32", 1)
    m.widthAnim.control = "start"
end sub

sub onItemFocused()
    RBS_CC_46_reportLine("36", 1)
    speakFocused(m.menu)
end sub

sub buildGradiant()
    RBS_CC_46_reportLine("40", 1)
    gardientBg = m.gradientBg
    RBS_CC_46_reportLine("41", 1)
    numStrips = 370
    RBS_CC_46_reportLine("42", 1)
    totalWidth = 370
    RBS_CC_46_reportLine("43", 1)
    totalHeight = 720
    RBS_CC_46_reportLine("45", 1)
    r = 0
    RBS_CC_46_reportLine("45", 1)
    g = 0
    RBS_CC_46_reportLine("45", 1)
    b = 0
    RBS_CC_46_reportLine("47", 1)
    stripWidth = totalWidth / numStrips
    RBS_CC_46_reportLine("49", 1): for i = 0 to numStrips - 1
        RBS_CC_46_reportLine("50", 1)
        t = i / numStrips
        ' smoother alpha falloff
        RBS_CC_46_reportLine("53", 1)
        alpha = int(255 * (1 - t) * 0.9)
        RBS_CC_46_reportLine("55", 1)
        strip = CreateObject("roSGNode", "Rectangle")
        RBS_CC_46_reportLine("56", 1)
        strip.width = stripWidth + 1
        RBS_CC_46_reportLine("57", 1)
        strip.height = totalHeight
        RBS_CC_46_reportLine("58", 1)
        strip.translation = [
            i * stripWidth
            0
        ]
        RBS_CC_46_reportLine("59", 1)
        strip.color = rgbaToHex(r, g, b, alpha)
        RBS_CC_46_reportLine("60", 1)
        gardientBg.appendChild(strip)
    end for
end sub

function rgbaToHex(r as integer, g as integer, b as integer, a as integer) as string
    RBS_CC_46_reportLine("65", 1)
    return "0x" + toHex2(r) + toHex2(g) + toHex2(b) + toHex2(a)
end function

function toHex2(n as integer) as string
    RBS_CC_46_reportLine("69", 1)
    digits = "0123456789ABCDEF"
    RBS_CC_46_reportLine("70", 1)
    hi = int(n / 16)
    RBS_CC_46_reportLine("71", 1)
    lo = n mod 16
    RBS_CC_46_reportLine("72", 1)
    return mid(digits, hi + 1, 1) + mid(digits, lo + 1, 1)
end function

sub setupMenu()
    RBS_CC_46_reportLine("76", 1)
    content = CreateObject("roSGNode", "ContentNode")
    RBS_CC_46_reportLine("77", 1)
    m.json = translate()
    RBS_CC_46_reportLine("78", 1)
    items = [
        {
            label: m.json["sidebar"]["home"][m.selectedlang]
            icon: "pkg:/images/homef.png"
        }
        {
            label: m.json["sidebar"]["search"][m.selectedlang]
            icon: "pkg:/images/searchf.png"
        }
        {
            label: m.json["sidebar"]["movies"][m.selectedlang]
            icon: "pkg:/images/movief.png"
        }
        {
            label: m.json["sidebar"]["series"][m.selectedlang]
            icon: "pkg:/images/seriesf.png"
        }
        {
            label: m.json["sidebar"]["watch_later"][m.selectedlang]
            icon: "pkg:/images/watch_later.png"
        }
        {
            label: m.json["sidebar"]["settings"][m.selectedlang]
            icon: "pkg:/images/settingsf.png"
        }
    ]
    RBS_CC_46_reportLine("87", 1): for each item in items
        RBS_CC_46_reportLine("88", 1)
        node = CreateObject("roSGNode", "ContentNode")
        RBS_CC_46_reportLine("89", 1)
        node.addField("label", "string", false)
        RBS_CC_46_reportLine("90", 1)
        node.addField("icon", "string", false)
        RBS_CC_46_reportLine("91", 1)
        node.addField("fullLabel", "string", false)
        RBS_CC_46_reportLine("92", 1)
        node.label = item.label
        RBS_CC_46_reportLine("93", 1)
        node.icon = item.icon
        RBS_CC_46_reportLine("94", 1)
        node.fullLabel = item.label
        RBS_CC_46_reportLine("95", 1)
        content.appendChild(node)
    end for
    RBS_CC_46_reportLine("97", 1)
    m.menu.content = content
end sub

sub onItemSelected()
    RBS_CC_46_reportLine("101", 1)
    m.top.selectedIndex = m.menu.itemSelected
    ' stop
    RBS_CC_46_reportLine("103", 1)
    speakSelected(m.menu)
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if RBS_CC_46_reportLine("107", 2) and (not press) then
        RBS_CC_46_reportLine("107", 3)
        RBS_CC_46_reportLine("107", 1)
        return false
    end if
    if RBS_CC_46_reportLine("109", 2) and (key = "OK")
        RBS_CC_46_reportLine("109", 3)
        RBS_CC_46_reportLine("110", 1)
        selectedIndex = m.menu.itemSelected
        RBS_CC_46_reportLine("111", 1)
        m.menu.itemSelected = selectedIndex
        RBS_CC_46_reportLine("112", 1)
        m.activepage = selectedIndex
        RBS_CC_46_reportLine("113", 1)
        m.top.collapsed = true
        RBS_CC_46_reportLine("114", 1)
        return true
    end if
    RBS_CC_46_reportLine("116", 1)
    return false
end function

sub onCollapsedChanged()
    if RBS_CC_46_reportLine("120", 2) and (m.top.collapsed) then
        RBS_CC_46_reportLine("120", 3)
        RBS_CC_46_reportLine("121", 1)
        collapseSidebar()
    else
        RBS_CC_46_reportLine("122", 3)
        RBS_CC_46_reportLine("123", 1)
        expandSidebar()
        RBS_CC_46_reportLine("124", 1)
        m.menu.setFocus(true)
    end if
end sub

sub collapseSidebar()
    RBS_CC_46_reportLine("129", 1)
    m.top.isOpen = false
    RBS_CC_46_reportLine("130", 1)
    setLabels(false)
    RBS_CC_46_reportLine("131", 1)
    m.widthInterp.keyValue = [
        m.bg.width
        50.0
    ]
    RBS_CC_46_reportLine("132", 1)
    m.gradientInterp.keyValue = [
        m.gradientBg.opacity
        0.0
    ]
    RBS_CC_46_reportLine("133", 1)
    m.sidebarAnim.control = "start"
    RBS_CC_46_reportLine("134", 1)
    m.top.findNode("menu").jumpToItem = m.activepage
end sub

sub expandSidebar()
    RBS_CC_46_reportLine("138", 1)
    m.top.isOpen = true
    RBS_CC_46_reportLine("139", 1)
    setLabels(true)
    RBS_CC_46_reportLine("140", 1)
    m.widthInterp.keyValue = [
        m.bg.width
        370.0
    ]
    RBS_CC_46_reportLine("141", 1)
    m.gradientInterp.keyValue = [
        m.gradientBg.opacity
        1.0
    ]
    RBS_CC_46_reportLine("142", 1)
    m.sidebarAnim.control = "start"
    RBS_CC_46_reportLine("143", 1)
    m.menu.setFocus(true)
end sub

sub setLabels(show as boolean)
    RBS_CC_46_reportLine("147", 1)
    content = m.menu.content
    if RBS_CC_46_reportLine("148", 2) and (content = invalid) then
        RBS_CC_46_reportLine("148", 3)
        RBS_CC_46_reportLine("148", 1)
        return
    end if
    RBS_CC_46_reportLine("149", 1): for i = 0 to content.getChildCount() - 1
        RBS_CC_46_reportLine("150", 1)
        item = content.getChild(i)
        if RBS_CC_46_reportLine("151", 2) and (show)
            RBS_CC_46_reportLine("151", 3)
            RBS_CC_46_reportLine("152", 1)
            item.label = item.fullLabel
        else
            RBS_CC_46_reportLine("153", 3)
            RBS_CC_46_reportLine("154", 1)
            item.label = ""
        end if
    end for
end sub

function RBS_CC_46_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "46"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "46"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./SideBar.brs.map