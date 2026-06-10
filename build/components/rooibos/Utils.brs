function __rooibos_utils_MockNode_builder()
    RBS_CC_37_reportLine("1", 1)
    instance = {}
    RBS_CC_37_reportLine("2", 1)
    instance.new = function(id = "", subType = "Node")
        RBS_CC_37_reportLine("3", 1)
        m.id = invalid
        RBS_CC_37_reportLine("4", 1)
        m.name = invalid
        RBS_CC_37_reportLine("5", 1)
        m.createdNodes = []
        RBS_CC_37_reportLine("6", 1)
        m.createdChildren = []
        RBS_CC_37_reportLine("7", 1)
        m.children = []
        RBS_CC_37_reportLine("8", 1)
        m._subType = "Node"
        RBS_CC_37_reportLine("9", 1)
        m._parent = invalid
        RBS_CC_37_reportLine("10", 1)
        m.id = id
        RBS_CC_37_reportLine("11", 1)
        m._subType = subType
    end function
    RBS_CC_37_reportLine("13", 1)
    instance.subType = function()
        RBS_CC_37_reportLine("14", 1)
        return m._subType
    end function
    RBS_CC_37_reportLine("16", 1)
    instance.isSubType = function(name)
        RBS_CC_37_reportLine("17", 1)
        return false
    end function
    RBS_CC_37_reportLine("19", 1)
    instance.createObject = function(nodeType)
        RBS_CC_37_reportLine("20", 1)
        node = rooibos_utils_MockNode("", nodeType)
        RBS_CC_37_reportLine("21", 1)
        m.createdNodes.push(node)
        RBS_CC_37_reportLine("22", 1)
        return node
    end function
    RBS_CC_37_reportLine("24", 1)
    instance.createChild = function(nodeType)
        RBS_CC_37_reportLine("25", 1)
        node = rooibos_utils_MockNode("", nodeType)
        RBS_CC_37_reportLine("26", 1)
        m.createdChildren.push(node)
        RBS_CC_37_reportLine("27", 1)
        return node
    end function
    RBS_CC_37_reportLine("29", 1)
    instance.appendChild = function(child)
        RBS_CC_37_reportLine("30", 1)
        m.children.push(child)
    end function
    RBS_CC_37_reportLine("32", 1)
    instance.getParent = function()
        if RBS_CC_37_reportLine("33", 2) and (m._parent = invalid)
            RBS_CC_37_reportLine("33", 3)
            RBS_CC_37_reportLine("34", 1)
            m._parent = rooibos_utils_MockNode("_generated_parent")
        end if
        RBS_CC_37_reportLine("36", 1)
        return m._parent
    end function
    RBS_CC_37_reportLine("38", 1)
    instance.addFields = function(fields)
        RBS_CC_37_reportLine("39", 1)
        m.append(fields)
    end function
    RBS_CC_37_reportLine("41", 1)
    instance.setField = function(field, value)
        RBS_CC_37_reportLine("42", 1)
        m[field] = value
    end function
    RBS_CC_37_reportLine("44", 1)
    instance.setFields = function(fields)
        RBS_CC_37_reportLine("45", 1)
        m.append(fields)
    end function
    RBS_CC_37_reportLine("47", 1)
    instance.observeField = function(field, callback)
    end function
    RBS_CC_37_reportLine("49", 1)
    instance.getChildren = function(offset, count)
        RBS_CC_37_reportLine("50", 1)
        return m.children
    end function
    RBS_CC_37_reportLine("52", 1)
    instance.removeChildren = function(children)
    end function
    RBS_CC_37_reportLine("54", 1)
    instance.observeFieldScoped = function(field, callback)
    end function
    RBS_CC_37_reportLine("56", 1)
    return instance
end function

function rooibos_utils_MockNode(id = "", subType = "Node")
    RBS_CC_37_reportLine("59", 1)
    instance = __rooibos_utils_MockNode_builder()
    RBS_CC_37_reportLine("60", 1)
    instance.new(id, subType)
    RBS_CC_37_reportLine("61", 1)
    return instance
end function

'//# sourceMappingURL=./Utils.brs.map
function RBS_CC_37_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "37"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "37"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./Utils.brs.map