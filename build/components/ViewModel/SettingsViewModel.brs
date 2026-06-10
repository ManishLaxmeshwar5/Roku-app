sub init()
    RBS_CC_18_reportLine("1", 1)
    m.deviceInfo = CreateObject("roDeviceInfo")
end sub

function loadMenu()
    ' stop
    RBS_CC_18_reportLine("7", 1)
    items = getMenuItems()
    RBS_CC_18_reportLine("8", 1)
    root = createContentNode()
    RBS_CC_18_reportLine("9", 1): for each item in items
        RBS_CC_18_reportLine("10", 1)
        appendItem(root, item)
    end for
    RBS_CC_18_reportLine("12", 1)
    m.top.menuContent = root
    RBS_CC_18_reportLine("13", 1)
    return true
end function

function getMenuItems() as object
    RBS_CC_18_reportLine("18", 1)
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
    RBS_CC_18_reportLine("30", 1)
    root = createContentNode()
    RBS_CC_18_reportLine("31", 1)
    settingsMap = getSettingsMap()
    if RBS_CC_18_reportLine("32", 2) and (settingsMap.doesExist(title))
        RBS_CC_18_reportLine("32", 3)
        RBS_CC_18_reportLine("33", 1): for each item in settingsMap[title]
            RBS_CC_18_reportLine("34", 1)
            appendDetail(root, item.title, item.value)
        end for
    end if
    RBS_CC_18_reportLine("37", 1)
    m.top.detailContent = root
    RBS_CC_18_reportLine("38", 1)
    return true
end function

function getSettingsMap() as object
    RBS_CC_18_reportLine("43", 1)
    di = m.deviceInfo
    RBS_CC_18_reportLine("44", 1)
    return {
        "TimeZone": [
            {
                title: "Time Zone"
                value: di.GetTimeZone()
            }
        ]
        "Language": [
            {
                title: "Language"
                value: di.GetCurrentLocale()
            }
            {
                title: "Country"
                value: di.GetCountryCode()
            }
        ]
        "Audio Info": [
            {
                title: "Audio Output"
                value: di.CanDecodeAudio({
                    Codec: "aac"
                }).Result
            }
            {
                title: "Sound Effects"
                value: di.GetSoundEffectsVolume()
            }
            {
                title: "Audio Mode"
                value: di.GetAudioOutputChannel()
            }
        ]
        "Storage Info": [
            {
                title: "Memory Level"
                value: di.GetGeneralMemoryLevel()
            }
        ]
        "Device Info": [
            {
                title: "Model"
                value: di.GetModel()
            }
            {
                title: "Firmware"
                value: di.GetVersion()
            }
            {
                title: "Serial"
                value: di.GetDeviceUniqueId()
            }
            {
                title: "Display Mode"
                value: di.GetDisplayMode()
            }
            {
                title: "Display Type"
                value: di.GetDisplayType()
            }
        ]
        "Text-to-Speech": [
            {
                title: "Enable"
                value: "English"
            }
            {
                title: "Disable"
                value: "English"
            }
        ]
    }
end function

function handleDetailSelection(title as string)
    if RBS_CC_18_reportLine("81", 2) and (Instr(1, title, "Enable") > 0)
        RBS_CC_18_reportLine("81", 3)
        RBS_CC_18_reportLine("82", 1)
        m.top.ttsEnabled = true
        RBS_CC_18_reportLine("83", 1)
        m.top.toastData = {
            message: "Text-to-Speech enabled"
            duration: 2
        }
    else if RBS_CC_18_reportLine("88", 2) and (Instr(1, title, "Disable") > 0)
        RBS_CC_18_reportLine("88", 3)
        RBS_CC_18_reportLine("89", 1)
        m.top.ttsEnabled = false
        RBS_CC_18_reportLine("90", 1)
        m.top.toastData = {
            message: "Text-to-Speech disabled"
            duration: 2
        }
    end if
    RBS_CC_18_reportLine("95", 1)
    return true
end function

function RBS_CC_18_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "18"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "18"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./SettingsViewModel.brs.map