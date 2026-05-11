sub init()
    m.top.backgroundURI = "pkg:/images/background2.jpg"
    m.sideMenu = m.top.findNode("SideBar")
    m.sideMenu.observeField("collapsed", "onCollapsedChanged")
    m.screenManager = createScreenManager()
    m.screenContainer = m.top.findNode("contentGroup")
    m.sideMenu.observeField("selectedIndex", "onSidebarSelected")
    m.sideMenu.observeField("itemFocused","onSidebarItemFocused")
    m.moviescreen = m.top.findNode("MovieScreen")
    m.sideMenu.observeField("isOpen", "changeFlag")
    m.rowList = m.top.findNode("rowList")
    m.sideMenu.observeField("events", "onHandleScreenEvents")
    m.global.addFields({
        watchLaterList: []
        ttsEnabled: true
    })
    displayScreen("HomeScreen")

    m.global.addField("toast", "assocarray", true)   
 
    m.slideAnim = m.top.findNode("slideAnim")
    m.slideInterpolator = m.top.findNode("slideInterpolator")
    m.isOpen = false
    m.topscreen = "HomeScreen"
    m.sideMenu.collapsed = true
    animateTranslation(10)
    m.deepLinkHandled = false
    m.top.observeField("deepLinkData", "onDeepLinkDataChanged")
    
    m.ttsTask = CreateObject("roSGNode","TTSTask")
    m.ttsTask.observeField("ttsState","onTTSStateChanged")
    m.ttsTask.functionName = "runTTS"
    m.ttsTask.control = "RUN"
    m.dialogopen = false 
end sub

sub onTTSStateChanged()
    print "TTS state: " +m.ttsTask.ttsState
end sub

sub ttsSpeak(text as string)
    if text = invalid or text = "" then return
    if m.global.ttsEnabled = false then return
    if m.ttsTask = invalid then return
    m.ttsTask.text = text
end sub

sub onDeepLinkDataChanged()
    if m.deepLinkHandled then return
    deepLinkData = m.top.deepLinkData
    if deepLinkData = invalid then return
    if deepLinkData.contentId = invalid then return
    if deepLinkData.mediaType = invalid then return
    m.deepLinkHandled = true

    contentId = deepLinkData.contentId
    mediaType = deepLinkData.mediaType

    print "Deep link received in MainScene:"
    print "   contentId: "; contentId
    print "   mediaType: "; mediaType

    clearScreen()

    displayScreen("MovieScreen", { contentType: mediaType })

    '  Now pass deep link separately
    movieScreen = m.screenManager.getTopScreen()

    if movieScreen <> invalid
        movieScreen.deepLinkPayload = {
            contentType: mediaType
            deepLinkId: contentId
        }
    end if

end sub


sub animateTranslation(targetX as integer)
    if m.slideAnim = invalid or m.slideInterpolator = invalid then return
    current = m.screenContainer.translation
    m.slideInterpolator.keyValue = [
        current,
        [targetX, 0]
    ]
    m.slideAnim.control = "start"
end sub

sub clearScreen()
    while m.screenContainer.getChildCount() > 0

        m.screenContainer.removeChildIndex(0)
        m.screenManager.popScreen()
    end while
end sub

sub showExitDialog()
    ttsSpeak("Exit App. Are you sure you want to exit? Press Yes or No.") 
    m.dialog = createObject("roSGNode", "Dialog")
    m.dialog.title = "Exit App"
    m.dialog.message = "Are you sure you want to exit?"
    m.dialog.buttons = ["Yes", "No"]
    m.dialog.observeField("buttonSelected", "onExitDialogSelected")
    m.dialogopen = true
    m.dialog.muteAudioGuide="true"

    m.top.appendChild(m.dialog)
    m.dialog.observeField("wasClosed", "closeDialog")
    m.dialog.setFocus(true)
end sub

sub onExitDialogSelected(event as object)
    index = event.getData()


    if index = 0 then
        m.top.exitApp = true

    else if index = 1 then
        ttsSpeak("Cancelled")  
        m.top.removeChild(m.dialog)
        m.dialog = invalid
        m.sideMenu.setFocus(true)
        m.sideMenu.findNode("menu").setFocus(true)
        m.dialogopen = false
    else
        m.dialogopen = false
        m.sideMenu.setFocus(true)
        m.sideMenu.findNode("menu").setFocus(true)
    end if
end sub

sub onSidebarSelected()
    index = m.sideMenu.selectedIndex
    ' speakSelected(m.sideMenu)

    if index = 0
        clearScreen()
        displayScreen("HomeScreen")
        m.sideMenu.collapsed = true

    else if index = 1
        clearScreen()
        displayScreen("SearchScreen")

    else if index = 2  
        clearScreen()
        displayScreen("MovieScreen", { contentType: "movies" })

    else if index = 3
        clearScreen()
        displayScreen("MovieScreen", { contentType: "series" })
        
    else if index = 5
        clearScreen()
        displayScreen("SettingsScreen")
        
    else if index = 4
        clearScreen()
        displayScreen("WatchlaterScreen")
        
    end if
end sub

sub onMovieRequestSidebarFocus()
    m.sideMenu.visible = true
    m.sideMenu.setFocus(true)
    ' animateTranslation(150)
end sub



' -----screen Management codes
sub displayScreen(screenName as string, payload = invalid)

    screen = CreateObject("roSGNode", screenName)
    m.topscreen = screenName
    screen.observeField("events", "onHandleScreenEvents")

    if screenName = "HomeScreen"
            m.homeScreen = screen
    end if
    if payload <> invalid
        if screenName = "HomeScreen"
            m.homeScreen = screen
            m.screen.findNode("carouselbutton").setFocus(true)


        else if screenName = "DetailScreen" or screenName = "VideoPlayer"
            m.sideMenu.visible = false
            animateTranslation(0)
            if screenName = "DetailScreen"
                screen.itemContent = payload

            else
                screen.videoContent = payload
            end if
        else
            screen.screenData = payload
        end if
    end if
    screen.visible = true

    m.screenManager.pushScreen(screen)
    m.screenContainer.appendChild(screen)
    ' stop
    if screen.subtype() <> "VideoPlayer"
        if screen.subtype() = "HomeScreen"
            ' Let HomeScreen manage its own initial focus via carousel
            carouselBtn = screen.findNode("carouselbutton")
            if carouselBtn <> invalid
                carouselBtn.setFocus(true)
            end if
        else
            row = screen.findNode("rowList")
            if row <> invalid
                row.setFocus(true)
            end if
        end if

    else
        screen.requestFocus = true
    end if
end sub

sub onHandleScreenEvents(msg as object)

    if msg = invalid then
        return
    end if

    event = msg.getData()

    if event = invalid then
        return
    end if

    if event.type = "navigate"
        displayScreen(event.screen, event.payload)

    else if event.type = "backPress"
        ttsSpeak("Going back")
        handleBack()

    else if event.type = "speak"
        ttsSpeak(event.text)

    else if event.type = "bookmark"
    if event.videoUrl <> invalid and event.bookmarkPosition <> invalid
        if m.homeScreen <> invalid
            m.homeScreen.callFunc("loadContinueWatching")
        end if
    end if
end if
end sub

sub handleBack()
    screen = m.screenManager.popScreen()

    if screen <> invalid
        if screen.subtype() = "DetailScreen"
             
            m.screenContainer.getchild(0).visible = true
            m.sideMenu.visible = true
            animateTranslation(10)
        end if
        if screen.subtype() = "VideoPlayer"
            if m.homeScreen <> invalid
                m.homeScreen.callFunc("loadContinueWatching")
            end if
        end if
        
        m.screenContainer.removeChild(screen)

    end if

    if m.screenManager.hasScreens()
        topScreen = m.screenContainer.getChild(m.screenContainer.getChildCount() - 1)
        topScreen.setFocus(true)
        
    else
        m.sideMenu.visible = true
        
        m.sideMenu.setFocus(true)
        
    end if
end sub

sub changeFlag(event as object)
    m.isOpen = event.getData()
end sub


function onKeyEvent(key as string, press as boolean) as boolean

    if press
        if key = "right" and m.sideMenu.findNode("menu").hasFocus()

            if m.screenManager.getTopScreen().subtype() = "SettingsScreen"
                m.screenContainer.getchild(0).findNode("settingsMenuList").setFocus(true)
                m.sideMenu.collapsed = true

            else if m.screenManager.getTopScreen().subtype() = "WatchlaterScreen"
                m.screenContainer.getchild(0).findNode("watchLaterGrid").setFocus(true)
                m.sideMenu.collapsed = true

            else if m.screenManager.getTopScreen().subtype() = "HomeScreen"
                m.screenContainer.getchild(0).setFocus(true)
                m.sideMenu.collapsed = true

            else if m.screenManager.getTopScreen().subtype() = "SearchScreen" or m.screenManager.getTopScreen().subtype() = "DetailScreen"
                m.screenContainer.getchild(0).findNode("searchkeyboard").setFocus(true)
                m.sideMenu.collapsed = true
                
            else
                m.screenContainer.getchild(0).findNode("rowList").setFocus(true)
                m.sideMenu.collapsed = true
                return true
            end if
        end if


        if key = "left"
            ttsSpeak("Menu opened") 
            m.sideMenu.findNode("menu").setFocus(true)
            m.sideMenu.setFocus(true)
            m.sideMenu.collapsed = false
            return true
        end if

        if key = "back"

            if m.isOpen = false and m.screenContainer.getChildCount() = 1
                ttsSpeak("Menu opened") 
                m.sideMenu.findNode("menu").setFocus(true)
                m.sideMenu.setFocus(true)
                m.sideMenu.collapsed = false
                return true
            end if
            if m.isOpen = true
                if m.dialog <> invalid
                   
                    m.top.removeChild(m.dialog)
                    m.dialog = invalid
                    m.sideMenu.setFocus(true)
                    return true
                else
                    showExitDialog()
                    return true
                end if
            end if
        end if
    end if
    return false
end function