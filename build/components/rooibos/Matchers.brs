function rooibos_Matcher_anyString(value)
    RBS_CC_28_reportLine("1", 1)
    return rooibos_common_isString(value)
end function

function rooibos_Matcher_anyBool(value)
    RBS_CC_28_reportLine("5", 1)
    return rooibos_common_isBoolean(value)
end function

function rooibos_Matcher_anyNumber(value)
    RBS_CC_28_reportLine("9", 1)
    return rooibos_common_isNumber(value)
end function

function rooibos_Matcher_anyAA(value)
    RBS_CC_28_reportLine("13", 1)
    return rooibos_common_isAssociativeArray(value)
end function

function rooibos_Matcher_anyArray(value)
    RBS_CC_28_reportLine("17", 1)
    return rooibos_common_isArray(value)
end function

function rooibos_Matcher_anyNode(value)
    RBS_CC_28_reportLine("21", 1)
    return rooibos_common_isSGNode(value)
end function

'//# sourceMappingURL=./Matchers.brs.map
function RBS_CC_28_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "28"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "28"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./Matchers.brs.map