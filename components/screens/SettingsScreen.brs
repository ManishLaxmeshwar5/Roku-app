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