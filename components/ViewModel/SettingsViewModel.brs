sub init()
    m.deviceInfo = CreateObject("roDeviceInfo")
end sub


function loadMenu()
    ' stop
    items = getMenuItems()
    root = createContentNode()
    for each item in items
        appendItem(root, item)
    end for
    m.top.menuContent = root
    return true
end function


function getMenuItems() as object
    return [
        "TimeZone"
        "Language"
        "Device Info"
        "Audio Info"
        "Storage Info"
        "Text-to-Speech"
    ]
end function


function loadDetails(title as string)
    root = createContentNode()
    settingsMap = getSettingsMap()
    if settingsMap.doesExist(title)
        for each item in settingsMap[title]
            appendDetail(root, item.title, item.value)
        end for
    end if
    m.top.detailContent = root
    return true
end function


function getSettingsMap() as object
    di = m.deviceInfo
    return {
        "TimeZone": [
            { title: "Time Zone", value: di.GetTimeZone() }
        ]

        "Language": [
            { title: "Language", value: di.GetCurrentLocale() }
            { title: "Country", value: di.GetCountryCode() }
        ]

        "Audio Info": [
            { title: "Audio Output", value: di.CanDecodeAudio({ Codec: "aac" }).Result }
            { title: "Sound Effects", value: di.GetSoundEffectsVolume() }
            { title: "Audio Mode", value: di.GetAudioOutputChannel() }
        ]

        "Storage Info": [
            { title: "Memory Level", value: di.GetGeneralMemoryLevel() }
        ]

        "Device Info": [
            { title: "Model", value: di.GetModel() }
            { title: "Firmware", value: di.GetVersion() }
            { title: "Serial", value: di.GetDeviceUniqueId() }
            { title: "Display Mode", value: di.GetDisplayMode() }
            { title: "Display Type", value: di.GetDisplayType() }
        ]

        "Text-to-Speech": [
            { title: "Enable", value: "English" }
            { title: "Disable", value: "English" }
        ]
    }
end function


function handleDetailSelection(title as string)
    if Instr(1, title, "Enable") > 0
        m.top.ttsEnabled = true
        m.top.toastData = {
            message: "Text-to-Speech enabled"
            duration: 2
        }

    else if Instr(1, title, "Disable") > 0
        m.top.ttsEnabled = false
        m.top.toastData = {
            message: "Text-to-Speech disabled"
            duration: 2
        }
    end if
    return true
end function