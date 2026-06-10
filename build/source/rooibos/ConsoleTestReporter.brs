' @ignore
function __rooibos_ConsoleTestReporter_builder()
    instance = __rooibos_BaseTestReporter_builder()
    instance.super0_new = instance.new
    instance.new = function(runner)
        'bs:disable-next-line
        m.lineWidth = 60
        m.super0_new(runner)
        if m.config.lineWidth <> invalid
            m.lineWidth = m.config.lineWidth
        else
            m.lineWidth = 60
        end if
    end function
    instance.super0_onSuiteBegin = instance.onSuiteBegin
    instance.onSuiteBegin = function(event as object)
        if event.suite.isIgnored then
            return invalid
        end if
        ? ""
        ? rooibos_common_fillText("> SUITE: " + event.suite.name, ">", 80)
    end function
    instance.super0_onTestGroupBegin = instance.onTestGroupBegin
    instance.onTestGroupBegin = function(event as object)
        if event.group.isIgnored then
            return invalid
        end if
        ? ""
        ? rooibos_common_fillText(">>>> Describe: " + event.group.name, ">", 80)
        'bs:disable-next-line
        ? ("  Location: file://" + bslib_toString(event.group.testSuite.filePath.trim()) + ":" + bslib_toString(event.group.lineNumber))
        ? ""
    end function
    instance.super0_onTestBegin = instance.onTestBegin
    instance.onTestBegin = function(event as object)
        if event.test.isIgnored then
            return invalid
        end if
        ? ""
        ? rooibos_common_fillText(">>>>>> It: " + event.test.name, ">", 80)
        ? ("  Location: file://" + bslib_toString(event.test.testSuite.filePath.trim()) + ":" + bslib_toString(event.test.lineNumber))
        ? ""
    end function
    instance.super0_onTestComplete = instance.onTestComplete
    instance.onTestComplete = function(event as object)
        if event.test.isIgnored then
            return invalid
        end if
        ? rooibos_common_fillText("<<<< END It: " + event.test.name + " (" + event.test.result.getStatusText() + ") ", "<", 80)
    end function
    ' override function onTestGroupComplete(event as rooibos.TestReporterOnTestGroupCompleteEvent)
    '   'override me
    ' end function
    ' override function onSuiteComplete(event as rooibos.TestReporterOnSuiteCompleteEvent)
    '   'override me
    ' end function
    instance.super0_onEnd = instance.onEnd
    instance.onEnd = function(event as object)
        m.allStats = event.stats
        m.startReport()
        for each testSuite in m.testRunner.testSuites
            if not testSuite.isIgnored
                if not m.allStats.hasFailures or ((not m.config.showOnlyFailures) or testSuite.stats.failedCount > 0 or testSuite.stats.crashedCount > 0)
                    m.printSuiteStart(testSuite)
                    for each testGroup in testSuite.groups
                        m.printGroup(testGroup)
                    end for
                end if
            end if
        end for
        m.printLine()
        'bs:disable-next-line
        ignoredInfo = m.testRunner.runtimeConfig.getIgnoredTestInfo()
        m.printLine(0, "Total: " + rooibos_common_AsString(m.allStats.ranCount))
        m.printLine(0, "  Passed: " + rooibos_common_AsString(m.allStats.passedCount))
        m.printLine(0, "  Crashed: " + rooibos_common_AsString(m.allStats.crashedCount))
        m.printLine(0, "  Failed: " + rooibos_common_AsString(m.allStats.failedCount))
        'bs:disable-next-line
        m.printLine(0, "  Ignored: " + rooibos_common_AsString(ignoredInfo.count))
        m.printLine(0, "  Time: " + rooibos_common_AsString(m.allStats.time) + "ms")
        m.printLine()
        m.printLine()
        if ignoredInfo.count > 0
            m.printLine(0, "IGNORED TESTS:")
            for each ignoredItemName in ignoredInfo.items
                m.printLine(1, ignoredItemName)
            end for
            m.printLine()
            m.printLine()
        end if
        overrallResult = ""
        if m.allStats.hasFailures
            overrallResult = "Fail"
        else
            overrallResult = "Success"
        end if
        m.printLine(0, "RESULT: " + overrallResult)
        m.endReport()
    end function
    instance.printGroup = function(testGroup)
        if testGroup.isIgnored then
            return invalid
        end if
        isGroupPrinted = false
        for each test in testGroup.tests
            if not test.result.isSkipped
                if not m.allStats.hasFailures or ((not m.config.showOnlyFailures) or test.result.isFail)
                    if not isGroupPrinted
                        m.printGroupStart(testGroup)
                        isGroupPrinted = true
                    end if
                    m.printTest(test)
                end if
            end if
        end for
        if isGroupPrinted
            m.printLine(0, " |")
        end if
    end function
    instance.printTest = function(test)
        testLocationLine = StrI(test.lineNumber).trim()
        locationLine = invalid
        testChar = ""
        if test.result.isCrash
            testChar = "|"
            locationLine = StrI(test.lineNumber).trim()
        else if test.result.isFail
            testChar = "-"
            locationLine = StrI(test.result.lineNumber).trim()
        else
            testChar = "|"
            locationLine = StrI(test.lineNumber).trim()
        end if
        testLocationText = "file://" + test.testSuite.filePath.trim() + ":" + testLocationLine
        timeText = ""
        if m.config.printTestTimes = true
            timeText = " (" + stri(test.result.time).trim() + "ms)"
        end if
        insetText = ""
        if test.isParamTest <> true
            messageLine = rooibos_common_fillText(" " + testChar + " |--" + test.name + " : ", ".", m.lineWidth)
            m.printLine(0, messageLine + test.result.getStatusText() + timeText)
            m.printLine(0, " | " + insetText + "  |--Test : " + testLocationText)
        else if test.paramTestIndex = 0
            name = test.name
            if len(name) > 1 and right(name, 1) = "0"
                name = left(name, len(name) - 1)
            end if
            m.printLine(0, " " + testChar + " |--" + name + " : ")
            m.printLine(0, " | " + insetText + "  |--Test : " + testLocationText)
        end if
        locationText = "file://" + test.testSuite.filePath.trim() + ":" + locationLine
        if test.isParamTest = true
            insetText = "  "
            rawParams = invalid
            if type(test.rawParams) = "roAssociativeArray"
                rawParams = {}
                for each key in test.rawParams
                    if type(test.rawParams[key]) <> "Function" and type(test.rawParams[key]) <> "roFunction"
                        rawParams[key] = test.rawParams[key]
                    end if
                end for
            else
                rawParams = test.rawParams
            end if
            messageLine = rooibos_common_fillText(" " + testChar + insetText + " |--" + formatJson(rawParams) + " : ", ".", m.lineWidth)
            m.printLine(0, messageLine + test.result.getStatusText() + timeText)
        end if
        if test.result.isCrash
            m.printLine(0, " | " + insetText + "  |--Crashed at: " + locationText)
            m.printStackTrace(insetText, test.result.error)
            m.printLine(0, " | ")
        else if test.result.isFail
            m.printLine(0, " | " + insetText + "  |--Failed at: " + locationText)
            if test.isParamTest = true
                m.printLine(0, " | " + insetText + "  |--Param Line: " + StrI(test.paramLineNumber).trim())
            end if
            m.printLine(0, " | " + insetText + "  |--Error Message: " + test.result.message)
            m.printLine(0, " | ")
        end if
    end function
    instance.printStackTrace = function(insetText, error)
        m.printLine(0, " | " + insetText + "  |")
        m.printLine(0, " | " + insetText + "  |--Message: " + error.message)
        m.printLine(0, " | " + insetText + "  |--Stack trace: ")
        for i = error.backTrace.count() - 1 to 0 step -1
            e = error.backTrace[i]
            if e.filename.instr("pkg:/source/rooibos") = -1
                m.printLine(0, " | " + insetText + "    " + e.filename + "(" + stri(e.line_number).trim() + ")")
            end if
        end for
    end function
    instance.startReport = function()
        m.printLine()
        m.printLine(0, "[START TEST REPORT]")
        m.printLine()
    end function
    instance.endReport = function()
        m.printLine()
        m.printLine(0, "[END TEST REPORT]")
        m.printLine()
    end function
    instance.printSuiteStart = function(testSuite)
        m.printLine(0, " " + testSuite.name + " file://" + testSuite.filePath.trim() + ":" + str(testSuite.lineNumber).trim())
    end function
    instance.printGroupStart = function(testGroup)
        m.printLine(0, " |-" + testGroup.name)
    end function
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    '++ printing
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    instance.printLine = function(depth = 0, text = "")
        ? " "; text
    end function
    return instance
end function
function rooibos_ConsoleTestReporter(runner)
    instance = __rooibos_ConsoleTestReporter_builder()
    instance.new(runner)
    return instance
end function
'//# sourceMappingURL=./ConsoleTestReporter.brs.map