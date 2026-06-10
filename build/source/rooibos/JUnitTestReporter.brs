' @ignore
function __rooibos_JUnitTestReporter_builder()
    instance = __rooibos_BaseTestReporter_builder()
    instance.super0_new = instance.new
    instance.new = sub()
        m.super0_new()
    end sub
    instance.super0_onEnd = instance.onEnd
    instance.onEnd = function(event as object)
        root = createObject("roXMLElement")
        root.SetName("testsuites")
        properties = root.addElement("properties")
        versionProperty = properties.AddElement("property")
        versionProperty.AddAttribute("name", "Rooibos Version")
        versionProperty.AddAttribute("value", m.testRunner.runtimeConfig.getVersionText())
        for each testSuite in m.testRunner.testSuites
            suite = root.AddElement("testsuite")
            suite.AddAttribute("name", testSuite.name)
            suite.AddAttribute("tests", Rooibos_Common_AsString(testSuite.stats.ranCount))
            suite.AddAttribute("failures", Rooibos_Common_AsString(testSuite.stats.failedCount))
            suite.AddAttribute("skipped", Rooibos_Common_AsString(testSuite.stats.ignoredCount))
            suite.AddAttribute("time", Rooibos_Common_AsString(testSuite.stats.time))
            for each testGroup in testSuite.groups
                m.generateGroupXML(testGroup, suite)
            end for
        end for
        'bs:disable-next-line
        ignoredInfo = m.testRunner.runtimeConfig.getIgnoredTestInfo()
        if ignoredInfo.count > 0
            for each ignoredItemName in ignoredInfo.items
                testCase = root.AddElement("testcase")
                testCase.AddAttribute("name", ignoredItemName)
                testCase.addAttribute("classname", "skipped")
                testCase.AddElement("skipped")
            end for
        end if
        ? "<?xml version=" + chr(34) + "1.0" + chr(34) + " encoding=" + chr(34) + "UTF-8" + chr(34) + "?>" + root.GenXML(false)
    end function
    instance.generateGroupXML = function(testGroup, suite)
        for each test in testGroup.tests
            testCase = suite.AddElement("testcase")
            testCase.AddAttribute("name", test.name)
            testCase.AddAttribute("time", Rooibos_Common_AsString(test.result.time))
            locationText = "file://" + test.testSuite.filePath.trim() + ":" + Rooibos_Common_AsString(test.lineNumber)
            testCase.addAttribute("file", locationText)
            ' Gitlab displays classname in the suite field for some reason
            testCase.addAttribute("classname", test.testSuite.name)
            if test.result.isCrash or test.result.isFail
                testFailure = testCase.AddElement(bslib_ternary(test.result.isCrash, "error", "failure"))
                testFailure.addAttribute("message", test.result.getMessage())
                testFailure.addAttribute("type", Rooibos_Common_AsString(test.result.getStatusText()))
                if test.isParamTest = true
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
                    testFailure.addText(chr(10) + "Params: " + formatJson(rawParams) + chr(10))
                end if
                testFailure.addText("Failure/Error: " + test.result.getMessage() + chr(10))
                if test.result.isCrash
                    testFailure.addText("Trace: " + m.getStackTrace(test.result.error) + chr(10))
                end if
            end if
        end for
    end function
    instance.getStackTrace = function(error) as string
        output = ""
        for i = error.backTrace.count() - 1 to 0 step -1
            e = error.backTrace[i]
            if e.filename.instr("pkg:/source/rooibos") = -1
                output = output + e.filename + "(" + stri(e.line_number).trim() + ")"
            end if
        end for
        return output
    end function
    return instance
end function
function rooibos_JUnitTestReporter()
    instance = __rooibos_JUnitTestReporter_builder()
    instance.new()
    return instance
end function
'//# sourceMappingURL=./JUnitTestReporter.brs.map