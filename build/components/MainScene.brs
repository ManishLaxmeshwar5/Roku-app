sub init()
    RBS_CC_1_reportLine("1", 1)
    m.top.backgroundURI = "pkg:/images/background2.jpg"
    RBS_CC_1_reportLine("2", 1)
    m.sideMenu = m.top.findNode("SideBar")
    RBS_CC_1_reportLine("3", 1)
    m.sideMenu.observeField("collapsed", "onCollapsedChanged")
    RBS_CC_1_reportLine("4", 1)
    m.screenManager = createScreenManager()
    RBS_CC_1_reportLine("5", 1)
    m.screenContainer = m.top.findNode("contentGroup")
    RBS_CC_1_reportLine("6", 1)
    m.sideMenu.observeField("selectedIndex", "onSidebarSelected")
    RBS_CC_1_reportLine("7", 1)
    m.sideMenu.observeField("itemFocused", "onSidebarItemFocused")
    RBS_CC_1_reportLine("8", 1)
    m.moviescreen = m.top.findNode("MovieScreen")
    RBS_CC_1_reportLine("9", 1)
    m.sideMenu.observeField("isOpen", "changeFlag")
    RBS_CC_1_reportLine("10", 1)
    m.rowList = m.top.findNode("rowList")
    RBS_CC_1_reportLine("11", 1)
    m.sideMenu.observeField("events", "onHandleScreenEvents")
    RBS_CC_1_reportLine("13", 1)
    deviceInfo = CreateObject("roDeviceInfo")
    RBS_CC_1_reportLine("14", 1)
    locale = deviceInfo.GetCurrentLocale()
    RBS_CC_1_reportLine("15", 1)
    langParts = locale.Tokenize("_")
    RBS_CC_1_reportLine("16", 1)
    detectedLang = "en"
    if RBS_CC_1_reportLine("17", 2) and (langParts.Count() > 0)
        RBS_CC_1_reportLine("17", 3)
        RBS_CC_1_reportLine("18", 1)
        detectedLang = LCase(langParts[0])
    end if
    if RBS_CC_1_reportLine("21", 2) and (detectedLang <> "en" and detectedLang <> "pt" and detectedLang <> "fr" and detectedLang <> "es")
        RBS_CC_1_reportLine("21", 3)
        RBS_CC_1_reportLine("22", 1)
        detectedLang = "en"
    end if
    RBS_CC_1_reportLine("25", 1)
    m.global.addFields({
        watchLaterList: []
        ttsEnabled: true
        currentLang: detectedLang
    })
    RBS_CC_1_reportLine("30", 1)
    displayScreen("HomeScreen")
    RBS_CC_1_reportLine("32", 1)
    m.global.addField("toast", "assocarray", true)
    RBS_CC_1_reportLine("34", 1)
    m.slideAnim = m.top.findNode("slideAnim")
    RBS_CC_1_reportLine("35", 1)
    m.slideInterpolator = m.top.findNode("slideInterpolator")
    RBS_CC_1_reportLine("36", 1)
    m.isOpen = false
    RBS_CC_1_reportLine("37", 1)
    m.topscreen = "HomeScreen"
    RBS_CC_1_reportLine("38", 1)
    m.sideMenu.collapsed = true
    RBS_CC_1_reportLine("39", 1)
    animateTranslation(10)
    RBS_CC_1_reportLine("40", 1)
    m.deepLinkHandled = false
    RBS_CC_1_reportLine("41", 1)
    m.top.observeField("deepLinkData", "onDeepLinkDataChanged")
    RBS_CC_1_reportLine("43", 1)
    m.ttsTask = CreateObject("roSGNode", "TTSTask")
    RBS_CC_1_reportLine("44", 1)
    m.ttsTask.observeField("ttsState", "onTTSStateChanged")
    RBS_CC_1_reportLine("45", 1)
    m.ttsTask.functionName = "runTTS"
    RBS_CC_1_reportLine("46", 1)
    m.ttsTask.control = "RUN"
    RBS_CC_1_reportLine("47", 1)
    m.dialogopen = false
    RBS_CC_1_reportLine("48", 1)
    m.json = translate()
    RBS_CC_1_reportLine("49", 1)
    m.global.toast = {
        message: m.json["messages"]["welcome"][m.global.currentLang]
        duration: 2
    }
end sub

sub onTTSStateChanged()
    RBS_CC_1_reportLine("56", 1)
    print "TTS state: " + m.ttsTask.ttsState
end sub

sub ttsSpeak(text as string)
    if RBS_CC_1_reportLine("60", 2) and (text = invalid or text = "") then
        RBS_CC_1_reportLine("60", 3)
        RBS_CC_1_reportLine("60", 1)
        return
    end if
    if RBS_CC_1_reportLine("61", 2) and (m.global.ttsEnabled = false) then
        RBS_CC_1_reportLine("61", 3)
        RBS_CC_1_reportLine("61", 1)
        return
    end if
    if RBS_CC_1_reportLine("62", 2) and (m.ttsTask = invalid) then
        RBS_CC_1_reportLine("62", 3)
        RBS_CC_1_reportLine("62", 1)
        return
    end if
    RBS_CC_1_reportLine("63", 1)
    m.ttsTask.text = text
end sub

sub onDeepLinkDataChanged()
    if RBS_CC_1_reportLine("67", 2) and (m.deepLinkHandled) then
        RBS_CC_1_reportLine("67", 3)
        RBS_CC_1_reportLine("67", 1)
        return
    end if
    RBS_CC_1_reportLine("68", 1)
    deepLinkData = m.top.deepLinkData
    if RBS_CC_1_reportLine("69", 2) and (deepLinkData = invalid) then
        RBS_CC_1_reportLine("69", 3)
        RBS_CC_1_reportLine("69", 1)
        return
    end if
    if RBS_CC_1_reportLine("70", 2) and (deepLinkData.contentId = invalid) then
        RBS_CC_1_reportLine("70", 3)
        RBS_CC_1_reportLine("70", 1)
        return
    end if
    if RBS_CC_1_reportLine("71", 2) and (deepLinkData.mediaType = invalid) then
        RBS_CC_1_reportLine("71", 3)
        RBS_CC_1_reportLine("71", 1)
        return
    end if
    RBS_CC_1_reportLine("72", 1)
    m.deepLinkHandled = true
    RBS_CC_1_reportLine("74", 1)
    contentId = deepLinkData.contentId
    RBS_CC_1_reportLine("75", 1)
    mediaType = deepLinkData.mediaType
    RBS_CC_1_reportLine("77", 1)
    print "Deep link received in MainScene:"
    RBS_CC_1_reportLine("78", 1)
    print "   contentId: "; contentId
    RBS_CC_1_reportLine("79", 1)
    print "   mediaType: "; mediaType
    RBS_CC_1_reportLine("81", 1)
    clearScreen()
    RBS_CC_1_reportLine("83", 1)
    displayScreen("MovieScreen", {
        contentType: mediaType
    })
    '  Now pass deep link separately
    RBS_CC_1_reportLine("86", 1)
    movieScreen = m.screenManager.getTopScreen()
    if RBS_CC_1_reportLine("88", 2) and (movieScreen <> invalid)
        RBS_CC_1_reportLine("88", 3)
        RBS_CC_1_reportLine("89", 1)
        movieScreen.deepLinkPayload = {
            contentType: mediaType
            deepLinkId: contentId
        }
    end if
end sub

sub animateTranslation(targetX as integer)
    if RBS_CC_1_reportLine("99", 2) and (m.slideAnim = invalid or m.slideInterpolator = invalid) then
        RBS_CC_1_reportLine("99", 3)
        RBS_CC_1_reportLine("99", 1)
        return
    end if
    RBS_CC_1_reportLine("100", 1)
    current = m.screenContainer.translation
    RBS_CC_1_reportLine("101", 1)
    m.slideInterpolator.keyValue = [
        current
        [
            targetX
            0
        ]
    ]
    RBS_CC_1_reportLine("105", 1)
    m.slideAnim.control = "start"
end sub

sub clearScreen()
    RBS_CC_1_reportLine("109", 1): while m.screenContainer.getChildCount() > 0
        RBS_CC_1_reportLine("111", 1)
        m.screenContainer.removeChildIndex(0)
        RBS_CC_1_reportLine("112", 1)
        m.screenManager.popScreen()
    end while
end sub

sub showExitDialog()
    RBS_CC_1_reportLine("117", 1)
    ttsSpeak("Exit App. Are you sure you want to exit? Press Yes or No.")
    RBS_CC_1_reportLine("118", 1)
    m.dialog = createObject("roSGNode", "Dialog")
    RBS_CC_1_reportLine("119", 1)
    m.dialog.title = "Exit App"
    RBS_CC_1_reportLine("120", 1)
    m.dialog.message = "Are you sure you want to exit?"
    RBS_CC_1_reportLine("121", 1)
    m.dialog.buttons = [
        "Yes"
        "No"
    ]
    RBS_CC_1_reportLine("122", 1)
    m.dialog.observeField("buttonSelected", "onExitDialogSelected")
    RBS_CC_1_reportLine("123", 1)
    m.dialogopen = true
    RBS_CC_1_reportLine("124", 1)
    m.dialog.muteAudioGuide = "true"
    RBS_CC_1_reportLine("126", 1)
    m.top.appendChild(m.dialog)
    RBS_CC_1_reportLine("127", 1)
    m.dialog.observeField("wasClosed", "closeDialog")
    RBS_CC_1_reportLine("128", 1)
    m.dialog.setFocus(true)
end sub

sub onExitDialogSelected(event as object)
    RBS_CC_1_reportLine("132", 1)
    index = event.getData()
    if RBS_CC_1_reportLine("135", 2) and (index = 0) then
        RBS_CC_1_reportLine("135", 3)
        RBS_CC_1_reportLine("136", 1)
        m.top.exitApp = true
    else if RBS_CC_1_reportLine("138", 2) and (index = 1) then
        RBS_CC_1_reportLine("138", 3)
        RBS_CC_1_reportLine("139", 1)
        ttsSpeak("Cancelled")
        RBS_CC_1_reportLine("140", 1)
        m.top.removeChild(m.dialog)
        RBS_CC_1_reportLine("141", 1)
        m.dialog = invalid
        RBS_CC_1_reportLine("142", 1)
        m.sideMenu.setFocus(true)
        RBS_CC_1_reportLine("143", 1)
        m.sideMenu.findNode("menu").setFocus(true)
        RBS_CC_1_reportLine("144", 1)
        m.dialogopen = false
    else
        RBS_CC_1_reportLine("145", 3)
        RBS_CC_1_reportLine("146", 1)
        m.dialogopen = false
        RBS_CC_1_reportLine("147", 1)
        m.sideMenu.setFocus(true)
        RBS_CC_1_reportLine("148", 1)
        m.sideMenu.findNode("menu").setFocus(true)
    end if
end sub

sub onSidebarSelected()
    RBS_CC_1_reportLine("153", 1)
    index = m.sideMenu.selectedIndex
    if RBS_CC_1_reportLine("155", 2) and (index = 0)
        RBS_CC_1_reportLine("155", 3)
        RBS_CC_1_reportLine("156", 1)
        clearScreen()
        RBS_CC_1_reportLine("157", 1)
        displayScreen("HomeScreen")
        RBS_CC_1_reportLine("158", 1)
        m.sideMenu.collapsed = true
    else if RBS_CC_1_reportLine("160", 2) and (index = 1)
        RBS_CC_1_reportLine("160", 3)
        RBS_CC_1_reportLine("161", 1)
        clearScreen()
        RBS_CC_1_reportLine("162", 1)
        displayScreen("SearchScreen")
    else if RBS_CC_1_reportLine("164", 2) and (index = 2)
        RBS_CC_1_reportLine("164", 3)
        RBS_CC_1_reportLine("165", 1)
        clearScreen()
        RBS_CC_1_reportLine("166", 1)
        displayScreen("MovieScreen", {
            contentType: "movies"
        })
    else if RBS_CC_1_reportLine("168", 2) and (index = 3)
        RBS_CC_1_reportLine("168", 3)
        RBS_CC_1_reportLine("169", 1)
        clearScreen()
        RBS_CC_1_reportLine("170", 1)
        displayScreen("MovieScreen", {
            contentType: "series"
        })
    else if RBS_CC_1_reportLine("172", 2) and (index = 5)
        RBS_CC_1_reportLine("172", 3)
        RBS_CC_1_reportLine("173", 1)
        clearScreen()
        RBS_CC_1_reportLine("174", 1)
        displayScreen("SettingsScreen")
    else if RBS_CC_1_reportLine("176", 2) and (index = 4)
        RBS_CC_1_reportLine("176", 3)
        RBS_CC_1_reportLine("177", 1)
        clearScreen()
        RBS_CC_1_reportLine("178", 1)
        displayScreen("WatchlaterScreen")
    end if
end sub

sub onMovieRequestSidebarFocus()
    RBS_CC_1_reportLine("184", 1)
    m.sideMenu.visible = true
    RBS_CC_1_reportLine("185", 1)
    m.sideMenu.setFocus(true)
    ' animateTranslation(150)
end sub

' -----screen Management codes
sub displayScreen(screenName as string, payload = invalid)
    RBS_CC_1_reportLine("194", 1)
    screen = CreateObject("roSGNode", screenName)
    RBS_CC_1_reportLine("195", 1)
    m.topscreen = screenName
    RBS_CC_1_reportLine("196", 1)
    screen.observeField("events", "onHandleScreenEvents")
    if RBS_CC_1_reportLine("198", 2) and (screenName = "HomeScreen")
        RBS_CC_1_reportLine("198", 3)
        RBS_CC_1_reportLine("199", 1)
        m.homeScreen = screen
    end if
    if RBS_CC_1_reportLine("201", 2) and (payload <> invalid)
        RBS_CC_1_reportLine("201", 3)
        if RBS_CC_1_reportLine("202", 2) and (screenName = "HomeScreen")
            RBS_CC_1_reportLine("202", 3)
            RBS_CC_1_reportLine("203", 1)
            m.homeScreen = screen
            RBS_CC_1_reportLine("204", 1)
            m.screen.findNode("carouselbutton").setFocus(true)
        else if RBS_CC_1_reportLine("207", 2) and (screenName = "DetailScreen" or screenName = "VideoPlayer")
            RBS_CC_1_reportLine("207", 3)
            RBS_CC_1_reportLine("208", 1)
            m.sideMenu.visible = false
            RBS_CC_1_reportLine("209", 1)
            animateTranslation(0)
            if RBS_CC_1_reportLine("210", 2) and (screenName = "DetailScreen")
                RBS_CC_1_reportLine("210", 3)
                RBS_CC_1_reportLine("211", 1)
                screen.itemContent = payload
            else
                RBS_CC_1_reportLine("213", 3)
                RBS_CC_1_reportLine("214", 1)
                screen.videoContent = payload
            end if
        else
            RBS_CC_1_reportLine("216", 3)
            RBS_CC_1_reportLine("217", 1)
            screen.screenData = payload
        end if
    end if
    RBS_CC_1_reportLine("220", 1)
    screen.visible = true
    RBS_CC_1_reportLine("222", 1)
    m.screenManager.pushScreen(screen)
    RBS_CC_1_reportLine("223", 1)
    m.screenContainer.appendChild(screen)
    ' stop
    if RBS_CC_1_reportLine("225", 2) and (screen.subtype() <> "VideoPlayer")
        RBS_CC_1_reportLine("225", 3)
        if RBS_CC_1_reportLine("226", 2) and (screen.subtype() = "HomeScreen")
            RBS_CC_1_reportLine("226", 3)
            ' Let HomeScreen manage its own initial focus via carousel
            RBS_CC_1_reportLine("228", 1)
            carouselBtn = screen.findNode("carouselbutton")
            if RBS_CC_1_reportLine("229", 2) and (carouselBtn <> invalid)
                RBS_CC_1_reportLine("229", 3)
                RBS_CC_1_reportLine("230", 1)
                carouselBtn.setFocus(true)
            end if
        else
            RBS_CC_1_reportLine("232", 3)
            RBS_CC_1_reportLine("233", 1)
            row = screen.findNode("rowList")
            if RBS_CC_1_reportLine("234", 2) and (row <> invalid)
                RBS_CC_1_reportLine("234", 3)
                RBS_CC_1_reportLine("235", 1)
                row.setFocus(true)
            end if
        end if
    else
        RBS_CC_1_reportLine("239", 3)
        RBS_CC_1_reportLine("240", 1)
        screen.requestFocus = true
    end if
end sub

sub onHandleScreenEvents(msg as object)
    if RBS_CC_1_reportLine("246", 2) and (msg = invalid) then
        RBS_CC_1_reportLine("246", 3)
        RBS_CC_1_reportLine("247", 1)
        return
    end if
    RBS_CC_1_reportLine("250", 1)
    event = msg.getData()
    if RBS_CC_1_reportLine("252", 2) and (event = invalid) then
        RBS_CC_1_reportLine("252", 3)
        RBS_CC_1_reportLine("253", 1)
        return
    end if
    if RBS_CC_1_reportLine("256", 2) and (event.type = "navigate")
        RBS_CC_1_reportLine("256", 3)
        RBS_CC_1_reportLine("257", 1)
        displayScreen(event.screen, event.payload)
    else if RBS_CC_1_reportLine("259", 2) and (event.type = "backPress")
        RBS_CC_1_reportLine("259", 3)
        RBS_CC_1_reportLine("260", 1)
        ttsSpeak("Going back")
        RBS_CC_1_reportLine("261", 1)
        handleBack()
    else if RBS_CC_1_reportLine("263", 2) and (event.type = "speak")
        RBS_CC_1_reportLine("263", 3)
        RBS_CC_1_reportLine("264", 1)
        ttsSpeak(event.text)
    else if RBS_CC_1_reportLine("266", 2) and (event.type = "bookmark")
        RBS_CC_1_reportLine("266", 3)
        if RBS_CC_1_reportLine("267", 2) and (event.videoUrl <> invalid and event.bookmarkPosition <> invalid)
            RBS_CC_1_reportLine("267", 3)
            if RBS_CC_1_reportLine("268", 2) and (m.homeScreen <> invalid)
                RBS_CC_1_reportLine("268", 3)
                RBS_CC_1_reportLine("269", 1)
                m.homeScreen.callFunc("loadContinueWatching")
            end if
        end if
    end if
end sub

sub handleBack()
    RBS_CC_1_reportLine("276", 1)
    screen = m.screenManager.popScreen()
    if RBS_CC_1_reportLine("278", 2) and (screen <> invalid)
        RBS_CC_1_reportLine("278", 3)
        if RBS_CC_1_reportLine("279", 2) and (screen.subtype() = "DetailScreen")
            RBS_CC_1_reportLine("279", 3)
            RBS_CC_1_reportLine("281", 1)
            m.screenContainer.getchild(0).visible = true
            RBS_CC_1_reportLine("282", 1)
            m.sideMenu.visible = true
            RBS_CC_1_reportLine("283", 1)
            animateTranslation(10)
        end if
        if RBS_CC_1_reportLine("285", 2) and (screen.subtype() = "VideoPlayer")
            RBS_CC_1_reportLine("285", 3)
            if RBS_CC_1_reportLine("286", 2) and (m.homeScreen <> invalid)
                RBS_CC_1_reportLine("286", 3)
                RBS_CC_1_reportLine("287", 1)
                m.homeScreen.callFunc("loadContinueWatching")
            end if
        end if
        RBS_CC_1_reportLine("291", 1)
        m.screenContainer.removeChild(screen)
    end if
    if RBS_CC_1_reportLine("295", 2) and (m.screenManager.hasScreens())
        RBS_CC_1_reportLine("295", 3)
        RBS_CC_1_reportLine("296", 1)
        topScreen = m.screenContainer.getChild(m.screenContainer.getChildCount() - 1)
        RBS_CC_1_reportLine("297", 1)
        topScreen.setFocus(true)
    else
        RBS_CC_1_reportLine("299", 3)
        RBS_CC_1_reportLine("300", 1)
        m.sideMenu.visible = true
        RBS_CC_1_reportLine("302", 1)
        m.sideMenu.setFocus(true)
    end if
end sub

sub changeFlag(event as object)
    RBS_CC_1_reportLine("308", 1)
    m.isOpen = event.getData()
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if RBS_CC_1_reportLine("314", 2) and (press)
        RBS_CC_1_reportLine("314", 3)
        if RBS_CC_1_reportLine("315", 2) and (key = "right" and m.sideMenu.findNode("menu").hasFocus())
            RBS_CC_1_reportLine("315", 3)
            if RBS_CC_1_reportLine("317", 2) and (m.screenManager.getTopScreen().subtype() = "SettingsScreen")
                RBS_CC_1_reportLine("317", 3)
                RBS_CC_1_reportLine("318", 1)
                m.screenContainer.getchild(0).findNode("settingsMenuList").setFocus(true)
                RBS_CC_1_reportLine("319", 1)
                m.sideMenu.collapsed = true
            else if RBS_CC_1_reportLine("321", 2) and (m.screenManager.getTopScreen().subtype() = "WatchlaterScreen")
                RBS_CC_1_reportLine("321", 3)
                RBS_CC_1_reportLine("322", 1)
                m.screenContainer.getchild(0).findNode("watchLaterGrid").setFocus(true)
                RBS_CC_1_reportLine("323", 1)
                m.sideMenu.collapsed = true
            else if RBS_CC_1_reportLine("325", 2) and (m.screenManager.getTopScreen().subtype() = "HomeScreen")
                RBS_CC_1_reportLine("325", 3)
                RBS_CC_1_reportLine("326", 1)
                m.screenContainer.getchild(0).setFocus(true)
                RBS_CC_1_reportLine("327", 1)
                m.sideMenu.collapsed = true
            else if RBS_CC_1_reportLine("329", 2) and (m.screenManager.getTopScreen().subtype() = "SearchScreen" or m.screenManager.getTopScreen().subtype() = "DetailScreen")
                RBS_CC_1_reportLine("329", 3)
                RBS_CC_1_reportLine("330", 1)
                m.screenContainer.getchild(0).findNode("searchkeyboard").setFocus(true)
                RBS_CC_1_reportLine("331", 1)
                m.sideMenu.collapsed = true
            else
                RBS_CC_1_reportLine("333", 3)
                RBS_CC_1_reportLine("334", 1)
                m.screenContainer.getchild(0).findNode("rowList").setFocus(true)
                RBS_CC_1_reportLine("335", 1)
                m.sideMenu.collapsed = true
                RBS_CC_1_reportLine("336", 1)
                return true
            end if
        end if
        if RBS_CC_1_reportLine("341", 2) and (key = "left")
            RBS_CC_1_reportLine("341", 3)
            RBS_CC_1_reportLine("342", 1)
            ttsSpeak("Menu opened")
            RBS_CC_1_reportLine("343", 1)
            m.sideMenu.findNode("menu").setFocus(true)
            RBS_CC_1_reportLine("344", 1)
            m.sideMenu.setFocus(true)
            RBS_CC_1_reportLine("345", 1)
            m.sideMenu.collapsed = false
            RBS_CC_1_reportLine("346", 1)
            return true
        end if
        if RBS_CC_1_reportLine("349", 2) and (key = "back")
            RBS_CC_1_reportLine("349", 3)
            if RBS_CC_1_reportLine("351", 2) and (m.isOpen = false and m.screenContainer.getChildCount() = 1)
                RBS_CC_1_reportLine("351", 3)
                RBS_CC_1_reportLine("352", 1)
                ttsSpeak("Menu opened")
                RBS_CC_1_reportLine("353", 1)
                m.sideMenu.findNode("menu").setFocus(true)
                RBS_CC_1_reportLine("354", 1)
                m.sideMenu.setFocus(true)
                RBS_CC_1_reportLine("355", 1)
                m.sideMenu.collapsed = false
                RBS_CC_1_reportLine("356", 1)
                return true
            end if
            if RBS_CC_1_reportLine("358", 2) and (m.isOpen = true)
                RBS_CC_1_reportLine("358", 3)
                if RBS_CC_1_reportLine("359", 2) and (m.dialog <> invalid)
                    RBS_CC_1_reportLine("359", 3)
                    RBS_CC_1_reportLine("361", 1)
                    m.top.removeChild(m.dialog)
                    RBS_CC_1_reportLine("362", 1)
                    m.dialog = invalid
                    RBS_CC_1_reportLine("363", 1)
                    m.sideMenu.setFocus(true)
                    RBS_CC_1_reportLine("364", 1)
                    return true
                else
                    RBS_CC_1_reportLine("365", 3)
                    RBS_CC_1_reportLine("366", 1)
                    showExitDialog()
                    RBS_CC_1_reportLine("367", 1)
                    return true
                end if
            end if
        end if
    end if
    RBS_CC_1_reportLine("372", 1)
    return false
end function

function RBS_CC_1_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "1"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "1"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./MainScene.brs.map