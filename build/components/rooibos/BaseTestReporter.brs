' @ignore
function __rooibos_BaseTestReporter_builder()
    RBS_CC_21_reportLine("2", 1)
    instance = {}
    RBS_CC_21_reportLine("3", 1)
    instance.new = sub(runner as dynamic)
        RBS_CC_21_reportLine("4", 1)
        m.testRunner = invalid
        RBS_CC_21_reportLine("5", 1)
        m.config = invalid
        RBS_CC_21_reportLine("6", 1)
        m.allStats = invalid
        RBS_CC_21_reportLine("7", 1)
        m.colorizeOutput = false
        RBS_CC_21_reportLine("8", 1)
        m.testRunner = runner
        RBS_CC_21_reportLine("9", 1)
        m.config = runner.config
        RBS_CC_21_reportLine("10", 1)
        m.allStats = runner.stats
        RBS_CC_21_reportLine("11", 1)
        m.colorizeOutput = runner.config.colorizeOutput = true
    end sub
    RBS_CC_21_reportLine("13", 1)
    instance.onBegin = sub(event as object)
        'override me
        RBS_CC_21_reportLine("15", 1)
        rooibos_common_logDebug("BaseTestReporter.onBegin")
    end sub
    RBS_CC_21_reportLine("17", 1)
    instance.onSuiteBegin = sub(event as object)
        'override me
    end sub
    RBS_CC_21_reportLine("20", 1)
    instance.onTestGroupBegin = sub(event as object)
        'override me
    end sub
    RBS_CC_21_reportLine("23", 1)
    instance.onTestBegin = sub(event as object)
        'override me
    end sub
    RBS_CC_21_reportLine("26", 1)
    instance.onTestComplete = sub(event as object)
        'override me
    end sub
    RBS_CC_21_reportLine("29", 1)
    instance.onTestGroupComplete = sub(event as object)
        'override me
    end sub
    RBS_CC_21_reportLine("32", 1)
    instance.onSuiteComplete = sub(event as object)
        'override me
    end sub
    RBS_CC_21_reportLine("35", 1)
    instance.onEnd = sub(event as object)
        'override me
        RBS_CC_21_reportLine("37", 1)
        rooibos_common_logDebug("BaseTestReporter.onEnd")
    end sub
    RBS_CC_21_reportLine("39", 1)
    return instance
end function

function rooibos_BaseTestReporter(runner as dynamic)
    RBS_CC_21_reportLine("42", 1)
    instance = __rooibos_BaseTestReporter_builder()
    RBS_CC_21_reportLine("43", 1)
    instance.new(runner)
    RBS_CC_21_reportLine("44", 1)
    return instance
end function
' @ignore
' @ignore
' @ignore
' @ignore
' @ignore
' @ignore
' @ignore
' @ignore
' @deprecated use rooibos.TestReporterOnEndEvent
' @ignore

'//# sourceMappingURL=./BaseTestReporter.brs.map
function RBS_CC_21_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "21"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "21"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./BaseTestReporter.brs.map