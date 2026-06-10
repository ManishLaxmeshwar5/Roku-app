' @ignore
function __rooibos_MochaTestReporter_builder()
    RBS_CC_29_reportLine("2", 1)
    instance = __rooibos_BaseTestReporter_builder()
    RBS_CC_29_reportLine("3", 1)
    instance.super0_new = instance.new
    RBS_CC_29_reportLine("4", 1)
    instance.new = sub(runner)
        'bs:disable-next-line
        RBS_CC_29_reportLine("6", 1)
        m.failureCount = 0
        RBS_CC_29_reportLine("7", 1)
        m.super0_new(runner)
    end sub
    ' override function onBegin(event as rooibos.TestReporterOnBeginEvent)
    '   'override me
    ' end function
    RBS_CC_29_reportLine("12", 1)
    instance.super0_onSuiteBegin = instance.onSuiteBegin
    RBS_CC_29_reportLine("13", 1)
    instance.onSuiteBegin = sub(event as object)
        RBS_CC_29_reportLine("14", 1)
        print m.colorLines("0", event.suite.name)
    end sub
    RBS_CC_29_reportLine("16", 1)
    instance.super0_onTestGroupBegin = instance.onTestGroupBegin
    RBS_CC_29_reportLine("17", 1)
    instance.onTestGroupBegin = sub(event as object)
        RBS_CC_29_reportLine("18", 1)
        print tab(2) m.colorLines("0", event.group.name)
    end sub
    ' override function onTestBegin(event as rooibos.TestReporterOnTestBeginEvent)
    '   'override me
    ' end function
    RBS_CC_29_reportLine("23", 1)
    instance.super0_onTestComplete = instance.onTestComplete
    RBS_CC_29_reportLine("24", 1)
    instance.onTestComplete = sub(event as object)
        RBS_CC_29_reportLine("25", 1)
        test = event.test
        RBS_CC_29_reportLine("26", 1)
        status = test.result.getStatusText()
        RBS_CC_29_reportLine("27", 1)
        lineColor = "90"
        RBS_CC_29_reportLine("28", 1)
        symbolColor = ""
        RBS_CC_29_reportLine("29", 1)
        symbol = "?"
        if RBS_CC_29_reportLine("30", 2) and (status = "PASS")
            RBS_CC_29_reportLine("30", 3)
            RBS_CC_29_reportLine("31", 1)
            symbol = "✔"
            RBS_CC_29_reportLine("32", 1)
            symbolColor = "32"
        else if RBS_CC_29_reportLine("33", 2) and (status = "FAIL" or status = "CRASH")
            RBS_CC_29_reportLine("33", 3)
            RBS_CC_29_reportLine("34", 1)
            symbol = "✖"
            RBS_CC_29_reportLine("35", 1)
            symbolColor = "91"
        else if RBS_CC_29_reportLine("36", 2) and (status = "SKIP")
            RBS_CC_29_reportLine("36", 3)
            RBS_CC_29_reportLine("37", 1)
            symbol = "-"
            RBS_CC_29_reportLine("38", 1)
            symbolColor = "36"
            RBS_CC_29_reportLine("39", 1)
            lineColor = "36"
        end if
        RBS_CC_29_reportLine("41", 1)
        params = ""
        if RBS_CC_29_reportLine("42", 2) and (test.isParamTest)
            RBS_CC_29_reportLine("42", 3)
            RBS_CC_29_reportLine("43", 1)
            rawParams = invalid
            if RBS_CC_29_reportLine("44", 2) and (type(test.rawParams) = "roAssociativeArray")
                RBS_CC_29_reportLine("44", 3)
                RBS_CC_29_reportLine("45", 1)
                rawParams = {}
                RBS_CC_29_reportLine("46", 1): for each key in test.rawParams
                    if RBS_CC_29_reportLine("47", 2) and (type(test.rawParams[key]) <> "Function" and type(test.rawParams[key]) <> "roFunction")
                        RBS_CC_29_reportLine("47", 3)
                        RBS_CC_29_reportLine("48", 1)
                        rawParams[key] = test.rawParams[key]
                    end if
                end for
            else
                RBS_CC_29_reportLine("51", 3)
                RBS_CC_29_reportLine("52", 1)
                rawParams = test.rawParams
            end if
            RBS_CC_29_reportLine("54", 1)
            params = " " + formatJson(rawParams)
        end if
        RBS_CC_29_reportLine("56", 1)
        duration = ""
        if RBS_CC_29_reportLine("57", 2) and (test.result.time > test.slow)
            RBS_CC_29_reportLine("57", 3)
            RBS_CC_29_reportLine("58", 1)
            duration = m.colorLines("31", (" (" + bslib_toString(test.result.time) + "ms)"))
        else if RBS_CC_29_reportLine("59", 2) and (test.result.time > test.slow / 2)
            RBS_CC_29_reportLine("59", 3)
            RBS_CC_29_reportLine("60", 1)
            duration = m.colorLines("33", (" (" + bslib_toString(test.result.time) + "ms)"))
            ' else if test.result.time > slow / 4
            '   duration = m.colorLines(rooibos.reporters.mocha.colors.fast, ` (${test.result.time}ms)`)
        end if
        RBS_CC_29_reportLine("64", 1)
        print tab(4) m.colorLines(symbolColor, symbol) + " " + m.colorLines(lineColor, test.name + params) + duration
    end sub
    ' override function onTestGroupComplete(event as rooibos.TestReporterOnTestGroupCompleteEvent)
    '   'override me
    ' end function
    ' override function onSuiteComplete(event as rooibos.TestReporterOnSuiteCompleteEvent)
    '   'override me
    ' end function
    RBS_CC_29_reportLine("72", 1)
    instance.super0_onEnd = instance.onEnd
    RBS_CC_29_reportLine("73", 1)
    instance.onEnd = sub(event as object)
        RBS_CC_29_reportLine("74", 1)
        print m.formatStatsString(event.stats)
        RBS_CC_29_reportLine("75", 1): for each testSuite in m.testRunner.testSuites
            RBS_CC_29_reportLine("76", 1): for each testGroup in testSuite.groups
                RBS_CC_29_reportLine("77", 1)
                m.logFailures(testGroup)
            end for
        end for
    end sub
    ' Creates a formatted string from the stats object
    ' example:
    '`
    '     327 passed (5113ms)
    '     1 crashed
    '     207 failing
    '     8 skipped
    '`
    RBS_CC_29_reportLine("89", 1)
    instance.formatStatsString = function(stats as object) as string
        RBS_CC_29_reportLine("90", 1)
        statusString = chr(10)
        RBS_CC_29_reportLine("91", 1)
        indent = string(1, chr(9))
        RBS_CC_29_reportLine("92", 1)
        statusString += (bslib_toString(indent) + bslib_toString(m.colorLines("92", (bslib_toString(stats.passedCount) + " passed"))) + " " + bslib_toString(m.colorLines("90", (" (" + bslib_toString(stats.time) + "ms)"))))
        if RBS_CC_29_reportLine("93", 2) and (stats.crashedCount > 0)
            RBS_CC_29_reportLine("93", 3)
            RBS_CC_29_reportLine("94", 1)
            statusString += chr(10) + m.colorLines("31", (bslib_toString(indent) + bslib_toString(stats.crashedCount) + " crashed"))
        end if
        if RBS_CC_29_reportLine("96", 2) and (stats.failedCount > 0)
            RBS_CC_29_reportLine("96", 3)
            RBS_CC_29_reportLine("97", 1)
            statusString += chr(10) + m.colorLines("31", (bslib_toString(indent) + bslib_toString(stats.failedCount) + " failing"))
        end if
        if RBS_CC_29_reportLine("99", 2) and (stats.ignoredCount > 0)
            RBS_CC_29_reportLine("99", 3)
            RBS_CC_29_reportLine("100", 1)
            statusString += chr(10) + m.colorLines("36", (bslib_toString(indent) + bslib_toString(stats.ignoredCount) + " skipped"))
        end if
        RBS_CC_29_reportLine("102", 1)
        statusString += chr(10)
        RBS_CC_29_reportLine("103", 1)
        return statusString
    end function
    ' Logs all failures for a given test group
    ' example:
    '    1) Rooibos failed assertion tests
    '      tests fail on crash
    '        reports error:
    '
    '    Error: some error
    '        $anon_6c() As Dynamic (pkg:/source/FailedAssertion.spec.brs:11)
    '        $anon_303() As Dynamic (pkg:/source/rooibos/Test.brs:45)
    '        $anon_1f2(test As Object) As Dynamic (pkg:/source/rooibos/BaseTestSuite.brs:243)
    '        $anon_30a() As Dynamic (pkg:/source/rooibos/TestGroup.brs:88)
    '        $anon_309() As Dynamic (pkg:/source/rooibos/TestGroup.brs:68)
    '        $anon_1ec() As Dynamic (pkg:/source/rooibos/BaseTestSuite.brs:131)
    '        $anon_1eb() As Dynamic (pkg:/source/rooibos/BaseTestSuite.brs:121)
    '        $anon_325(testsuite As Dynamic) As Void (pkg:/source/rooibos/TestRunner.brs:191)
    '        $anon_322() As Dynamic (pkg:/source/rooibos/TestRunner.brs:72)
    '        rooibos_init(testscenename As Dynamic) As Void (pkg:/source/rooibos/Rooibos.brs:27)
    '        main(args As Dynamic) As Dynamic (pkg:/source/Main.brs:2)
    '
    '    at (file:///Users/chris/roku/rooibos/tests/src/source/FailedAssertion.spec.bs:15)
    '
    '    2) Rooibos failed assertion tests
    '        tests AssertTrue fail
    '            AssertTrue with message 0:
    '
    '    AssertionError: expected "false (Boolean)" to be true (Boolean)
    '      + expected - actual
    '
    '      -false (Boolean)
    '      +true (Boolean)
    '
    '    params at (file:///Users/chris/roku/rooibos/tests/src/source/FailedAssertion.spec.bs:23)
    '    assertion at (file:///Users/chris/roku/rooibos/tests/src/source/FailedAssertion.spec.bs:31)
    '
    RBS_CC_29_reportLine("139", 1)
    instance.logFailures = sub(testGroup)
        RBS_CC_29_reportLine("140", 1): for each test in testGroup.tests
            if RBS_CC_29_reportLine("141", 2) and (test.result.isFail)
                RBS_CC_29_reportLine("141", 3)
                RBS_CC_29_reportLine("142", 1)
                m.failureCount++
                RBS_CC_29_reportLine("143", 1)
                resultMessage = ""
                RBS_CC_29_reportLine("144", 1)
                resultMessage += (bslib_toString(string(1, chr(9))) + bslib_toString(m.failureCount.toStr()) + ") " + bslib_toString(test.testSuite.name) + chr(10))
                RBS_CC_29_reportLine("145", 1)
                resultMessage += (bslib_toString(string(2, chr(9))) + bslib_toString(testGroup.name) + chr(10))
                RBS_CC_29_reportLine("146", 1)
                resultMessage += (bslib_toString(string(3, chr(9))) + bslib_toString(test.name) + ":" + chr(10) + chr(10))
                if RBS_CC_29_reportLine("147", 2) and (not test.result.isCrash)
                    RBS_CC_29_reportLine("147", 3)
                    RBS_CC_29_reportLine("148", 1)
                    resultMessage += (bslib_toString(string(1, chr(9))) + "AssertionError: " + bslib_toString(test.result.getMessage()))
                    if RBS_CC_29_reportLine("149", 2) and ((test.result.actual <> "" or test.result.expected <> "") and (test.result.actual <> test.result.expected))
                        RBS_CC_29_reportLine("149", 3)
                        RBS_CC_29_reportLine("150", 1)
                        resultMessage += m.unifiedDiff(test.result.actual, test.result.expected)
                    end if
                    RBS_CC_29_reportLine("152", 1)
                    resultMessage += chr(10)
                else
                    RBS_CC_29_reportLine("153", 3)
                    RBS_CC_29_reportLine("154", 1)
                    resultMessage += (bslib_toString(string(1, chr(9))) + "Error: " + bslib_toString(m.getStackTrace(test.result.error)) + chr(10))
                end if
                if RBS_CC_29_reportLine("156", 2) and (test.result.error <> invalid and not test.result.isCrash)
                    RBS_CC_29_reportLine("156", 3)
                    RBS_CC_29_reportLine("157", 1)
                    resultMessage += m.getStackTrace(test.result.error, false) + chr(10)
                end if
                if RBS_CC_29_reportLine("159", 2) and (test.isParamTest)
                    RBS_CC_29_reportLine("159", 3)
                    RBS_CC_29_reportLine("160", 1)
                    resultMessage += (bslib_toString(string(6, " ")) + bslib_toString(m.colorLines("90", ("params at (file://" + bslib_toString(test.testSuite.filePath.trim()) + ":" + bslib_toString(Rooibos_Common_AsString(test.paramLineNumber)) + ")"))) + chr(10))
                end if
                if RBS_CC_29_reportLine("162", 2) and (test.result.lineNumber > -1)
                    RBS_CC_29_reportLine("162", 3)
                    RBS_CC_29_reportLine("163", 1)
                    resultMessage += (bslib_toString(string(6, " ")) + bslib_toString(m.colorLines("90", ("assertion at (file://" + bslib_toString(test.testSuite.filePath.trim()) + ":" + bslib_toString(Rooibos_Common_AsString(test.result.lineNumber)) + ")"))) + chr(10))
                else
                    RBS_CC_29_reportLine("164", 3)
                    RBS_CC_29_reportLine("165", 1)
                    resultMessage += (bslib_toString(string(6, " ")) + bslib_toString(m.colorLines("90", ("test at (file://" + bslib_toString(test.testSuite.filePath.trim()) + ":" + bslib_toString(Rooibos_Common_AsString(test.lineNumber)) + ")"))) + chr(10))
                end if
                RBS_CC_29_reportLine("167", 1)
                print resultMessage
            end if
        end for
    end sub
    ' Returns a string representation of the stack trace
    ' example:
    '    Error: some error
    '        $anon_6c() As Dynamic (pkg:/source/FailedAssertion.spec.brs:11)
    '        $anon_303() As Dynamic (pkg:/source/rooibos/Test.brs:45)
    '        $anon_1f2(test As Object) As Dynamic (pkg:/source/rooibos/BaseTestSuite.brs:243)
    '        $anon_30a() As Dynamic (pkg:/source/rooibos/TestGroup.brs:88)
    '        $anon_309() As Dynamic (pkg:/source/rooibos/TestGroup.brs:68)
    '        $anon_1ec() As Dynamic (pkg:/source/rooibos/BaseTestSuite.brs:131)
    '        $anon_1eb() As Dynamic (pkg:/source/rooibos/BaseTestSuite.brs:121)
    '        $anon_325(testsuite As Dynamic) As Void (pkg:/source/rooibos/TestRunner.brs:191)
    '        $anon_322() As Dynamic (pkg:/source/rooibos/TestRunner.brs:72)
    '        rooibos_init(testscenename As Dynamic) As Void (pkg:/source/rooibos/Rooibos.brs:27)
    '        main(args As Dynamic) As Dynamic (pkg:/source/Main.brs:2)
    RBS_CC_29_reportLine("185", 1)
    instance.getStackTrace = function(error, fullTrace = true) as string
        if RBS_CC_29_reportLine("186", 2) and (fullTrace)
            RBS_CC_29_reportLine("186", 3)
            RBS_CC_29_reportLine("187", 1)
            output = m.colorLines("0", (bslib_toString(error.message) + chr(10)))
            RBS_CC_29_reportLine("188", 1)
            indent = 6
        else
            RBS_CC_29_reportLine("189", 3)
            RBS_CC_29_reportLine("190", 1)
            output = ""
            RBS_CC_29_reportLine("191", 1)
            indent = 6
        end if
        RBS_CC_29_reportLine("193", 1)
        foundNonFrameworkFile = false
        RBS_CC_29_reportLine("194", 1): for i = error.backTrace.count() - 1 to 0 step -1
            RBS_CC_29_reportLine("195", 1)
            e = error.backTrace[i]
            RBS_CC_29_reportLine("196", 1)
            isFrameworkFile = e.filename.instr("pkg:/source/rooibos") > -1 or e.filename.instr("pkg:/components/rooibos/generated") > -1
            if RBS_CC_29_reportLine("197", 2) and (fullTrace or not isFrameworkFile)
                RBS_CC_29_reportLine("197", 3)
                RBS_CC_29_reportLine("198", 1)
                output += m.colorLines("90", (bslib_toString(string(indent, " ")) + bslib_toString(e["function"]) + " (" + bslib_toString(e.filename.trim()) + ":" + bslib_toString(Rooibos_Common_AsString(e.line_number)) + ")")) + chr(10)
                RBS_CC_29_reportLine("199", 1)
                foundNonFrameworkFile = true
            end if
            if RBS_CC_29_reportLine("201", 2) and (not fullTrace and (foundNonFrameworkFile and isFrameworkFile))
                RBS_CC_29_reportLine("201", 3)
                RBS_CC_29_reportLine("202", 1)
                return output
            end if
        end for
        RBS_CC_29_reportLine("205", 1)
        return output
    end function
    ' Returns a unified diff string based on the actual and expected string values
    ' example:
    '      + expected - actual
    '
    '      -0 (Integer)
    '      +true (Boolean)
    RBS_CC_29_reportLine("213", 1)
    instance.unifiedDiff = function(actual, expected)
        RBS_CC_29_reportLine("214", 1)
        cleanUp = function(line, m)
            RBS_CC_29_reportLine("215", 1)
            indent = "      "
            if RBS_CC_29_reportLine("216", 2) and (line.left(1) = "+")
                RBS_CC_29_reportLine("216", 3)
                RBS_CC_29_reportLine("217", 1)
                return indent + m.colorLines("32", line)
            end if
            if RBS_CC_29_reportLine("219", 2) and (line.left(1) = "-")
                RBS_CC_29_reportLine("219", 3)
                RBS_CC_29_reportLine("220", 1)
                return indent + m.colorLines("31", line)
            end if
            if RBS_CC_29_reportLine("222", 2) and (CreateObject("roRegex", "@@", "").isMatch(line))
                RBS_CC_29_reportLine("222", 3)
                RBS_CC_29_reportLine("223", 1)
                return "--"
            end if
            if RBS_CC_29_reportLine("225", 2) and (CreateObject("roRegex", "\\ No newline", "").isMatch(line))
                RBS_CC_29_reportLine("225", 3)
                RBS_CC_29_reportLine("226", 1)
                return invalid
            end if
            RBS_CC_29_reportLine("228", 1)
            return indent + line
        end function
        RBS_CC_29_reportLine("230", 1)
        msg = m.createPatch("string", actual, expected)
        RBS_CC_29_reportLine("231", 1)
        lines = msg.split(chr(10)).slice(5)
        RBS_CC_29_reportLine("232", 1)
        final = chr(10) + "      " + m.colorLines("32", "+ expected") + " " + m.colorLines("31", "- actual")
        RBS_CC_29_reportLine("233", 1)
        final += chr(10) + chr(10)
        RBS_CC_29_reportLine("234", 1)
        cleanLines = []
        RBS_CC_29_reportLine("235", 1): for i = 0 to lines.count() - 1
            RBS_CC_29_reportLine("236", 1)
            cleaned = cleanUp(lines[i], m)
            if RBS_CC_29_reportLine("237", 2) and (cleaned <> invalid)
                RBS_CC_29_reportLine("237", 3)
                RBS_CC_29_reportLine("238", 1)
                cleanLines.push(cleaned)
            end if
        end for
        RBS_CC_29_reportLine("241", 1)
        return final + cleanLines.join(chr(10))
    end function
    ' Applies Asci colors to each line of a string based on the supplied color type
    RBS_CC_29_reportLine("244", 1)
    instance.colorLines = function(name as dynamic, targetString as string) as string
        RBS_CC_29_reportLine("245", 1)
        lines = targetString.split(chr(10))
        RBS_CC_29_reportLine("246", 1): for i = 0 to lines.count() - 1
            RBS_CC_29_reportLine("247", 1)
            lines[i] = m.colors(name, lines[i])
        end for
        RBS_CC_29_reportLine("249", 1)
        return lines.join(chr(10))
    end function
    ' Applies Asci colors the supplied of a string based on the supplied color type
    RBS_CC_29_reportLine("252", 1)
    instance.colors = function(colorType, targetString)
        ' colors = {
        '   pass: 90,
        '   fail: 31,
        '   "bright pass": 92,
        '   "bright fail": 91,
        '   "bright yellow": 93,
        '   pending: 36,
        '   suite: 0,
        '   "error title": 0,
        '   "error message": 31,
        '   "error stack": 90,
        '   checkmark: 32,
        '   fast: 90,
        '   medium: 33,
        '   slow: 31,
        '   green: 32,
        '   light: 90,
        '   "diff gutter": 90,
        '   "diff added": 32,
        '   "diff removed": 31,
        '   "diff added inline": "30;42",
        '   "diff removed inline": "30;41"
        ' }
        if RBS_CC_29_reportLine("276", 2) and (m.colorizeOutput)
            RBS_CC_29_reportLine("276", 3)
            RBS_CC_29_reportLine("277", 1)
            return chr(27) + "[" + colorType + "m" + targetString + chr(27) + "[0m"
            ' return chr(27) + "[" + colors[colorType].toStr() + "m" + targetString + chr(27) + "[0m"
            ' return "\u001b[" + colors[colorType].toStr() + "m" + targetString + "\u001b[0m"
        else
            RBS_CC_29_reportLine("280", 3)
            RBS_CC_29_reportLine("281", 1)
            return targetString
        end if
    end function
    ' Creates a patch file string based on the the differences of the two supplied strings
    RBS_CC_29_reportLine("285", 1)
    instance.createPatch = function(fileName, oldStr, newStr)
        RBS_CC_29_reportLine("286", 1)
        result = m.structuredPatch(fileName, fileName, oldStr, newStr, invalid, invalid, {
            context: 4
            newlineIsToken: false
        })
        if RBS_CC_29_reportLine("290", 2) and (result <> invalid)
            RBS_CC_29_reportLine("290", 3)
            RBS_CC_29_reportLine("291", 1)
            return m.formatPatch(result)
        end if
        RBS_CC_29_reportLine("293", 1)
        return invalid
    end function
    ' Generate a structured patch object from two strings
    RBS_CC_29_reportLine("296", 1)
    instance.structuredPatch = function(oldFileName, newFileName, oldStr, newStr, oldHeader, newHeader, options)
        if RBS_CC_29_reportLine("297", 2) and (options = invalid)
            RBS_CC_29_reportLine("297", 3)
            RBS_CC_29_reportLine("298", 1)
            options = {}
        end if
        if RBS_CC_29_reportLine("300", 2) and (options.context = invalid)
            RBS_CC_29_reportLine("300", 3)
            RBS_CC_29_reportLine("301", 1)
            options.context = 4
        end if
        if RBS_CC_29_reportLine("303", 2) and (options.newlineIsToken = true)
            RBS_CC_29_reportLine("303", 3)
            throw "newlineIsToken may not be used with patch-generation functions, only with diffing functions"
        end if
        RBS_CC_29_reportLine("306", 1)
        return m.diffLinesResultToPatch(m.diffLines(oldStr, newStr, options), oldFileName, newFileName, oldHeader, newHeader, options)
    end function
    ' Diff two sets of strings, comparing them line by line
    RBS_CC_29_reportLine("309", 1)
    instance.diffLines = function(oldStr, newStr, callback)
        RBS_CC_29_reportLine("310", 1)
        lineDiff = rooibos_reporters_mocha_new_lineDiff()
        RBS_CC_29_reportLine("311", 1)
        return lineDiff.diff(oldStr, newStr, {
            ignoreCase: false
            comparator: invalid
            useLongestToken: false
            oneChangePerToken: false
            maxEditLength: invalid
        })
    end function
    ' Convert a diff result into a patch
    RBS_CC_29_reportLine("320", 1)
    instance.diffLinesResultToPatch = function(diff, oldFileName, newFileName, oldHeader, newHeader, options)
        ' STEP 1: Build up the patch with no "\ No newline at end of file" lines and with the arrays
        '         of lines containing trailing newline characters. We'll tidy up later...
        if RBS_CC_29_reportLine("323", 2) and (diff = invalid)
            RBS_CC_29_reportLine("323", 3)
            RBS_CC_29_reportLine("324", 1)
            return invalid
        end if
        RBS_CC_29_reportLine("326", 1)
        diff.push({
            value: ""
            lines: []
        }) ' Append an empty value to make cleanup easier
        RBS_CC_29_reportLine("330", 1)
        hunks = []
        RBS_CC_29_reportLine("331", 1)
        oldRangeStart = 0
        RBS_CC_29_reportLine("332", 1)
        newRangeStart = 0
        RBS_CC_29_reportLine("333", 1)
        curRange = []
        RBS_CC_29_reportLine("334", 1)
        oldLine = 1
        RBS_CC_29_reportLine("335", 1)
        newLine = 1
        RBS_CC_29_reportLine("336", 1): for i = 0 to diff.count() - 1
            RBS_CC_29_reportLine("337", 1)
            current = diff[i]
            if RBS_CC_29_reportLine("338", 2) and (current.lines <> invalid)
                RBS_CC_29_reportLine("338", 3)
                RBS_CC_29_reportLine("339", 1)
                lines = current.lines
            else
                RBS_CC_29_reportLine("340", 3)
                RBS_CC_29_reportLine("341", 1)
                lines = m.splitLines(current.value)
            end if
            RBS_CC_29_reportLine("343", 1)
            current.lines = lines
            if RBS_CC_29_reportLine("344", 2) and (current.added = true or current.removed = true)
                RBS_CC_29_reportLine("344", 3)
                ' If we have previous context, start with that
                if RBS_CC_29_reportLine("346", 2) and (not (oldRangeStart) = true)
                    RBS_CC_29_reportLine("346", 3)
                    RBS_CC_29_reportLine("347", 1)
                    prev = diff[i - 1]
                    RBS_CC_29_reportLine("348", 1)
                    oldRangeStart = oldLine
                    RBS_CC_29_reportLine("349", 1)
                    newRangeStart = newLine
                    if RBS_CC_29_reportLine("350", 2) and (prev <> invalid)
                        RBS_CC_29_reportLine("350", 3)
                        if RBS_CC_29_reportLine("351", 2) and (options.context > 0)
                            RBS_CC_29_reportLine("351", 3)
                            RBS_CC_29_reportLine("352", 1)
                            curRange = m.contextLines(prev.lines.slice(- options.context))
                        else
                            RBS_CC_29_reportLine("353", 3)
                            RBS_CC_29_reportLine("354", 1)
                            curRange = []
                        end if
                        RBS_CC_29_reportLine("356", 1)
                        oldRangeStart -= curRange.count()
                        RBS_CC_29_reportLine("357", 1)
                        newRangeStart -= curRange.count()
                    end if
                end if
                ' Output our changes
                RBS_CC_29_reportLine("361", 1): for each entry in lines
                    if RBS_CC_29_reportLine("362", 2) and (current.added)
                        RBS_CC_29_reportLine("362", 3)
                        RBS_CC_29_reportLine("363", 1)
                        curRange.push("+" + entry)
                    else
                        RBS_CC_29_reportLine("364", 3)
                        RBS_CC_29_reportLine("365", 1)
                        curRange.push("-" + entry)
                    end if
                end for
                ' Track the updated file position
                if RBS_CC_29_reportLine("369", 2) and (current.added)
                    RBS_CC_29_reportLine("369", 3)
                    RBS_CC_29_reportLine("370", 1)
                    newLine += lines.count()
                else
                    RBS_CC_29_reportLine("371", 3)
                    RBS_CC_29_reportLine("372", 1)
                    oldLine += lines.count()
                end if
            else
                RBS_CC_29_reportLine("374", 3)
                ' Identical context lines. Track line changes
                if RBS_CC_29_reportLine("376", 2) and (oldRangeStart)
                    RBS_CC_29_reportLine("376", 3)
                    ' Close out any changes that have been output (or join overlapping)
                    if RBS_CC_29_reportLine("378", 2) and (lines.count() <= options.context * 2 and i < diff.count() - 2)
                        RBS_CC_29_reportLine("378", 3)
                        ' Overlapping
                        RBS_CC_29_reportLine("380", 1)
                        curRange.append(m.contextLines(lines))
                    else
                        RBS_CC_29_reportLine("381", 3)
                        ' end the range and output
                        RBS_CC_29_reportLine("383", 1)
                        contextSize = rooibos_reporters_mocha_min(lines.count(), options.context)
                        RBS_CC_29_reportLine("384", 1)
                        curRange.append(m.contextLines(lines.slice(0, contextSize)))
                        RBS_CC_29_reportLine("385", 1)
                        hunk = {
                            oldStart: oldRangeStart
                            oldLines: (oldLine - oldRangeStart + contextSize)
                            newStart: newRangeStart
                            newLines: (newLine - newRangeStart + contextSize)
                            lines: curRange
                        }
                        RBS_CC_29_reportLine("392", 1)
                        hunks.push(hunk)
                        RBS_CC_29_reportLine("393", 1)
                        oldRangeStart = 0
                        RBS_CC_29_reportLine("394", 1)
                        newRangeStart = 0
                        RBS_CC_29_reportLine("395", 1)
                        curRange = []
                    end if
                end if
                RBS_CC_29_reportLine("398", 1)
                oldLine += lines.count()
                RBS_CC_29_reportLine("399", 1)
                newLine += lines.count()
            end if
        end for
        ' Step 2: eliminate the trailing `\n` from each line of each hunk, and, where needed, add
        '         "\ No newline at end of file".
        RBS_CC_29_reportLine("404", 1): for each hunk in hunks
            RBS_CC_29_reportLine("405", 1): for i = 0 to hunk.lines.count() - 1
                if RBS_CC_29_reportLine("406", 2) and (hunk.lines[i].endsWith(chr(10)))
                    RBS_CC_29_reportLine("406", 3)
                    RBS_CC_29_reportLine("407", 1)
                    hunk.lines[i] = hunk.lines[i].mid(0, len(hunk.lines[i]) - 1)
                else
                    RBS_CC_29_reportLine("408", 3)
                    RBS_CC_29_reportLine("409", 1)
                    hunk.lines = rooibos_reporters_mocha_arraySplice(hunk.lines, i + 1, 0, [
                        "\ No newline at end of file"
                    ])
                    RBS_CC_29_reportLine("412", 1)
                    i++ ' Skip the line we just added, then continue iterating
                end if
            end for
        end for
        RBS_CC_29_reportLine("416", 1)
        return {
            oldFileName: oldFileName
            newFileName: newFileName
            oldHeader: oldHeader
            newHeader: newHeader
            hunks: hunks
        }
    end function
    ' Split `text` into an array of lines, including the trailing newline character (where present)
    RBS_CC_29_reportLine("425", 1)
    instance.splitLines = function(text)
        RBS_CC_29_reportLine("426", 1)
        hasTrailingNl = text.endsWith(chr(10))
        RBS_CC_29_reportLine("427", 1)
        result = rooibos_reporters_mocha_arrayMap(text.split(chr(10)), function(line, _ = invalid)
            RBS_CC_29_reportLine("428", 1)
            return line + chr(10)
        end function)
        if RBS_CC_29_reportLine("430", 2) and (hasTrailingNl)
            RBS_CC_29_reportLine("430", 3)
            RBS_CC_29_reportLine("431", 1)
            result.pop()
        else
            RBS_CC_29_reportLine("432", 3)
            RBS_CC_29_reportLine("433", 1)
            lastEntry = result.pop()
            RBS_CC_29_reportLine("434", 1)
            result.push(lastEntry.mid(0, len(lastEntry) - 1))
        end if
        RBS_CC_29_reportLine("436", 1)
        return result
    end function
    RBS_CC_29_reportLine("438", 1)
    instance.contextLines = function(lines)
        RBS_CC_29_reportLine("439", 1)
        return rooibos_reporters_mocha_arrayMap(lines, function(entry, _ = invalid)
            RBS_CC_29_reportLine("440", 1)
            return " " + entry
        end function)
    end function
    ' Return a unified patch file contents from a structured patch
    RBS_CC_29_reportLine("444", 1)
    instance.formatPatch = function(diff, _ = invalid)
        if RBS_CC_29_reportLine("445", 2) and (type(diff) = "roArray")
            RBS_CC_29_reportLine("445", 3)
            RBS_CC_29_reportLine("446", 1)
            return rooibos_reporters_mocha_arrayMap(diff, m.formatPatch).join(chr(10))
        end if
        RBS_CC_29_reportLine("448", 1)
        ret = []
        if RBS_CC_29_reportLine("449", 2) and (diff.oldFileName = diff.newFileName)
            RBS_CC_29_reportLine("449", 3)
            RBS_CC_29_reportLine("450", 1)
            ret.push("Index: " + diff.oldFileName)
        end if
        RBS_CC_29_reportLine("452", 1)
        ret.push("===================================================================")
        if RBS_CC_29_reportLine("453", 2) and (diff.oldHeader <> invalid)
            RBS_CC_29_reportLine("453", 3)
            RBS_CC_29_reportLine("454", 1)
            ret.push("--- " + diff.oldFileName + chr(9) + diff.oldHeader)
        else
            RBS_CC_29_reportLine("455", 3)
            RBS_CC_29_reportLine("456", 1)
            ret.push("--- " + diff.oldFileName)
        end if
        if RBS_CC_29_reportLine("458", 2) and (diff.newHeader <> invalid)
            RBS_CC_29_reportLine("458", 3)
            RBS_CC_29_reportLine("459", 1)
            ret.push("+++ " + diff.newFileName + chr(9) + diff.newHeader)
        else
            RBS_CC_29_reportLine("460", 3)
            RBS_CC_29_reportLine("461", 1)
            ret.push("+++ " + diff.newFileName)
        end if
        RBS_CC_29_reportLine("463", 1): for i = 0 to diff.hunks.count() - 1
            RBS_CC_29_reportLine("464", 1)
            hunk = diff.hunks[i]
            ' Unified Diff Format quirk: If the chunk size is 0,
            ' the first number is one lower than one would expect.
            ' https://www.artima.com/weblogs/viewpost.jsp?thread=164293
            if RBS_CC_29_reportLine("468", 2) and (hunk.oldLines = 0)
                RBS_CC_29_reportLine("468", 3)
                RBS_CC_29_reportLine("469", 1)
                hunk.oldStart -= 1
            end if
            if RBS_CC_29_reportLine("471", 2) and (hunk.newLines = 0)
                RBS_CC_29_reportLine("471", 3)
                RBS_CC_29_reportLine("472", 1)
                hunk.newStart -= 1
            end if
            RBS_CC_29_reportLine("474", 1)
            ret.push("@@ -" + hunk.oldStart.toStr() + "," + hunk.oldLines.toStr() + " +" + hunk.newStart.toStr() + "," + hunk.newLines.toStr() + " @@")
            RBS_CC_29_reportLine("475", 1)
            ret.append(hunk.lines)
        end for
        RBS_CC_29_reportLine("477", 1)
        return ret.join(chr(10)) + chr(10)
    end function
    RBS_CC_29_reportLine("479", 1)
    return instance
end function

function rooibos_MochaTestReporter(runner)
    RBS_CC_29_reportLine("482", 1)
    instance = __rooibos_MochaTestReporter_builder()
    RBS_CC_29_reportLine("483", 1)
    instance.new(runner)
    RBS_CC_29_reportLine("484", 1)
    return instance
end function

' @ignore
' @ignore
function rooibos_reporters_mocha_buildValues(diff, lastComponent, newString, oldString, useLongestToken)
    ' First we convert our linked list of components in reverse order to an
    ' array in the right order:
    RBS_CC_29_reportLine("493", 1)
    components = []
    RBS_CC_29_reportLine("494", 1)
    nextComponent = invalid
    RBS_CC_29_reportLine("495", 1): while lastComponent <> invalid
        RBS_CC_29_reportLine("496", 1)
        components.push(lastComponent)
        RBS_CC_29_reportLine("497", 1)
        nextComponent = lastComponent.previousComponent
        RBS_CC_29_reportLine("498", 1)
        lastComponent.delete("previousComponent")
        RBS_CC_29_reportLine("499", 1)
        lastComponent = nextComponent
    end while
    RBS_CC_29_reportLine("501", 1)
    components.reverse()
    RBS_CC_29_reportLine("502", 1)
    componentPos = 0
    RBS_CC_29_reportLine("503", 1)
    componentLen = components.count()
    RBS_CC_29_reportLine("504", 1)
    newPos = 0
    RBS_CC_29_reportLine("505", 1)
    oldPos = 0
    RBS_CC_29_reportLine("506", 1): for componentPos = 0 to componentLen - 1
        RBS_CC_29_reportLine("507", 1)
        component = components[componentPos]
        if RBS_CC_29_reportLine("508", 2) and (not component.removed)
            RBS_CC_29_reportLine("508", 3)
            if RBS_CC_29_reportLine("509", 2) and (not component.added and useLongestToken = true)
                RBS_CC_29_reportLine("509", 3)
                RBS_CC_29_reportLine("510", 1)
                value = newString.slice(newPos, newPos + component.count)
                RBS_CC_29_reportLine("511", 1)
                newValue = createObject("roArray", component.count(), true)
                RBS_CC_29_reportLine("512", 1): for i = 0 to value.count() - 1
                    RBS_CC_29_reportLine("513", 1)
                    currentValue = value[i]
                    RBS_CC_29_reportLine("514", 1)
                    oldValue = oldString[oldPos + i]
                    if RBS_CC_29_reportLine("515", 2) and (len(oldValue) > len(currentValue))
                        RBS_CC_29_reportLine("515", 3)
                        RBS_CC_29_reportLine("516", 1)
                        newValue[i] = oldValue
                    else
                        RBS_CC_29_reportLine("517", 3)
                        RBS_CC_29_reportLine("518", 1)
                        newValue[i] = currentValue
                    end if
                end for
                RBS_CC_29_reportLine("521", 1)
                value = newValue
                RBS_CC_29_reportLine("522", 1)
                component.value = diff.join(value)
            else
                RBS_CC_29_reportLine("523", 3)
                RBS_CC_29_reportLine("524", 1)
                component.value = diff.join(newString.slice(newPos, newPos + component.count))
            end if
            RBS_CC_29_reportLine("526", 1)
            newPos += component.count
            ' Common case
            if RBS_CC_29_reportLine("528", 2) and (not component.added)
                RBS_CC_29_reportLine("528", 3)
                RBS_CC_29_reportLine("529", 1)
                oldPos += component.count
            end if
        else
            RBS_CC_29_reportLine("531", 3)
            RBS_CC_29_reportLine("532", 1)
            component.value = diff.join(oldString.slice(oldPos, oldPos + component.count))
            RBS_CC_29_reportLine("533", 1)
            oldPos += component.count
        end if
    end for
    RBS_CC_29_reportLine("536", 1)
    return components
end function

function rooibos_reporters_mocha_new_Diff()
    RBS_CC_29_reportLine("540", 1)
    return {
        ' bs:disable-next-line
        diff: function(oldString, newString, options = {})
            RBS_CC_29_reportLine("543", 1)
            Infinity = 2147483647
            RBS_CC_29_reportLine("544", 1)
            oldString = m.removeEmpty(m.tokenize(oldString, options))
            RBS_CC_29_reportLine("545", 1)
            newString = m.removeEmpty(m.tokenize(newString, options))
            RBS_CC_29_reportLine("546", 1)
            newLen = newString.count()
            RBS_CC_29_reportLine("547", 1)
            oldLen = oldString.count()
            RBS_CC_29_reportLine("548", 1)
            editLength = 1
            RBS_CC_29_reportLine("549", 1)
            maxEditLength = newLen + oldLen
            if RBS_CC_29_reportLine("550", 2) and (options.maxEditLength <> invalid)
                RBS_CC_29_reportLine("550", 3)
                RBS_CC_29_reportLine("551", 1)
                maxEditLength = rooibos_reporters_mocha_min(maxEditLength, options.maxEditLength)
            end if
            RBS_CC_29_reportLine("553", 1)
            maxExecutionTime = Infinity
            RBS_CC_29_reportLine("554", 1)
            abortAfterTimestamp = CreateObject("roDateTime").asSeconds() + maxExecutionTime
            RBS_CC_29_reportLine("555", 1)
            bestPath = rooibos_reporters_mocha_new_objectArray()
            ' bestPath = [{ oldPos: -1, lastComponent: invalid }]
            RBS_CC_29_reportLine("557", 1)
            bestPath.set(0, {
                oldPos: -1
                lastComponent: invalid
            })
            ' Seed editLength = 0, i.e. the content starts with the same values
            ' newPos = m.extractCommon(bestPath[0], newString, oldString, 0, options)
            RBS_CC_29_reportLine("563", 1)
            newPos = m.extractCommon(bestPath.get(0), newString, oldString, 0, options)
            if RBS_CC_29_reportLine("564", 2) and (bestPath.get(0).oldPos + 1 >= oldLen and newPos + 1 >= newLen)
                RBS_CC_29_reportLine("564", 3)
                ' Identity per the equality and tokenizer
                ' return m.done(buildValues(m, bestPath[0].lastComponent, newString, oldString, m.useLongestToken))
                RBS_CC_29_reportLine("567", 1)
                return m.done(rooibos_reporters_mocha_buildValues(m, bestPath.get(0).lastComponent, newString, oldString, m.useLongestToken), options)
            end if
            ' Once we hit the right edge of the edit graph on some diagonal k, we can
            ' definitely reach the end of the edit graph in no more than k edits, so
            ' there's no point in considering any moves to diagonal k+1 any more (from
            ' which we're guaranteed to need at least k+1 more edits).
            ' Similarly, once we've reached the bottom of the edit graph, there's no
            ' point considering moves to lower diagonals.
            ' We record this fact by setting minDiagonalToConsider and
            ' maxDiagonalToConsider to some finite value once we've hit the edge of
            ' the edit graph.
            ' This optimization is not faithful to the original algorithm presented in
            ' Myers's paper, which instead pointlessly extends D-paths off the end of
            ' the edit graph - see page 7 of Myers's paper which notes this point
            ' explicitly and illustrates it with a diagram. This has major performance
            ' implications for some common scenarios. For instance, to compute a diff
            ' where the new text simply appends d characters on the end of the
            ' original text of length n, the true Myers algorithm will take O(n+d^2)
            ' time while this optimization needs only O(n+d) time.
            RBS_CC_29_reportLine("586", 1)
            minDiagonalToConsider = -Infinity
            RBS_CC_29_reportLine("587", 1)
            maxDiagonalToConsider = Infinity
            ' Performs the length of edit iteration. Is a bit fugly as this has to support the
            ' sync and async mode which is never fun. Loops over execEditLength until a value
            ' is produced, or until the edit length exceeds options.maxEditLength (if given),
            ' in which case it will return undefined.
            RBS_CC_29_reportLine("592", 1)
            execEditParams = {
                bestPath: bestPath
                editLength: editLength
                newString: newString
                oldString: oldString
                minDiagonalToConsider: minDiagonalToConsider
                maxDiagonalToConsider: maxDiagonalToConsider
                options: options
                newLen: newLen
                oldLen: oldLen
            }
            RBS_CC_29_reportLine("603", 1): while execEditParams.editLength <= maxEditLength and CreateObject("roDateTime").asSeconds() <= abortAfterTimestamp
                RBS_CC_29_reportLine("604", 1)
                execEdit = m.execEditLength(execEditParams)
                RBS_CC_29_reportLine("605", 1)
                execEditParams = execEdit
                if RBS_CC_29_reportLine("606", 2) and (execEdit.ret <> invalid)
                    RBS_CC_29_reportLine("606", 3)
                    RBS_CC_29_reportLine("607", 1)
                    return execEdit.ret
                end if
            end while
        end function
        ' Main worker method. checks all permutations of a given edit length for acceptance.
        execEditLength: function(execEditParams)
            RBS_CC_29_reportLine("613", 1)
            startingDiagonalPath = rooibos_reporters_mocha_max(execEditParams.minDiagonalToConsider, - execEditParams.editLength)
            RBS_CC_29_reportLine("614", 1)
            diagonalPath = rooibos_reporters_mocha_max(execEditParams.minDiagonalToConsider, - execEditParams.editLength)
            ' while diagonalPath <= min(execEditParams.maxDiagonalToConsider, execEditParams.editLength)
            RBS_CC_29_reportLine("616", 1): for diagonalPath = rooibos_reporters_mocha_max(execEditParams.minDiagonalToConsider, - execEditParams.editLength) to rooibos_reporters_mocha_min(execEditParams.maxDiagonalToConsider, execEditParams.editLength) step 2
                RBS_CC_29_reportLine("617", 1)
                removePath = execEditParams.bestPath.get(diagonalPath - 1)
                RBS_CC_29_reportLine("618", 1)
                addPath = execEditParams.bestPath.get(diagonalPath + 1)
                if RBS_CC_29_reportLine("619", 2) and (removePath <> invalid)
                    RBS_CC_29_reportLine("619", 3)
                    ' No one else is going to attempt to use this value, clear it
                    RBS_CC_29_reportLine("621", 1)
                    execEditParams.bestPath.set(diagonalPath - 1, invalid)
                end if
                RBS_CC_29_reportLine("623", 1)
                canAdd = false
                if RBS_CC_29_reportLine("624", 2) and (addPath <> invalid)
                    RBS_CC_29_reportLine("624", 3)
                    ' what newPos will be after we do an insertion:
                    RBS_CC_29_reportLine("626", 1)
                    addPathNewPos = addPath.oldPos - diagonalPath
                    RBS_CC_29_reportLine("627", 1)
                    canAdd = addPath <> invalid and 0 <= addPathNewPos and addPathNewPos < execEditParams.newLen
                end if
                RBS_CC_29_reportLine("629", 1)
                canRemove = removePath <> invalid and removePath.oldPos + 1 < execEditParams.oldLen
                if RBS_CC_29_reportLine("630", 2) and (not canAdd and not canRemove)
                    RBS_CC_29_reportLine("630", 3)
                    ' If this path is a terminal then prune
                    RBS_CC_29_reportLine("632", 1)
                    execEditParams.bestPath.set(diagonalPath, invalid)
                    continue for
                end if
                ' Select the diagonal that we want to branch from. We select the prior
                ' path whose position in the old string is the farthest from the origin
                ' and does not pass the bounds of the diff graph
                if RBS_CC_29_reportLine("638", 2) and (not canRemove or (canAdd and removePath.oldPos < addPath.oldPos))
                    RBS_CC_29_reportLine("638", 3)
                    RBS_CC_29_reportLine("639", 1)
                    basePath = m.addToPath(addPath, true, false, 0, execEditParams.options)
                else
                    RBS_CC_29_reportLine("640", 3)
                    RBS_CC_29_reportLine("641", 1)
                    basePath = m.addToPath(removePath, false, true, 1, execEditParams.options)
                end if
                RBS_CC_29_reportLine("643", 1)
                newPos = m.extractCommon(basePath, execEditParams.newString, execEditParams.oldString, diagonalPath, execEditParams.options)
                if RBS_CC_29_reportLine("644", 2) and (basePath.oldPos + 1 >= execEditParams.oldLen and newPos + 1 >= execEditParams.newLen)
                    RBS_CC_29_reportLine("644", 3)
                    ' If we have hit the end of both strings, then we are done
                    RBS_CC_29_reportLine("646", 1)
                    execEditParams.ret = m.done(rooibos_reporters_mocha_buildValues(m, basePath.lastComponent, execEditParams.newString, execEditParams.oldString, m.useLongestToken), execEditParams.options)
                    RBS_CC_29_reportLine("647", 1)
                    return execEditParams
                else
                    RBS_CC_29_reportLine("648", 3)
                    RBS_CC_29_reportLine("649", 1)
                    execEditParams.bestPath.set(diagonalPath, basePath)
                    if RBS_CC_29_reportLine("650", 2) and (basePath.oldPos + 1 >= execEditParams.oldLen)
                        RBS_CC_29_reportLine("650", 3)
                        RBS_CC_29_reportLine("651", 1)
                        execEditParams.maxDiagonalToConsider = rooibos_reporters_mocha_min(execEditParams.maxDiagonalToConsider, diagonalPath - 1)
                    end if
                    if RBS_CC_29_reportLine("653", 2) and (newPos + 1 >= execEditParams.newLen)
                        RBS_CC_29_reportLine("653", 3)
                        RBS_CC_29_reportLine("654", 1)
                        execEditParams.minDiagonalToConsider = rooibos_reporters_mocha_max(execEditParams.minDiagonalToConsider, diagonalPath + 1)
                    end if
                end if
            end for
            RBS_CC_29_reportLine("658", 1)
            execEditParams.editLength++
            RBS_CC_29_reportLine("659", 1)
            return execEditParams
        end function
        addToPath: function(path, added, removed, oldPosInc, options)
            RBS_CC_29_reportLine("662", 1)
            last = path.lastComponent
            if RBS_CC_29_reportLine("663", 2) and (last <> invalid and not options.oneChangePerToken and last.added = added and last.removed = removed)
                RBS_CC_29_reportLine("663", 3)
                RBS_CC_29_reportLine("664", 1)
                return {
                    oldPos: path.oldPos + oldPosInc
                    lastComponent: {
                        count: last.count + 1
                        added: added
                        removed: removed
                        previousComponent: last.previousComponent
                    }
                }
            else
                RBS_CC_29_reportLine("673", 3)
                RBS_CC_29_reportLine("674", 1)
                return {
                    oldPos: path.oldPos + oldPosInc
                    lastComponent: {
                        count: 1
                        added: added
                        removed: removed
                        previousComponent: last
                    }
                }
            end if
        end function
        extractCommon: function(basePath, newString, oldString, diagonalPath, options)
            RBS_CC_29_reportLine("686", 1)
            newLen = newString.count()
            RBS_CC_29_reportLine("687", 1)
            oldLen = oldString.count()
            RBS_CC_29_reportLine("688", 1)
            oldPos = basePath.oldPos
            RBS_CC_29_reportLine("689", 1)
            newPos = oldPos - diagonalPath
            RBS_CC_29_reportLine("690", 1)
            commonCount = 0
            RBS_CC_29_reportLine("691", 1): while newPos + 1 < newLen and oldPos + 1 < oldLen and m.equals(oldString[oldPos + 1], newString[newPos + 1], options)
                RBS_CC_29_reportLine("692", 1)
                newPos++
                RBS_CC_29_reportLine("693", 1)
                oldPos++
                RBS_CC_29_reportLine("694", 1)
                commonCount++
                if RBS_CC_29_reportLine("695", 2) and (options.oneChangePerToken)
                    RBS_CC_29_reportLine("695", 3)
                    RBS_CC_29_reportLine("696", 1)
                    basePath.lastComponent = {
                        count: 1
                        previousComponent: basePath.lastComponent
                        added: false
                        removed: false
                    }
                end if
            end while
            if RBS_CC_29_reportLine("704", 2) and (commonCount and not options.oneChangePerToken)
                RBS_CC_29_reportLine("704", 3)
                RBS_CC_29_reportLine("705", 1)
                basePath.lastComponent = {
                    count: commonCount
                    previousComponent: basePath.lastComponent
                    added: false
                    removed: false
                }
            end if
            RBS_CC_29_reportLine("712", 1)
            basePath.oldPos = oldPos
            RBS_CC_29_reportLine("713", 1)
            return newPos
        end function
        equals: function(left, right, options)
            if RBS_CC_29_reportLine("716", 2) and (options.comparator <> invalid)
                RBS_CC_29_reportLine("716", 3)
                RBS_CC_29_reportLine("717", 1)
                return options.comparator(left, right)
            else
                RBS_CC_29_reportLine("718", 3)
                RBS_CC_29_reportLine("719", 1)
                return left = right or (options.ignoreCase = true and lCase(left) = lCase(right))
            end if
        end function
        removeEmpty: function(array)
            RBS_CC_29_reportLine("723", 1)
            ret = []
            RBS_CC_29_reportLine("724", 1): for i = 0 to array.count() - 1
                if RBS_CC_29_reportLine("725", 2) and (array[i] <> "")
                    RBS_CC_29_reportLine("725", 3)
                    RBS_CC_29_reportLine("726", 1)
                    ret.push(array[i])
                end if
            end for
            RBS_CC_29_reportLine("729", 1)
            return ret
        end function
        tokenize: function(value, options)
            RBS_CC_29_reportLine("732", 1)
            return value.split("")
        end function
        join: function(chars)
            RBS_CC_29_reportLine("735", 1)
            return chars.join("")
        end function
        postProcess: function(changeObjects, options)
            RBS_CC_29_reportLine("738", 1)
            return changeObjects
        end function
        done: function(value, options)
            RBS_CC_29_reportLine("741", 1)
            value = m.postProcess(value, options)
            RBS_CC_29_reportLine("742", 1)
            return value
        end function
    }
end function

function rooibos_reporters_mocha_arrayMap(arr as object, callback as Function) as object
    if RBS_CC_29_reportLine("748", 2) and (type(arr) <> "roArray")
        RBS_CC_29_reportLine("748", 3)
        RBS_CC_29_reportLine("749", 1)
        print "Error: First argument must be an array."
        RBS_CC_29_reportLine("750", 1)
        return invalid
    end if
    if RBS_CC_29_reportLine("752", 2) and (type(callback) <> "Function")
        RBS_CC_29_reportLine("752", 3)
        RBS_CC_29_reportLine("753", 1)
        print "Error: Second argument must be a function."
        RBS_CC_29_reportLine("754", 1)
        return invalid
    end if
    ' Create a new array to store the results
    RBS_CC_29_reportLine("757", 1)
    result = []
    RBS_CC_29_reportLine("758", 1): for each item in arr
        ' Apply the callback function to the item
        RBS_CC_29_reportLine("760", 1)
        transformedItem = callback(item)
        RBS_CC_29_reportLine("761", 1)
        result.Push(transformedItem)
    end for
    RBS_CC_29_reportLine("763", 1)
    return result
end function

function rooibos_reporters_mocha_min(a as dynamic, b as dynamic) as dynamic
    if RBS_CC_29_reportLine("767", 2) and (a < b)
        RBS_CC_29_reportLine("767", 3)
        RBS_CC_29_reportLine("768", 1)
        return a
    else
        RBS_CC_29_reportLine("769", 3)
        RBS_CC_29_reportLine("770", 1)
        return b
    end if
end function

function rooibos_reporters_mocha_max(a as dynamic, b as dynamic) as dynamic
    if RBS_CC_29_reportLine("775", 2) and (a > b)
        RBS_CC_29_reportLine("775", 3)
        RBS_CC_29_reportLine("776", 1)
        return a
    else
        RBS_CC_29_reportLine("777", 3)
        RBS_CC_29_reportLine("778", 1)
        return b
    end if
end function

function rooibos_reporters_mocha_arraySplice(array, start, deleteCount, items = [])
    RBS_CC_29_reportLine("783", 1)
    partOne = array.slice(0, start)
    RBS_CC_29_reportLine("784", 1)
    partTwo = array.slice(start + deleteCount)
    if RBS_CC_29_reportLine("785", 2) and (items <> invalid)
        RBS_CC_29_reportLine("785", 3)
        RBS_CC_29_reportLine("786", 1)
        partOne.append(items)
    end if
    RBS_CC_29_reportLine("788", 1)
    partOne.append(partTwo)
    RBS_CC_29_reportLine("789", 1)
    return partOne
end function

function rooibos_reporters_mocha_new_lineDiff()
    RBS_CC_29_reportLine("793", 1)
    lineDiff = rooibos_reporters_mocha_new_Diff()
    RBS_CC_29_reportLine("794", 1)
    lineDiff.tokenize = function(value, options)
        if RBS_CC_29_reportLine("795", 2) and (options.stripTrailingCr = true)
            RBS_CC_29_reportLine("795", 3)
            ' remove one \r before \n to match GNU diff's --strip-trailing-cr behavior
            RBS_CC_29_reportLine("797", 1)
            value = CreateObject("roRegex", "\r\n", "g").ReplaceAll(value, chr(10))
        end if
        RBS_CC_29_reportLine("799", 1)
        retLines = []
        RBS_CC_29_reportLine("800", 1)
        linesAndNewlines = CreateObject("roRegex", "(\n|\r\n)", "g").split(value).toArray()
        ' Ignore the final empty token that occurs if the string ends with a new line
        if RBS_CC_29_reportLine("802", 2) and (linesAndNewlines[linesAndNewlines.count() - 1] = "")
            RBS_CC_29_reportLine("802", 3)
            RBS_CC_29_reportLine("803", 1)
            linesAndNewlines.pop()
        end if
        ' Add the newlines back that where stripped out by the split
        RBS_CC_29_reportLine("806", 1): for i = 0 to linesAndNewlines.count() - 2
            RBS_CC_29_reportLine("807", 1)
            linesAndNewlines[i] = linesAndNewlines[i] + chr(10)
        end for
        ' Merge the content and line separators into single tokens
        ' for  i = 0 to linesAndNewlines.count() - 1
        '   line = linesAndNewlines[i]
        '   if i mod 2 and not options.newlineIsToken = true
        '     retLines[retLines.count() - 1] = retLines[retLines.count() - 1] + line
        '   else
        '     retLines.push(line)
        '   end if
        ' end for
        RBS_CC_29_reportLine("818", 1)
        return linesAndNewlines
    end function
    RBS_CC_29_reportLine("820", 1)
    lineDiff.equals = function(leftPart, rightPart, options)
        ' If we're ignoring whitespace, we need to normalise lines by stripping
        ' whitespace before checking equality. (This has an annoying interaction
        ' with newlineIsToken that requires special handling: if newlines get their
        ' own token, then we DON'T want to trim the *newline* tokens down to empty
        ' strings, since this would cause us to treat whitespace-only line content
        ' as equal to a separator between lines, which would be weird and
        ' inconsistent with the documented behavior of the options.)
        if RBS_CC_29_reportLine("828", 2) and (options.ignoreWhitespace = true)
            RBS_CC_29_reportLine("828", 3)
            if RBS_CC_29_reportLine("829", 2) and (not options.newlineIsToken = true or leftPart.inStr(0, chr(10)) > -1)
                RBS_CC_29_reportLine("829", 3)
                RBS_CC_29_reportLine("830", 1)
                leftPart = leftPart.trim()
            end if
            if RBS_CC_29_reportLine("832", 2) and (not options.newlineIsToken = true or rightPart.inStr(0, chr(10)) > -1)
                RBS_CC_29_reportLine("832", 3)
                RBS_CC_29_reportLine("833", 1)
                rightPart = rightPart.trim()
            end if
        else if RBS_CC_29_reportLine("835", 2) and (options.ignoreNewlineAtEof = true and not options.newlineIsToken = true)
            RBS_CC_29_reportLine("835", 3)
            if RBS_CC_29_reportLine("836", 2) and (leftPart.endsWith(chr(10)))
                RBS_CC_29_reportLine("836", 3)
                RBS_CC_29_reportLine("837", 1)
                leftPart = leftPart.mid(0, len(leftPart) - 1)
            end if
            if RBS_CC_29_reportLine("839", 2) and (rightPart.endsWith(chr(10)))
                RBS_CC_29_reportLine("839", 3)
                RBS_CC_29_reportLine("840", 1)
                rightPart = rightPart.mid(0, len(rightPart) - 1)
            end if
        end if
        RBS_CC_29_reportLine("843", 1)
        return rooibos_reporters_mocha_new_Diff().equals(leftPart, rightPart, options)
    end function
    RBS_CC_29_reportLine("845", 1)
    return lineDiff
end function

function rooibos_reporters_mocha_new_objectArray()
    RBS_CC_29_reportLine("849", 1)
    return {
        array: []
        aa: {}
        count: function()
            RBS_CC_29_reportLine("853", 1)
            return m.array.count()
        end function
        set: sub(index, value)
            if RBS_CC_29_reportLine("856", 2) and (index >= 0)
                RBS_CC_29_reportLine("856", 3)
                RBS_CC_29_reportLine("857", 1)
                m.array[index] = value
            else
                RBS_CC_29_reportLine("858", 3)
                RBS_CC_29_reportLine("859", 1)
                m.aa[index.toStr()] = value
            end if
        end sub
        get: function(index)
            if RBS_CC_29_reportLine("863", 2) and (index >= 0)
                RBS_CC_29_reportLine("863", 3)
                RBS_CC_29_reportLine("864", 1)
                return m.array[index]
            else
                RBS_CC_29_reportLine("865", 3)
                RBS_CC_29_reportLine("866", 1)
                return m.aa[index.toStr()]
            end if
        end function
    }
end function

'//# sourceMappingURL=./MochaTestReporter.brs.map
function RBS_CC_29_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "29"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "29"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./MochaTestReporter.brs.map