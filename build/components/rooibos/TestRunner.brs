' @ignore
function __rooibos_TestRunner_builder()
    RBS_CC_36_reportLine("2", 1)
    instance = {}
    RBS_CC_36_reportLine("3", 1)
    instance.new = function(testScene, nodeContext)
        RBS_CC_36_reportLine("4", 1)
        m.testScene = invalid
        RBS_CC_36_reportLine("5", 1)
        m.testReporters = []
        RBS_CC_36_reportLine("6", 1)
        m.nodeContext = invalid
        RBS_CC_36_reportLine("7", 1)
        m.config = invalid
        RBS_CC_36_reportLine("8", 1)
        m.testSuites = []
        RBS_CC_36_reportLine("9", 1)
        m.runtimeConfig = invalid
        RBS_CC_36_reportLine("10", 1)
        m.stats = invalid
        RBS_CC_36_reportLine("11", 1)
        m.top = invalid
        RBS_CC_36_reportLine("12", 1)
        m.testScene = testScene
        if RBS_CC_36_reportLine("13", 2) and (nodeContext.top = invalid)
            RBS_CC_36_reportLine("13", 3)
            RBS_CC_36_reportLine("14", 1)
            nodeContext.top = testScene
        end if
        RBS_CC_36_reportLine("16", 1)
        nodeContext.scene = testScene
        RBS_CC_36_reportLine("17", 1)
        m.top = nodeContext.top
        RBS_CC_36_reportLine("18", 1)
        m.nodeContext = nodeContext
        RBS_CC_36_reportLine("19", 1)
        m.stats = rooibos_Stats()
        RBS_CC_36_reportLine("20", 1)
        m.runtimeConfig = rooibos_RuntimeConfig()
        RBS_CC_36_reportLine("21", 1)
        m.config = m.runtimeConfig.getRuntimeConfig()
        RBS_CC_36_reportLine("22", 1)
        m.testReporters = m.getTestReporters()
    end function
    ' Executes all tests for a project, as per the config
    RBS_CC_36_reportLine("25", 1)
    instance.run = function()
        RBS_CC_36_reportLine("26", 1): for each reporter in m.testReporters
            if RBS_CC_36_reportLine("27", 2) and (rooibos_common_isFunction(reporter.onBegin))
                RBS_CC_36_reportLine("27", 3)
                RBS_CC_36_reportLine("28", 1)
                reporter.onBegin({
                    runner: m
                })
            end if
        end for
        RBS_CC_36_reportLine("33", 1)
        rooibosTimer = createObject("roTimespan")
        RBS_CC_36_reportLine("34", 1)
        rooibosTimer.mark()
        RBS_CC_36_reportLine("35", 1)
        suiteNames = m.runtimeConfig.getAllTestSuitesNames()
        RBS_CC_36_reportLine("36", 1)
        isFailed = false
        RBS_CC_36_reportLine("37", 1)
        failedText = ""
        RBS_CC_36_reportLine("38", 1)
        i = 0
        RBS_CC_36_reportLine("39", 1)
        numSuites = suiteNames.count()
        RBS_CC_36_reportLine("40", 1)
        testSuite = invalid
        RBS_CC_36_reportLine("41", 1): for each name in suiteNames
            RBS_CC_36_reportLine("42", 1)
            i++
            'bs:disable-next-line
            RBS_CC_36_reportLine("44", 1)
            suiteClass = m.runtimeConfig.getTestSuiteClassWithName(name)
            RBS_CC_36_reportLine("45", 1)
            testSuite = invalid
            if RBS_CC_36_reportLine("46", 2) and (suiteClass <> invalid)
                RBS_CC_36_reportLine("46", 3)
                RBS_CC_36_reportLine("47", 1)
                testSuite = suiteClass()
                RBS_CC_36_reportLine("48", 1)
                testSuite.testRunner = m
                RBS_CC_36_reportLine("49", 1)
                testSuite.testReporters = m.testReporters
                RBS_CC_36_reportLine("50", 1)
                testSuite.global = m.nodeContext.global
                RBS_CC_36_reportLine("51", 1)
                testSuite.context = m.nodeContext
                RBS_CC_36_reportLine("52", 1)
                testSuite.top = m.nodeContext.top
                RBS_CC_36_reportLine("53", 1)
                testSuite.scene = m.nodeContext.global.testsScene
                RBS_CC_36_reportLine("54", 1)
                testSuite.catchCrashes = m.config.catchCrashes
                RBS_CC_36_reportLine("55", 1)
                testSuite.throwOnFailedAssertion = m.config.throwOnFailedAssertion
                RBS_CC_36_reportLine("56", 1)
                testSuite.scene.testText = ("Running Suite " + bslib_toString(i) + " of " + bslib_toString(numSuites) + ": " + bslib_toString(name))
                RBS_CC_36_reportLine("57", 1)
                m.runTestSuite(testSuite)
                if RBS_CC_36_reportLine("58", 2) and (m.stats.hasFailures = true)
                    RBS_CC_36_reportLine("58", 3)
                    if RBS_CC_36_reportLine("59", 2) and (not isFailed)
                        RBS_CC_36_reportLine("59", 3)
                        RBS_CC_36_reportLine("60", 1)
                        isFailed = true
                        RBS_CC_36_reportLine("61", 1)
                        testSuite.scene.statusColor = "#DA3633"
                    end if
                    if RBS_CC_36_reportLine("63", 2) and (m.config.failFast = true)
                        RBS_CC_36_reportLine("63", 3)
                        exit for
                    end if
                end if
                if RBS_CC_36_reportLine("67", 2) and (testSuite.stats.hasFailures)
                    RBS_CC_36_reportLine("67", 3)
                    RBS_CC_36_reportLine("68", 1)
                    failedText = name + chr(10) + failedText
                    RBS_CC_36_reportLine("69", 1)
                    testSuite.scene.failedText = "Failed Suites: " + chr(10) + failedText
                end if
            else
                RBS_CC_36_reportLine("71", 3)
                RBS_CC_36_reportLine("72", 1)
                rooibos_common_logError(("Could not create test for suite : " + bslib_toString(name)))
                RBS_CC_36_reportLine("73", 1)
                failedText = "COULD NOT CREATE suite " + name + chr(10) + failedText
                RBS_CC_36_reportLine("74", 1)
                testSuite.scene.failedText = "Failed Suites: " + chr(10) + failedText
            end if
        end for
        if RBS_CC_36_reportLine("77", 2) and (not isFailed and testSuite <> invalid)
            RBS_CC_36_reportLine("77", 3)
            RBS_CC_36_reportLine("78", 1)
            testSuite.scene.statusColor = "#238636"
        end if
        if RBS_CC_36_reportLine("80", 2) and (testSuite = invalid)
            RBS_CC_36_reportLine("80", 3)
            RBS_CC_36_reportLine("81", 1)
            m.nodeContext.global.testsScene.failedText = "No tests were found"
        end if
        RBS_CC_36_reportLine("83", 1)
        m.stats.time = rooibosTimer.totalMilliseconds()
        RBS_CC_36_reportLine("84", 1): for each reporter in m.testReporters
            if RBS_CC_36_reportLine("85", 2) and (rooibos_common_isFunction(reporter.onEnd))
                RBS_CC_36_reportLine("85", 3)
                RBS_CC_36_reportLine("86", 1)
                reporter.onEnd({
                    stats: m.stats
                })
            end if
        end for
        RBS_CC_36_reportLine("91", 1)
        rooibosResult = {
            stats: m.stats
            testSuites: m.testSuites
        }
        RBS_CC_36_reportLine("95", 1)
        m.nodeContext.global.testsScene.rooibosTestResult = rooibosResult
        if RBS_CC_36_reportLine("96", 2) and (m.config.isRecordingCodeCoverage)
            RBS_CC_36_reportLine("96", 3)
            RBS_CC_36_reportLine("97", 1)
            rooibos_Coverage_reportCodeCoverage()
            if RBS_CC_36_reportLine("98", 2) and (m.config.printLcov = true)
                RBS_CC_36_reportLine("98", 3)
                RBS_CC_36_reportLine("99", 1)
                rooibos_Coverage_printLCovInfo()
            end if
        else
            RBS_CC_36_reportLine("101", 3)
            RBS_CC_36_reportLine("102", 1)
            rooibos_common_logDebug("rooibos.Coverage.reportCodeCoverage is not a function")
        end if
        ' Final results to be logged after all test reporters have finished
        RBS_CC_36_reportLine("105", 1)
        resultStatus = "PASS"
        if RBS_CC_36_reportLine("106", 2) and (isFailed) then
            RBS_CC_36_reportLine("106", 3)
            RBS_CC_36_reportLine("107", 1)
            resultStatus = "FAIL"
        end if
        RBS_CC_36_reportLine("109", 1)
        print "[Rooibos Result]: " + resultStatus
        RBS_CC_36_reportLine("110", 1)
        print "[Rooibos Shutdown]"
        if RBS_CC_36_reportLine("111", 2) and (m.config.sendHomeOnFinish <> false)
            RBS_CC_36_reportLine("111", 3)
            RBS_CC_36_reportLine("112", 1)
            m.sendHomeKeypress()
        end if
    end function
    RBS_CC_36_reportLine("115", 1)
    instance.runInNodeMode = function(nodeTestName)
        'bs:disable-next-line
        RBS_CC_36_reportLine("117", 1)
        suiteClass = m.runtimeConfig.getTestSuiteClassWithName(nodeTestName)
        RBS_CC_36_reportLine("118", 1)
        testSuite = invalid
        if RBS_CC_36_reportLine("119", 2) and (suiteClass <> invalid)
            RBS_CC_36_reportLine("119", 3)
            RBS_CC_36_reportLine("120", 1)
            testSuite = suiteClass()
            RBS_CC_36_reportLine("121", 1)
            testSuite.testReporters = m.testReporters
            RBS_CC_36_reportLine("122", 1)
            testSuite.global = m.nodeContext.global
            RBS_CC_36_reportLine("123", 1)
            testSuite.node = m.nodeContext
            RBS_CC_36_reportLine("124", 1)
            testSuite.top = m.nodeContext.top
            RBS_CC_36_reportLine("125", 1)
            testSuite.scene = m.nodeContext.global.testsScene
            RBS_CC_36_reportLine("126", 1)
            testSuite.catchCrashes = m.config.catchCrashes
            RBS_CC_36_reportLine("127", 1)
            testSuite.throwOnFailedAssertion = m.config.throwOnFailedAssertion
            RBS_CC_36_reportLine("128", 1)
            m.nodeContext.testSuite = testSuite
            RBS_CC_36_reportLine("129", 1)
            m.nodeTestName = nodeTestName
            RBS_CC_36_reportLine("130", 1)
            m.nodeContext.testRunner = m
        end if
        if RBS_CC_36_reportLine("132", 2) and (testSuite <> invalid)
            RBS_CC_36_reportLine("132", 3)
            RBS_CC_36_reportLine("133", 1)
            m.currentTestSuite = testSuite
            RBS_CC_36_reportLine("134", 1)
            testSuite.testRunner = m
            RBS_CC_36_reportLine("135", 1)
            rooibos_common_logDebug("Running suite as a Node test!")
            RBS_CC_36_reportLine("136", 1)
            testSuite.run()
            RBS_CC_36_reportLine("137", 1)
            return invalid
        else
            RBS_CC_36_reportLine("138", 3)
            RBS_CC_36_reportLine("139", 1)
            rooibos_common_logError(("Could not create test suite " + bslib_toString(nodeTestName)))
        end if
        RBS_CC_36_reportLine("141", 1)
        rooibos_common_logError(("(runInNodeMode) executing node test " + bslib_toString(nodeTestName) + " was unsuccessful."))
        RBS_CC_36_reportLine("142", 1)
        return invalid
    end function
    RBS_CC_36_reportLine("144", 1)
    instance.onTestSuiteComplete = function()
        RBS_CC_36_reportLine("145", 1)
        testSuite = m.currentTestSuite
        if RBS_CC_36_reportLine("146", 2) and (testSuite <> invalid)
            RBS_CC_36_reportLine("146", 3)
            RBS_CC_36_reportLine("147", 1)
            return {
                stats: testSuite.stats
                tests: testSuite.tests
            }
        else
            RBS_CC_36_reportLine("151", 3)
            RBS_CC_36_reportLine("152", 1)
            rooibos_common_logError(("could not create test suite " + bslib_toString(m.testRunner.nodeTestName)))
        end if
        RBS_CC_36_reportLine("154", 1)
        rooibos_common_logError(("(onTestSuiteComplete) executing node test " + bslib_toString(m.testRunner.nodeTestName) + " was unsuccessful."))
        RBS_CC_36_reportLine("155", 1)
        return invalid
    end function
    RBS_CC_36_reportLine("157", 1)
    instance.runTestSuite = function(testSuite) as void
        if RBS_CC_36_reportLine("158", 2) and (testSuite.groupsData <> invalid and testSuite.groupsData.count() > 0)
            RBS_CC_36_reportLine("158", 3)
            RBS_CC_36_reportLine("159", 1)
            m.testSuites.push(testSuite)
            if RBS_CC_36_reportLine("160", 2) and (testSuite.isNodeTest)
                RBS_CC_36_reportLine("160", 3)
                RBS_CC_36_reportLine("161", 1)
                m.runNodeTest(testSuite)
            else
                RBS_CC_36_reportLine("162", 3)
                RBS_CC_36_reportLine("163", 1)
                testSuite.run()
            end if
            RBS_CC_36_reportLine("165", 1)
            m.stats.merge(testSuite.stats)
        end if
    end function
    RBS_CC_36_reportLine("168", 1)
    instance.waitForField = function(target, fieldName, delay = 500, maxAttempts = 10)
        RBS_CC_36_reportLine("169", 1)
        attempts = 0
        if RBS_CC_36_reportLine("170", 2) and (target = invalid)
            RBS_CC_36_reportLine("170", 3)
            RBS_CC_36_reportLine("171", 1)
            return false
        end if
        RBS_CC_36_reportLine("173", 1)
        initialValue = target[fieldName]
        RBS_CC_36_reportLine("174", 1): while target[fieldName] = initialValue
            RBS_CC_36_reportLine("175", 1)
            port = CreateObject("roMessagePort")
            RBS_CC_36_reportLine("176", 1)
            wait(delay, port)
            RBS_CC_36_reportLine("177", 1)
            attempts++
            if RBS_CC_36_reportLine("178", 2) and (attempts = maxAttempts)
                RBS_CC_36_reportLine("178", 3)
                RBS_CC_36_reportLine("179", 1)
                return false
            end if
            RBS_CC_36_reportLine("181", 1)
            rooibos_common_logTrace(("waiting for signal field '" + bslib_toString(fieldName) + "' - " + bslib_toString(attempts) + " VALUE " + bslib_toString(target[fieldName])))
        end while
        RBS_CC_36_reportLine("183", 1)
        return true
    end function
    RBS_CC_36_reportLine("185", 1)
    instance.wait = function(delay = 1)
        RBS_CC_36_reportLine("186", 1)
        port = CreateObject("roMessagePort")
        RBS_CC_36_reportLine("187", 1)
        wait(delay, port)
    end function
    RBS_CC_36_reportLine("189", 1)
    instance.runNodeTest = function(testSuite) as void
        if RBS_CC_36_reportLine("190", 2) and (testSuite.generatedNodeName <> "")
            RBS_CC_36_reportLine("190", 3)
            RBS_CC_36_reportLine("191", 1)
            rooibos_common_logDebug(("+++++RUNNING NODE TEST" + bslib_toString(chr(10)) + "node type is " + bslib_toString(testSuite.generatedNodeName)))
            RBS_CC_36_reportLine("192", 1)
            node = m.testScene.createChild(testSuite.generatedNodeName)
            RBS_CC_36_reportLine("193", 1)
            port = CreateObject("roMessagePort")
            RBS_CC_36_reportLine("194", 1)
            node.observeField("rooibosTestResult", port)
            ' Trigger test via observer so that thread ownership
            ' can be transferred to the render thread
            RBS_CC_36_reportLine("197", 1)
            node.rooibosRunSuite = true
            'wait on the field
            if RBS_CC_36_reportLine("199", 2) and (type(node) = "roSGNode")
                RBS_CC_36_reportLine("199", 3)
                RBS_CC_36_reportLine("200", 1)
                event = invalid
                RBS_CC_36_reportLine("201", 1): while true
                    RBS_CC_36_reportLine("202", 1)
                    event = wait(0, port)
                    if RBS_CC_36_reportLine("203", 2) and (type(event) = "roSGNodeEvent")
                        RBS_CC_36_reportLine("203", 3)
                        exit while
                    end if
                end while
                RBS_CC_36_reportLine("207", 1)
                nodeResults = event.getData()
                RBS_CC_36_reportLine("208", 1)
                m.groups = []
                RBS_CC_36_reportLine("209", 1): for each groupData in testSuite.groupsData
                    'bs:disable-next-line
                    RBS_CC_36_reportLine("211", 1)
                    group = rooibos_TestGroup(testSuite, groupData)
                    RBS_CC_36_reportLine("212", 1)
                    testSuite.groups.push(group)
                end for
                if RBS_CC_36_reportLine("214", 2) and (nodeResults <> invalid)
                    RBS_CC_36_reportLine("214", 3)
                    RBS_CC_36_reportLine("215", 1)
                    testSuite.stats.merge(nodeResults.stats)
                    RBS_CC_36_reportLine("216", 1)
                    m.mergeGroups(testSuite, nodeResults.groups)
                else
                    RBS_CC_36_reportLine("217", 3)
                    RBS_CC_36_reportLine("218", 1)
                    rooibos_common_logError(("The node test " + bslib_toString(testSuite.name) + " did not indicate test completion. Did you call m.done() in your test? Did you correctly configure your node test? Please refer to : https://github.com/rokucommunity/rooibos/blob/master/docs/index.md#testing-scenegraph-nodes"))
                end if
                RBS_CC_36_reportLine("220", 1)
                m.testScene.removeChild(node)
                RBS_CC_36_reportLine("221", 1)
                return
            else
                RBS_CC_36_reportLine("222", 3)
                RBS_CC_36_reportLine("223", 1)
                rooibos_common_logError(("Could not create node required to execute tests for " + bslib_toString(testSuite.name) + bslib_toString(chr(10)) + "Node of type " + bslib_toString(testSuite.generatedNodeName) + " was not found/could not be instantiated"))
            end if
        else
            RBS_CC_36_reportLine("225", 3)
            RBS_CC_36_reportLine("226", 1)
            rooibos_common_logError(("Could not create node required to execute tests for " + bslib_toString(testSuite.name) + bslib_toString(chr(10)) + "No node type was provided"))
        end if
        RBS_CC_36_reportLine("228", 1)
        testSuite.stats.hasFailures = true
        RBS_CC_36_reportLine("229", 1)
        testSuite.failedCount += testSuite.testsData.count()
    end function
    RBS_CC_36_reportLine("231", 1)
    instance.mergeGroups = function(testSuite, groups)
        RBS_CC_36_reportLine("232", 1): for i = 0 to testSuite.groups.count() - 1
            RBS_CC_36_reportLine("233", 1)
            group = groups[i]
            RBS_CC_36_reportLine("234", 1)
            realGroup = testSuite.groups[i]
            RBS_CC_36_reportLine("235", 1)
            realGroup.stats.merge(group.stats)
            RBS_CC_36_reportLine("236", 1)
            realGroup.hasFailures = group.hasFailures
            RBS_CC_36_reportLine("237", 1)
            realGroup.tests = []
            RBS_CC_36_reportLine("238", 1): for testDataIndex = 0 to group.testsData.count() - 1
                RBS_CC_36_reportLine("239", 1)
                testData = group.testsData[testDataIndex]
                RBS_CC_36_reportLine("240", 1)
                realTest = rooibos_Test(m, testData, testSuite)
                RBS_CC_36_reportLine("241", 1)
                realGroup.tests.push(realTest)
                RBS_CC_36_reportLine("242", 1)
                test = group.tests[testDataIndex]
                RBS_CC_36_reportLine("243", 1)
                realTest.result.merge(test.result)
            end for
        end for
    end function
    RBS_CC_36_reportLine("247", 1)
    instance.sendHomeKeypress = function()
        RBS_CC_36_reportLine("248", 1)
        ut = createObject("roUrlTransfer")
        RBS_CC_36_reportLine("249", 1)
        ut.SetUrl("http://localhost:8060/keypress/Home")
        RBS_CC_36_reportLine("250", 1)
        ut.PostFromString("")
    end function
    RBS_CC_36_reportLine("252", 1)
    instance.getTestReporters = function()
        RBS_CC_36_reportLine("253", 1)
        testReporters = []
        RBS_CC_36_reportLine("254", 1): for each factory in m.config.reporters
            if RBS_CC_36_reportLine("255", 2) and (rooibos_common_isFunction(factory))
                RBS_CC_36_reportLine("255", 3)
                RBS_CC_36_reportLine("256", 1)
                testReporters.push(factory(m))
            end if
        end for
        if RBS_CC_36_reportLine("259", 2) and (testReporters.isEmpty())
            RBS_CC_36_reportLine("259", 3)
            RBS_CC_36_reportLine("260", 1)
            testReporters.push(rooibos_ConsoleTestReporter(m))
        end if
        RBS_CC_36_reportLine("262", 1)
        return testReporters
    end function
    RBS_CC_36_reportLine("264", 1)
    return instance
end function

function rooibos_TestRunner(testScene, nodeContext)
    RBS_CC_36_reportLine("267", 1)
    instance = __rooibos_TestRunner_builder()
    RBS_CC_36_reportLine("268", 1)
    instance.new(testScene, nodeContext)
    RBS_CC_36_reportLine("269", 1)
    return instance
end function
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'++ This code is called inside of the node
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

' @ignore
function rooibos_createTestNode(nodeType) as object
    RBS_CC_36_reportLine("277", 1)
    node = createObject("roSGNode", nodeType)
    if RBS_CC_36_reportLine("278", 2) and (type(node) = "roSGNode" and node.subType() = nodeType)
        RBS_CC_36_reportLine("278", 3)
        RBS_CC_36_reportLine("279", 1)
        m.top.AppendChild(node)
        RBS_CC_36_reportLine("280", 1)
        return node
    else
        RBS_CC_36_reportLine("281", 3)
        RBS_CC_36_reportLine("282", 1)
        rooibos_common_logError(("Error creating test node of type " + bslib_toString(nodeType)))
        RBS_CC_36_reportLine("283", 1)
        return invalid
    end if
end function

' @ignore
function rooibos_runNodeTestSuite(name)
    RBS_CC_36_reportLine("289", 1)
    nodeRunner = rooibos_TestRunner(m.top.getScene(), m)
    RBS_CC_36_reportLine("290", 1)
    return nodeRunner.runInNodeMode(name)
end function

' @ignore
function rooibos_onTestSuiteComplete()
    RBS_CC_36_reportLine("295", 1)
    m.testRunner.onTestSuiteComplete()
end function

'//# sourceMappingURL=./TestRunner.brs.map
function RBS_CC_36_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "36"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "36"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./TestRunner.brs.map