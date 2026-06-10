' ******************
' Common utility functions
' ******************

' check if value contains XMLElement interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains XMLElement interface, else return false
function rooibos_common_isXmlElement(value) as boolean
    RBS_CC_24_reportLine("8", 1)
    return rooibos_common_isValid(value) and GetInterface(value, "ifXMLElement") <> invalid
end function

' check if value contains Function interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains Function interface, else return false
function rooibos_common_isFunction(value) as boolean
    RBS_CC_24_reportLine("15", 1)
    return rooibos_common_isValid(value) and GetInterface(value, "ifFunction") <> invalid
end function

' looks up the function by name, for the function map
' @param {filename} string - name of the file where the function was found
' @param {String} functionName - name of the function to locate
' @returns {Function} - function pointer or invalid
function rooibos_common_getFunction(filename, functionName) as object
    if RBS_CC_24_reportLine("23", 2) and (not rooibos_common_isNotEmptyString(functionName))
        RBS_CC_24_reportLine("23", 3)
        RBS_CC_24_reportLine("24", 1)
        return invalid
    end if
    if RBS_CC_24_reportLine("26", 2) and (not rooibos_common_isNotEmptyString(filename))
        RBS_CC_24_reportLine("26", 3)
        RBS_CC_24_reportLine("27", 1)
        return invalid
    end if
    'bs:disable-next-line
    RBS_CC_24_reportLine("30", 1)
    mapFunction = RBSFM_getFunctionsForFile(filename)
    'bs:disable-next-line
    if RBS_CC_24_reportLine("32", 2) and (mapFunction <> invalid)
        RBS_CC_24_reportLine("32", 3)
        'bs:disable-next-line
        RBS_CC_24_reportLine("34", 1)
        map = mapFunction()
        'bs:disable-next-line
        if RBS_CC_24_reportLine("36", 2) and (type(map) = "roAssociativeArray")
            RBS_CC_24_reportLine("36", 3)
            'bs:disable-next-line
            RBS_CC_24_reportLine("38", 1)
            functionPointer = map[functionName]
            'bs:disable-next-linenrb
            RBS_CC_24_reportLine("40", 1)
            return functionPointer
        else
            RBS_CC_24_reportLine("41", 3)
            RBS_CC_24_reportLine("42", 1)
            return invalid
        end if
    end if
    RBS_CC_24_reportLine("45", 1)
    return invalid
end function

' looks up the function by name, from any function map
'            in future
' @param {filename} string - name of the file where the function was found
' @param {String} functionName - name of the function to locate
' @returns {Function} - function pointer or invalid
function rooibos_common_getFunctionBruteForce(functionName) as object
    if RBS_CC_24_reportLine("54", 2) and (not rooibos_common_isNotEmptyString(functionName))
        RBS_CC_24_reportLine("54", 3)
        RBS_CC_24_reportLine("55", 1)
        return invalid
    end if
    'bs:disable-next-line
    RBS_CC_24_reportLine("58", 1)
    filenames = RBSFM_getFilenames()
    RBS_CC_24_reportLine("59", 1): for i = 0 to filenames.count() - 1
        RBS_CC_24_reportLine("60", 1)
        filename = filenames[i]
        'bs:disable-next-line
        RBS_CC_24_reportLine("62", 1)
        mapFunction = RBSFM_getFunctionsForFile(filename)
        'bs:disable-next-line
        if RBS_CC_24_reportLine("64", 2) and (mapFunction <> invalid)
            RBS_CC_24_reportLine("64", 3)
            'bs:disable-next-line
            RBS_CC_24_reportLine("66", 1)
            map = mapFunction()
            'bs:disable-next-line
            if RBS_CC_24_reportLine("68", 2) and (type(map) = "roAssociativeArray")
                RBS_CC_24_reportLine("68", 3)
                'bs:disable-next-line
                RBS_CC_24_reportLine("70", 1)
                functionPointer = map[functionName]
                'bs:disable-next-line
                if RBS_CC_24_reportLine("72", 2) and (functionPointer <> invalid)
                    RBS_CC_24_reportLine("72", 3)
                    'bs:disable-next-line
                    RBS_CC_24_reportLine("74", 1)
                    return functionPointer
                end if
            end if
        end if
    end for
    RBS_CC_24_reportLine("79", 1)
    return invalid
end function

' check if value contains Boolean interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains Boolean interface, else return false
function rooibos_common_isBoolean(value) as boolean
    RBS_CC_24_reportLine("86", 1)
    return rooibos_common_isValid(value) and GetInterface(value, "ifBoolean") <> invalid
end function

' check if value type equals Integer
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value type equals Integer, else return false
function rooibos_common_isInteger(value) as boolean
    RBS_CC_24_reportLine("93", 1)
    return rooibos_common_isValid(value) and GetInterface(value, "ifInt") <> invalid and (Type(value) = "roInt" or Type(value) = "roInteger" or Type(value) = "Integer")
end function

' check if value contains Float interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains Float interface, else return false
function rooibos_common_isFloat(value) as boolean
    RBS_CC_24_reportLine("100", 1)
    return rooibos_common_isValid(value) and GetInterface(value, "ifFloat") <> invalid
end function

' check if value contains Double interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains Double interface, else return false
function rooibos_common_isDouble(value) as boolean
    RBS_CC_24_reportLine("107", 1)
    return rooibos_common_isValid(value) and GetInterface(value, "ifDouble") <> invalid
end function

' check if value contains LongInteger interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains LongInteger interface, else return false
function rooibos_common_isLongInteger(value) as boolean
    RBS_CC_24_reportLine("114", 1)
    return rooibos_common_isValid(value) and GetInterface(value, "ifLongInt") <> invalid
end function

' check if value contains LongInteger or Integer or Double or Float interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value is number, else return false
function rooibos_common_isNumber(value) as boolean
    RBS_CC_24_reportLine("121", 1)
    return rooibos_common_isLongInteger(value) or rooibos_common_isDouble(value) or rooibos_common_isInteger(value) or rooibos_common_isFloat(value)
end function

' check if value contains List interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains List interface, else return false
function rooibos_common_isList(value) as boolean
    RBS_CC_24_reportLine("128", 1)
    return rooibos_common_isValid(value) and GetInterface(value, "ifList") <> invalid
end function

' check if value contains Array interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains Array interface, else return false
function rooibos_common_isArray(value) as boolean
    RBS_CC_24_reportLine("135", 1)
    return rooibos_common_isValid(value) and GetInterface(value, "ifArray") <> invalid
end function

' check if value contains AssociativeArray interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains AssociativeArray interface, else return false
function rooibos_common_isAssociativeArray(value) as boolean
    RBS_CC_24_reportLine("142", 1)
    return rooibos_common_isValid(value) and GetInterface(value, "ifAssociativeArray") <> invalid
end function

' check if value contains SGNodeChildren interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains SGNodeChildren interface, else return false
function rooibos_common_isSGNode(value) as boolean
    RBS_CC_24_reportLine("149", 1)
    return rooibos_common_isValid(value) and GetInterface(value, "ifSGNodeChildren") <> invalid
end function

' check if value contains String interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains String interface, else return false
function rooibos_common_isString(value) as boolean
    RBS_CC_24_reportLine("156", 1)
    return rooibos_common_isValid(value) and GetInterface(value, "ifString") <> invalid
end function

' check if value contains String interface and length more 0
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains String interface and length more 0, else return false
function rooibos_common_isNotEmptyString(value) as boolean
    RBS_CC_24_reportLine("163", 1)
    return rooibos_common_isString(value) and len(value) > 0
end function

' check if value contains DateTime interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains DateTime interface, else return false
function rooibos_common_isDateTime(value) as boolean
    RBS_CC_24_reportLine("170", 1)
    return rooibos_common_isValid(value) and (GetInterface(value, "ifDateTime") <> invalid or Type(value) = "roDateTime")
end function

' check if value initialized and not equal invalid
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value initialized and not equal invalid, else return false
function rooibos_common_isValid(value) as boolean
    RBS_CC_24_reportLine("177", 1)
    return not rooibos_common_isUndefined(value) and value <> invalid
end function

function rooibos_common_isUndefined(value) as boolean
    RBS_CC_24_reportLine("181", 1)
    return type(value) = "" or Type(value) = "<uninitialized>"
end function

' return value if his contains String interface else return empty string
' @param {Dynamic} value - value to check
' @returns {String} - value if his contains String interface else return empty string
function rooibos_common_validStr(obj) as string
    if RBS_CC_24_reportLine("188", 2) and (obj <> invalid and GetInterface(obj, "ifString") <> invalid)
        RBS_CC_24_reportLine("188", 3)
        RBS_CC_24_reportLine("189", 1)
        return obj
    else
        RBS_CC_24_reportLine("190", 3)
        RBS_CC_24_reportLine("191", 1)
        return ""
    end if
end function

' /**
' convert input to multiline String if this possible, else return empty string
' @param {Dynamic} input - value to check
' @returns {String} - converted string
function rooibos_common_asMultilineString(input, includeType = false, indention = 0) as string
    RBS_CC_24_reportLine("200", 1)
    indentChr = "  "
    if RBS_CC_24_reportLine("201", 2) and (rooibos_common_isValid(input) = false)
        RBS_CC_24_reportLine("201", 3)
        RBS_CC_24_reportLine("202", 1)
        return type(input)
    else if RBS_CC_24_reportLine("203", 2) and (rooibos_common_isString(input))
        RBS_CC_24_reportLine("203", 3)
        RBS_CC_24_reportLine("204", 1)
        return formatJson(input)
    else if RBS_CC_24_reportLine("205", 2) and (rooibos_common_isInteger(input) or rooibos_common_isLongInteger(input) or rooibos_common_isBoolean(input))
        RBS_CC_24_reportLine("205", 3)
        if RBS_CC_24_reportLine("206", 2) and (includeType)
            RBS_CC_24_reportLine("206", 3)
            RBS_CC_24_reportLine("207", 1)
            return input.ToStr() + " (" + rooibos_common_getSafeType(input) + ")"
        else
            RBS_CC_24_reportLine("208", 3)
            RBS_CC_24_reportLine("209", 1)
            return input.ToStr()
        end if
    else if RBS_CC_24_reportLine("211", 2) and (rooibos_common_isFloat(input) or rooibos_common_isDouble(input))
        RBS_CC_24_reportLine("211", 3)
        if RBS_CC_24_reportLine("212", 2) and (includeType)
            RBS_CC_24_reportLine("212", 3)
            RBS_CC_24_reportLine("213", 1)
            return Str(input).Trim() + " (" + rooibos_common_getSafeType(input) + ")"
        else
            RBS_CC_24_reportLine("214", 3)
            RBS_CC_24_reportLine("215", 1)
            return Str(input).Trim()
        end if
    else if RBS_CC_24_reportLine("217", 2) and (type(input) = "roSGNode")
        RBS_CC_24_reportLine("217", 3)
        RBS_CC_24_reportLine("218", 1)
        return "Node(" + input.subType() + ")"
    else if RBS_CC_24_reportLine("219", 2) and (type(input) = "roAssociativeArray")
        RBS_CC_24_reportLine("219", 3)
        if RBS_CC_24_reportLine("220", 2) and (input.isEmpty())
            RBS_CC_24_reportLine("220", 3)
            RBS_CC_24_reportLine("221", 1)
            return "{" + chr(10) + string(indention, indentChr) + "}"
        end if
        RBS_CC_24_reportLine("223", 1)
        text = "{" + chr(10)
        RBS_CC_24_reportLine("224", 1)
        keys = input.ifAssociativeArray.keys()
        RBS_CC_24_reportLine("225", 1)
        keys.sort()
        RBS_CC_24_reportLine("226", 1): for each key in keys
            if RBS_CC_24_reportLine("227", 2) and (rooibos_common_canSafelyIterateAAKey(input, key))
                RBS_CC_24_reportLine("227", 3)
                RBS_CC_24_reportLine("228", 1)
                text = text + string(indention + 1, indentChr) + formatJson(key) + ": " + rooibos_common_asMultilineString(input[key], includeType, indention + 1) + "," + chr(10)
            end if
        end for
        ' remove last comma
        if RBS_CC_24_reportLine("232", 2) and (len(text) > 2)
            RBS_CC_24_reportLine("232", 3)
            RBS_CC_24_reportLine("233", 1)
            text = left(text, len(text) - 2)
        end if
        RBS_CC_24_reportLine("235", 1)
        text = text + chr(10) + string(indention, indentChr) + "}"
        RBS_CC_24_reportLine("236", 1)
        return text
    else if RBS_CC_24_reportLine("237", 2) and (rooibos_common_isArray(input))
        RBS_CC_24_reportLine("237", 3)
        if RBS_CC_24_reportLine("238", 2) and (input.isEmpty())
            RBS_CC_24_reportLine("238", 3)
            RBS_CC_24_reportLine("239", 1)
            return "[" + chr(10) + "]"
        end if
        RBS_CC_24_reportLine("241", 1)
        text = "[" + chr(10)
        RBS_CC_24_reportLine("242", 1): for i = 0 to input.count() - 1
            RBS_CC_24_reportLine("243", 1)
            v = input[i]
            RBS_CC_24_reportLine("244", 1)
            text += string(indention + 1, indentChr) + rooibos_common_asMultilineString(v, includeType, indention + 1)
            if RBS_CC_24_reportLine("245", 2) and (i < input.count() - 1)
                RBS_CC_24_reportLine("245", 3)
                RBS_CC_24_reportLine("246", 1)
                text += ","
            end if
            RBS_CC_24_reportLine("248", 1)
            text += chr(10)
        end for
        RBS_CC_24_reportLine("250", 1)
        text = text + string(indention, indentChr) + "]"
        RBS_CC_24_reportLine("251", 1)
        return text
    else if RBS_CC_24_reportLine("252", 2) and (rooibos_common_isFunction(input))
        RBS_CC_24_reportLine("252", 3)
        RBS_CC_24_reportLine("253", 1)
        return input.toStr().mid(10) + " (function)"
    else
        RBS_CC_24_reportLine("254", 3)
        RBS_CC_24_reportLine("255", 1)
        return ""
    end if
end function

' convert input to String if this possible, else return empty string
' @param {Dynamic} input - value to check
' @returns {String} - converted string
function rooibos_common_asString(input, includeType = false) as string
    if RBS_CC_24_reportLine("263", 2) and (rooibos_common_isValid(input) = false)
        RBS_CC_24_reportLine("263", 3)
        RBS_CC_24_reportLine("264", 1)
        return "INVALID"
    else if RBS_CC_24_reportLine("265", 2) and (rooibos_common_isString(input))
        RBS_CC_24_reportLine("265", 3)
        if RBS_CC_24_reportLine("266", 2) and (includeType)
            RBS_CC_24_reportLine("266", 3)
            RBS_CC_24_reportLine("267", 1)
            return """" + input + """"
        else
            RBS_CC_24_reportLine("268", 3)
            RBS_CC_24_reportLine("269", 1)
            return input
        end if
    else if RBS_CC_24_reportLine("271", 2) and (rooibos_common_isInteger(input) or rooibos_common_isLongInteger(input) or rooibos_common_isBoolean(input))
        RBS_CC_24_reportLine("271", 3)
        if RBS_CC_24_reportLine("272", 2) and (includeType)
            RBS_CC_24_reportLine("272", 3)
            RBS_CC_24_reportLine("273", 1)
            return input.ToStr() + " (" + rooibos_common_getSafeType(input) + ")"
        else
            RBS_CC_24_reportLine("274", 3)
            RBS_CC_24_reportLine("275", 1)
            return input.ToStr()
        end if
    else if RBS_CC_24_reportLine("277", 2) and (rooibos_common_isFloat(input) or rooibos_common_isDouble(input))
        RBS_CC_24_reportLine("277", 3)
        if RBS_CC_24_reportLine("278", 2) and (includeType)
            RBS_CC_24_reportLine("278", 3)
            RBS_CC_24_reportLine("279", 1)
            return Str(input).Trim() + " (" + rooibos_common_getSafeType(input) + ")"
        else
            RBS_CC_24_reportLine("280", 3)
            RBS_CC_24_reportLine("281", 1)
            return Str(input).Trim()
        end if
    else if RBS_CC_24_reportLine("283", 2) and (type(input) = "roSGNode")
        RBS_CC_24_reportLine("283", 3)
        RBS_CC_24_reportLine("284", 1)
        return "Node(" + input.subType() + ")"
    else if RBS_CC_24_reportLine("285", 2) and (type(input) = "roAssociativeArray")
        RBS_CC_24_reportLine("285", 3)
        RBS_CC_24_reportLine("286", 1)
        isFirst = true
        RBS_CC_24_reportLine("287", 1)
        text = "{"
        if RBS_CC_24_reportLine("288", 2) and (not isFirst)
            RBS_CC_24_reportLine("288", 3)
            RBS_CC_24_reportLine("289", 1)
            text = text + ","
            'bs:disable-next-line
            RBS_CC_24_reportLine("291", 1)
            isFirst = false
        end if
        RBS_CC_24_reportLine("293", 1)
        keys = input.ifAssociativeArray.keys()
        RBS_CC_24_reportLine("294", 1)
        keys.sort()
        RBS_CC_24_reportLine("295", 1): for each key in keys
            if RBS_CC_24_reportLine("296", 2) and (rooibos_common_canSafelyIterateAAKey(input, key))
                RBS_CC_24_reportLine("296", 3)
                RBS_CC_24_reportLine("297", 1)
                text = text + key + ":" + rooibos_common_asString(input[key], includeType)
            end if
        end for
        RBS_CC_24_reportLine("300", 1)
        text = text + "}"
        RBS_CC_24_reportLine("301", 1)
        return text
    else if RBS_CC_24_reportLine("302", 2) and (rooibos_common_isArray(input))
        RBS_CC_24_reportLine("302", 3)
        RBS_CC_24_reportLine("303", 1)
        text = "["
        RBS_CC_24_reportLine("304", 1)
        join = ""
        RBS_CC_24_reportLine("305", 1)
        maxLen = 500
        RBS_CC_24_reportLine("306", 1): for each v in input
            if RBS_CC_24_reportLine("307", 2) and (len(text) < maxLen)
                RBS_CC_24_reportLine("307", 3)
                RBS_CC_24_reportLine("308", 1)
                text += join + rooibos_common_asString(v, includeType)
                RBS_CC_24_reportLine("309", 1)
                join = ", "
            end if
        end for
        if RBS_CC_24_reportLine("312", 2) and (len(text) > maxLen)
            RBS_CC_24_reportLine("312", 3)
            RBS_CC_24_reportLine("313", 1)
            text = left(text, maxLen - 3) + "..."
        end if
        RBS_CC_24_reportLine("315", 1)
        text = text + "]"
        RBS_CC_24_reportLine("316", 1)
        return text
    else if RBS_CC_24_reportLine("317", 2) and (rooibos_common_isFunction(input))
        RBS_CC_24_reportLine("317", 3)
        RBS_CC_24_reportLine("318", 1)
        return input.toStr() + "(function)"
    else
        RBS_CC_24_reportLine("319", 3)
        RBS_CC_24_reportLine("320", 1)
        return ""
    end if
end function

' convert input to Integer if this possible, else return 0
' @param {Dynamic} input - value to check
' @returns {Integer} - converted Integer
function rooibos_common_asInteger(input) as integer
    if RBS_CC_24_reportLine("328", 2) and (rooibos_common_isValid(input) = false)
        RBS_CC_24_reportLine("328", 3)
        RBS_CC_24_reportLine("329", 1)
        return 0
    else if RBS_CC_24_reportLine("330", 2) and (rooibos_common_isString(input))
        RBS_CC_24_reportLine("330", 3)
        RBS_CC_24_reportLine("331", 1)
        return input.ToInt()
    else if RBS_CC_24_reportLine("332", 2) and (rooibos_common_isInteger(input))
        RBS_CC_24_reportLine("332", 3)
        RBS_CC_24_reportLine("333", 1)
        return input
    else if RBS_CC_24_reportLine("334", 2) and (rooibos_common_isFloat(input) or rooibos_common_isDouble(input) or rooibos_common_isLongInteger(input))
        RBS_CC_24_reportLine("334", 3)
        RBS_CC_24_reportLine("335", 1)
        return Int(input)
    else
        RBS_CC_24_reportLine("336", 3)
        RBS_CC_24_reportLine("337", 1)
        return 0
    end if
end function

' convert input to LongInteger if this possible, else return 0
' @param {Dynamic} input - value to check
' @returns {Integer} - converted LongInteger
function rooibos_common_asLongInteger(input) as longinteger
    if RBS_CC_24_reportLine("345", 2) and (rooibos_common_isValid(input) = false)
        RBS_CC_24_reportLine("345", 3)
        RBS_CC_24_reportLine("346", 1)
        return 0
    else if RBS_CC_24_reportLine("347", 2) and (rooibos_common_isString(input))
        RBS_CC_24_reportLine("347", 3)
        RBS_CC_24_reportLine("348", 1)
        return rooibos_common_asInteger(input)
    else if RBS_CC_24_reportLine("349", 2) and (rooibos_common_isLongInteger(input) or rooibos_common_isFloat(input) or rooibos_common_isDouble(input) or rooibos_common_isInteger(input))
        RBS_CC_24_reportLine("349", 3)
        RBS_CC_24_reportLine("350", 1)
        return input
    else
        RBS_CC_24_reportLine("351", 3)
        RBS_CC_24_reportLine("352", 1)
        return 0
    end if
end function

' convert input to Float if this possible, else return 0.0
' @param {Dynamic} input - value to check
' @returns {Float} - converted Float
function rooibos_common_asFloat(input) as float
    if RBS_CC_24_reportLine("360", 2) and (rooibos_common_isValid(input) = false)
        RBS_CC_24_reportLine("360", 3)
        RBS_CC_24_reportLine("361", 1)
        return 0.0
    else if RBS_CC_24_reportLine("362", 2) and (rooibos_common_isString(input))
        RBS_CC_24_reportLine("362", 3)
        RBS_CC_24_reportLine("363", 1)
        return input.ToFloat()
    else if RBS_CC_24_reportLine("364", 2) and (rooibos_common_isInteger(input))
        RBS_CC_24_reportLine("364", 3)
        RBS_CC_24_reportLine("365", 1)
        return (input / 1)
    else if RBS_CC_24_reportLine("366", 2) and (rooibos_common_isFloat(input) or rooibos_common_isDouble(input) or rooibos_common_isLongInteger(input))
        RBS_CC_24_reportLine("366", 3)
        RBS_CC_24_reportLine("367", 1)
        return input
    else
        RBS_CC_24_reportLine("368", 3)
        RBS_CC_24_reportLine("369", 1)
        return 0.0
    end if
end function

' convert input to Double if this possible, else return 0.0
' @param {Dynamic} input - value to check
' @returns {Float} - converted Double
function rooibos_common_asDouble(input) as double
    if RBS_CC_24_reportLine("377", 2) and (rooibos_common_isValid(input) = false)
        RBS_CC_24_reportLine("377", 3)
        RBS_CC_24_reportLine("378", 1)
        return 0.0
    else if RBS_CC_24_reportLine("379", 2) and (rooibos_common_isString(input))
        RBS_CC_24_reportLine("379", 3)
        RBS_CC_24_reportLine("380", 1)
        return rooibos_common_asFloat(input)
    else if RBS_CC_24_reportLine("381", 2) and (rooibos_common_isInteger(input) or rooibos_common_isLongInteger(input) or rooibos_common_isFloat(input) or rooibos_common_isDouble(input))
        RBS_CC_24_reportLine("381", 3)
        RBS_CC_24_reportLine("382", 1)
        return input
    else
        RBS_CC_24_reportLine("383", 3)
        RBS_CC_24_reportLine("384", 1)
        return 0.0
    end if
end function

' convert input to Boolean if this possible, else return False
' @param {Dynamic} input - value to check
' @returns {Boolean} - converted boolean
function rooibos_common_asBoolean(input) as boolean
    if RBS_CC_24_reportLine("392", 2) and (rooibos_common_isValid(input) = false)
        RBS_CC_24_reportLine("392", 3)
        RBS_CC_24_reportLine("393", 1)
        return false
    else if RBS_CC_24_reportLine("394", 2) and (rooibos_common_isString(input))
        RBS_CC_24_reportLine("394", 3)
        RBS_CC_24_reportLine("395", 1)
        return LCase(input) = "true"
    else if RBS_CC_24_reportLine("396", 2) and (rooibos_common_isInteger(input) or rooibos_common_isFloat(input))
        RBS_CC_24_reportLine("396", 3)
        RBS_CC_24_reportLine("397", 1)
        return input <> 0
    else if RBS_CC_24_reportLine("398", 2) and (rooibos_common_isBoolean(input))
        RBS_CC_24_reportLine("398", 3)
        RBS_CC_24_reportLine("399", 1)
        return input
    else
        RBS_CC_24_reportLine("400", 3)
        RBS_CC_24_reportLine("401", 1)
        return false
    end if
end function

' if type of value equals array return value, else return array with one element [value]
' @param {Dynamic} value - value to check
' @returns {Array} - converted array
function rooibos_common_asArray(value) as object
    if RBS_CC_24_reportLine("409", 2) and (rooibos_common_isValid(value))
        RBS_CC_24_reportLine("409", 3)
        if RBS_CC_24_reportLine("410", 2) and (not rooibos_common_isArray(value))
            RBS_CC_24_reportLine("410", 3)
            RBS_CC_24_reportLine("411", 1)
            return [
                value
            ]
        else
            RBS_CC_24_reportLine("414", 3)
            RBS_CC_24_reportLine("415", 1)
            return value
        end if
    end if
    RBS_CC_24_reportLine("418", 1)
    return []
end function
'=====================
' Strings
'=====================

' check if value is invalid or empty
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value is null or empty string, else return false
function rooibos_common_isNullOrEmpty(value) as boolean
    if RBS_CC_24_reportLine("428", 2) and (rooibos_common_isString(value))
        RBS_CC_24_reportLine("428", 3)
        RBS_CC_24_reportLine("429", 1)
        return Len(value) = 0
    else
        RBS_CC_24_reportLine("430", 3)
        RBS_CC_24_reportLine("431", 1)
        return not rooibos_common_isValid(value)
    end if
end function
'=====================
' Arrays
'=====================

' find an element index in array
' @param {Dynamic} array - array to search
' @param {Dynamic} value - value to check
' @param {Dynamic} compareAttribute - attribue to use for comparisons
' @param {Boolean} caseSensitive - indicates if comparisons are case sensitive
' @returns {Integer} - element index if array contains a value, else return -1
function rooibos_common_findElementIndexInArray(array, value, compareAttribute = invalid, caseSensitive = false, callCount = 0) as integer
    if RBS_CC_24_reportLine("445", 2) and (callCount = 0 and not rooibos_common_isArray(array))
        RBS_CC_24_reportLine("445", 3)
        RBS_CC_24_reportLine("446", 1)
        array = rooibos_common_asArray(array)
    end if
    if RBS_CC_24_reportLine("448", 2) and (rooibos_common_isArray(array))
        RBS_CC_24_reportLine("448", 3)
        RBS_CC_24_reportLine("449", 1): for i = 0 to rooibos_common_asArray(array).Count() - 1
            RBS_CC_24_reportLine("450", 1)
            compareValue = array[i]
            if RBS_CC_24_reportLine("451", 2) and (compareAttribute <> invalid and rooibos_common_isAssociativeArray(compareValue))
                RBS_CC_24_reportLine("451", 3)
                RBS_CC_24_reportLine("452", 1)
                compareValue = compareValue.ifAssociativeArray.lookupCI(compareAttribute)
            end if
            if RBS_CC_24_reportLine("454", 2) and (rooibos_common_eqValues(compareValue, value, callCount + 1))
                RBS_CC_24_reportLine("454", 3)
                RBS_CC_24_reportLine("455", 1)
                return i
            end if
        next
    end if
    RBS_CC_24_reportLine("459", 1)
    return -1
end function

' check if array contains specified value
' @param {Dynamic} array - array to search in
' @param {Dynamic} value - value to check
' @param {Dynamic} compareAttribute - attribute to compare on
' @returns {Boolean} - true if array contains a value, else return false
function rooibos_common_arrayContains(array, value, compareAttribute = invalid) as boolean
    RBS_CC_24_reportLine("468", 1)
    return (rooibos_common_findElementIndexInArray(array, value, compareAttribute) > -1)
end function
'=====================
' NODES
'=====================

' find an element index in node
' @param {Dynamic} node - node to search in
' @param {Dynamic} value - child to search for
' @returns {Integer} - element index if node contains a value, else return -1
function rooibos_common_findElementIndexInNode(node, value) as integer
    if RBS_CC_24_reportLine("479", 2) and (type(node) = "roSGNode")
        RBS_CC_24_reportLine("479", 3)
        if RBS_CC_24_reportLine("480", 2) and (node.isSubType("mc_Node"))
            RBS_CC_24_reportLine("480", 3)
            RBS_CC_24_reportLine("481", 1): for i = 0 to node.length - 1
                RBS_CC_24_reportLine("482", 1)
                compareValue = node.callfunc("getChild", i)
                if RBS_CC_24_reportLine("483", 2) and (type(compareValue) = "roSGNode" and compareValue.isSameNode(value))
                    RBS_CC_24_reportLine("483", 3)
                    RBS_CC_24_reportLine("484", 1)
                    return i
                end if
            end for
        else
            RBS_CC_24_reportLine("487", 3)
            RBS_CC_24_reportLine("488", 1): for i = 0 to node.getChildCount() - 1
                RBS_CC_24_reportLine("489", 1)
                compareValue = node.getChild(i)
                if RBS_CC_24_reportLine("490", 2) and (type(compareValue) = "roSGNode" and compareValue.isSameNode(value))
                    RBS_CC_24_reportLine("490", 3)
                    RBS_CC_24_reportLine("491", 1)
                    return i
                end if
            end for
        end if
    end if
    RBS_CC_24_reportLine("496", 1)
    return -1
end function

' check if node contains specified child
' @param {Dynamic} node - the node to check on
' @param {Dynamic} value - child to look for
' @returns {Boolean} - true if node contains a value, else return false
function rooibos_common_nodeContains(node, value) as boolean
    RBS_CC_24_reportLine("504", 1)
    return (rooibos_common_findElementIndexInNode(node, value) > -1)
end function

function rooibos_common_getSafeType(v)
    RBS_CC_24_reportLine("508", 1)
    t = type(v)
    if RBS_CC_24_reportLine("509", 2) and (t = "")
        RBS_CC_24_reportLine("509", 3)
        RBS_CC_24_reportLine("510", 1)
        return invalid
    else if RBS_CC_24_reportLine("511", 2) and (t = "<uninitialized>")
        RBS_CC_24_reportLine("511", 3)
        RBS_CC_24_reportLine("512", 1)
        return "<uninitialized>"
    else if RBS_CC_24_reportLine("513", 2) and (t = "roString")
        RBS_CC_24_reportLine("513", 3)
        RBS_CC_24_reportLine("514", 1)
        return "String"
    else if RBS_CC_24_reportLine("515", 2) and (t = "roInteger")
        RBS_CC_24_reportLine("515", 3)
        RBS_CC_24_reportLine("516", 1)
        return "Integer"
    else if RBS_CC_24_reportLine("517", 2) and (t = "roBoolean")
        RBS_CC_24_reportLine("517", 3)
        RBS_CC_24_reportLine("518", 1)
        return "Boolean"
    else if RBS_CC_24_reportLine("519", 2) and (t = "roBool")
        RBS_CC_24_reportLine("519", 3)
        RBS_CC_24_reportLine("520", 1)
        return "Boolean"
    else if RBS_CC_24_reportLine("521", 2) and (t = "roInt")
        RBS_CC_24_reportLine("521", 3)
        RBS_CC_24_reportLine("522", 1)
        return "Integer"
    else if RBS_CC_24_reportLine("523", 2) and (t = "roList")
        RBS_CC_24_reportLine("523", 3)
        RBS_CC_24_reportLine("524", 1)
        return "List"
    else if RBS_CC_24_reportLine("525", 2) and (t = "roFloat")
        RBS_CC_24_reportLine("525", 3)
        RBS_CC_24_reportLine("526", 1)
        return "Float"
    else if RBS_CC_24_reportLine("527", 2) and (t = "roDouble")
        RBS_CC_24_reportLine("527", 3)
        RBS_CC_24_reportLine("528", 1)
        return "Double"
    else if RBS_CC_24_reportLine("529", 2) and (t = "roInvalid")
        RBS_CC_24_reportLine("529", 3)
        RBS_CC_24_reportLine("530", 1)
        return "Invalid"
    else
        RBS_CC_24_reportLine("531", 3)
        RBS_CC_24_reportLine("532", 1)
        return t
    end if
end function

' Takes a value and if the value is not a primitive it will wrap the type in a Component: tag like the debugger does
' @param {Dynamic} value - value to check the type of
' @param {Boolean} includeSubtype - If true and the value is a node the result will include the node subtype
' @returns {string} - Formatted result. Examples: 'String', 'Integer', '<Component: roDateTime>', '<Component: roSGNode:Node>'
function rooibos_common_getTypeWithComponentWrapper(value, includeSubtype = false) as string
    if RBS_CC_24_reportLine("541", 2) and (not rooibos_common_isValid(value) or rooibos_common_isNumber(value) or rooibos_common_isString(value) or rooibos_common_isBoolean(value))
        RBS_CC_24_reportLine("541", 3)
        RBS_CC_24_reportLine("542", 1)
        return type(value)
    else
        RBS_CC_24_reportLine("543", 3)
        if RBS_CC_24_reportLine("544", 2) and (includeSubtype and rooibos_common_isSGNode(value))
            RBS_CC_24_reportLine("544", 3)
            RBS_CC_24_reportLine("545", 1)
            return ("<Component: " + bslib_toString(type(value)) + ":" + bslib_toString(value.subType()) + ">")
        else
            RBS_CC_24_reportLine("546", 3)
            RBS_CC_24_reportLine("547", 1)
            return ("<Component: " + bslib_toString(type(value)) + ">")
        end if
    end if
end function

' Takes a string and formats and truncates a string for more compact printing.
' @param {Dynamic} value - string to format
' @param {Integer} maxLength - the max length of the resulting string
' @param {Boolean} collapseNewlines - Will convert newlines and spaces into a single space
' @returns {String} - Formatted result
function rooibos_common_truncateString(value as string, length = 38 as integer, collapseNewlines = true as boolean) as string
    if RBS_CC_24_reportLine("558", 2) and (collapseNewlines)
        RBS_CC_24_reportLine("558", 3)
        RBS_CC_24_reportLine("559", 1)
        value = CreateObject("roRegex", "\n\s*", "g").replaceAll(value, " ")
    end if
    if RBS_CC_24_reportLine("561", 2) and (len(value) > length)
        RBS_CC_24_reportLine("561", 3)
        RBS_CC_24_reportLine("562", 1)
        value = value.mid(0, length - 1) + "…"
    end if
    RBS_CC_24_reportLine("564", 1)
    return value
end function

' Compare two arbitrary values to each-other.
' @param {Dynamic} Value1 - first item to compare
' @param {Dynamic} Value2 - second item to compare
' @returns {boolean} - True if values are equal or False in other case.
function rooibos_common_eqValues(Value1, Value2, fuzzy = false, callCount = 0) as dynamic
    if RBS_CC_24_reportLine("572", 2) and (callCount > 10)
        RBS_CC_24_reportLine("572", 3)
        RBS_CC_24_reportLine("573", 1)
        rooibos_common_logError("REACHED MAX ITERATIONS DOING COMPARISON")
        RBS_CC_24_reportLine("574", 1)
        return true
    end if
    ' Workaround for bug with string boxing, and box everything else
    RBS_CC_24_reportLine("577", 1)
    val1Type = rooibos_common_getSafeType(Value1)
    RBS_CC_24_reportLine("578", 1)
    val2Type = rooibos_common_getSafeType(Value2)
    if RBS_CC_24_reportLine("579", 2) and (val1Type = invalid or val2Type = invalid)
        RBS_CC_24_reportLine("579", 3)
        RBS_CC_24_reportLine("580", 1)
        rooibos_common_logError("undefined value passed")
        RBS_CC_24_reportLine("581", 1)
        return false
    end if
    'Upcast int to float, if other is float
    if RBS_CC_24_reportLine("584", 2) and (val1Type = "Float" and val2Type = "Integer")
        RBS_CC_24_reportLine("584", 3)
        RBS_CC_24_reportLine("585", 1)
        Value2 = cdbl(Value2)
    else if RBS_CC_24_reportLine("586", 2) and (val2Type = "Float" and val1Type = "Integer")
        RBS_CC_24_reportLine("586", 3)
        RBS_CC_24_reportLine("587", 1)
        Value1 = cdbl(Value1)
    end if
    if RBS_CC_24_reportLine("589", 2) and (val1Type <> val2Type and (fuzzy <> true or val1Type = "String" or val2Type = "String"))
        RBS_CC_24_reportLine("589", 3)
        RBS_CC_24_reportLine("590", 1)
        return false
    else
        RBS_CC_24_reportLine("591", 3)
        RBS_CC_24_reportLine("592", 1)
        valtype = val1Type
        if RBS_CC_24_reportLine("593", 2) and (val1Type = "List")
            RBS_CC_24_reportLine("593", 3)
            RBS_CC_24_reportLine("594", 1)
            return rooibos_common_eqArray(Value1, Value2, fuzzy, callCount + 1)
        else if RBS_CC_24_reportLine("595", 2) and (valtype = "roAssociativeArray")
            RBS_CC_24_reportLine("595", 3)
            RBS_CC_24_reportLine("596", 1)
            return rooibos_common_eqAssocArray(Value1, Value2, fuzzy, callCount + 1)
        else if RBS_CC_24_reportLine("597", 2) and (valtype = "roArray")
            RBS_CC_24_reportLine("597", 3)
            RBS_CC_24_reportLine("598", 1)
            return rooibos_common_eqArray(Value1, Value2, fuzzy, callCount + 1)
        else if RBS_CC_24_reportLine("599", 2) and (valtype = "roSGNode")
            RBS_CC_24_reportLine("599", 3)
            if RBS_CC_24_reportLine("600", 2) and (val2Type <> "roSGNode")
                RBS_CC_24_reportLine("600", 3)
                RBS_CC_24_reportLine("601", 1)
                return false
            else
                RBS_CC_24_reportLine("602", 3)
                RBS_CC_24_reportLine("603", 1)
                return Value1.isSameNode(Value2)
            end if
        else if RBS_CC_24_reportLine("605", 2) and (valtype = "<uninitialized>" and val2Type = "<uninitialized>")
            RBS_CC_24_reportLine("605", 3)
            ' Both values are uninitialized, so they are equal
            RBS_CC_24_reportLine("607", 1)
            return true
        else if RBS_CC_24_reportLine("608", 2) and (valtype = "<uninitialized>" or val2Type = "<uninitialized>")
            RBS_CC_24_reportLine("608", 3)
            ' One value is uninitialized, so they are not equal due to passing previous check
            RBS_CC_24_reportLine("610", 1)
            return false
        else
            RBS_CC_24_reportLine("611", 3)
            if RBS_CC_24_reportLine("612", 2) and (fuzzy = true)
                RBS_CC_24_reportLine("612", 3)
                RBS_CC_24_reportLine("613", 1)
                return rooibos_common_asString(Value1) = rooibos_common_asString(Value2)
            else
                RBS_CC_24_reportLine("614", 3)
                'If you crashed on this line, then you're trying to compare
                '2 things which can't be compared - check what value1 and value2
                'are in your debug log
                RBS_CC_24_reportLine("618", 1)
                return Value1 = Value2
            end if
        end if
    end if
end function

function rooibos_common_eqTypes(Value1, Value2) as dynamic
    RBS_CC_24_reportLine("625", 1)
    val1Type = rooibos_common_getSafeType(Value1)
    RBS_CC_24_reportLine("626", 1)
    val2Type = rooibos_common_getSafeType(Value2)
    if RBS_CC_24_reportLine("627", 2) and (val1Type = invalid or val2Type = invalid)
        RBS_CC_24_reportLine("627", 3)
        ' TODO: this doesn't actually feel like an error, Need to talk about this.
        RBS_CC_24_reportLine("629", 1)
        rooibos_common_logError("undefined value passed")
        RBS_CC_24_reportLine("630", 1)
        return false
    end if
    'Upcast int to float, if other is float
    if RBS_CC_24_reportLine("633", 2) and (val1Type = "Float" and val2Type = "Integer")
        RBS_CC_24_reportLine("633", 3)
        RBS_CC_24_reportLine("634", 1)
        Value2 = cdbl(Value2)
    else if RBS_CC_24_reportLine("635", 2) and (val2Type = "Float" and val1Type = "Integer")
        RBS_CC_24_reportLine("635", 3)
        RBS_CC_24_reportLine("636", 1)
        Value1 = cdbl(Value1)
    end if
    RBS_CC_24_reportLine("638", 1)
    return val1Type <> val2Type
end function

' Compare to roAssociativeArray objects for equality.
' @param {Dynamic} Value1 - first associative array
' @param {Dynamic} Value2 - second associative array
' @returns {boolean} - True if arrays are equal or False in other case.
function rooibos_common_eqAssocArray(Value1, Value2, fuzzy = false, callCount = 0) as dynamic
    if RBS_CC_24_reportLine("646", 2) and (not rooibos_common_isAssociativeArray(Value1) or not rooibos_common_isAssociativeArray(Value2))
        RBS_CC_24_reportLine("646", 3)
        RBS_CC_24_reportLine("647", 1)
        return false
    end if
    RBS_CC_24_reportLine("649", 1)
    l1 = Value1.ifAssociativeArray.Count()
    RBS_CC_24_reportLine("650", 1)
    l2 = Value2.ifAssociativeArray.Count()
    if RBS_CC_24_reportLine("651", 2) and (not l1 = l2)
        RBS_CC_24_reportLine("651", 3)
        RBS_CC_24_reportLine("652", 1)
        return false
    else
        RBS_CC_24_reportLine("653", 3)
        RBS_CC_24_reportLine("654", 1): for each k in Value1
            if RBS_CC_24_reportLine("655", 2) and (not Value2.ifAssociativeArray.DoesExist(k))
                RBS_CC_24_reportLine("655", 3)
                RBS_CC_24_reportLine("656", 1)
                return false
            else
                RBS_CC_24_reportLine("657", 3)
                if RBS_CC_24_reportLine("658", 2) and (rooibos_common_canSafelyIterateAAKey(Value1, k) and rooibos_common_canSafelyIterateAAKey(Value2, k))
                    RBS_CC_24_reportLine("658", 3)
                    RBS_CC_24_reportLine("659", 1)
                    v1 = Value1[k]
                    RBS_CC_24_reportLine("660", 1)
                    v2 = Value2[k]
                    if RBS_CC_24_reportLine("661", 2) and (not rooibos_common_eqValues(v1, v2, fuzzy, callCount + 1))
                        RBS_CC_24_reportLine("661", 3)
                        RBS_CC_24_reportLine("662", 1)
                        return false
                    end if
                end if
            end if
        end for
        RBS_CC_24_reportLine("667", 1)
        return true
    end if
end function

function rooibos_common_canSafelyIterateAAKey(aa, key) as boolean
    if RBS_CC_24_reportLine("672", 2) and (lcase(key) = "__rooibosskipfields" or key = "__mocks" or key = "__stubs" or key = "log" or key = "top" or key = "m")
        RBS_CC_24_reportLine("672", 3) 'fix infinite loop/box crash when doing equals on an aa with a mock
        RBS_CC_24_reportLine("673", 1)
        return false
    else if RBS_CC_24_reportLine("674", 2) and (aa.__rooibosSkipFields <> invalid and aa.__rooibosSkipFields.doesExist(key))
        RBS_CC_24_reportLine("674", 3)
        RBS_CC_24_reportLine("675", 1)
        return false
    end if
    RBS_CC_24_reportLine("677", 1)
    return true
end function

' Compare to roArray objects for equality.
' @param {Dynamic} Value1 - first array
' @param {Dynamic} Value2 - second array
' @returns {boolean} - True if arrays are equal or False in other case.
function rooibos_common_eqArray(Value1, Value2, fuzzy = false, callCount = 0) as dynamic
    if RBS_CC_24_reportLine("685", 2) and (callCount > 30)
        RBS_CC_24_reportLine("685", 3)
        RBS_CC_24_reportLine("686", 1)
        rooibos_common_logError("REACHED MAX ITERATIONS DOING COMPARISON")
        RBS_CC_24_reportLine("687", 1)
        return true
    end if
    if RBS_CC_24_reportLine("689", 2) and (not (rooibos_common_isArray(Value1)) or not rooibos_common_isArray(Value2))
        RBS_CC_24_reportLine("689", 3)
        RBS_CC_24_reportLine("690", 1)
        return false
    end if
    RBS_CC_24_reportLine("692", 1)
    l1 = Value1.Count()
    RBS_CC_24_reportLine("693", 1)
    l2 = Value2.Count()
    if RBS_CC_24_reportLine("694", 2) and (not l1 = l2)
        RBS_CC_24_reportLine("694", 3)
        RBS_CC_24_reportLine("695", 1)
        return false
    else
        RBS_CC_24_reportLine("696", 3)
        RBS_CC_24_reportLine("697", 1): for i = 0 to l1 - 1
            RBS_CC_24_reportLine("698", 1)
            v1 = Value1[i]
            RBS_CC_24_reportLine("699", 1)
            v2 = Value2[i]
            if RBS_CC_24_reportLine("700", 2) and (not rooibos_common_eqValues(v1, v2, fuzzy, callCount + 1))
                RBS_CC_24_reportLine("700", 3)
                RBS_CC_24_reportLine("701", 1)
                return false
            end if
        end for
        RBS_CC_24_reportLine("704", 1)
        return true
    end if
end function

' Fills text with count of fillChars
' @param {string} text - text to fill
' @param {string} fillChar - char to fill with
' @param {integer} numChars - target length
' @returns {string} filled string
function rooibos_common_fillText(text as string, fillChar = " ", numChars = 40) as string
    if RBS_CC_24_reportLine("714", 2) and (len(text) >= numChars)
        RBS_CC_24_reportLine("714", 3)
        RBS_CC_24_reportLine("715", 1)
        text = left(text, numChars - 5) + "..." + fillChar + fillChar
    else
        RBS_CC_24_reportLine("716", 3)
        RBS_CC_24_reportLine("717", 1)
        numToFill = numChars - len(text) - 1
        RBS_CC_24_reportLine("718", 1): for i = 0 to numToFill
            RBS_CC_24_reportLine("719", 1)
            text = text + fillChar
        end for
    end if
    RBS_CC_24_reportLine("722", 1)
    return text
end function

function rooibos_common_makePathStubbable(content as dynamic, path as string)
    RBS_CC_24_reportLine("726", 1)
    part = invalid
    if RBS_CC_24_reportLine("727", 2) and (path <> invalid)
        RBS_CC_24_reportLine("727", 3)
        RBS_CC_24_reportLine("728", 1)
        parts = path.split(".")
        RBS_CC_24_reportLine("729", 1)
        numParts = parts.count()
        RBS_CC_24_reportLine("730", 1)
        i = 0
        RBS_CC_24_reportLine("731", 1)
        contentName = parts[i]
        RBS_CC_24_reportLine("732", 1)
        i++
        if RBS_CC_24_reportLine("733", 2) and (type(content) <> "roAssociativeArray")
            RBS_CC_24_reportLine("733", 3)
            RBS_CC_24_reportLine("734", 1)
            content = {
                id: contentName
            }
        end if
        RBS_CC_24_reportLine("738", 1)
        part = content
        RBS_CC_24_reportLine("739", 1): while i < numParts and part <> invalid
            RBS_CC_24_reportLine("740", 1)
            isIndexNumber = parts[i] = "0" or (parts[i].toInt() <> 0 and parts[i].toInt().toStr() = parts[i])
            RBS_CC_24_reportLine("741", 1)
            index = invalid
            if RBS_CC_24_reportLine("742", 2) and (isIndexNumber)
                RBS_CC_24_reportLine("742", 3)
                RBS_CC_24_reportLine("743", 1)
                index = parts[i].toInt()
            else
                RBS_CC_24_reportLine("744", 3)
                RBS_CC_24_reportLine("745", 1)
                index = parts[i]
            end if
            RBS_CC_24_reportLine("747", 1)
            nextPart = invalid
            if RBS_CC_24_reportLine("748", 2) and (rooibos_common_isArray(part) and isIndexNumber)
                RBS_CC_24_reportLine("748", 3)
                RBS_CC_24_reportLine("749", 1)
                nextPart = part[index]
            else if RBS_CC_24_reportLine("750", 2) and (type(part) = "roAssociativeArray" and not isIndexNumber)
                RBS_CC_24_reportLine("750", 3)
                RBS_CC_24_reportLine("751", 1)
                nextPart = part[index]
            end if
            if RBS_CC_24_reportLine("753", 2) and (nextPart = invalid or type(nextPart) <> "roAssociativeArray")
                RBS_CC_24_reportLine("753", 3)
                if RBS_CC_24_reportLine("754", 2) and ((not isIndexNumber and type(part) = "roAssociativeArray") or (isIndexNumber and (rooibos_common_isArray(part))))
                    RBS_CC_24_reportLine("754", 3)
                    RBS_CC_24_reportLine("755", 1)
                    nextPart = {
                        id: index
                    }
                    RBS_CC_24_reportLine("758", 1)
                    part[index] = nextPart
                else
                    RBS_CC_24_reportLine("759", 3)
                    'index type mismatch, gonna have to bail
                    RBS_CC_24_reportLine("761", 1)
                    return content
                end if
            end if
            RBS_CC_24_reportLine("764", 1)
            part = nextPart
            RBS_CC_24_reportLine("765", 1)
            i++
        end while
    end if
    RBS_CC_24_reportLine("768", 1)
    return part
end function

' @ignore
sub rooibos_common_logError(value)
    RBS_CC_24_reportLine("773", 1)
    ? "[Rooibos Error]: " value
end sub

' @ignore
sub rooibos_common_logWarning(value)
end sub

' @ignore
sub rooibos_common_logInfo(value)
    RBS_CC_24_reportLine("782", 1)
    ? "[Rooibos Info]: " value
end sub

' @ignore
sub rooibos_common_logDebug(value)
end sub

' @ignore
sub rooibos_common_logTrace(value)
end sub

'//# sourceMappingURL=./CommonUtils.brs.map
function RBS_CC_24_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "24"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "24"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./CommonUtils.brs.map