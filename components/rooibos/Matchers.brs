function rooibos_Matcher_anyString(value)
    return rooibos_common_isString(value)
end function

function rooibos_Matcher_anyBool(value)
    return rooibos_common_isBoolean(value)
end function

function rooibos_Matcher_anyNumber(value)
    return rooibos_common_isNumber(value)
end function

function rooibos_Matcher_anyAA(value)
    return rooibos_common_isAssociativeArray(value)
end function

function rooibos_Matcher_anyArray(value)
    return rooibos_common_isArray(value)
end function

function rooibos_Matcher_anyNode(value)
    return rooibos_common_isSGNode(value)
end function
'//# sourceMappingURL=./Matchers.brs.map