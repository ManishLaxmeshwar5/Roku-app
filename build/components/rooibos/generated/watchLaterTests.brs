function init()
    RBS_CC_52_reportLine("1", 1)
    m.top.addField("rooibosRunSuite", "boolean", false)
    RBS_CC_52_reportLine("2", 1)
    m.top.observeFieldScoped("rooibosRunSuite", "rooibosRunSuite")
end function

function rooibosRunSuite()
    RBS_CC_52_reportLine("6", 1)
    m.top.unobserveFieldScoped("rooibosRunSuite")
    RBS_CC_52_reportLine("7", 1)
    nodeRunner = Rooibos_TestRunner(m.top.getScene(), m)
    RBS_CC_52_reportLine("8", 1)
    m.top.rooibosTestResult = nodeRunner.runInNodeMode("watchLaterTests")
end function

function RBS_CC_52_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "52"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "52"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./watchLaterTests.brs.map