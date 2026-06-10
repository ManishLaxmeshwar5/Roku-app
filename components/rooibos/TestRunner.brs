' @ignore
function __rooibos_TestRunner_builder()
    instance = {}
    instance.new = function(testScene, nodeContext)
        m.testScene = invalid
        m.testReporters = []
        m.nodeContext = invalid
        m.config = invalid
        m.testSuites = []
        m.runtimeConfig = invalid
        m.stats = invalid
        m.top = invalid
        m.testScene = testScene
        if nodeContext.top = invalid
            nodeContext.top = testScene
        end if
        nodeContext.scene = testScene
        m.top = nodeContext.top
        m.nodeContext = nodeContext
        m.stats = rooibos_Stats()
        m.runtimeConfig = rooibos_RuntimeConfig()
        m.config = m.runtimeConfig.getRuntimeConfig()
        m.testReporters = m.getTestReporters()
    end function
    ' Executes all tests for a project, as per the config
    instance.run = function()
        for each reporter in m.testReporters
            if rooibos_common_isFunction(reporter.onBegin)
                reporter.onBegin({
                    runner: m
                })
            end if
        end for
        rooibosTimer = createObject("roTimespan")
        rooibosTimer.mark()
        suiteNames = m.runtimeConfig.getAllTestSuitesNames()
        isFailed = false
        failedText = ""
        i = 0
        numSuites = suiteNames.count()
        testSuite = invalid
        for each name in suiteNames
            i++
            'bs:disable-next-line
            suiteClass = m.runtimeConfig.getTestSuiteClassWithName(name)
            testSuite = invalid
            if suiteClass <> invalid
                testSuite = suiteClass()
                testSuite.testRunner = m
                testSuite.testReporters = m.testReporters
                testSuite.global = m.nodeContext.global
                testSuite.context = m.nodeContext
                testSuite.top = m.nodeContext.top
                testSuite.scene = m.nodeContext.global.testsScene
                testSuite.catchCrashes = m.config.catchCrashes
                testSuite.throwOnFailedAssertion = m.config.throwOnFailedAssertion
                testSuite.scene.testText = ("Running Suite " + bslib_toString(i) + " of " + bslib_toString(numSuites) + ": " + bslib_toString(name))
                m.runTestSuite(testSuite)
                if m.stats.hasFailures = true
                    if not isFailed
                        isFailed = true
                        testSuite.scene.statusColor = "#DA3633"
                    end if
                    if m.config.failFast = true
                        exit for
                    end if
                end if
                if testSuite.stats.hasFailures
                    failedText = name + chr(10) + failedText
                    testSuite.scene.failedText = "Failed Suites: " + chr(10) + failedText
                end if
            else
                rooibos_common_logError(("Could not create test for suite : " + bslib_toString(name)))
                failedText = "COULD NOT CREATE suite " + name + chr(10) + failedText
                testSuite.scene.failedText = "Failed Suites: " + chr(10) + failedText
            end if
        end for
        if not isFailed and testSuite <> invalid
            testSuite.scene.statusColor = "#238636"
        end if
        if testSuite = invalid
            m.nodeContext.global.testsScene.failedText = "No tests were found"
        end if
        m.stats.time = rooibosTimer.totalMilliseconds()
        for each reporter in m.testReporters
            if rooibos_common_isFunction(reporter.onEnd)
                reporter.onEnd({
                    stats: m.stats
                })
            end if
        end for
        rooibosResult = {
            stats: m.stats
            testSuites: m.testSuites
        }
        m.nodeContext.global.testsScene.rooibosTestResult = rooibosResult
        if m.config.isRecordingCodeCoverage
            rooibos_Coverage_reportCodeCoverage()
            if m.config.printLcov = true
                rooibos_Coverage_printLCovInfo()
            end if
        else
            rooibos_common_logDebug("rooibos.Coverage.reportCodeCoverage is not a function")
        end if
        ' Final results to be logged after all test reporters have finished
        resultStatus = "PASS"
        if isFailed then
            resultStatus = "FAIL"
        end if
        print "[Rooibos Result]: " + resultStatus
        print "[Rooibos Shutdown]"
        if m.config.sendHomeOnFinish <> false
            m.sendHomeKeypress()
        end if
    end function
    instance.runInNodeMode = function(nodeTestName)
        'bs:disable-next-line
        suiteClass = m.runtimeConfig.getTestSuiteClassWithName(nodeTestName)
        testSuite = invalid
        if suiteClass <> invalid
            testSuite = suiteClass()
            testSuite.testReporters = m.testReporters
            testSuite.global = m.nodeContext.global
            testSuite.node = m.nodeContext
            testSuite.top = m.nodeContext.top
            testSuite.scene = m.nodeContext.global.testsScene
            testSuite.catchCrashes = m.config.catchCrashes
            testSuite.throwOnFailedAssertion = m.config.throwOnFailedAssertion
            m.nodeContext.testSuite = testSuite
            m.nodeTestName = nodeTestName
            m.nodeContext.testRunner = m
        end if
        if testSuite <> invalid
            m.currentTestSuite = testSuite
            testSuite.testRunner = m
            rooibos_common_logDebug("Running suite as a Node test!")
            testSuite.run()
            return invalid
        else
            rooibos_common_logError(("Could not create test suite " + bslib_toString(nodeTestName)))
        end if
        rooibos_common_logError(("(runInNodeMode) executing node test " + bslib_toString(nodeTestName) + " was unsuccessful."))
        return invalid
    end function
    instance.onTestSuiteComplete = function()
        testSuite = m.currentTestSuite
        if testSuite <> invalid
            return {
                stats: testSuite.stats
                tests: testSuite.tests
            }
        else
            rooibos_common_logError(("could not create test suite " + bslib_toString(m.testRunner.nodeTestName)))
        end if
        rooibos_common_logError(("(onTestSuiteComplete) executing node test " + bslib_toString(m.testRunner.nodeTestName) + " was unsuccessful."))
        return invalid
    end function
    instance.runTestSuite = function(testSuite) as void
        if testSuite.groupsData <> invalid and testSuite.groupsData.count() > 0
            m.testSuites.push(testSuite)
            if testSuite.isNodeTest
                m.runNodeTest(testSuite)
            else
                testSuite.run()
            end if
            m.stats.merge(testSuite.stats)
        end if
    end function
    instance.waitForField = function(target, fieldName, delay = 500, maxAttempts = 10)
        attempts = 0
        if target = invalid
            return false
        end if
        initialValue = target[fieldName]
        while target[fieldName] = initialValue
            port = CreateObject("roMessagePort")
            wait(delay, port)
            attempts++
            if attempts = maxAttempts
                return false
            end if
            rooibos_common_logTrace(("waiting for signal field '" + bslib_toString(fieldName) + "' - " + bslib_toString(attempts) + " VALUE " + bslib_toString(target[fieldName])))
        end while
        return true
    end function
    instance.wait = function(delay = 1)
        port = CreateObject("roMessagePort")
        wait(delay, port)
    end function
    instance.runNodeTest = function(testSuite) as void
        if testSuite.generatedNodeName <> ""
            rooibos_common_logDebug(("+++++RUNNING NODE TEST" + bslib_toString(chr(10)) + "node type is " + bslib_toString(testSuite.generatedNodeName)))
            node = m.testScene.createChild(testSuite.generatedNodeName)
            port = CreateObject("roMessagePort")
            node.observeField("rooibosTestResult", port)
            ' Trigger test via observer so that thread ownership
            ' can be transferred to the render thread
            node.rooibosRunSuite = true
            'wait on the field
            if type(node) = "roSGNode"
                event = invalid
                while true
                    event = wait(0, port)
                    if type(event) = "roSGNodeEvent"
                        exit while
                    end if
                end while
                nodeResults = event.getData()
                m.groups = []
                for each groupData in testSuite.groupsData
                    'bs:disable-next-line
                    group = rooibos_TestGroup(testSuite, groupData)
                    testSuite.groups.push(group)
                end for
                if nodeResults <> invalid
                    testSuite.stats.merge(nodeResults.stats)
                    m.mergeGroups(testSuite, nodeResults.groups)
                else
                    rooibos_common_logError(("The node test " + bslib_toString(testSuite.name) + " did not indicate test completion. Did you call m.done() in your test? Did you correctly configure your node test? Please refer to : https://github.com/rokucommunity/rooibos/blob/master/docs/index.md#testing-scenegraph-nodes"))
                end if
                m.testScene.removeChild(node)
                return
            else
                rooibos_common_logError(("Could not create node required to execute tests for " + bslib_toString(testSuite.name) + bslib_toString(chr(10)) + "Node of type " + bslib_toString(testSuite.generatedNodeName) + " was not found/could not be instantiated"))
            end if
        else
            rooibos_common_logError(("Could not create node required to execute tests for " + bslib_toString(testSuite.name) + bslib_toString(chr(10)) + "No node type was provided"))
        end if
        testSuite.stats.hasFailures = true
        testSuite.failedCount += testSuite.testsData.count()
    end function
    instance.mergeGroups = function(testSuite, groups)
        for i = 0 to testSuite.groups.count() - 1
            group = groups[i]
            realGroup = testSuite.groups[i]
            realGroup.stats.merge(group.stats)
            realGroup.hasFailures = group.hasFailures
            realGroup.tests = []
            for testDataIndex = 0 to group.testsData.count() - 1
                testData = group.testsData[testDataIndex]
                realTest = rooibos_Test(m, testData, testSuite)
                realGroup.tests.push(realTest)
                test = group.tests[testDataIndex]
                realTest.result.merge(test.result)
            end for
        end for
    end function
    instance.sendHomeKeypress = function()
        ut = createObject("roUrlTransfer")
        ut.SetUrl("http://localhost:8060/keypress/Home")
        ut.PostFromString("")
    end function
    instance.getTestReporters = function()
        testReporters = []
        for each factory in m.config.reporters
            if rooibos_common_isFunction(factory)
                testReporters.push(factory(m))
            end if
        end for
        if testReporters.isEmpty()
            testReporters.push(rooibos_ConsoleTestReporter(m))
        end if
        return testReporters
    end function
    return instance
end function
function rooibos_TestRunner(testScene, nodeContext)
    instance = __rooibos_TestRunner_builder()
    instance.new(testScene, nodeContext)
    return instance
end function
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'++ This code is called inside of the node
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

' @ignore
function rooibos_createTestNode(nodeType) as object
    node = createObject("roSGNode", nodeType)
    if type(node) = "roSGNode" and node.subType() = nodeType
        m.top.AppendChild(node)
        return node
    else
        rooibos_common_logError(("Error creating test node of type " + bslib_toString(nodeType)))
        return invalid
    end if
end function

' @ignore
function rooibos_runNodeTestSuite(name)
    nodeRunner = rooibos_TestRunner(m.top.getScene(), m)
    return nodeRunner.runInNodeMode(name)
end function

' @ignore
function rooibos_onTestSuiteComplete()
    m.testRunner.onTestSuiteComplete()
end function
'//# sourceMappingURL=./TestRunner.brs.map