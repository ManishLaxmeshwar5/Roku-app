sub speak(text as string)
    if text = invalid or text = "" then return
    if m.global.ttsEnabled = false then return
    m.top.events = { type: "speak", text: text }
end sub

sub speakFocused(listNode as object)
    if listNode = invalid then return
    item = listNode.content.getChild(listNode.itemFocused)
    if item = invalid then return
    text = item.title
    if text = invalid or text = "" then text = item.label
    if text = invalid or text = "" then return
    speak(text)
end sub


sub speakSelected(listNode as object)
    if listNode = invalid then return
    item = listNode.content.getChild(listNode.itemSelected)
    if item = invalid then return
    text = item.title
    if text = invalid or text = "" then text = item.label
    if text = invalid or text = "" then return
    speak(text + " selected")
end sub

function isValid(obj as dynamic) as boolean
    return obj<> invalid 
end function

function isNonEmptyString(str as dynamic) as boolean
    return str <> invalid and str <> ""
end function

function isValidAA(obj as dynamic) as boolean
    return obj <> invalid and type(obj) = "roAssociativeArray"
end function

function getContentTitle(content as object) as string
    if content.DoesExist("ShortDescriptionLine1") and content.ShortDescriptionLine1 <> ""
        return content.ShortDescriptionLine1
    else if content.DoesExist("title") and content.title <> ""
        return content.title
    end if
    return ""
end function

function createContentNode() as object
    return CreateObject("roSGNode", "ContentNode")
end function

function createItem(title as string) as object
    item = CreateObject("roSGNode", "ContentNode")
    item.title = title
    return item
end function

sub appendItem(root as object, title as string)
    root.appendChild(createItem(title))
end sub

sub appendDetail(root as object, title as string, value as dynamic)
    item = CreateObject("roSGNode", "ContentNode")
    item.title = title + ": " + value.ToStr()
    root.appendChild(item)
end sub

function readJsonFile(path as string) as dynamic
    jsonText = ReadAsciiFile(path)
    if not isNonEmptyString(jsonText) then return invalid
    return ParseJson(jsonText)
end function