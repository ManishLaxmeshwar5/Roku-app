' @ignore
function __rooibos_JUnitTestReporter_builder()
    RBS_CC_27_reportLine("2", 1)
    instance = __rooibos_BaseTestReporter_builder()
    RBS_CC_27_reportLine("3", 1)
    instance.super0_new = instance.new
    RBS_CC_27_reportLine("4", 1)
    instance.new = sub()
        RBS_CC_27_reportLine("5", 1)
        m.super0_new()
    end sub
    RBS_CC_27_reportLine("7", 1)
    instance.super0_onEnd = instance.onEnd
    RBS_CC_27_reportLine("8", 1)
    instance.onEnd = function(event as object)
        RBS_CC_27_reportLine("9", 1)
        root = createObject("roXMLElement")
        RBS_CC_27_reportLine("10", 1)
        root.SetName("testsuites")
        RBS_CC_27_reportLine("11", 1)
        properties = root.addElement("properties")
        RBS_CC_27_reportLine("12", 1)
        versionProperty = properties.AddElement("property")
        RBS_CC_27_reportLine("13", 1)
        versionProperty.AddAttribute("name", "Rooibos Version")
        RBS_CC_27_reportLine("14", 1)
        versionProperty.AddAttribute("value", m.testRunner.runtimeConfig.getVersionText())
        RBS_CC_27_reportLine("15", 1): for each testSuite in m.testRunner.testSuites
            RBS_CC_27_reportLine("16", 1)
            suite = root.AddElement("testsuite")
            RBS_CC_27_reportLine("17", 1)
            suite.AddAttribute("name", testSuite.name)
            RBS_CC_27_reportLine("18", 1)
            suite.AddAttribute("tests", Rooibos_Common_AsString(testSuite.stats.ranCount))
            RBS_CC_27_reportLine("19", 1)
            suite.AddAttribute("failures", Rooibos_Common_AsString(testSuite.stats.failedCount))
            RBS_CC_27_reportLine("20", 1)
            suite.AddAttribute("skipped", Rooibos_Common_AsString(testSuite.stats.ignoredCount))
            RBS_CC_27_reportLine("21", 1)
            suite.AddAttribute("time", Rooibos_Common_AsString(testSuite.stats.time))
            RBS_CC_27_reportLine("22", 1): for each testGroup in testSuite.groups
                RBS_CC_27_reportLine("23", 1)
                m.generateGroupXML(testGroup, suite)
            end for
        end for
        'bs:disable-next-line
        RBS_CC_27_reportLine("27", 1)
        ignoredInfo = m.testRunner.runtimeConfig.getIgnoredTestInfo()
        if RBS_CC_27_reportLine("28", 2) and (ignoredInfo.count > 0)
            RBS_CC_27_reportLine("28", 3)
            RBS_CC_27_reportLine("29", 1): for each ignoredItemName in ignoredInfo.items
                RBS_CC_27_reportLine("30", 1)
                testCase = root.AddElement("testcase")
                RBS_CC_27_reportLine("31", 1)
                testCase.AddAttribute("name", ignoredItemName)
                RBS_CC_27_reportLine("32", 1)
                testCase.addAttribute("classname", "skipped")
                RBS_CC_27_reportLine("33", 1)
                testCase.AddElement("skipped")
            end for
        end if
        RBS_CC_27_reportLine("36", 1)
        ? "<?xml version=" + chr(34) + "1.0" + chr(34) + " encoding=" + chr(34) + "UTF-8" + chr(34) + "?>" + root.GenXML(false)
    end function
    RBS_CC_27_reportLine("38", 1)
    instance.generateGroupXML = function(testGroup, suite)
        RBS_CC_27_reportLine("39", 1): for each test in testGroup.tests
            RBS_CC_27_reportLine("40", 1)
            testCase = suite.AddElement("testcase")
            RBS_CC_27_reportLine("41", 1)
            testCase.AddAttribute("name", test.name)
            RBS_CC_27_reportLine("42", 1)
            testCase.AddAttribute("time", Rooibos_Common_AsString(test.result.time))
            RBS_CC_27_reportLine("43", 1)
            locationText = "file://" + test.testSuite.filePath.trim() + ":" + Rooibos_Common_AsString(test.lineNumber)
            RBS_CC_27_reportLine("44", 1)
            testCase.addAttribute("file", locationText)
            ' Gitlab displays classname in the suite field for some reason
            RBS_CC_27_reportLine("46", 1)
            testCase.addAttribute("classname", test.testSuite.name)
            if RBS_CC_27_reportLine("47", 2) and (test.result.isCrash or test.result.isFail)
                RBS_CC_27_reportLine("47", 3)
                RBS_CC_27_reportLine("48", 1)
                testFailure = testCase.AddElement(bslib_ternary(test.result.isCrash, "error", "failure"))
                RBS_CC_27_reportLine("49", 1)
                testFailure.addAttribute("message", test.result.getMessage())
                RBS_CC_27_reportLine("50", 1)
                testFailure.addAttribute("type", Rooibos_Common_AsString(test.result.getStatusText()))
                if RBS_CC_27_reportLine("51", 2) and (test.isParamTest = true)
                    RBS_CC_27_reportLine("51", 3)
                    if RBS_CC_27_reportLine("52", 2) and (type(test.rawParams) = "roAssociativeArray")
                        RBS_CC_27_reportLine("52", 3)
                        RBS_CC_27_reportLine("53", 1)
                        rawParams = {}
                        RBS_CC_27_reportLine("54", 1): for each key in test.rawParams
                            if RBS_CC_27_reportLine("55", 2) and (type(test.rawParams[key]) <> "Function" and type(test.rawParams[key]) <> "roFunction")
                                RBS_CC_27_reportLine("55", 3)
                                RBS_CC_27_reportLine("56", 1)
                                rawParams[key] = test.rawParams[key]
                            end if
                        end for
                    else
                        RBS_CC_27_reportLine("59", 3)
                        RBS_CC_27_reportLine("60", 1)
                        rawParams = test.rawParams
                    end if
                    RBS_CC_27_reportLine("62", 1)
                    testFailure.addText(chr(10) + "Params: " + formatJson(rawParams) + chr(10))
                end if
                RBS_CC_27_reportLine("64", 1)
                testFailure.addText("Failure/Error: " + test.result.getMessage() + chr(10))
                if RBS_CC_27_reportLine("65", 2) and (test.result.isCrash)
                    RBS_CC_27_reportLine("65", 3)
                    RBS_CC_27_reportLine("66", 1)
                    testFailure.addText("Trace: " + m.getStackTrace(test.result.error) + chr(10))
                end if
            end if
        end for
    end function
    RBS_CC_27_reportLine("71", 1)
    instance.getStackTrace = function(error) as string
        RBS_CC_27_reportLine("72", 1)
        output = ""
        RBS_CC_27_reportLine("73", 1): for i = error.backTrace.count() - 1 to 0 step -1
            RBS_CC_27_reportLine("74", 1)
            e = error.backTrace[i]
            if RBS_CC_27_reportLine("75", 2) and (e.filename.instr("pkg:/source/rooibos") = -1)
                RBS_CC_27_reportLine("75", 3)
                RBS_CC_27_reportLine("76", 1)
                output = output + e.filename + "(" + stri(e.line_number).trim() + ")"
            end if
        end for
        RBS_CC_27_reportLine("79", 1)
        return output
    end function
    RBS_CC_27_reportLine("81", 1)
    return instance
end function

function rooibos_JUnitTestReporter()
    RBS_CC_27_reportLine("84", 1)
    instance = __rooibos_JUnitTestReporter_builder()
    RBS_CC_27_reportLine("85", 1)
    instance.new()
    RBS_CC_27_reportLine("86", 1)
    return instance
end function

'//# sourceMappingURL=./JUnitTestReporter.brs.map
function RBS_CC_27_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "27"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "27"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./JUnitTestReporter.brs.map