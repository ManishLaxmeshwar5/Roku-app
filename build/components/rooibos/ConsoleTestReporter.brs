' @ignore
function __rooibos_ConsoleTestReporter_builder()
    RBS_CC_25_reportLine("2", 1)
    instance = __rooibos_BaseTestReporter_builder()
    RBS_CC_25_reportLine("3", 1)
    instance.super0_new = instance.new
    RBS_CC_25_reportLine("4", 1)
    instance.new = function(runner)
        'bs:disable-next-line
        RBS_CC_25_reportLine("6", 1)
        m.lineWidth = 60
        RBS_CC_25_reportLine("7", 1)
        m.super0_new(runner)
        if RBS_CC_25_reportLine("8", 2) and (m.config.lineWidth <> invalid)
            RBS_CC_25_reportLine("8", 3)
            RBS_CC_25_reportLine("9", 1)
            m.lineWidth = m.config.lineWidth
        else
            RBS_CC_25_reportLine("10", 3)
            RBS_CC_25_reportLine("11", 1)
            m.lineWidth = 60
        end if
    end function
    RBS_CC_25_reportLine("14", 1)
    instance.super0_onSuiteBegin = instance.onSuiteBegin
    RBS_CC_25_reportLine("15", 1)
    instance.onSuiteBegin = function(event as object)
        if RBS_CC_25_reportLine("16", 2) and (event.suite.isIgnored) then
            RBS_CC_25_reportLine("16", 3)
            RBS_CC_25_reportLine("17", 1)
            return invalid
        end if
        RBS_CC_25_reportLine("19", 1)
        ? ""
        RBS_CC_25_reportLine("20", 1)
        ? rooibos_common_fillText("> SUITE: " + event.suite.name, ">", 80)
    end function
    RBS_CC_25_reportLine("22", 1)
    instance.super0_onTestGroupBegin = instance.onTestGroupBegin
    RBS_CC_25_reportLine("23", 1)
    instance.onTestGroupBegin = function(event as object)
        if RBS_CC_25_reportLine("24", 2) and (event.group.isIgnored) then
            RBS_CC_25_reportLine("24", 3)
            RBS_CC_25_reportLine("25", 1)
            return invalid
        end if
        RBS_CC_25_reportLine("27", 1)
        ? ""
        RBS_CC_25_reportLine("28", 1)
        ? rooibos_common_fillText(">>>> Describe: " + event.group.name, ">", 80)
        'bs:disable-next-line
        RBS_CC_25_reportLine("30", 1)
        ? ("  Location: file://" + bslib_toString(event.group.testSuite.filePath.trim()) + ":" + bslib_toString(event.group.lineNumber))
        RBS_CC_25_reportLine("31", 1)
        ? ""
    end function
    RBS_CC_25_reportLine("33", 1)
    instance.super0_onTestBegin = instance.onTestBegin
    RBS_CC_25_reportLine("34", 1)
    instance.onTestBegin = function(event as object)
        if RBS_CC_25_reportLine("35", 2) and (event.test.isIgnored) then
            RBS_CC_25_reportLine("35", 3)
            RBS_CC_25_reportLine("36", 1)
            return invalid
        end if
        RBS_CC_25_reportLine("38", 1)
        ? ""
        RBS_CC_25_reportLine("39", 1)
        ? rooibos_common_fillText(">>>>>> It: " + event.test.name, ">", 80)
        RBS_CC_25_reportLine("40", 1)
        ? ("  Location: file://" + bslib_toString(event.test.testSuite.filePath.trim()) + ":" + bslib_toString(event.test.lineNumber))
        RBS_CC_25_reportLine("41", 1)
        ? ""
    end function
    RBS_CC_25_reportLine("43", 1)
    instance.super0_onTestComplete = instance.onTestComplete
    RBS_CC_25_reportLine("44", 1)
    instance.onTestComplete = function(event as object)
        if RBS_CC_25_reportLine("45", 2) and (event.test.isIgnored) then
            RBS_CC_25_reportLine("45", 3)
            RBS_CC_25_reportLine("46", 1)
            return invalid
        end if
        RBS_CC_25_reportLine("48", 1)
        ? rooibos_common_fillText("<<<< END It: " + event.test.name + " (" + event.test.result.getStatusText() + ") ", "<", 80)
    end function
    ' override function onTestGroupComplete(event as rooibos.TestReporterOnTestGroupCompleteEvent)
    '   'override me
    ' end function
    ' override function onSuiteComplete(event as rooibos.TestReporterOnSuiteCompleteEvent)
    '   'override me
    ' end function
    RBS_CC_25_reportLine("56", 1)
    instance.super0_onEnd = instance.onEnd
    RBS_CC_25_reportLine("57", 1)
    instance.onEnd = function(event as object)
        RBS_CC_25_reportLine("58", 1)
        m.allStats = event.stats
        RBS_CC_25_reportLine("59", 1)
        m.startReport()
        RBS_CC_25_reportLine("60", 1): for each testSuite in m.testRunner.testSuites
            if RBS_CC_25_reportLine("61", 2) and (not testSuite.isIgnored)
                RBS_CC_25_reportLine("61", 3)
                if RBS_CC_25_reportLine("62", 2) and (not m.allStats.hasFailures or ((not m.config.showOnlyFailures) or testSuite.stats.failedCount > 0 or testSuite.stats.crashedCount > 0))
                    RBS_CC_25_reportLine("62", 3)
                    RBS_CC_25_reportLine("63", 1)
                    m.printSuiteStart(testSuite)
                    RBS_CC_25_reportLine("64", 1): for each testGroup in testSuite.groups
                        RBS_CC_25_reportLine("65", 1)
                        m.printGroup(testGroup)
                    end for
                end if
            end if
        end for
        RBS_CC_25_reportLine("70", 1)
        m.printLine()
        'bs:disable-next-line
        RBS_CC_25_reportLine("72", 1)
        ignoredInfo = m.testRunner.runtimeConfig.getIgnoredTestInfo()
        RBS_CC_25_reportLine("73", 1)
        m.printLine(0, "Total: " + rooibos_common_AsString(m.allStats.ranCount))
        RBS_CC_25_reportLine("74", 1)
        m.printLine(0, "  Passed: " + rooibos_common_AsString(m.allStats.passedCount))
        RBS_CC_25_reportLine("75", 1)
        m.printLine(0, "  Crashed: " + rooibos_common_AsString(m.allStats.crashedCount))
        RBS_CC_25_reportLine("76", 1)
        m.printLine(0, "  Failed: " + rooibos_common_AsString(m.allStats.failedCount))
        'bs:disable-next-line
        RBS_CC_25_reportLine("78", 1)
        m.printLine(0, "  Ignored: " + rooibos_common_AsString(ignoredInfo.count))
        RBS_CC_25_reportLine("79", 1)
        m.printLine(0, "  Time: " + rooibos_common_AsString(m.allStats.time) + "ms")
        RBS_CC_25_reportLine("80", 1)
        m.printLine()
        RBS_CC_25_reportLine("81", 1)
        m.printLine()
        if RBS_CC_25_reportLine("82", 2) and (ignoredInfo.count > 0)
            RBS_CC_25_reportLine("82", 3)
            RBS_CC_25_reportLine("83", 1)
            m.printLine(0, "IGNORED TESTS:")
            RBS_CC_25_reportLine("84", 1): for each ignoredItemName in ignoredInfo.items
                RBS_CC_25_reportLine("85", 1)
                m.printLine(1, ignoredItemName)
            end for
            RBS_CC_25_reportLine("87", 1)
            m.printLine()
            RBS_CC_25_reportLine("88", 1)
            m.printLine()
        end if
        RBS_CC_25_reportLine("90", 1)
        overrallResult = ""
        if RBS_CC_25_reportLine("91", 2) and (m.allStats.hasFailures)
            RBS_CC_25_reportLine("91", 3)
            RBS_CC_25_reportLine("92", 1)
            overrallResult = "Fail"
        else
            RBS_CC_25_reportLine("93", 3)
            RBS_CC_25_reportLine("94", 1)
            overrallResult = "Success"
        end if
        RBS_CC_25_reportLine("96", 1)
        m.printLine(0, "RESULT: " + overrallResult)
        RBS_CC_25_reportLine("97", 1)
        m.endReport()
    end function
    RBS_CC_25_reportLine("99", 1)
    instance.printGroup = function(testGroup)
        if RBS_CC_25_reportLine("100", 2) and (testGroup.isIgnored) then
            RBS_CC_25_reportLine("100", 3)
            RBS_CC_25_reportLine("101", 1)
            return invalid
        end if
        RBS_CC_25_reportLine("103", 1)
        isGroupPrinted = false
        RBS_CC_25_reportLine("104", 1): for each test in testGroup.tests
            if RBS_CC_25_reportLine("105", 2) and (not test.result.isSkipped)
                RBS_CC_25_reportLine("105", 3)
                if RBS_CC_25_reportLine("106", 2) and (not m.allStats.hasFailures or ((not m.config.showOnlyFailures) or test.result.isFail))
                    RBS_CC_25_reportLine("106", 3)
                    if RBS_CC_25_reportLine("107", 2) and (not isGroupPrinted)
                        RBS_CC_25_reportLine("107", 3)
                        RBS_CC_25_reportLine("108", 1)
                        m.printGroupStart(testGroup)
                        RBS_CC_25_reportLine("109", 1)
                        isGroupPrinted = true
                    end if
                    RBS_CC_25_reportLine("111", 1)
                    m.printTest(test)
                end if
            end if
        end for
        if RBS_CC_25_reportLine("115", 2) and (isGroupPrinted)
            RBS_CC_25_reportLine("115", 3)
            RBS_CC_25_reportLine("116", 1)
            m.printLine(0, " |")
        end if
    end function
    RBS_CC_25_reportLine("119", 1)
    instance.printTest = function(test)
        RBS_CC_25_reportLine("120", 1)
        testLocationLine = StrI(test.lineNumber).trim()
        RBS_CC_25_reportLine("121", 1)
        locationLine = invalid
        RBS_CC_25_reportLine("122", 1)
        testChar = ""
        if RBS_CC_25_reportLine("123", 2) and (test.result.isCrash)
            RBS_CC_25_reportLine("123", 3)
            RBS_CC_25_reportLine("124", 1)
            testChar = "|"
            RBS_CC_25_reportLine("125", 1)
            locationLine = StrI(test.lineNumber).trim()
        else if RBS_CC_25_reportLine("126", 2) and (test.result.isFail)
            RBS_CC_25_reportLine("126", 3)
            RBS_CC_25_reportLine("127", 1)
            testChar = "-"
            RBS_CC_25_reportLine("128", 1)
            locationLine = StrI(test.result.lineNumber).trim()
        else
            RBS_CC_25_reportLine("129", 3)
            RBS_CC_25_reportLine("130", 1)
            testChar = "|"
            RBS_CC_25_reportLine("131", 1)
            locationLine = StrI(test.lineNumber).trim()
        end if
        RBS_CC_25_reportLine("133", 1)
        testLocationText = "file://" + test.testSuite.filePath.trim() + ":" + testLocationLine
        RBS_CC_25_reportLine("134", 1)
        timeText = ""
        if RBS_CC_25_reportLine("135", 2) and (m.config.printTestTimes = true)
            RBS_CC_25_reportLine("135", 3)
            RBS_CC_25_reportLine("136", 1)
            timeText = " (" + stri(test.result.time).trim() + "ms)"
        end if
        RBS_CC_25_reportLine("138", 1)
        insetText = ""
        if RBS_CC_25_reportLine("139", 2) and (test.isParamTest <> true)
            RBS_CC_25_reportLine("139", 3)
            RBS_CC_25_reportLine("140", 1)
            messageLine = rooibos_common_fillText(" " + testChar + " |--" + test.name + " : ", ".", m.lineWidth)
            RBS_CC_25_reportLine("141", 1)
            m.printLine(0, messageLine + test.result.getStatusText() + timeText)
            RBS_CC_25_reportLine("142", 1)
            m.printLine(0, " | " + insetText + "  |--Test : " + testLocationText)
        else if RBS_CC_25_reportLine("143", 2) and (test.paramTestIndex = 0)
            RBS_CC_25_reportLine("143", 3)
            RBS_CC_25_reportLine("144", 1)
            name = test.name
            if RBS_CC_25_reportLine("145", 2) and (len(name) > 1 and right(name, 1) = "0")
                RBS_CC_25_reportLine("145", 3)
                RBS_CC_25_reportLine("146", 1)
                name = left(name, len(name) - 1)
            end if
            RBS_CC_25_reportLine("148", 1)
            m.printLine(0, " " + testChar + " |--" + name + " : ")
            RBS_CC_25_reportLine("149", 1)
            m.printLine(0, " | " + insetText + "  |--Test : " + testLocationText)
        end if
        RBS_CC_25_reportLine("151", 1)
        locationText = "file://" + test.testSuite.filePath.trim() + ":" + locationLine
        if RBS_CC_25_reportLine("152", 2) and (test.isParamTest = true)
            RBS_CC_25_reportLine("152", 3)
            RBS_CC_25_reportLine("153", 1)
            insetText = "  "
            RBS_CC_25_reportLine("154", 1)
            rawParams = invalid
            if RBS_CC_25_reportLine("155", 2) and (type(test.rawParams) = "roAssociativeArray")
                RBS_CC_25_reportLine("155", 3)
                RBS_CC_25_reportLine("156", 1)
                rawParams = {}
                RBS_CC_25_reportLine("157", 1): for each key in test.rawParams
                    if RBS_CC_25_reportLine("158", 2) and (type(test.rawParams[key]) <> "Function" and type(test.rawParams[key]) <> "roFunction")
                        RBS_CC_25_reportLine("158", 3)
                        RBS_CC_25_reportLine("159", 1)
                        rawParams[key] = test.rawParams[key]
                    end if
                end for
            else
                RBS_CC_25_reportLine("162", 3)
                RBS_CC_25_reportLine("163", 1)
                rawParams = test.rawParams
            end if
            RBS_CC_25_reportLine("165", 1)
            messageLine = rooibos_common_fillText(" " + testChar + insetText + " |--" + formatJson(rawParams) + " : ", ".", m.lineWidth)
            RBS_CC_25_reportLine("166", 1)
            m.printLine(0, messageLine + test.result.getStatusText() + timeText)
        end if
        if RBS_CC_25_reportLine("168", 2) and (test.result.isCrash)
            RBS_CC_25_reportLine("168", 3)
            RBS_CC_25_reportLine("169", 1)
            m.printLine(0, " | " + insetText + "  |--Crashed at: " + locationText)
            RBS_CC_25_reportLine("170", 1)
            m.printStackTrace(insetText, test.result.error)
            RBS_CC_25_reportLine("171", 1)
            m.printLine(0, " | ")
        else if RBS_CC_25_reportLine("172", 2) and (test.result.isFail)
            RBS_CC_25_reportLine("172", 3)
            RBS_CC_25_reportLine("173", 1)
            m.printLine(0, " | " + insetText + "  |--Failed at: " + locationText)
            if RBS_CC_25_reportLine("174", 2) and (test.isParamTest = true)
                RBS_CC_25_reportLine("174", 3)
                RBS_CC_25_reportLine("175", 1)
                m.printLine(0, " | " + insetText + "  |--Param Line: " + StrI(test.paramLineNumber).trim())
            end if
            RBS_CC_25_reportLine("177", 1)
            m.printLine(0, " | " + insetText + "  |--Error Message: " + test.result.message)
            RBS_CC_25_reportLine("178", 1)
            m.printLine(0, " | ")
        end if
    end function
    RBS_CC_25_reportLine("181", 1)
    instance.printStackTrace = function(insetText, error)
        RBS_CC_25_reportLine("182", 1)
        m.printLine(0, " | " + insetText + "  |")
        RBS_CC_25_reportLine("183", 1)
        m.printLine(0, " | " + insetText + "  |--Message: " + error.message)
        RBS_CC_25_reportLine("184", 1)
        m.printLine(0, " | " + insetText + "  |--Stack trace: ")
        RBS_CC_25_reportLine("185", 1): for i = error.backTrace.count() - 1 to 0 step -1
            RBS_CC_25_reportLine("186", 1)
            e = error.backTrace[i]
            if RBS_CC_25_reportLine("187", 2) and (e.filename.instr("pkg:/source/rooibos") = -1)
                RBS_CC_25_reportLine("187", 3)
                RBS_CC_25_reportLine("188", 1)
                m.printLine(0, " | " + insetText + "    " + e.filename + "(" + stri(e.line_number).trim() + ")")
            end if
        end for
    end function
    RBS_CC_25_reportLine("192", 1)
    instance.startReport = function()
        RBS_CC_25_reportLine("193", 1)
        m.printLine()
        RBS_CC_25_reportLine("194", 1)
        m.printLine(0, "[START TEST REPORT]")
        RBS_CC_25_reportLine("195", 1)
        m.printLine()
    end function
    RBS_CC_25_reportLine("197", 1)
    instance.endReport = function()
        RBS_CC_25_reportLine("198", 1)
        m.printLine()
        RBS_CC_25_reportLine("199", 1)
        m.printLine(0, "[END TEST REPORT]")
        RBS_CC_25_reportLine("200", 1)
        m.printLine()
    end function
    RBS_CC_25_reportLine("202", 1)
    instance.printSuiteStart = function(testSuite)
        RBS_CC_25_reportLine("203", 1)
        m.printLine(0, " " + testSuite.name + " file://" + testSuite.filePath.trim() + ":" + str(testSuite.lineNumber).trim())
    end function
    RBS_CC_25_reportLine("205", 1)
    instance.printGroupStart = function(testGroup)
        RBS_CC_25_reportLine("206", 1)
        m.printLine(0, " |-" + testGroup.name)
    end function
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    '++ printing
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    RBS_CC_25_reportLine("211", 1)
    instance.printLine = function(depth = 0, text = "")
        RBS_CC_25_reportLine("212", 1)
        ? " "; text
    end function
    RBS_CC_25_reportLine("214", 1)
    return instance
end function

function rooibos_ConsoleTestReporter(runner)
    RBS_CC_25_reportLine("217", 1)
    instance = __rooibos_ConsoleTestReporter_builder()
    RBS_CC_25_reportLine("218", 1)
    instance.new(runner)
    RBS_CC_25_reportLine("219", 1)
    return instance
end function

'//# sourceMappingURL=./ConsoleTestReporter.brs.map
function RBS_CC_25_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "25"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "25"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./ConsoleTestReporter.brs.map