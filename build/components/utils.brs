sub speak(text as string)
    if RBS_CC_48_reportLine("1", 2) and (text = invalid or text = "") then
        RBS_CC_48_reportLine("1", 3)
        RBS_CC_48_reportLine("1", 1)
        return
    end if
    if RBS_CC_48_reportLine("2", 2) and (m.global.ttsEnabled = false) then
        RBS_CC_48_reportLine("2", 3)
        RBS_CC_48_reportLine("2", 1)
        return
    end if
    RBS_CC_48_reportLine("3", 1)
    m.top.events = {
        type: "speak"
        text: text
    }
end sub

sub speakFocused(listNode as object)
    if RBS_CC_48_reportLine("7", 2) and (listNode = invalid) then
        RBS_CC_48_reportLine("7", 3)
        RBS_CC_48_reportLine("7", 1)
        return
    end if
    RBS_CC_48_reportLine("8", 1)
    item = listNode.content.getChild(listNode.itemFocused)
    if RBS_CC_48_reportLine("9", 2) and (item = invalid) then
        RBS_CC_48_reportLine("9", 3)
        RBS_CC_48_reportLine("9", 1)
        return
    end if
    RBS_CC_48_reportLine("10", 1)
    text = item.title
    if RBS_CC_48_reportLine("11", 2) and (text = invalid or text = "") then
        RBS_CC_48_reportLine("11", 3)
        RBS_CC_48_reportLine("11", 1)
        text = item.label
    end if
    if RBS_CC_48_reportLine("12", 2) and (text = invalid or text = "") then
        RBS_CC_48_reportLine("12", 3)
        RBS_CC_48_reportLine("12", 1)
        return
    end if
    RBS_CC_48_reportLine("13", 1)
    speak(text)
end sub

sub speakSelected(listNode as object)
    if RBS_CC_48_reportLine("18", 2) and (listNode = invalid) then
        RBS_CC_48_reportLine("18", 3)
        RBS_CC_48_reportLine("18", 1)
        return
    end if
    RBS_CC_48_reportLine("19", 1)
    item = listNode.content.getChild(listNode.itemSelected)
    if RBS_CC_48_reportLine("20", 2) and (item = invalid) then
        RBS_CC_48_reportLine("20", 3)
        RBS_CC_48_reportLine("20", 1)
        return
    end if
    RBS_CC_48_reportLine("21", 1)
    text = item.title
    if RBS_CC_48_reportLine("22", 2) and (text = invalid or text = "") then
        RBS_CC_48_reportLine("22", 3)
        RBS_CC_48_reportLine("22", 1)
        text = item.label
    end if
    if RBS_CC_48_reportLine("23", 2) and (text = invalid or text = "") then
        RBS_CC_48_reportLine("23", 3)
        RBS_CC_48_reportLine("23", 1)
        return
    end if
    RBS_CC_48_reportLine("24", 1)
    speak(text + " selected")
end sub

function isValid(obj as dynamic) as boolean
    RBS_CC_48_reportLine("28", 1)
    return obj <> invalid
end function

function isNonEmptyString(str as dynamic) as boolean
    RBS_CC_48_reportLine("32", 1)
    return str <> invalid and str <> ""
end function

function isValidAA(obj as dynamic) as boolean
    RBS_CC_48_reportLine("36", 1)
    return obj <> invalid and type(obj) = "roAssociativeArray"
end function

function getContentTitle(content as object) as string
    if RBS_CC_48_reportLine("40", 2) and (content.DoesExist("ShortDescriptionLine1") and content.ShortDescriptionLine1 <> "")
        RBS_CC_48_reportLine("40", 3)
        RBS_CC_48_reportLine("41", 1)
        return content.ShortDescriptionLine1
    else if RBS_CC_48_reportLine("42", 2) and (content.DoesExist("title") and content.title <> "")
        RBS_CC_48_reportLine("42", 3)
        RBS_CC_48_reportLine("43", 1)
        return content.title
    end if
    RBS_CC_48_reportLine("45", 1)
    return ""
end function

function createContentNode() as object
    RBS_CC_48_reportLine("49", 1)
    return CreateObject("roSGNode", "ContentNode")
end function

function createItem(title as string) as object
    RBS_CC_48_reportLine("53", 1)
    item = CreateObject("roSGNode", "ContentNode")
    RBS_CC_48_reportLine("54", 1)
    item.title = title
    RBS_CC_48_reportLine("55", 1)
    return item
end function

sub appendItem(root as object, title as string)
    RBS_CC_48_reportLine("59", 1)
    root.appendChild(createItem(title))
end sub

sub appendDetail(root as object, title as string, value as dynamic)
    RBS_CC_48_reportLine("63", 1)
    item = CreateObject("roSGNode", "ContentNode")
    RBS_CC_48_reportLine("64", 1)
    item.title = title + ": " + value.ToStr()
    RBS_CC_48_reportLine("65", 1)
    root.appendChild(item)
end sub

function readJsonFile(path as string) as dynamic
    RBS_CC_48_reportLine("69", 1)
    jsonText = ReadAsciiFile(path)
    if RBS_CC_48_reportLine("70", 2) and (not isNonEmptyString(jsonText)) then
        RBS_CC_48_reportLine("70", 3)
        RBS_CC_48_reportLine("70", 1)
        return invalid
    end if
    RBS_CC_48_reportLine("71", 1)
    return ParseJson(jsonText)
end function

sub markScreenType(root as object, screenType as string)
    RBS_CC_48_reportLine("76", 1): for each row in root.getChildren(-1)
        RBS_CC_48_reportLine("78", 1): for each item in row.getChildren(-1)
            if RBS_CC_48_reportLine("80", 2) and (not item.hasField("screenType"))
                RBS_CC_48_reportLine("80", 3)
                RBS_CC_48_reportLine("81", 1)
                item.addField("screenType", "string", false)
            end if
            RBS_CC_48_reportLine("84", 1)
            item.screenType = screenType
        end for
    end for
end sub

function getCurrentLang() as String
    RBS_CC_48_reportLine("93", 1)
    lang = m.global.currentLang
    if RBS_CC_48_reportLine("94", 2) and (lang = invalid or lang = "") then
        RBS_CC_48_reportLine("94", 3)
        RBS_CC_48_reportLine("94", 1)
        return "en"
    end if
    RBS_CC_48_reportLine("95", 1)
    return lang
end function

function translate()
    RBS_CC_48_reportLine("99", 1)
    translations = ReadAsciiFile("pkg:/source/translation.json")
    RBS_CC_48_reportLine("100", 1)
    json = ParseJson(translations)
    RBS_CC_48_reportLine("101", 1)
    return json
end function

function RBS_CC_48_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "48"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "48"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./utils.brs.map