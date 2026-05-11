' sub init()
'     m.settingsMenuList = m.top.findNode("settingsMenuList")
'     m.settingsDetailList = m.top.findNode("settingsDetailList")

'     m.settingsMenuList.observeField("itemFocused", "onMenuItemFocused")
'     m.settingsDetailList.observeField("itemSelected", "onDetailSelected")
'     m.settingsDetailList.observeField("itemFocused", "onDetailsItemFocused")

'     m.deviceInfo = CreateObject("roDeviceInfo")

'     loadSettingsMenu()
'     m.settingsMenuList.setFocus(true)
'     m.isopen = false
' end sub

' function getMenuItems() as object
'     return [
'         "TimeZone"
'         "Language"
'         "Device Info"
'         "Audio Info"
'         "Storage Info"
'         "Text-to-Speech"
'     ]
' end function

' sub loadSettingsMenu()
'     m.menuItems = getMenuItems()
'     root = createContentNode()

'     for each item in m.menuItems
'         appendItem(root, item)
'     end for

'     m.settingsMenuList.content = root
' end sub

' sub onDetailsItemFocused()
'     speakFocused(m.settingsDetailList)
' end sub

' sub addMenuItem(root as object, title as string)
'     item = CreateObject("roSGNode", "ContentNode")
'     item.title = title
'     root.appendChild(item)
' end sub

' sub onMenuItemFocused()
'     speakFocused(m.settingsMenuList)
'     m.isopen = true
'     index = m.settingsMenuList.itemFocused
'     item = m.settingsMenuList.content.getChild(index)
'     loadSettingsDetail(item.title)
'     m.settingsDetailList.visible = true
' end sub

' function getSettingsMap() as object
'     di = m.deviceInfo

'     return {
'         "TimeZone": [
'             { title: "Time Zone", value: di.GetTimeZone() }
'         ]

'         "Language": [
'             { title: "Language", value: di.GetCurrentLocale() }
'             { title: "Country", value: di.GetCountryCode() }
'         ]

'         "Audio Info": [
'             { title: "Audio Output", value: di.CanDecodeAudio({ Codec: "aac" }).Result }
'             { title: "Sound Effects", value: di.GetSoundEffectsVolume() }
'             { title: "Audio Mode", value: di.GetAudioOutputChannel() }
'         ]

'         "Storage Info": [
'             { title: "Memory Level", value: di.GetGeneralMemoryLevel() }
'         ]

'         "Device Info": [
'             { title: "Model", value: di.GetModel() }
'             { title: "Firmware", value: di.GetVersion() }
'             { title: "Serial", value: di.GetDeviceUniqueId() }
'             { title: "Display Mode", value: di.GetDisplayMode() }
'             { title: "Display Type", value: di.GetDisplayType() }
'         ]

'         "Text-to-Speech": [
'             { title: "Enable", value: "English" }
'             { title: "Disable", value: "English" }
'         ]
'     }
' end function

' sub loadSettingsDetail(title as string)
'     root = createContentNode()
'     settingsMap = getSettingsMap()

'     if settingsMap.doesExist(title)
'         for each item in settingsMap[title]
'             appendDetail(root, item.title, item.value)
'         end for
'     end if

'     m.settingsDetailList.content = root
' end sub

' sub onDetailSelected()
'     index = m.settingsDetailList.itemSelected
'     item = m.settingsDetailList.content.getChild(index)
'     title = item.title
'     if instr(1, title, "Enable") > 0
'         m.global.ttsEnabled = true
'         m.top.events = { type: "speak", text: "Text to speech enabled" }
'         m.global.toast = {
'             message: " Text-to-Speech enabled"
'             duration: 2
'         }
'     else if instr(1, title, "Disable") > 0
'         m.top.events = { type: "speak", text: "Text to speech disabled" }
'         m.global.toast = {
'             message: "Text-to-Speech disabled"
'             duration: 2
'         }
'         m.global.ttsEnabled = false
'     end if
' end sub

' function onKeyEvent(key as string, press as boolean) as boolean
'     if not press then return false
'     if (key = "left" or key = "back")and m.settingsDetailList.hasFocus()
'         m.settingsMenuList.setFocus(true)
'         return true

'     else if key = "right"
'         if m.settingsMenuList.hasFocus() and m.isopen
'             m.settingsDetailList.setFocus(true)
'         end if

'     else if key = "OK"
'         m.settingsDetailList.setFocus(true)
'     end if

'     return false
' end function

sub init()
    m.settingsMenuList = m.top.findNode("settingsMenuList")
    m.settingsDetailList = m.top.findNode("settingsDetailList")
    m.settingsMenuList.observeField("itemFocused", "onMenuItemFocused")
    m.settingsDetailList.observeField("itemSelected", "onDetailSelected")
    m.settingsDetailList.observeField("itemFocused", "onDetailsItemFocused")
    initViewModel()
    m.viewModel.callFunc("loadMenu")
    m.settingsMenuList.setFocus(true)
    m.isopen = false
end sub


sub initViewModel()
    m.viewModel = CreateObject("roSGNode", "SettingsViewModel")
    m.viewModel.observeField("menuContent", "onMenuLoaded")
    m.viewModel.observeField("detailContent", "onDetailLoaded")
    m.viewModel.observeField("ttsEnabled", "onTTSChanged")
    m.viewModel.observeField("toastData", "onToastData")
end sub


sub onMenuLoaded()
    ' stop
    m.settingsMenuList.content = m.viewModel.menuContent
end sub


sub onDetailLoaded()
    m.settingsDetailList.content = m.viewModel.detailContent
end sub


sub onTTSChanged()

    m.global.ttsEnabled = m.viewModel.ttsEnabled
    if m.viewModel.ttsEnabled
        m.top.events = {
            type: "speak"
            text: "Text to speech enabled"
        }
    else
        m.top.events = {
            type: "speak"
            text: "Text to speech disabled"
        }
    end if
end sub


sub onToastData()
    m.global.toast = m.viewModel.toastData
end sub


sub onDetailsItemFocused()
    speakFocused(m.settingsDetailList)
end sub


sub onMenuItemFocused()
    speakFocused(m.settingsMenuList)
    m.isopen = true
    index = m.settingsMenuList.itemFocused
    item = m.settingsMenuList.content.getChild(index)
    if not isValid(item) then return
    m.viewModel.callFunc("loadDetails", item.title)
    m.settingsDetailList.visible = true
end sub


sub onDetailSelected()
    index = m.settingsDetailList.itemSelected
    item = m.settingsDetailList.content.getChild(index)
    if not isValid(item) then return
    title = item.title
    m.viewModel.callFunc("handleDetailSelection", title)
end sub


function onKeyEvent(key as string, press as boolean) as boolean

    if not press then return false

    if (key = "left" or key = "back") and m.settingsDetailList.hasFocus()
        m.settingsMenuList.setFocus(true)
        return true

    else if key = "right"
        if m.settingsMenuList.hasFocus() and m.isopen
            m.settingsDetailList.setFocus(true)
            return true
        end if

    else if key = "OK"
        m.settingsDetailList.setFocus(true)
        return true
    end if
    return false
end function