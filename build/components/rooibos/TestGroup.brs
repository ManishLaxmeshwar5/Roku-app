function __rooibos_TestGroup_builder()
    RBS_CC_34_reportLine("1", 1)
    instance = {}
    'test state
    RBS_CC_34_reportLine("3", 1)
    instance.new = function(testSuite, data)
        RBS_CC_34_reportLine("4", 1)
        m.name = "Unnamed Suite"
        RBS_CC_34_reportLine("5", 1)
        m.testSuite = invalid
        RBS_CC_34_reportLine("6", 1)
        m.setupFunctionName = invalid
        RBS_CC_34_reportLine("7", 1)
        m.tearDownFunctionName = invalid
        RBS_CC_34_reportLine("8", 1)
        m.beforeEachFunctionName = invalid
        RBS_CC_34_reportLine("9", 1)
        m.afterEachFunctionName = invalid
        RBS_CC_34_reportLine("10", 1)
        m.isSolo = false
        RBS_CC_34_reportLine("11", 1)
        m.isLegacy = false
        RBS_CC_34_reportLine("12", 1)
        m.isIgnored = false
        RBS_CC_34_reportLine("13", 1)
        m.stats = invalid
        RBS_CC_34_reportLine("14", 1)
        m.scene = invalid
        RBS_CC_34_reportLine("15", 1)
        m.lineNumber = 00
        RBS_CC_34_reportLine("16", 1)
        m.top = invalid
        RBS_CC_34_reportLine("17", 1)
        m.valid = false
        RBS_CC_34_reportLine("18", 1)
        m.hasFailures = false
        RBS_CC_34_reportLine("19", 1)
        m.isNodeTest = false
        RBS_CC_34_reportLine("20", 1)
        m.nodeName = invalid
        RBS_CC_34_reportLine("21", 1)
        m.testsData = invalid
        RBS_CC_34_reportLine("22", 1)
        m.tests = []
        RBS_CC_34_reportLine("23", 1)
        m.deferred = invalid
        RBS_CC_34_reportLine("24", 1)
        m.currentTestIndex = 0
        RBS_CC_34_reportLine("25", 1)
        m.testSuite = testSuite
        RBS_CC_34_reportLine("26", 1)
        m.name = data.name
        RBS_CC_34_reportLine("27", 1)
        m.valid = data.valid
        RBS_CC_34_reportLine("28", 1)
        m.hasFailures = testSuite.hasFailures
        RBS_CC_34_reportLine("29", 1)
        m.isSolo = data.isSolo
        RBS_CC_34_reportLine("30", 1)
        m.isIgnored = data.isIgnored
        RBS_CC_34_reportLine("31", 1)
        m.isAsync = data.isAsync
        RBS_CC_34_reportLine("32", 1)
        m.asyncTimeout = data.asyncTimeout
        RBS_CC_34_reportLine("33", 1)
        m.testsData = data.testCases
        RBS_CC_34_reportLine("34", 1)
        m.isNodeTest = testSuite.isNodeTest
        RBS_CC_34_reportLine("35", 1)
        m.nodeName = invalid
        RBS_CC_34_reportLine("36", 1)
        m.setupFunctionName = data.setupFunctionName
        RBS_CC_34_reportLine("37", 1)
        m.tearDownFunctionName = data.tearDownFunctionName
        RBS_CC_34_reportLine("38", 1)
        m.beforeEachFunctionName = data.beforeEachFunctionName
        RBS_CC_34_reportLine("39", 1)
        m.afterEachFunctionName = data.afterEachFunctionName
        RBS_CC_34_reportLine("40", 1)
        m.lineNumber = data.lineNumber
        if RBS_CC_34_reportLine("41", 2) and (m.isNodeTest)
            RBS_CC_34_reportLine("41", 3)
            RBS_CC_34_reportLine("42", 1)
            m.deferred = rooibos_promises_create()
        end if
        'bs:disable-next-line
        RBS_CC_34_reportLine("45", 1)
        m.global = testSuite.global
        RBS_CC_34_reportLine("46", 1)
        m.top = testSuite.top
        RBS_CC_34_reportLine("47", 1)
        m.scene = testSuite.scene
        RBS_CC_34_reportLine("48", 1)
        m.stats = rooibos_Stats()
    end function
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    '++ running
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    'TODO CONVERT THIS TO ASYNC
    RBS_CC_34_reportLine("54", 1)
    instance.run = function()
        RBS_CC_34_reportLine("55", 1)
        rooibos_common_logTrace(">>>>>>>>>>>>")
        RBS_CC_34_reportLine("56", 1)
        rooibos_common_logTrace("RUNNING TEST GROUP")
        RBS_CC_34_reportLine("57", 1)
        m.testRunner = m.testSuite.testRunner
        RBS_CC_34_reportLine("58", 1)
        m.notifyReportersOnTestGroupBegin()
        if RBS_CC_34_reportLine("59", 2) and (m.testSuite.isNodeTest = true)
            RBS_CC_34_reportLine("59", 3)
            RBS_CC_34_reportLine("60", 1)
            rooibos_common_logTrace("THIS GROUP IS ASYNC")
            RBS_CC_34_reportLine("61", 1)
            m.runAsync()
            RBS_CC_34_reportLine("62", 1)
            return m.deferred
        else
            RBS_CC_34_reportLine("63", 3)
            RBS_CC_34_reportLine("64", 1)
            rooibos_common_logTrace("THIS GROUP IS SYNC")
            RBS_CC_34_reportLine("65", 1)
            m.runSync()
            RBS_CC_34_reportLine("66", 1)
            return true
        end if
    end function
    RBS_CC_34_reportLine("69", 1)
    instance.runSync = function()
        RBS_CC_34_reportLine("70", 1)
        isOk = m.runSuiteFunction(m.setupFunctionName, "setup")
        if RBS_CC_34_reportLine("71", 2) and (isOk)
            RBS_CC_34_reportLine("71", 3)
            RBS_CC_34_reportLine("72", 1): for each testData in m.testsData
                RBS_CC_34_reportLine("73", 1)
                test = rooibos_Test(m, testData)
                RBS_CC_34_reportLine("74", 1)
                m.tests.push(test)
                if RBS_CC_34_reportLine("75", 2) and (test.isIgnored)
                    RBS_CC_34_reportLine("75", 3)
                    RBS_CC_34_reportLine("76", 1)
                    m.notifyReportersOnTestBegin(test)
                    RBS_CC_34_reportLine("77", 1)
                    m.testSuite.runTest(test)
                    RBS_CC_34_reportLine("78", 1)
                    m.notifyReportersOnTestComplete(test)
                    RBS_CC_34_reportLine("79", 1)
                    m.stats.appendTestResult(test.result)
                    continue for
                end if
                RBS_CC_34_reportLine("82", 1)
                isOk = m.runSuiteFunction(m.beforeEachFunctionName, "beforeEach", test)
                if RBS_CC_34_reportLine("83", 2) and (isOk)
                    RBS_CC_34_reportLine("83", 3)
                    RBS_CC_34_reportLine("84", 1)
                    m.notifyReportersOnTestBegin(test)
                    RBS_CC_34_reportLine("85", 1)
                    m.testSuite.runTest(test)
                    RBS_CC_34_reportLine("86", 1)
                    m.notifyReportersOnTestComplete(test)
                end if
                RBS_CC_34_reportLine("88", 1)
                m.runSuiteFunction(m.afterEachFunctionName, "afterEach", test)
                RBS_CC_34_reportLine("89", 1)
                m.stats.appendTestResult(test.result)
                if RBS_CC_34_reportLine("90", 2) and (m.stats.hasFailures and m.testSuite.isFailingFast)
                    RBS_CC_34_reportLine("90", 3)
                    RBS_CC_34_reportLine("91", 1)
                    rooibos_common_logTrace("Terminating group due to failed test")
                    exit for
                end if
            end for
        else
            RBS_CC_34_reportLine("95", 3)
            RBS_CC_34_reportLine("96", 1)
            rooibos_common_logError("ERROR running test setup function")
        end if
        RBS_CC_34_reportLine("98", 1)
        m.notifyReportersOnTestGroupComplete()
        RBS_CC_34_reportLine("99", 1)
        m.runSuiteFunction(m.tearDownFunctionName, "tearDown")
    end function
    RBS_CC_34_reportLine("101", 1)
    instance.runAsync = function()
        RBS_CC_34_reportLine("102", 1)
        isOk = m.runSuiteFunction(m.setupFunctionName, "setup")
        RBS_CC_34_reportLine("103", 1)
        m.testTimer = createObject("roTimespan")
        if RBS_CC_34_reportLine("104", 2) and (isOk)
            RBS_CC_34_reportLine("104", 3)
            RBS_CC_34_reportLine("105", 1)
            m.testRunner.currentGroup = m
            RBS_CC_34_reportLine("106", 1): for each testData in m.testsData
                RBS_CC_34_reportLine("107", 1)
                test = rooibos_Test(m, testData)
                RBS_CC_34_reportLine("108", 1)
                m.tests.push(test)
            end for
            RBS_CC_34_reportLine("110", 1)
            m.currentTestIndex = -1
            RBS_CC_34_reportLine("111", 1)
            m.runNextAsync()
        else
            RBS_CC_34_reportLine("112", 3)
            RBS_CC_34_reportLine("113", 1)
            rooibos_common_logError("ERROR running test setup function")
            RBS_CC_34_reportLine("114", 1)
            m.runSuiteFunction(m.tearDownFunctionName, "tearDown")
        end if
    end function
    RBS_CC_34_reportLine("117", 1)
    instance.runNextAsync = function()
        RBS_CC_34_reportLine("118", 1)
        rooibos_common_logTrace("Getting next async test")
        RBS_CC_34_reportLine("119", 1)
        m.currentTestIndex++
        RBS_CC_34_reportLine("120", 1)
        m.currentTest = m.tests[m.currentTestIndex]
        RBS_CC_34_reportLine("121", 1)
        m.testSuite.isDoneCalled = false
        RBS_CC_34_reportLine("122", 1)
        m.testTimer.mark()
        if RBS_CC_34_reportLine("123", 2) and (m.currentTest = invalid)
            RBS_CC_34_reportLine("123", 3)
            RBS_CC_34_reportLine("124", 1)
            rooibos_common_logTrace("All tests are finished")
            RBS_CC_34_reportLine("125", 1)
            m.finishAsyncTests()
        else
            RBS_CC_34_reportLine("126", 3)
            RBS_CC_34_reportLine("127", 1)
            test = m.currentTest
            ' Check to see if the test is ignored or if the suite is timed out
            ' and skip the before and after hooks
            if RBS_CC_34_reportLine("130", 2) and (test.isIgnored or m.testSuite.isSuiteTimedOut())
                RBS_CC_34_reportLine("130", 3)
                RBS_CC_34_reportLine("131", 1)
                m.notifyReportersOnTestBegin(test)
                RBS_CC_34_reportLine("132", 1)
                m.testSuite.runTest(test)
                RBS_CC_34_reportLine("133", 1)
                m.onAsyncTestComplete()
                RBS_CC_34_reportLine("134", 1)
                return invalid
            end if
            RBS_CC_34_reportLine("136", 1)
            isOk = m.runSuiteFunction(m.beforeEachFunctionName, "beforeEach", m.currentTest)
            if RBS_CC_34_reportLine("137", 2) and (isOk)
                RBS_CC_34_reportLine("137", 3)
                RBS_CC_34_reportLine("138", 1)
                m.notifyReportersOnTestBegin(test)
                RBS_CC_34_reportLine("139", 1)
                m.testSuite.runTest(test)
                RBS_CC_34_reportLine("140", 1)
                rooibos_common_logDebug("Waiting on deferred test results")
                RBS_CC_34_reportLine("141", 1)
                rooibos_promises_chain(test.deferred, {
                    self: m
                    test: test
                }).then(function(_, context)
                    RBS_CC_34_reportLine("145", 1)
                    rooibos_common_logDebug("Promise resolved")
                    RBS_CC_34_reportLine("146", 1)
                    context.self.testSuite.done()
                end function).catch(function(error, context)
                    RBS_CC_34_reportLine("148", 1)
                    rooibos_common_logDebug("Promise rejected")
                    if RBS_CC_34_reportLine("149", 2) and (rooibos_common_isAssociativeArray(error) and not error.isEmpty() and rooibos_common_isArray(error.backtrace) and not error.backtrace.isEmpty() and rooibos_common_isBoolean(error.rethrown))
                        RBS_CC_34_reportLine("149", 3)
                        RBS_CC_34_reportLine("150", 1)
                        context.self.testSuite.failCrash(error)
                    else
                        RBS_CC_34_reportLine("151", 3)
                        RBS_CC_34_reportLine("152", 1)
                        context.self.testSuite.fail("Test failed due to promise rejection")
                    end if
                    RBS_CC_34_reportLine("154", 1)
                    context.self.testSuite.done()
                end function).finally(function(context)
                    RBS_CC_34_reportLine("156", 1)
                    context.self.onAsyncTestComplete()
                end function)
            else
                RBS_CC_34_reportLine("158", 3)
                RBS_CC_34_reportLine("159", 1)
                rooibos_common_logTrace("Error running test before each function")
                RBS_CC_34_reportLine("160", 1)
                m.isTestFailedDueToEarlyExit = true
                RBS_CC_34_reportLine("161", 1)
                m.finishAsyncTests()
            end if
        end if
    end function
    RBS_CC_34_reportLine("165", 1)
    instance.onAsyncTestComplete = function()
        RBS_CC_34_reportLine("166", 1)
        rooibos_common_logTrace("++ CURRENT TEST COMPLETED")
        RBS_CC_34_reportLine("167", 1)
        m.notifyReportersOnTestComplete(m.currentTest)
        RBS_CC_34_reportLine("168", 1)
        m.runSuiteFunction(m.afterEachFunctionName, "afterEach", m.currentTest)
        RBS_CC_34_reportLine("169", 1)
        m.stats.appendTestResult(m.currentTest.result)
        if RBS_CC_34_reportLine("170", 2) and (m.stats.hasFailures and m.testSuite.isFailingFast)
            RBS_CC_34_reportLine("170", 3)
            RBS_CC_34_reportLine("171", 1)
            rooibos_common_logTrace("Terminating group due to failed test")
            RBS_CC_34_reportLine("172", 1)
            m.isTestFailedDueToEarlyExit = true
            RBS_CC_34_reportLine("173", 1)
            m.finishAsyncTests()
        else
            RBS_CC_34_reportLine("174", 3)
            RBS_CC_34_reportLine("175", 1)
            m.runNextAsync()
        end if
    end function
    RBS_CC_34_reportLine("178", 1)
    instance.finishAsyncTests = function()
        RBS_CC_34_reportLine("179", 1)
        m.runSuiteFunction(m.tearDownFunctionName, "tearDown")
        RBS_CC_34_reportLine("180", 1)
        rooibos_common_logTrace("Indicating test suite is done")
        RBS_CC_34_reportLine("181", 1)
        m.notifyReportersOnTestGroupComplete()
        RBS_CC_34_reportLine("182", 1)
        rooibos_promises_resolve(true, m.deferred)
    end function
    RBS_CC_34_reportLine("184", 1)
    instance.runSuiteFunction = function(methodName, defaultMethodName, test = invalid)
        if RBS_CC_34_reportLine("185", 2) and (methodName = invalid or methodName = "")
            RBS_CC_34_reportLine("185", 3)
            RBS_CC_34_reportLine("186", 1)
            methodName = defaultMethodName
        end if
        if RBS_CC_34_reportLine("188", 2) and (m.testSuite.catchCrashes and not m.testSuite.noCatch and not (test <> invalid and test.noCatch))
            RBS_CC_34_reportLine("188", 3)
            ' Add the users suite functions execution time to the suites current execution time
            RBS_CC_34_reportLine("190", 1)
            timespan = createObject("roTimespan")
            try
                RBS_CC_34_reportLine("192", 1)
                m.testSuite[methodName]()
                RBS_CC_34_reportLine("193", 1)
                m.testSuite.currentExecutionTime += timespan.totalMilliseconds()
                RBS_CC_34_reportLine("194", 1)
                return true
            catch error
                if RBS_CC_34_reportLine("196", 2) and (test <> invalid)
                    RBS_CC_34_reportLine("196", 3)
                    'bs:disable-next-line
                    RBS_CC_34_reportLine("198", 1)
                    test.result.crash("function " + methodName + "crashed!", error)
                    RBS_CC_34_reportLine("199", 1)
                    m.testSuite.currentExecutionTime += timespan.totalMilliseconds()
                end if
            end try
        else
            RBS_CC_34_reportLine("202", 3)
            RBS_CC_34_reportLine("203", 1)
            timespan = createObject("roTimespan")
            RBS_CC_34_reportLine("204", 1)
            m.testSuite[methodName]()
            RBS_CC_34_reportLine("205", 1)
            m.testSuite.currentExecutionTime += timespan.totalMilliseconds()
            RBS_CC_34_reportLine("206", 1)
            return true
        end if
        'bs:disable-next-line
        RBS_CC_34_reportLine("209", 1)
        return false
    end function
    RBS_CC_34_reportLine("211", 1)
    instance.notifyReportersOnTestGroupBegin = sub()
        RBS_CC_34_reportLine("212", 1): for each reporter in m.testSuite.testReporters
            if RBS_CC_34_reportLine("213", 2) and (rooibos_common_isFunction(reporter.onTestGroupBegin))
                RBS_CC_34_reportLine("213", 3)
                RBS_CC_34_reportLine("214", 1)
                reporter.onTestGroupBegin({
                    group: m
                })
            end if
        end for
    end sub
    RBS_CC_34_reportLine("220", 1)
    instance.notifyReportersOnTestBegin = sub(test as object)
        RBS_CC_34_reportLine("221", 1): for each reporter in m.testSuite.testReporters
            if RBS_CC_34_reportLine("222", 2) and (rooibos_common_isFunction(reporter.onTestBegin))
                RBS_CC_34_reportLine("222", 3)
                RBS_CC_34_reportLine("223", 1)
                reporter.onTestBegin({
                    test: test
                })
            end if
        end for
    end sub
    RBS_CC_34_reportLine("229", 1)
    instance.notifyReportersOnTestComplete = sub(test as object)
        if RBS_CC_34_reportLine("230", 2) and (test.result.time > 0)
            RBS_CC_34_reportLine("230", 3)
            ' Add the test execution time to the suites current execution time
            RBS_CC_34_reportLine("232", 1)
            m.testSuite.currentExecutionTime += test.result.time
        end if
        RBS_CC_34_reportLine("234", 1): for each reporter in m.testSuite.testReporters
            if RBS_CC_34_reportLine("235", 2) and (rooibos_common_isFunction(reporter.onTestComplete))
                RBS_CC_34_reportLine("235", 3)
                RBS_CC_34_reportLine("236", 1)
                reporter.onTestComplete({
                    test: test
                })
            end if
        end for
    end sub
    RBS_CC_34_reportLine("242", 1)
    instance.notifyReportersOnTestGroupComplete = sub()
        RBS_CC_34_reportLine("243", 1): for each reporter in m.testSuite.testReporters
            if RBS_CC_34_reportLine("244", 2) and (rooibos_common_isFunction(reporter.onTestGroupComplete))
                RBS_CC_34_reportLine("244", 3)
                RBS_CC_34_reportLine("245", 1)
                reporter.onTestGroupComplete({
                    group: m
                })
            end if
        end for
    end sub
    RBS_CC_34_reportLine("251", 1)
    return instance
end function

function rooibos_TestGroup(testSuite, data)
    RBS_CC_34_reportLine("254", 1)
    instance = __rooibos_TestGroup_builder()
    RBS_CC_34_reportLine("255", 1)
    instance.new(testSuite, data)
    RBS_CC_34_reportLine("256", 1)
    return instance
end function

'//# sourceMappingURL=./TestGroup.brs.map
function RBS_CC_34_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "34"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "34"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./TestGroup.brs.map