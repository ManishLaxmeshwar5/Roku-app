' @ignore
function __rooibos_Stats_builder()
    RBS_CC_32_reportLine("2", 1)
    instance = {}
    RBS_CC_32_reportLine("3", 1)
    instance.new = function()
        RBS_CC_32_reportLine("4", 1)
        m.time = 0
        RBS_CC_32_reportLine("5", 1)
        m.ranCount = 0
        RBS_CC_32_reportLine("6", 1)
        m.passedCount = 0
        RBS_CC_32_reportLine("7", 1)
        m.failedCount = 0
        RBS_CC_32_reportLine("8", 1)
        m.crashedCount = 0
        RBS_CC_32_reportLine("9", 1)
        m.ignoredCount = 0
        RBS_CC_32_reportLine("10", 1)
        m.ignoredTestNames = []
        RBS_CC_32_reportLine("11", 1)
        m.hasFailures = false
        RBS_CC_32_reportLine("12", 1)
        m.testResult = invalid
    end function
    RBS_CC_32_reportLine("14", 1)
    instance.merge = function(other) as void
        RBS_CC_32_reportLine("15", 1)
        m.time += other.time
        RBS_CC_32_reportLine("16", 1)
        m.ranCount += other.ranCount
        RBS_CC_32_reportLine("17", 1)
        m.passedCount += other.passedCount
        RBS_CC_32_reportLine("18", 1)
        m.failedCount += other.failedCount
        RBS_CC_32_reportLine("19", 1)
        m.crashedCount += other.crashedCount
        RBS_CC_32_reportLine("20", 1)
        m.ignoredCount += other.ignoredCount
        RBS_CC_32_reportLine("21", 1)
        m.ignoredTestNames.append(other.IgnoredTestNames)
        RBS_CC_32_reportLine("22", 1)
        m.onUpdate()
    end function
    RBS_CC_32_reportLine("24", 1)
    instance.appendTestResult = function(result)
        RBS_CC_32_reportLine("25", 1)
        m.time += result.time
        RBS_CC_32_reportLine("26", 1)
        m.ranCount++
        if RBS_CC_32_reportLine("27", 2) and (result.isCrash)
            RBS_CC_32_reportLine("27", 3)
            RBS_CC_32_reportLine("28", 1)
            m.crashedCount++
        else if RBS_CC_32_reportLine("29", 2) and (result.isFail)
            RBS_CC_32_reportLine("29", 3)
            RBS_CC_32_reportLine("30", 1)
            m.failedCount++
        else if RBS_CC_32_reportLine("31", 2) and (result.isSkipped)
            RBS_CC_32_reportLine("31", 3)
            RBS_CC_32_reportLine("32", 1)
            m.ignoredTestNames.push(result.test.name)
            RBS_CC_32_reportLine("33", 1)
            m.ignoredCount++
        else
            RBS_CC_32_reportLine("34", 3)
            RBS_CC_32_reportLine("35", 1)
            m.passedCount++
        end if
        RBS_CC_32_reportLine("37", 1)
        m.onUpdate()
    end function
    RBS_CC_32_reportLine("39", 1)
    instance.onUpdate = function()
        RBS_CC_32_reportLine("40", 1)
        m.hasFailures = m.failedCount > 0 or m.crashedCount > 0
    end function
    RBS_CC_32_reportLine("42", 1)
    return instance
end function

function rooibos_Stats()
    RBS_CC_32_reportLine("45", 1)
    instance = __rooibos_Stats_builder()
    RBS_CC_32_reportLine("46", 1)
    instance.new()
    RBS_CC_32_reportLine("47", 1)
    return instance
end function

'//# sourceMappingURL=./Stats.brs.map
function RBS_CC_32_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "32"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "32"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./Stats.brs.map