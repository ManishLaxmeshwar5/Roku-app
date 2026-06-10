function __rooibos_TestGroup_builder()
    instance = {}
    'test state
    instance.new = function(testSuite, data)
        m.name = "Unnamed Suite"
        m.testSuite = invalid
        m.setupFunctionName = invalid
        m.tearDownFunctionName = invalid
        m.beforeEachFunctionName = invalid
        m.afterEachFunctionName = invalid
        m.isSolo = false
        m.isLegacy = false
        m.isIgnored = false
        m.stats = invalid
        m.scene = invalid
        m.lineNumber = 00
        m.top = invalid
        m.valid = false
        m.hasFailures = false
        m.isNodeTest = false
        m.nodeName = invalid
        m.testsData = invalid
        m.tests = []
        m.deferred = invalid
        m.currentTestIndex = 0
        m.testSuite = testSuite
        m.name = data.name
        m.valid = data.valid
        m.hasFailures = testSuite.hasFailures
        m.isSolo = data.isSolo
        m.isIgnored = data.isIgnored
        m.isAsync = data.isAsync
        m.asyncTimeout = data.asyncTimeout
        m.testsData = data.testCases
        m.isNodeTest = testSuite.isNodeTest
        m.nodeName = invalid
        m.setupFunctionName = data.setupFunctionName
        m.tearDownFunctionName = data.tearDownFunctionName
        m.beforeEachFunctionName = data.beforeEachFunctionName
        m.afterEachFunctionName = data.afterEachFunctionName
        m.lineNumber = data.lineNumber
        if m.isNodeTest
            m.deferred = rooibos_promises_create()
        end if
        'bs:disable-next-line
        m.global = testSuite.global
        m.top = testSuite.top
        m.scene = testSuite.scene
        m.stats = rooibos_Stats()
    end function
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    '++ running
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    'TODO CONVERT THIS TO ASYNC
    instance.run = function()
        rooibos_common_logTrace(">>>>>>>>>>>>")
        rooibos_common_logTrace("RUNNING TEST GROUP")
        m.testRunner = m.testSuite.testRunner
        m.notifyReportersOnTestGroupBegin()
        if m.testSuite.isNodeTest = true
            rooibos_common_logTrace("THIS GROUP IS ASYNC")
            m.runAsync()
            return m.deferred
        else
            rooibos_common_logTrace("THIS GROUP IS SYNC")
            m.runSync()
            return true
        end if
    end function
    instance.runSync = function()
        isOk = m.runSuiteFunction(m.setupFunctionName, "setup")
        if isOk
            for each testData in m.testsData
                test = rooibos_Test(m, testData)
                m.tests.push(test)
                if test.isIgnored
                    m.notifyReportersOnTestBegin(test)
                    m.testSuite.runTest(test)
                    m.notifyReportersOnTestComplete(test)
                    m.stats.appendTestResult(test.result)
                    continue for
                end if
                isOk = m.runSuiteFunction(m.beforeEachFunctionName, "beforeEach", test)
                if isOk
                    m.notifyReportersOnTestBegin(test)
                    m.testSuite.runTest(test)
                    m.notifyReportersOnTestComplete(test)
                end if
                m.runSuiteFunction(m.afterEachFunctionName, "afterEach", test)
                m.stats.appendTestResult(test.result)
                if m.stats.hasFailures and m.testSuite.isFailingFast
                    rooibos_common_logTrace("Terminating group due to failed test")
                    exit for
                end if
            end for
        else
            rooibos_common_logError("ERROR running test setup function")
        end if
        m.notifyReportersOnTestGroupComplete()
        m.runSuiteFunction(m.tearDownFunctionName, "tearDown")
    end function
    instance.runAsync = function()
        isOk = m.runSuiteFunction(m.setupFunctionName, "setup")
        m.testTimer = createObject("roTimespan")
        if isOk
            m.testRunner.currentGroup = m
            for each testData in m.testsData
                test = rooibos_Test(m, testData)
                m.tests.push(test)
            end for
            m.currentTestIndex = -1
            m.runNextAsync()
        else
            rooibos_common_logError("ERROR running test setup function")
            m.runSuiteFunction(m.tearDownFunctionName, "tearDown")
        end if
    end function
    instance.runNextAsync = function()
        rooibos_common_logTrace("Getting next async test")
        m.currentTestIndex++
        m.currentTest = m.tests[m.currentTestIndex]
        m.testSuite.isDoneCalled = false
        m.testTimer.mark()
        if m.currentTest = invalid
            rooibos_common_logTrace("All tests are finished")
            m.finishAsyncTests()
        else
            test = m.currentTest
            ' Check to see if the test is ignored or if the suite is timed out
            ' and skip the before and after hooks
            if test.isIgnored or m.testSuite.isSuiteTimedOut()
                m.notifyReportersOnTestBegin(test)
                m.testSuite.runTest(test)
                m.onAsyncTestComplete()
                return invalid
            end if
            isOk = m.runSuiteFunction(m.beforeEachFunctionName, "beforeEach", m.currentTest)
            if isOk
                m.notifyReportersOnTestBegin(test)
                m.testSuite.runTest(test)
                rooibos_common_logDebug("Waiting on deferred test results")
                rooibos_promises_chain(test.deferred, {
                    self: m
                    test: test
                }).then(function(_, context)
                    rooibos_common_logDebug("Promise resolved")
                    context.self.testSuite.done()
                end function).catch(function(error, context)
                    rooibos_common_logDebug("Promise rejected")
                    if rooibos_common_isAssociativeArray(error) and not error.isEmpty() and rooibos_common_isArray(error.backtrace) and not error.backtrace.isEmpty() and rooibos_common_isBoolean(error.rethrown)
                        context.self.testSuite.failCrash(error)
                    else
                        context.self.testSuite.fail("Test failed due to promise rejection")
                    end if
                    context.self.testSuite.done()
                end function).finally(function(context)
                    context.self.onAsyncTestComplete()
                end function)
            else
                rooibos_common_logTrace("Error running test before each function")
                m.isTestFailedDueToEarlyExit = true
                m.finishAsyncTests()
            end if
        end if
    end function
    instance.onAsyncTestComplete = function()
        rooibos_common_logTrace("++ CURRENT TEST COMPLETED")
        m.notifyReportersOnTestComplete(m.currentTest)
        m.runSuiteFunction(m.afterEachFunctionName, "afterEach", m.currentTest)
        m.stats.appendTestResult(m.currentTest.result)
        if m.stats.hasFailures and m.testSuite.isFailingFast
            rooibos_common_logTrace("Terminating group due to failed test")
            m.isTestFailedDueToEarlyExit = true
            m.finishAsyncTests()
        else
            m.runNextAsync()
        end if
    end function
    instance.finishAsyncTests = function()
        m.runSuiteFunction(m.tearDownFunctionName, "tearDown")
        rooibos_common_logTrace("Indicating test suite is done")
        m.notifyReportersOnTestGroupComplete()
        rooibos_promises_resolve(true, m.deferred)
    end function
    instance.runSuiteFunction = function(methodName, defaultMethodName, test = invalid)
        if methodName = invalid or methodName = ""
            methodName = defaultMethodName
        end if
        if m.testSuite.catchCrashes and not m.testSuite.noCatch and not (test <> invalid and test.noCatch)
            ' Add the users suite functions execution time to the suites current execution time
            timespan = createObject("roTimespan")
            try
                m.testSuite[methodName]()
                m.testSuite.currentExecutionTime += timespan.totalMilliseconds()
                return true
            catch error
                if test <> invalid
                    'bs:disable-next-line
                    test.result.crash("function " + methodName + "crashed!", error)
                    m.testSuite.currentExecutionTime += timespan.totalMilliseconds()
                end if
            end try
        else
            timespan = createObject("roTimespan")
            m.testSuite[methodName]()
            m.testSuite.currentExecutionTime += timespan.totalMilliseconds()
            return true
        end if
        'bs:disable-next-line
        return false
    end function
    instance.notifyReportersOnTestGroupBegin = sub()
        for each reporter in m.testSuite.testReporters
            if rooibos_common_isFunction(reporter.onTestGroupBegin)
                reporter.onTestGroupBegin({
                    group: m
                })
            end if
        end for
    end sub
    instance.notifyReportersOnTestBegin = sub(test as object)
        for each reporter in m.testSuite.testReporters
            if rooibos_common_isFunction(reporter.onTestBegin)
                reporter.onTestBegin({
                    test: test
                })
            end if
        end for
    end sub
    instance.notifyReportersOnTestComplete = sub(test as object)
        if test.result.time > 0
            ' Add the test execution time to the suites current execution time
            m.testSuite.currentExecutionTime += test.result.time
        end if
        for each reporter in m.testSuite.testReporters
            if rooibos_common_isFunction(reporter.onTestComplete)
                reporter.onTestComplete({
                    test: test
                })
            end if
        end for
    end sub
    instance.notifyReportersOnTestGroupComplete = sub()
        for each reporter in m.testSuite.testReporters
            if rooibos_common_isFunction(reporter.onTestGroupComplete)
                reporter.onTestGroupComplete({
                    group: m
                })
            end if
        end for
    end sub
    return instance
end function
function rooibos_TestGroup(testSuite, data)
    instance = __rooibos_TestGroup_builder()
    instance.new(testSuite, data)
    return instance
end function
'//# sourceMappingURL=./TestGroup.brs.map