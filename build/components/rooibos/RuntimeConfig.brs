' @ignore
function __rooibos_RuntimeConfig_builder()
    RBS_CC_31_reportLine("2", 1)
    instance = {}
    RBS_CC_31_reportLine("3", 1)
    instance.new = function()
        RBS_CC_31_reportLine("4", 1)
        m.testSuites = m.getTestSuiteClassMap()
    end function
    RBS_CC_31_reportLine("6", 1)
    instance.getVersionText = function()
        RBS_CC_31_reportLine("7", 1)
        return "5.15.7"
    end function
    RBS_CC_31_reportLine("9", 1)
    instance.getRuntimeConfig = function()
        RBS_CC_31_reportLine("10", 1)
        return {
            "reporters": [
                rooibos_ConsoleTestReporter
            ]
            "failFast": false
            "sendHomeOnFinish": false
            "logLevel": 0
            "showOnlyFailures": true
            "printTestTimes": true
            "lineWidth": 70
            "printLcov": false
            "port": "invalid"
            "catchCrashes": true
            "colorizeOutput": false
            "throwOnFailedAssertion": false
            "keepAppOpen": true
            "isRecordingCodeCoverage": false
        }
    end function
    RBS_CC_31_reportLine("29", 1)
    instance.getTestSuiteClassMap = function()
        RBS_CC_31_reportLine("30", 1)
        return {
            "HelloWorldTests": tests_HelloWorldTests
        }
    end function
    RBS_CC_31_reportLine("34", 1)
    instance.getTestSuiteClassWithName = function(name)
        RBS_CC_31_reportLine("35", 1)
        return m.testSuites[name]
    end function
    RBS_CC_31_reportLine("37", 1)
    instance.getAllTestSuitesNames = function()
        RBS_CC_31_reportLine("38", 1)
        return m.testSuites.keys()
    end function
    RBS_CC_31_reportLine("40", 1)
    instance.getIgnoredTestInfo = function()
        RBS_CC_31_reportLine("41", 1)
        return {
            "count": 0
            "items": []
        }
    end function
    RBS_CC_31_reportLine("46", 1)
    return instance
end function

function rooibos_RuntimeConfig()
    RBS_CC_31_reportLine("49", 1)
    instance = __rooibos_RuntimeConfig_builder()
    RBS_CC_31_reportLine("50", 1)
    instance.new()
    RBS_CC_31_reportLine("51", 1)
    return instance
end function

'//# sourceMappingURL=./RuntimeConfig.brs.map
function RBS_CC_31_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "31"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "31"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./RuntimeConfig.brs.map