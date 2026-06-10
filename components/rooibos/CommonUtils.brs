' ******************
' Common utility functions
' ******************

' check if value contains XMLElement interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains XMLElement interface, else return false
function rooibos_common_isXmlElement(value) as boolean
    return rooibos_common_isValid(value) and GetInterface(value, "ifXMLElement") <> invalid
end function

' check if value contains Function interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains Function interface, else return false
function rooibos_common_isFunction(value) as boolean
    return rooibos_common_isValid(value) and GetInterface(value, "ifFunction") <> invalid
end function

' looks up the function by name, for the function map
' @param {filename} string - name of the file where the function was found
' @param {String} functionName - name of the function to locate
' @returns {Function} - function pointer or invalid
function rooibos_common_getFunction(filename, functionName) as object
    if not rooibos_common_isNotEmptyString(functionName)
        return invalid
    end if
    if not rooibos_common_isNotEmptyString(filename)
        return invalid
    end if
    'bs:disable-next-line
    mapFunction = RBSFM_getFunctionsForFile(filename)
    'bs:disable-next-line
    if mapFunction <> invalid
        'bs:disable-next-line
        map = mapFunction()
        'bs:disable-next-line
        if type(map) = "roAssociativeArray"
            'bs:disable-next-line
            functionPointer = map[functionName]
            'bs:disable-next-linenrb
            return functionPointer
        else
            return invalid
        end if
    end if
    return invalid
end function

' looks up the function by name, from any function map
'            in future
' @param {filename} string - name of the file where the function was found
' @param {String} functionName - name of the function to locate
' @returns {Function} - function pointer or invalid
function rooibos_common_getFunctionBruteForce(functionName) as object
    if not rooibos_common_isNotEmptyString(functionName)
        return invalid
    end if
    'bs:disable-next-line
    filenames = RBSFM_getFilenames()
    for i = 0 to filenames.count() - 1
        filename = filenames[i]
        'bs:disable-next-line
        mapFunction = RBSFM_getFunctionsForFile(filename)
        'bs:disable-next-line
        if mapFunction <> invalid
            'bs:disable-next-line
            map = mapFunction()
            'bs:disable-next-line
            if type(map) = "roAssociativeArray"
                'bs:disable-next-line
                functionPointer = map[functionName]
                'bs:disable-next-line
                if functionPointer <> invalid
                    'bs:disable-next-line
                    return functionPointer
                end if
            end if
        end if
    end for
    return invalid
end function

' check if value contains Boolean interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains Boolean interface, else return false
function rooibos_common_isBoolean(value) as boolean
    return rooibos_common_isValid(value) and GetInterface(value, "ifBoolean") <> invalid
end function

' check if value type equals Integer
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value type equals Integer, else return false
function rooibos_common_isInteger(value) as boolean
    return rooibos_common_isValid(value) and GetInterface(value, "ifInt") <> invalid and (Type(value) = "roInt" or Type(value) = "roInteger" or Type(value) = "Integer")
end function

' check if value contains Float interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains Float interface, else return false
function rooibos_common_isFloat(value) as boolean
    return rooibos_common_isValid(value) and GetInterface(value, "ifFloat") <> invalid
end function

' check if value contains Double interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains Double interface, else return false
function rooibos_common_isDouble(value) as boolean
    return rooibos_common_isValid(value) and GetInterface(value, "ifDouble") <> invalid
end function

' check if value contains LongInteger interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains LongInteger interface, else return false
function rooibos_common_isLongInteger(value) as boolean
    return rooibos_common_isValid(value) and GetInterface(value, "ifLongInt") <> invalid
end function

' check if value contains LongInteger or Integer or Double or Float interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value is number, else return false
function rooibos_common_isNumber(value) as boolean
    return rooibos_common_isLongInteger(value) or rooibos_common_isDouble(value) or rooibos_common_isInteger(value) or rooibos_common_isFloat(value)
end function

' check if value contains List interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains List interface, else return false
function rooibos_common_isList(value) as boolean
    return rooibos_common_isValid(value) and GetInterface(value, "ifList") <> invalid
end function

' check if value contains Array interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains Array interface, else return false
function rooibos_common_isArray(value) as boolean
    return rooibos_common_isValid(value) and GetInterface(value, "ifArray") <> invalid
end function

' check if value contains AssociativeArray interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains AssociativeArray interface, else return false
function rooibos_common_isAssociativeArray(value) as boolean
    return rooibos_common_isValid(value) and GetInterface(value, "ifAssociativeArray") <> invalid
end function

' check if value contains SGNodeChildren interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains SGNodeChildren interface, else return false
function rooibos_common_isSGNode(value) as boolean
    return rooibos_common_isValid(value) and GetInterface(value, "ifSGNodeChildren") <> invalid
end function

' check if value contains String interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains String interface, else return false
function rooibos_common_isString(value) as boolean
    return rooibos_common_isValid(value) and GetInterface(value, "ifString") <> invalid
end function

' check if value contains String interface and length more 0
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains String interface and length more 0, else return false
function rooibos_common_isNotEmptyString(value) as boolean
    return rooibos_common_isString(value) and len(value) > 0
end function

' check if value contains DateTime interface
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value contains DateTime interface, else return false
function rooibos_common_isDateTime(value) as boolean
    return rooibos_common_isValid(value) and (GetInterface(value, "ifDateTime") <> invalid or Type(value) = "roDateTime")
end function

' check if value initialized and not equal invalid
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value initialized and not equal invalid, else return false
function rooibos_common_isValid(value) as boolean
    return not rooibos_common_isUndefined(value) and value <> invalid
end function

function rooibos_common_isUndefined(value) as boolean
    return type(value) = "" or Type(value) = "<uninitialized>"
end function

' return value if his contains String interface else return empty string
' @param {Dynamic} value - value to check
' @returns {String} - value if his contains String interface else return empty string
function rooibos_common_validStr(obj) as string
    if obj <> invalid and GetInterface(obj, "ifString") <> invalid
        return obj
    else
        return ""
    end if
end function

' /**
' convert input to multiline String if this possible, else return empty string
' @param {Dynamic} input - value to check
' @returns {String} - converted string
function rooibos_common_asMultilineString(input, includeType = false, indention = 0) as string
    indentChr = "  "
    if rooibos_common_isValid(input) = false
        return type(input)
    else if rooibos_common_isString(input)
        return formatJson(input)
    else if rooibos_common_isInteger(input) or rooibos_common_isLongInteger(input) or rooibos_common_isBoolean(input)
        if includeType
            return input.ToStr() + " (" + rooibos_common_getSafeType(input) + ")"
        else
            return input.ToStr()
        end if
    else if rooibos_common_isFloat(input) or rooibos_common_isDouble(input)
        if includeType
            return Str(input).Trim() + " (" + rooibos_common_getSafeType(input) + ")"
        else
            return Str(input).Trim()
        end if
    else if type(input) = "roSGNode"
        return "Node(" + input.subType() + ")"
    else if type(input) = "roAssociativeArray"
        if input.isEmpty()
            return "{" + chr(10) + string(indention, indentChr) + "}"
        end if
        text = "{" + chr(10)
        keys = input.ifAssociativeArray.keys()
        keys.sort()
        for each key in keys
            if rooibos_common_canSafelyIterateAAKey(input, key)
                text = text + string(indention + 1, indentChr) + formatJson(key) + ": " + rooibos_common_asMultilineString(input[key], includeType, indention + 1) + "," + chr(10)
            end if
        end for
        ' remove last comma
        if len(text) > 2
            text = left(text, len(text) - 2)
        end if
        text = text + chr(10) + string(indention, indentChr) + "}"
        return text
    else if rooibos_common_isArray(input)
        if input.isEmpty()
            return "[" + chr(10) + "]"
        end if
        text = "[" + chr(10)
        for i = 0 to input.count() - 1
            v = input[i]
            text += string(indention + 1, indentChr) + rooibos_common_asMultilineString(v, includeType, indention + 1)
            if i < input.count() - 1
                text += ","
            end if
            text += chr(10)
        end for
        text = text + string(indention, indentChr) + "]"
        return text
    else if rooibos_common_isFunction(input)
        return input.toStr().mid(10) + " (function)"
    else
        return ""
    end if
end function

' convert input to String if this possible, else return empty string
' @param {Dynamic} input - value to check
' @returns {String} - converted string
function rooibos_common_asString(input, includeType = false) as string
    if rooibos_common_isValid(input) = false
        return "INVALID"
    else if rooibos_common_isString(input)
        if includeType
            return """" + input + """"
        else
            return input
        end if
    else if rooibos_common_isInteger(input) or rooibos_common_isLongInteger(input) or rooibos_common_isBoolean(input)
        if includeType
            return input.ToStr() + " (" + rooibos_common_getSafeType(input) + ")"
        else
            return input.ToStr()
        end if
    else if rooibos_common_isFloat(input) or rooibos_common_isDouble(input)
        if includeType
            return Str(input).Trim() + " (" + rooibos_common_getSafeType(input) + ")"
        else
            return Str(input).Trim()
        end if
    else if type(input) = "roSGNode"
        return "Node(" + input.subType() + ")"
    else if type(input) = "roAssociativeArray"
        isFirst = true
        text = "{"
        if not isFirst
            text = text + ","
            'bs:disable-next-line
            isFirst = false
        end if
        keys = input.ifAssociativeArray.keys()
        keys.sort()
        for each key in keys
            if rooibos_common_canSafelyIterateAAKey(input, key)
                text = text + key + ":" + rooibos_common_asString(input[key], includeType)
            end if
        end for
        text = text + "}"
        return text
    else if rooibos_common_isArray(input)
        text = "["
        join = ""
        maxLen = 500
        for each v in input
            if len(text) < maxLen
                text += join + rooibos_common_asString(v, includeType)
                join = ", "
            end if
        end for
        if len(text) > maxLen
            text = left(text, maxLen - 3) + "..."
        end if
        text = text + "]"
        return text
    else if rooibos_common_isFunction(input)
        return input.toStr() + "(function)"
    else
        return ""
    end if
end function

' convert input to Integer if this possible, else return 0
' @param {Dynamic} input - value to check
' @returns {Integer} - converted Integer
function rooibos_common_asInteger(input) as integer
    if rooibos_common_isValid(input) = false
        return 0
    else if rooibos_common_isString(input)
        return input.ToInt()
    else if rooibos_common_isInteger(input)
        return input
    else if rooibos_common_isFloat(input) or rooibos_common_isDouble(input) or rooibos_common_isLongInteger(input)
        return Int(input)
    else
        return 0
    end if
end function

' convert input to LongInteger if this possible, else return 0
' @param {Dynamic} input - value to check
' @returns {Integer} - converted LongInteger
function rooibos_common_asLongInteger(input) as longinteger
    if rooibos_common_isValid(input) = false
        return 0
    else if rooibos_common_isString(input)
        return rooibos_common_asInteger(input)
    else if rooibos_common_isLongInteger(input) or rooibos_common_isFloat(input) or rooibos_common_isDouble(input) or rooibos_common_isInteger(input)
        return input
    else
        return 0
    end if
end function

' convert input to Float if this possible, else return 0.0
' @param {Dynamic} input - value to check
' @returns {Float} - converted Float
function rooibos_common_asFloat(input) as float
    if rooibos_common_isValid(input) = false
        return 0.0
    else if rooibos_common_isString(input)
        return input.ToFloat()
    else if rooibos_common_isInteger(input)
        return (input / 1)
    else if rooibos_common_isFloat(input) or rooibos_common_isDouble(input) or rooibos_common_isLongInteger(input)
        return input
    else
        return 0.0
    end if
end function

' convert input to Double if this possible, else return 0.0
' @param {Dynamic} input - value to check
' @returns {Float} - converted Double
function rooibos_common_asDouble(input) as double
    if rooibos_common_isValid(input) = false
        return 0.0
    else if rooibos_common_isString(input)
        return rooibos_common_asFloat(input)
    else if rooibos_common_isInteger(input) or rooibos_common_isLongInteger(input) or rooibos_common_isFloat(input) or rooibos_common_isDouble(input)
        return input
    else
        return 0.0
    end if
end function

' convert input to Boolean if this possible, else return False
' @param {Dynamic} input - value to check
' @returns {Boolean} - converted boolean
function rooibos_common_asBoolean(input) as boolean
    if rooibos_common_isValid(input) = false
        return false
    else if rooibos_common_isString(input)
        return LCase(input) = "true"
    else if rooibos_common_isInteger(input) or rooibos_common_isFloat(input)
        return input <> 0
    else if rooibos_common_isBoolean(input)
        return input
    else
        return false
    end if
end function

' if type of value equals array return value, else return array with one element [value]
' @param {Dynamic} value - value to check
' @returns {Array} - converted array
function rooibos_common_asArray(value) as object
    if rooibos_common_isValid(value)
        if not rooibos_common_isArray(value)
            return [
                value
            ]
        else
            return value
        end if
    end if
    return []
end function
'=====================
' Strings
'=====================

' check if value is invalid or empty
' @param {Dynamic} value - value to check
' @returns {Boolean} - true if value is null or empty string, else return false
function rooibos_common_isNullOrEmpty(value) as boolean
    if rooibos_common_isString(value)
        return Len(value) = 0
    else
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
    if callCount = 0 and not rooibos_common_isArray(array)
        array = rooibos_common_asArray(array)
    end if
    if rooibos_common_isArray(array)
        for i = 0 to rooibos_common_asArray(array).Count() - 1
            compareValue = array[i]
            if compareAttribute <> invalid and rooibos_common_isAssociativeArray(compareValue)
                compareValue = compareValue.ifAssociativeArray.lookupCI(compareAttribute)
            end if
            if rooibos_common_eqValues(compareValue, value, callCount + 1)
                return i
            end if
        next
    end if
    return -1
end function

' check if array contains specified value
' @param {Dynamic} array - array to search in
' @param {Dynamic} value - value to check
' @param {Dynamic} compareAttribute - attribute to compare on
' @returns {Boolean} - true if array contains a value, else return false
function rooibos_common_arrayContains(array, value, compareAttribute = invalid) as boolean
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
    if type(node) = "roSGNode"
        if node.isSubType("mc_Node")
            for i = 0 to node.length - 1
                compareValue = node.callfunc("getChild", i)
                if type(compareValue) = "roSGNode" and compareValue.isSameNode(value)
                    return i
                end if
            end for
        else
            for i = 0 to node.getChildCount() - 1
                compareValue = node.getChild(i)
                if type(compareValue) = "roSGNode" and compareValue.isSameNode(value)
                    return i
                end if
            end for
        end if
    end if
    return -1
end function

' check if node contains specified child
' @param {Dynamic} node - the node to check on
' @param {Dynamic} value - child to look for
' @returns {Boolean} - true if node contains a value, else return false
function rooibos_common_nodeContains(node, value) as boolean
    return (rooibos_common_findElementIndexInNode(node, value) > -1)
end function

function rooibos_common_getSafeType(v)
    t = type(v)
    if t = ""
        return invalid
    else if t = "<uninitialized>"
        return "<uninitialized>"
    else if t = "roString"
        return "String"
    else if t = "roInteger"
        return "Integer"
    else if t = "roBoolean"
        return "Boolean"
    else if t = "roBool"
        return "Boolean"
    else if t = "roInt"
        return "Integer"
    else if t = "roList"
        return "List"
    else if t = "roFloat"
        return "Float"
    else if t = "roDouble"
        return "Double"
    else if t = "roInvalid"
        return "Invalid"
    else
        return t
    end if
end function

' Takes a value and if the value is not a primitive it will wrap the type in a Component: tag like the debugger does
' @param {Dynamic} value - value to check the type of
' @param {Boolean} includeSubtype - If true and the value is a node the result will include the node subtype
' @returns {string} - Formatted result. Examples: 'String', 'Integer', '<Component: roDateTime>', '<Component: roSGNode:Node>'
function rooibos_common_getTypeWithComponentWrapper(value, includeSubtype = false) as string
    if not rooibos_common_isValid(value) or rooibos_common_isNumber(value) or rooibos_common_isString(value) or rooibos_common_isBoolean(value)
        return type(value)
    else
        if includeSubtype and rooibos_common_isSGNode(value)
            return ("<Component: " + bslib_toString(type(value)) + ":" + bslib_toString(value.subType()) + ">")
        else
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
    if collapseNewlines
        value = CreateObject("roRegex", "\n\s*", "g").replaceAll(value, " ")
    end if
    if len(value) > length
        value = value.mid(0, length - 1) + "…"
    end if
    return value
end function

' Compare two arbitrary values to each-other.
' @param {Dynamic} Value1 - first item to compare
' @param {Dynamic} Value2 - second item to compare
' @returns {boolean} - True if values are equal or False in other case.
function rooibos_common_eqValues(Value1, Value2, fuzzy = false, callCount = 0) as dynamic
    if callCount > 10
        rooibos_common_logError("REACHED MAX ITERATIONS DOING COMPARISON")
        return true
    end if
    ' Workaround for bug with string boxing, and box everything else
    val1Type = rooibos_common_getSafeType(Value1)
    val2Type = rooibos_common_getSafeType(Value2)
    if val1Type = invalid or val2Type = invalid
        rooibos_common_logError("undefined value passed")
        return false
    end if
    'Upcast int to float, if other is float
    if val1Type = "Float" and val2Type = "Integer"
        Value2 = cdbl(Value2)
    else if val2Type = "Float" and val1Type = "Integer"
        Value1 = cdbl(Value1)
    end if
    if val1Type <> val2Type and (fuzzy <> true or val1Type = "String" or val2Type = "String")
        return false
    else
        valtype = val1Type
        if val1Type = "List"
            return rooibos_common_eqArray(Value1, Value2, fuzzy, callCount + 1)
        else if valtype = "roAssociativeArray"
            return rooibos_common_eqAssocArray(Value1, Value2, fuzzy, callCount + 1)
        else if valtype = "roArray"
            return rooibos_common_eqArray(Value1, Value2, fuzzy, callCount + 1)
        else if valtype = "roSGNode"
            if val2Type <> "roSGNode"
                return false
            else
                return Value1.isSameNode(Value2)
            end if
        else if valtype = "<uninitialized>" and val2Type = "<uninitialized>"
            ' Both values are uninitialized, so they are equal
            return true
        else if valtype = "<uninitialized>" or val2Type = "<uninitialized>"
            ' One value is uninitialized, so they are not equal due to passing previous check
            return false
        else
            if fuzzy = true
                return rooibos_common_asString(Value1) = rooibos_common_asString(Value2)
            else
                'If you crashed on this line, then you're trying to compare
                '2 things which can't be compared - check what value1 and value2
                'are in your debug log
                return Value1 = Value2
            end if
        end if
    end if
end function

function rooibos_common_eqTypes(Value1, Value2) as dynamic
    val1Type = rooibos_common_getSafeType(Value1)
    val2Type = rooibos_common_getSafeType(Value2)
    if val1Type = invalid or val2Type = invalid
        ' TODO: this doesn't actually feel like an error, Need to talk about this.
        rooibos_common_logError("undefined value passed")
        return false
    end if
    'Upcast int to float, if other is float
    if val1Type = "Float" and val2Type = "Integer"
        Value2 = cdbl(Value2)
    else if val2Type = "Float" and val1Type = "Integer"
        Value1 = cdbl(Value1)
    end if
    return val1Type <> val2Type
end function

' Compare to roAssociativeArray objects for equality.
' @param {Dynamic} Value1 - first associative array
' @param {Dynamic} Value2 - second associative array
' @returns {boolean} - True if arrays are equal or False in other case.
function rooibos_common_eqAssocArray(Value1, Value2, fuzzy = false, callCount = 0) as dynamic
    if not rooibos_common_isAssociativeArray(Value1) or not rooibos_common_isAssociativeArray(Value2)
        return false
    end if
    l1 = Value1.ifAssociativeArray.Count()
    l2 = Value2.ifAssociativeArray.Count()
    if not l1 = l2
        return false
    else
        for each k in Value1
            if not Value2.ifAssociativeArray.DoesExist(k)
                return false
            else
                if rooibos_common_canSafelyIterateAAKey(Value1, k) and rooibos_common_canSafelyIterateAAKey(Value2, k)
                    v1 = Value1[k]
                    v2 = Value2[k]
                    if not rooibos_common_eqValues(v1, v2, fuzzy, callCount + 1)
                        return false
                    end if
                end if
            end if
        end for
        return true
    end if
end function

function rooibos_common_canSafelyIterateAAKey(aa, key) as boolean
    if lcase(key) = "__rooibosskipfields" or key = "__mocks" or key = "__stubs" or key = "log" or key = "top" or key = "m" 'fix infinite loop/box crash when doing equals on an aa with a mock
        return false
    else if aa.__rooibosSkipFields <> invalid and aa.__rooibosSkipFields.doesExist(key)
        return false
    end if
    return true
end function

' Compare to roArray objects for equality.
' @param {Dynamic} Value1 - first array
' @param {Dynamic} Value2 - second array
' @returns {boolean} - True if arrays are equal or False in other case.
function rooibos_common_eqArray(Value1, Value2, fuzzy = false, callCount = 0) as dynamic
    if callCount > 30
        rooibos_common_logError("REACHED MAX ITERATIONS DOING COMPARISON")
        return true
    end if
    if not (rooibos_common_isArray(Value1)) or not rooibos_common_isArray(Value2)
        return false
    end if
    l1 = Value1.Count()
    l2 = Value2.Count()
    if not l1 = l2
        return false
    else
        for i = 0 to l1 - 1
            v1 = Value1[i]
            v2 = Value2[i]
            if not rooibos_common_eqValues(v1, v2, fuzzy, callCount + 1)
                return false
            end if
        end for
        return true
    end if
end function

' Fills text with count of fillChars
' @param {string} text - text to fill
' @param {string} fillChar - char to fill with
' @param {integer} numChars - target length
' @returns {string} filled string
function rooibos_common_fillText(text as string, fillChar = " ", numChars = 40) as string
    if len(text) >= numChars
        text = left(text, numChars - 5) + "..." + fillChar + fillChar
    else
        numToFill = numChars - len(text) - 1
        for i = 0 to numToFill
            text = text + fillChar
        end for
    end if
    return text
end function

function rooibos_common_makePathStubbable(content as dynamic, path as string)
    part = invalid
    if path <> invalid
        parts = path.split(".")
        numParts = parts.count()
        i = 0
        contentName = parts[i]
        i++
        if type(content) <> "roAssociativeArray"
            content = {
                id: contentName
            }
        end if
        part = content
        while i < numParts and part <> invalid
            isIndexNumber = parts[i] = "0" or (parts[i].toInt() <> 0 and parts[i].toInt().toStr() = parts[i])
            index = invalid
            if isIndexNumber
                index = parts[i].toInt()
            else
                index = parts[i]
            end if
            nextPart = invalid
            if rooibos_common_isArray(part) and isIndexNumber
                nextPart = part[index]
            else if type(part) = "roAssociativeArray" and not isIndexNumber
                nextPart = part[index]
            end if
            if nextPart = invalid or type(nextPart) <> "roAssociativeArray"
                if (not isIndexNumber and type(part) = "roAssociativeArray") or (isIndexNumber and (rooibos_common_isArray(part)))
                    nextPart = {
                        id: index
                    }
                    part[index] = nextPart
                else
                    'index type mismatch, gonna have to bail
                    return content
                end if
            end if
            part = nextPart
            i++
        end while
    end if
    return part
end function

' @ignore
sub rooibos_common_logError(value)
    ? "[Rooibos Error]: " value
end sub

' @ignore
sub rooibos_common_logWarning(value)
end sub

' @ignore
sub rooibos_common_logInfo(value)
    ? "[Rooibos Info]: " value
end sub

' @ignore
sub rooibos_common_logDebug(value)
end sub

' @ignore
sub rooibos_common_logTrace(value)
end sub
'//# sourceMappingURL=./CommonUtils.brs.map