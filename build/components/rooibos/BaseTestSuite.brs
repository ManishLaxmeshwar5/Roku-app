function __rooibos_BaseTestSuite_builder()
    RBS_CC_22_reportLine("1", 1)
    instance = {}
    'test state
    'set the name to the name of your test
    'special values
    ' special value used in mock arguments
    ' special value used in mock arguments
    'built in any matchers
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    '++ base methods to override
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    RBS_CC_22_reportLine("11", 1)
    instance.new = function()
        RBS_CC_22_reportLine("12", 1)
        m.name = "BaseTestSuite"
        RBS_CC_22_reportLine("13", 1)
        m.filePath = invalid
        RBS_CC_22_reportLine("14", 1)
        m.pkgPath = invalid
        RBS_CC_22_reportLine("15", 1)
        m.isValid = false
        RBS_CC_22_reportLine("16", 1)
        m.hasSoloTests = false
        RBS_CC_22_reportLine("17", 1)
        m.hasIgnoredTests = false
        RBS_CC_22_reportLine("18", 1)
        m.isSolo = false
        RBS_CC_22_reportLine("19", 1)
        m.isIgnored = false
        RBS_CC_22_reportLine("20", 1)
        m.noCatch = false
        RBS_CC_22_reportLine("21", 1)
        m.isNodeTest = false
        RBS_CC_22_reportLine("22", 1)
        m.nodeName = invalid
        RBS_CC_22_reportLine("23", 1)
        m.lineNumber = 1
        RBS_CC_22_reportLine("24", 1)
        m.groups = []
        RBS_CC_22_reportLine("25", 1)
        m.groupsData = []
        RBS_CC_22_reportLine("26", 1)
        m.stats = invalid
        RBS_CC_22_reportLine("27", 1)
        m.currentAssertLineNumber = -1
        RBS_CC_22_reportLine("28", 1)
        m.valid = false
        RBS_CC_22_reportLine("29", 1)
        m.hasFailures = false
        RBS_CC_22_reportLine("30", 1)
        m.hasSoloGroups = false
        RBS_CC_22_reportLine("31", 1)
        m.isFailingFast = false
        RBS_CC_22_reportLine("32", 1)
        m.stubs = invalid
        RBS_CC_22_reportLine("33", 1)
        m.mocks = invalid
        RBS_CC_22_reportLine("34", 1)
        m.__stubId = -1
        RBS_CC_22_reportLine("35", 1)
        m.__mockId = -1
        RBS_CC_22_reportLine("36", 1)
        m.__mockTargetId = -1
        RBS_CC_22_reportLine("37", 1)
        m.currentExecutionTime = 0
        RBS_CC_22_reportLine("38", 1)
        m.timedOut = false
        RBS_CC_22_reportLine("39", 1)
        m.deferred = invalid
        RBS_CC_22_reportLine("40", 1)
        m.invalidValue = "#ROIBOS#INVALID_VALUE"
        RBS_CC_22_reportLine("41", 1)
        m.ignoreValue = "#ROIBOS#IGNORE_VALUE"
        RBS_CC_22_reportLine("42", 1)
        m.anyStringMatcher = {
            "matcher": Rooibos_Matcher_anyString
        }
        RBS_CC_22_reportLine("45", 1)
        m.anyBoolMatcher = {
            "matcher": Rooibos_Matcher_anyBool
        }
        RBS_CC_22_reportLine("48", 1)
        m.anyNumberMatcher = {
            "matcher": Rooibos_Matcher_anyNumber
        }
        RBS_CC_22_reportLine("51", 1)
        m.anyAAMatcher = {
            "matcher": Rooibos_Matcher_anyAA
        }
        RBS_CC_22_reportLine("54", 1)
        m.anyArrayMatcher = {
            "matcher": Rooibos_Matcher_anyArray
        }
        RBS_CC_22_reportLine("57", 1)
        m.anyNodeMatcher = {
            "matcher": Rooibos_Matcher_anyNode
        }
        RBS_CC_22_reportLine("60", 1)
        m.allowNonExistingMethodsOnMocks = true
        RBS_CC_22_reportLine("61", 1)
        m.isAutoAssertingMocks = true
        RBS_CC_22_reportLine("62", 1)
        m.currentResult = invalid
        RBS_CC_22_reportLine("63", 1)
        m.global = invalid
        RBS_CC_22_reportLine("64", 1)
        m.catchCrashes = false
        RBS_CC_22_reportLine("65", 1)
        m.throwOnFailedAssertion = false
        RBS_CC_22_reportLine("66", 1)
        data = m.getTestSuitedata()
        if RBS_CC_22_reportLine("67", 2) and (data = invalid)
            RBS_CC_22_reportLine("67", 3)
            RBS_CC_22_reportLine("68", 1)
            rooibos_common_logError("ERROR RETRIEVING TEST SUITE DATA!! this is a rooibos BUG - please report the suite that resulted in a corrupt test. Thanks")
        else
            RBS_CC_22_reportLine("69", 3)
            RBS_CC_22_reportLine("70", 1)
            m.name = data.name
            RBS_CC_22_reportLine("71", 1)
            m.filePath = data.filePath
            RBS_CC_22_reportLine("72", 1)
            m.pkgPath = data.pkgPath
            RBS_CC_22_reportLine("73", 1)
            m.valid = data.valid
            RBS_CC_22_reportLine("74", 1)
            m.hasFailures = data.hasFailures
            RBS_CC_22_reportLine("75", 1)
            m.hasSoloTests = data.hasSoloTests
            RBS_CC_22_reportLine("76", 1)
            m.hasIgnoredTests = data.hasIgnoredTests
            RBS_CC_22_reportLine("77", 1)
            m.hasSoloGroups = data.hasSoloGroups
            RBS_CC_22_reportLine("78", 1)
            m.isSolo = data.isSolo
            RBS_CC_22_reportLine("79", 1)
            m.isIgnored = data.isIgnored
            RBS_CC_22_reportLine("80", 1)
            m.isAsync = data.isAsync
            RBS_CC_22_reportLine("81", 1)
            m.asyncTimeout = data.asyncTimeout
            RBS_CC_22_reportLine("82", 1)
            m.noCatch = data.noCatch
            RBS_CC_22_reportLine("83", 1)
            m.groupsData = data.testGroups
            RBS_CC_22_reportLine("84", 1)
            m.lineNumber = data.lineNumber
            RBS_CC_22_reportLine("85", 1)
            m.isNodeTest = data.isNodeTest
            RBS_CC_22_reportLine("86", 1)
            m.nodeName = data.nodeName
            RBS_CC_22_reportLine("87", 1)
            m.generatedNodeName = data.generatedNodeName
            RBS_CC_22_reportLine("88", 1)
            m.isFailingFast = false
            if RBS_CC_22_reportLine("89", 2) and (m.isNodeTest)
                RBS_CC_22_reportLine("89", 3)
                RBS_CC_22_reportLine("90", 1)
                m.deferred = rooibos_promises_create()
            end if
            RBS_CC_22_reportLine("92", 1)
            m.stats = rooibos_Stats()
        end if
    end function
    ' @ignore
    RBS_CC_22_reportLine("96", 1)
    instance.getTestSuiteData = function()
        'this will be injected by the plugin
    end function
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    '++ used for entire suite - use annotations to use elsewhere
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    RBS_CC_22_reportLine("102", 1)
    instance.setup = function()
    end function
    RBS_CC_22_reportLine("104", 1)
    instance.tearDown = function()
    end function
    RBS_CC_22_reportLine("106", 1)
    instance.beforeEach = function()
    end function
    RBS_CC_22_reportLine("108", 1)
    instance.afterEach = function()
    end function
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    '++ running
    '++++++++++++++++++++++++++++++++++++?+++++++++++++++++++++++++
    ' @ignore
    RBS_CC_22_reportLine("114", 1)
    instance.run = function()
        RBS_CC_22_reportLine("115", 1)
        m.notifyReportersOnSuiteBegin()
        RBS_CC_22_reportLine("116", 1)
        rooibos_common_logTrace(">>>>>>>>>>>>")
        RBS_CC_22_reportLine("117", 1)
        rooibos_common_logTrace("RUNNING TEST SUITE")
        if RBS_CC_22_reportLine("118", 2) and (m.isNodeTest = true)
            RBS_CC_22_reportLine("118", 3)
            RBS_CC_22_reportLine("119", 1)
            rooibos_common_logTrace("THIS GROUP IS ASYNC")
            RBS_CC_22_reportLine("120", 1)
            m.runAsync()
        else
            RBS_CC_22_reportLine("121", 3)
            RBS_CC_22_reportLine("122", 1)
            rooibos_common_logTrace("THIS GROUP IS SYNC")
            RBS_CC_22_reportLine("123", 1)
            m.runSync()
        end if
    end function
    ' @ignore
    RBS_CC_22_reportLine("127", 1)
    instance.runSync = function()
        RBS_CC_22_reportLine("128", 1): for each groupData in m.groupsData
            'bs:disable-next-line
            RBS_CC_22_reportLine("130", 1)
            group = rooibos_TestGroup(m, groupData)
            'bs:disable-next-line
            RBS_CC_22_reportLine("132", 1)
            m.groups.push(group)
            'bs:disable-next-line
            RBS_CC_22_reportLine("134", 1)
            group.run()
            'bs:disable-next-line
            RBS_CC_22_reportLine("136", 1)
            m.stats.merge(group.stats)
            if RBS_CC_22_reportLine("137", 2) and (m.stats.hasFailures and m.isFailingFast = true)
                RBS_CC_22_reportLine("137", 3)
                RBS_CC_22_reportLine("138", 1)
                rooibos_common_logDebug("Terminating suite due to failed group")
                exit for
            end if
        end for
        RBS_CC_22_reportLine("142", 1)
        m.notifyReportersOnSuiteComplete()
    end function
    ' @ignore
    RBS_CC_22_reportLine("145", 1)
    instance.runASync = function()
        RBS_CC_22_reportLine("146", 1)
        rooibos_common_logTrace("Running groups async")
        RBS_CC_22_reportLine("147", 1)
        m.groups = []
        RBS_CC_22_reportLine("148", 1): for each groupData in m.groupsData
            'bs:disable-next-line
            RBS_CC_22_reportLine("150", 1)
            group = rooibos_TestGroup(m, groupData)
            RBS_CC_22_reportLine("151", 1)
            m.groups.push(group)
        end for
        RBS_CC_22_reportLine("153", 1)
        m.currentGroupIndex = -1
        RBS_CC_22_reportLine("154", 1)
        m.runNextAsync()
    end function
    ' @ignore
    RBS_CC_22_reportLine("157", 1)
    instance.runNextAsync = function()
        RBS_CC_22_reportLine("158", 1)
        rooibos_common_logTrace("Getting next async group")
        RBS_CC_22_reportLine("159", 1)
        m.currentGroupIndex++
        RBS_CC_22_reportLine("160", 1)
        m.currentGroup = m.groups[m.currentGroupIndex]
        if RBS_CC_22_reportLine("161", 2) and (m.currentGroup = invalid)
            RBS_CC_22_reportLine("161", 3)
            RBS_CC_22_reportLine("162", 1)
            rooibos_common_logTrace("All groups are finished")
            'finished
            RBS_CC_22_reportLine("164", 1)
            m.testSuiteDone()
        else
            RBS_CC_22_reportLine("165", 3)
            RBS_CC_22_reportLine("166", 1)
            group = m.currentGroup
            RBS_CC_22_reportLine("167", 1)
            group.run()
            if RBS_CC_22_reportLine("168", 2) and (rooibos_promises_isPromise(group.deferred))
                RBS_CC_22_reportLine("168", 3)
                RBS_CC_22_reportLine("169", 1)
                rooibos_promises_onFinally(group.deferred, sub(context)
                    RBS_CC_22_reportLine("170", 1)
                    context.self.onAsyncGroupComplete(context.group)
                end sub, {
                    group: group
                    self: m
                })
            else
                RBS_CC_22_reportLine("175", 3)
                RBS_CC_22_reportLine("176", 1)
                m.onAsyncGroupComplete(group)
            end if
        end if
    end function
    ' @ignore
    RBS_CC_22_reportLine("181", 1)
    instance.onAsyncGroupComplete = function(group = invalid) as void
        RBS_CC_22_reportLine("182", 1)
        rooibos_common_logTrace("++ CURRENT GROUP COMPLETED")
        RBS_CC_22_reportLine("183", 1)
        group = (function(__bsCondition, group, m)
            if RBS_CC_22_reportLine("184", 2) and (__bsCondition) then
                RBS_CC_22_reportLine("184", 3)
                RBS_CC_22_reportLine("185", 1)
                return m.currentGroup
            else
                RBS_CC_22_reportLine("186", 3)
                RBS_CC_22_reportLine("187", 1)
                return group
            end if
        end function)(group = invalid, group, m)
        if RBS_CC_22_reportLine("190", 2) and (group = invalid)
            RBS_CC_22_reportLine("190", 3)
            RBS_CC_22_reportLine("191", 1)
            rooibos_common_logError("Cannot find test group to mark async finished for?!")
            RBS_CC_22_reportLine("192", 1)
            return
        end if
        'bs:disable-next-line
        RBS_CC_22_reportLine("195", 1)
        m.stats.merge(group.stats)
        if RBS_CC_22_reportLine("196", 2) and (m.stats.hasFailures and m.isFailingFast)
            RBS_CC_22_reportLine("196", 3)
            RBS_CC_22_reportLine("197", 1)
            rooibos_common_logTrace("Terminating group due to failed test")
            RBS_CC_22_reportLine("198", 1)
            m.isTestFailedDueToEarlyExit = true
            RBS_CC_22_reportLine("199", 1)
            m.testSuiteDone()
        else
            RBS_CC_22_reportLine("200", 3)
            RBS_CC_22_reportLine("201", 1)
            m.runNextAsync()
        end if
    end function
    ' calculate if the suite has timed out. Will return true if the suite flipped the timedOut flag
    ' @ignore
    RBS_CC_22_reportLine("206", 1)
    instance.isSuiteTimedOut = function()
        if RBS_CC_22_reportLine("207", 2) and (m.isNodeTest and m.asyncTimeout > 0 and m.currentExecutionTime >= m.asyncTimeout)
            RBS_CC_22_reportLine("207", 3)
            RBS_CC_22_reportLine("208", 1)
            m.timedOut = true
            RBS_CC_22_reportLine("209", 1)
            return true
        end if
        RBS_CC_22_reportLine("211", 1)
        return false
    end function
    ' @ignore
    RBS_CC_22_reportLine("214", 1)
    instance.runTest = function(test as object)
        RBS_CC_22_reportLine("215", 1)
        m.currentResult = test.result
        if RBS_CC_22_reportLine("216", 2) and (test.isIgnored)
            RBS_CC_22_reportLine("216", 3)
            RBS_CC_22_reportLine("217", 1)
            m.currentResult.skip("Test is ignored")
            RBS_CC_22_reportLine("218", 1)
            return invalid
        end if
        ' Fail the test if the suite has timed out.
        ' Currently, this will only happen if the suite is a node test.
        if RBS_CC_22_reportLine("222", 2) and (m.isNodeTest and m.timedOut)
            RBS_CC_22_reportLine("222", 3)
            RBS_CC_22_reportLine("223", 1)
            m.currentResult.fail("Suite test execution exceeded " + m.asyncTimeout.toStr() + "ms")
            RBS_CC_22_reportLine("224", 1)
            return invalid
        end if
        RBS_CC_22_reportLine("226", 1)
        m.currentAssertLineNumber = -1
        RBS_CC_22_reportLine("227", 1)
        m.currentResult.throwOnFailedAssertion = m.throwOnFailedAssertion
        if RBS_CC_22_reportLine("228", 2) and (m.catchCrashes and not test.noCatch and not m.noCatch)
            RBS_CC_22_reportLine("228", 3)
            try
                RBS_CC_22_reportLine("230", 1)
                test.run()
                if RBS_CC_22_reportLine("231", 2) and (m.isAutoAssertingMocks = true and test.deferred = invalid)
                    RBS_CC_22_reportLine("231", 3)
                    RBS_CC_22_reportLine("232", 1)
                    m.AssertMocks()
                    RBS_CC_22_reportLine("233", 1)
                    m.CleanMocks()
                    RBS_CC_22_reportLine("234", 1)
                    m.CleanStubs()
                end if
            catch error
                'bs:disable-next-line
                RBS_CC_22_reportLine("238", 1)
                m.currentResult.crash("test crashed!", error)
                if RBS_CC_22_reportLine("239", 2) and (rooibos_promises_isPromise(test.deferred))
                    RBS_CC_22_reportLine("239", 3)
                    RBS_CC_22_reportLine("240", 1)
                    rooibos_promises_reject(error, test.deferred)
                end if
            end try
        else
            RBS_CC_22_reportLine("243", 3)
            RBS_CC_22_reportLine("244", 1)
            test.run()
            if RBS_CC_22_reportLine("245", 2) and (m.isAutoAssertingMocks = true and test.deferred = invalid)
                RBS_CC_22_reportLine("245", 3)
                RBS_CC_22_reportLine("246", 1)
                m.AssertMocks()
                RBS_CC_22_reportLine("247", 1)
                m.CleanMocks()
                RBS_CC_22_reportLine("248", 1)
                m.CleanStubs()
            end if
        end if
        RBS_CC_22_reportLine("251", 1)
        return test.deferred
    end function
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    '++ Assertions
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ' Fail immediately, with the given message
    ' @param {Dynamic} [msg=""] - message to display in the test report
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("259", 1)
    instance.fail = function(msg = "Error" as string, actual = "" as string, expected = "" as string, createError = false as boolean) as dynamic
        if RBS_CC_22_reportLine("260", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("260", 3)
            if RBS_CC_22_reportLine("261", 2) and (m.throwOnFailedAssertion)
                RBS_CC_22_reportLine("261", 3)
                throw m.currentResult.getMessage()
            end if
            RBS_CC_22_reportLine("264", 1)
            return false
        end if
        RBS_CC_22_reportLine("266", 1)
        error = invalid
        if RBS_CC_22_reportLine("267", 2) and (createError)
            RBS_CC_22_reportLine("267", 3)
            try
                throw msg
            catch error
            end try
        end if
        RBS_CC_22_reportLine("273", 1)
        m.currentResult.fail(msg, m.currentAssertLineNumber, actual, expected, error)
        RBS_CC_22_reportLine("274", 1)
        return false
    end function
    ' Fail immediately, with the given message
    ' @ignore
    ' @param {Dynamic} [msg=""] - message to display in the test report
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("280", 1)
    instance.skip = function(msg = "Skipped" as string) as dynamic
        if RBS_CC_22_reportLine("281", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("281", 3)
            if RBS_CC_22_reportLine("282", 2) and (m.throwOnFailedAssertion)
                RBS_CC_22_reportLine("282", 3)
                throw m.currentResult.getMessage()
            end if
            RBS_CC_22_reportLine("285", 1)
            return false
        end if
        RBS_CC_22_reportLine("287", 1)
        m.currentResult.skip(msg)
        RBS_CC_22_reportLine("288", 1)
        return false
    end function
    ' Fail immediately, with the given exception
    ' @param {Dynamic} [error] - exception to fail on
    ' @param {Dynamic} [msg=""] - message to display in the test report
    ' @returns {boolean} - true if failure was set, false if the test is already failed
    RBS_CC_22_reportLine("294", 1)
    instance.failCrash = function(error as dynamic, msg = "" as string) as dynamic
        if RBS_CC_22_reportLine("295", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("295", 3)
            if RBS_CC_22_reportLine("296", 2) and (m.throwOnFailedAssertion)
                RBS_CC_22_reportLine("296", 3)
                throw m.currentResult.getMessage()
            end if
            RBS_CC_22_reportLine("299", 1)
            return false
        end if
        if RBS_CC_22_reportLine("301", 2) and (msg = "")
            RBS_CC_22_reportLine("301", 3)
            RBS_CC_22_reportLine("302", 1)
            msg = error.message
        end if
        RBS_CC_22_reportLine("304", 1)
        m.currentResult.fail(msg, m.currentAssertLineNumber)
        RBS_CC_22_reportLine("305", 1)
        m.currentResult.crash(msg, error)
        RBS_CC_22_reportLine("306", 1)
        return true
    end function
    RBS_CC_22_reportLine("308", 1)
    instance.failBecauseOfTimeOut = function() as dynamic
        if RBS_CC_22_reportLine("309", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("309", 3)
            RBS_CC_22_reportLine("310", 1)
            return false
        end if
        RBS_CC_22_reportLine("312", 1)
        m.currentResult.fail("Async test execution exceeded " + m.currentTimeout.toStr() + "ms")
        RBS_CC_22_reportLine("313", 1)
        m.done()
        RBS_CC_22_reportLine("314", 1)
        return false
    end function
    ' Fail the test if the expression is true.
    ' @param {Dynamic} expr - An expression to evaluate.
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("320", 1)
    instance.assertFalse = function(expr as dynamic, msg = "") as dynamic
        if RBS_CC_22_reportLine("321", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("321", 3)
            RBS_CC_22_reportLine("322", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("325", 2) and (not rooibos_common_isBoolean(expr) or expr)
                RBS_CC_22_reportLine("325", 3)
                RBS_CC_22_reportLine("326", 1)
                actual = rooibos_common_asMultilineString(expr, true)
                RBS_CC_22_reportLine("327", 1)
                expected = rooibos_common_asMultilineString(false, true)
                if RBS_CC_22_reportLine("328", 2) and (msg = "")
                    RBS_CC_22_reportLine("328", 3)
                    RBS_CC_22_reportLine("329", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be " + bslib_toString(rooibos_common_truncateString(expected)))
                end if
                RBS_CC_22_reportLine("331", 1)
                return m.fail(msg, actual, expected, true)
            end if
            RBS_CC_22_reportLine("333", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("336", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("338", 1)
        return false
    end function
    ' Fail the test unless the expression is true.
    ' @param {Dynamic} expr - An expression to evaluate.
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("344", 1)
    instance.assertTrue = function(expr, msg = "")
        if RBS_CC_22_reportLine("345", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("345", 3)
            RBS_CC_22_reportLine("346", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("349", 2) and (not rooibos_common_isBoolean(expr) or not expr)
                RBS_CC_22_reportLine("349", 3)
                RBS_CC_22_reportLine("350", 1)
                actual = rooibos_common_asMultilineString(expr, true)
                RBS_CC_22_reportLine("351", 1)
                expected = rooibos_common_asMultilineString(true, true)
                if RBS_CC_22_reportLine("352", 2) and (msg = "")
                    RBS_CC_22_reportLine("352", 3)
                    RBS_CC_22_reportLine("353", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be " + bslib_toString(rooibos_common_truncateString(expected)))
                end if
                RBS_CC_22_reportLine("355", 1)
                return m.fail(msg, actual, expected, true)
            end if
            RBS_CC_22_reportLine("357", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("360", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("362", 1)
        return false
    end function
    ' Fail if the two objects are unequal as determined by the '<>' operator.
    ' @param {Dynamic} first - first object to compare
    ' @param {Dynamic} second - second object to compare
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("369", 1)
    instance.assertEqual = function(first, second, msg = "") as dynamic
        if RBS_CC_22_reportLine("370", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("370", 3)
            RBS_CC_22_reportLine("371", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("374", 2) and (not rooibos_common_eqValues(first, second))
                RBS_CC_22_reportLine("374", 3)
                RBS_CC_22_reportLine("375", 1)
                actual = rooibos_common_asMultilineString(first, true)
                RBS_CC_22_reportLine("376", 1)
                expected = rooibos_common_asMultilineString(second, true)
                if RBS_CC_22_reportLine("377", 2) and (msg = "")
                    RBS_CC_22_reportLine("377", 3)
                    RBS_CC_22_reportLine("378", 1)
                    messageActual = rooibos_common_truncateString(actual)
                    RBS_CC_22_reportLine("379", 1)
                    messageExpected = rooibos_common_truncateString(expected)
                    RBS_CC_22_reportLine("380", 1)
                    msg = ("expected " + chr(34) + bslib_toString(messageActual) + chr(34) + " to equal " + chr(34) + bslib_toString(messageExpected) + chr(34))
                end if
                RBS_CC_22_reportLine("382", 1)
                m.fail(msg, actual, expected, true)
                RBS_CC_22_reportLine("383", 1)
                return false
            end if
            RBS_CC_22_reportLine("385", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("388", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("390", 1)
        return false
    end function
    ' does a fuzzy comparison
    ' @param {Dynamic} first - first object to compare
    ' @param {Dynamic} second - second object to compare
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("397", 1)
    instance.assertLike = function(first, second, msg = "") as dynamic
        if RBS_CC_22_reportLine("398", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("398", 3)
            RBS_CC_22_reportLine("399", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("402", 2) and (not rooibos_common_eqValues(first, second, true))
                RBS_CC_22_reportLine("402", 3)
                RBS_CC_22_reportLine("403", 1)
                actual = rooibos_common_asMultilineString(first, true)
                RBS_CC_22_reportLine("404", 1)
                expected = rooibos_common_asMultilineString(second, true)
                if RBS_CC_22_reportLine("405", 2) and (msg = "")
                    RBS_CC_22_reportLine("405", 3)
                    RBS_CC_22_reportLine("406", 1)
                    messageActual = rooibos_common_truncateString(actual)
                    RBS_CC_22_reportLine("407", 1)
                    messageExpected = rooibos_common_truncateString(expected)
                    RBS_CC_22_reportLine("408", 1)
                    msg = ("expected " + chr(34) + bslib_toString(messageActual) + chr(34) + " to be like " + chr(34) + bslib_toString(messageExpected) + chr(34))
                end if
                RBS_CC_22_reportLine("410", 1)
                m.fail(msg, actual, expected, true)
                RBS_CC_22_reportLine("411", 1)
                return false
            end if
            RBS_CC_22_reportLine("413", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("416", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("418", 1)
        return false
    end function
    ' Fail if the two objects are equal as determined by the '=' operator.
    ' @param {Dynamic} first - first object to compare
    ' @param {Dynamic} second - second object to compare
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("425", 1)
    instance.assertNotEqual = function(first, second, msg = "") as dynamic
        if RBS_CC_22_reportLine("426", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("426", 3)
            RBS_CC_22_reportLine("427", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("430", 2) and (rooibos_common_eqValues(first, second))
                RBS_CC_22_reportLine("430", 3)
                RBS_CC_22_reportLine("431", 1)
                actual = rooibos_common_asMultilineString(first, true)
                RBS_CC_22_reportLine("432", 1)
                expected = rooibos_common_asMultilineString(second, true)
                if RBS_CC_22_reportLine("433", 2) and (msg = "")
                    RBS_CC_22_reportLine("433", 3)
                    RBS_CC_22_reportLine("434", 1)
                    messageActual = rooibos_common_truncateString(actual)
                    RBS_CC_22_reportLine("435", 1)
                    messageExpected = rooibos_common_truncateString(expected)
                    RBS_CC_22_reportLine("436", 1)
                    msg = ("expected " + chr(34) + bslib_toString(messageActual) + chr(34) + " to not equal " + chr(34) + bslib_toString(messageExpected) + chr(34))
                end if
                RBS_CC_22_reportLine("438", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("439", 1)
                return false
            end if
            RBS_CC_22_reportLine("441", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("444", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("446", 1)
        return false
    end function
    ' Fail if the value is not invalid.
    ' @param {Dynamic} value - value to check - value to check for
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("452", 1)
    instance.assertInvalid = function(value, msg = "") as dynamic
        if RBS_CC_22_reportLine("453", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("453", 3)
            RBS_CC_22_reportLine("454", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("457", 2) and (rooibos_common_getSafeType(value) <> "Invalid")
                RBS_CC_22_reportLine("457", 3)
                if RBS_CC_22_reportLine("458", 2) and (msg = "")
                    RBS_CC_22_reportLine("458", 3)
                    RBS_CC_22_reportLine("459", 1)
                    actual = rooibos_common_asMultilineString(value, true)
                    RBS_CC_22_reportLine("460", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be invalid")
                end if
                RBS_CC_22_reportLine("462", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("463", 1)
                return false
            end if
            RBS_CC_22_reportLine("465", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("468", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("470", 1)
        return false
    end function
    ' Fail if the value is invalid.
    ' @param {Dynamic} value - value to check - value to check for
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("476", 1)
    instance.assertNotInvalid = function(value, msg = "") as dynamic
        if RBS_CC_22_reportLine("477", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("477", 3)
            RBS_CC_22_reportLine("478", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("481", 2) and (rooibos_common_getSafeType(value) = "Invalid")
                RBS_CC_22_reportLine("481", 3)
                if RBS_CC_22_reportLine("482", 2) and (msg = "")
                    RBS_CC_22_reportLine("482", 3)
                    RBS_CC_22_reportLine("483", 1)
                    actual = rooibos_common_asMultilineString(value, true)
                    RBS_CC_22_reportLine("484", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to not be invalid")
                end if
                RBS_CC_22_reportLine("486", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("487", 1)
                return false
            end if
            RBS_CC_22_reportLine("489", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("492", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("494", 1)
        return false
    end function
    ' Fail if the aa doesn't have the key.
    ' @param {Dynamic} aa - target aa
    ' @param {Dynamic} key - key name
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("501", 1)
    instance.assertAAHasKey = function(aa, key, msg = "") as dynamic
        if RBS_CC_22_reportLine("502", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("502", 3)
            RBS_CC_22_reportLine("503", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("506", 2) and (not rooibos_common_isAssociativeArray(aa))
                RBS_CC_22_reportLine("506", 3)
                if RBS_CC_22_reportLine("507", 2) and (msg = "")
                    RBS_CC_22_reportLine("507", 3)
                    RBS_CC_22_reportLine("508", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(aa, true))) + chr(34) + " to be an AssociativeArray")
                end if
                RBS_CC_22_reportLine("510", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("511", 1)
                return false
            end if
            if RBS_CC_22_reportLine("513", 2) and (not aa.ifAssociativeArray.DoesExist(key))
                RBS_CC_22_reportLine("513", 3)
                if RBS_CC_22_reportLine("514", 2) and (msg = "")
                    RBS_CC_22_reportLine("514", 3)
                    RBS_CC_22_reportLine("515", 1)
                    actual = rooibos_common_asMultilineString(aa, true)
                    RBS_CC_22_reportLine("516", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to have property " + chr(34) + bslib_toString(key) + chr(34))
                end if
                RBS_CC_22_reportLine("518", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("519", 1)
                return false
            end if
            RBS_CC_22_reportLine("521", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("524", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("526", 1)
        return false
    end function
    ' Fail if the aa has the key.
    ' @param {Dynamic} aa - target aa
    ' @param {Dynamic} key - key name
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("533", 1)
    instance.assertAANotHasKey = function(aa, key, msg = "") as dynamic
        if RBS_CC_22_reportLine("534", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("534", 3)
            RBS_CC_22_reportLine("535", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("538", 2) and (not rooibos_common_isAssociativeArray(aa))
                RBS_CC_22_reportLine("538", 3)
                if RBS_CC_22_reportLine("539", 2) and (msg = "")
                    RBS_CC_22_reportLine("539", 3)
                    RBS_CC_22_reportLine("540", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(aa, true))) + chr(34) + " to be an AssociativeArray")
                end if
                RBS_CC_22_reportLine("542", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("543", 1)
                return false
            end if
            if RBS_CC_22_reportLine("545", 2) and (aa.ifAssociativeArray.DoesExist(key))
                RBS_CC_22_reportLine("545", 3)
                if RBS_CC_22_reportLine("546", 2) and (msg = "")
                    RBS_CC_22_reportLine("546", 3)
                    RBS_CC_22_reportLine("547", 1)
                    actual = rooibos_common_asMultilineString(aa, true)
                    RBS_CC_22_reportLine("548", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to not have property " + chr(34) + bslib_toString(key) + chr(34))
                end if
                RBS_CC_22_reportLine("550", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("551", 1)
                return false
            end if
            RBS_CC_22_reportLine("553", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("556", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("558", 1)
        return false
    end function
    ' Fail if the aa doesn't have the keys list.
    ' @param {Dynamic} aa - A target associative array.
    ' @param {Dynamic} keys - Array of key names.
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("565", 1)
    instance.assertAAHasKeys = function(aa, keys, msg = "") as dynamic
        if RBS_CC_22_reportLine("566", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("566", 3)
            RBS_CC_22_reportLine("567", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("570", 2) and (not rooibos_common_isAssociativeArray(aa))
                RBS_CC_22_reportLine("570", 3)
                if RBS_CC_22_reportLine("571", 2) and (msg = "")
                    RBS_CC_22_reportLine("571", 3)
                    RBS_CC_22_reportLine("572", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(aa, true))) + chr(34) + " to be an AssociativeArray")
                end if
                RBS_CC_22_reportLine("574", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("575", 1)
                return false
            end if
            if RBS_CC_22_reportLine("577", 2) and (not rooibos_common_isArray(keys))
                RBS_CC_22_reportLine("577", 3)
                if RBS_CC_22_reportLine("578", 2) and (msg = "")
                    RBS_CC_22_reportLine("578", 3)
                    RBS_CC_22_reportLine("579", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(keys, true))) + chr(34) + " to be an Array")
                end if
                RBS_CC_22_reportLine("581", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("582", 1)
                return false
            end if
            RBS_CC_22_reportLine("584", 1)
            foundKeys = []
            RBS_CC_22_reportLine("585", 1)
            missingKeys = []
            RBS_CC_22_reportLine("586", 1): for each key in keys
                if RBS_CC_22_reportLine("587", 2) and (not aa.ifAssociativeArray.DoesExist(key))
                    RBS_CC_22_reportLine("587", 3)
                    RBS_CC_22_reportLine("588", 1)
                    missingKeys.push(key)
                else
                    RBS_CC_22_reportLine("589", 3)
                    RBS_CC_22_reportLine("590", 1)
                    foundKeys.push(key)
                end if
            end for
            if RBS_CC_22_reportLine("593", 2) and (missingKeys.count() > 0)
                RBS_CC_22_reportLine("593", 3)
                RBS_CC_22_reportLine("594", 1)
                actual = rooibos_common_asMultilineString(foundKeys, true)
                RBS_CC_22_reportLine("595", 1)
                expected = rooibos_common_asMultilineString(keys, true)
                if RBS_CC_22_reportLine("596", 2) and (msg = "")
                    RBS_CC_22_reportLine("596", 3)
                    RBS_CC_22_reportLine("597", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(aa, true))) + chr(34) + " to have properties " + bslib_toString(rooibos_common_truncateString(missingKeys.join(", "))))
                end if
                RBS_CC_22_reportLine("599", 1)
                m.fail(msg, actual, expected, true)
                RBS_CC_22_reportLine("600", 1)
                return false
            end if
            RBS_CC_22_reportLine("602", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("605", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("607", 1)
        return false
    end function
    ' Fail if the aa has the keys list.
    ' @param {Dynamic} aa - A target associative array.
    ' @param {Dynamic} keys - Array of key names.
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("614", 1)
    instance.assertAANotHasKeys = function(aa, keys, msg = "") as dynamic
        if RBS_CC_22_reportLine("615", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("615", 3)
            RBS_CC_22_reportLine("616", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("619", 2) and (not rooibos_common_isAssociativeArray(aa))
                RBS_CC_22_reportLine("619", 3)
                if RBS_CC_22_reportLine("620", 2) and (msg = "")
                    RBS_CC_22_reportLine("620", 3)
                    RBS_CC_22_reportLine("621", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(aa, true))) + chr(34) + " to be an AssociativeArray")
                end if
                RBS_CC_22_reportLine("623", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("624", 1)
                return false
            end if
            if RBS_CC_22_reportLine("626", 2) and (not rooibos_common_isArray(keys))
                RBS_CC_22_reportLine("626", 3)
                if RBS_CC_22_reportLine("627", 2) and (msg = "")
                    RBS_CC_22_reportLine("627", 3)
                    RBS_CC_22_reportLine("628", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(keys, true))) + chr(34) + " to be an Array")
                end if
                RBS_CC_22_reportLine("630", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("631", 1)
                return false
            end if
            RBS_CC_22_reportLine("633", 1)
            foundKeys = []
            RBS_CC_22_reportLine("634", 1): for each key in keys
                if RBS_CC_22_reportLine("635", 2) and (aa.ifAssociativeArray.DoesExist(key))
                    RBS_CC_22_reportLine("635", 3)
                    RBS_CC_22_reportLine("636", 1)
                    foundKeys.push(formatJson(key))
                end if
            end for
            if RBS_CC_22_reportLine("639", 2) and (foundKeys.count() > 0)
                RBS_CC_22_reportLine("639", 3)
                if RBS_CC_22_reportLine("640", 2) and (msg = "")
                    RBS_CC_22_reportLine("640", 3)
                    RBS_CC_22_reportLine("641", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(aa, true))) + chr(34) + " to not have properties " + bslib_toString(rooibos_common_truncateString(foundKeys.join(", "))))
                end if
                RBS_CC_22_reportLine("643", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("644", 1)
                return false
            end if
            RBS_CC_22_reportLine("646", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("649", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("651", 1)
        return false
    end function
    ' Fail if the array doesn't have the item.
    ' @param {Dynamic} array - target array
    ' @param {Dynamic} value - value to check - value to check for
    ' @param {Dynamic} key - key name in associative array
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("659", 1)
    instance.assertArrayContains = function(array, value, key = invalid, msg = "") as dynamic
        if RBS_CC_22_reportLine("660", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("660", 3)
            RBS_CC_22_reportLine("661", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("664", 2) and (not rooibos_common_isAssociativeArray(array) and not rooibos_common_isArray(array))
                RBS_CC_22_reportLine("664", 3)
                if RBS_CC_22_reportLine("665", 2) and (msg = "")
                    RBS_CC_22_reportLine("665", 3)
                    RBS_CC_22_reportLine("666", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to be an AssociativeArray or Array")
                end if
                RBS_CC_22_reportLine("668", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("669", 1)
                return false
            end if
            if RBS_CC_22_reportLine("671", 2) and (not rooibos_common_arrayContains(array, value, key))
                RBS_CC_22_reportLine("671", 3)
                if RBS_CC_22_reportLine("672", 2) and (msg = "")
                    RBS_CC_22_reportLine("672", 3)
                    RBS_CC_22_reportLine("673", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to contain " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(value, true))) + chr(34))
                end if
                RBS_CC_22_reportLine("675", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("676", 1)
                return false
            end if
            RBS_CC_22_reportLine("678", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("681", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("683", 1)
        return false
    end function
    ' Fail if the array does not contain all of the aa's in the values array.
    ' @param {Dynamic} array - target array
    ' @param {Dynamic} values - array of aas to look for in target array
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("690", 1)
    instance.assertArrayContainsAAs = function(array, values, msg = "") as dynamic
        if RBS_CC_22_reportLine("691", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("691", 3)
            RBS_CC_22_reportLine("692", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("695", 2) and (not rooibos_common_isArray(values))
                RBS_CC_22_reportLine("695", 3)
                if RBS_CC_22_reportLine("696", 2) and (msg = "")
                    RBS_CC_22_reportLine("696", 3)
                    RBS_CC_22_reportLine("697", 1)
                    msg = ("expected value " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(values, true))) + chr(34) + " must be an Array")
                end if
                RBS_CC_22_reportLine("699", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("700", 1)
                return false
            end if
            if RBS_CC_22_reportLine("702", 2) and (not rooibos_common_isArray(array))
                RBS_CC_22_reportLine("702", 3)
                if RBS_CC_22_reportLine("703", 2) and (msg = "")
                    RBS_CC_22_reportLine("703", 3)
                    RBS_CC_22_reportLine("704", 1)
                    msg = ("actual value " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " must be an Array")
                end if
                RBS_CC_22_reportLine("706", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("707", 1)
                return false
            end if
            RBS_CC_22_reportLine("709", 1): for each value in values
                RBS_CC_22_reportLine("710", 1)
                isMatched = false
                if RBS_CC_22_reportLine("711", 2) and (not rooibos_common_isAssociativeArray(value))
                    RBS_CC_22_reportLine("711", 3)
                    if RBS_CC_22_reportLine("712", 2) and (msg = "")
                        RBS_CC_22_reportLine("712", 3)
                        RBS_CC_22_reportLine("713", 1)
                        msg = ("expected search value " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(value, true))) + chr(34) + " to be an AssociativeArray")
                    end if
                    RBS_CC_22_reportLine("715", 1)
                    m.fail(msg, "", "", true)
                    RBS_CC_22_reportLine("716", 1)
                    return false
                end if
                RBS_CC_22_reportLine("718", 1): for each item in array
                    if RBS_CC_22_reportLine("719", 2) and (rooibos_common_IsAssociativeArray(item))
                        RBS_CC_22_reportLine("719", 3)
                        RBS_CC_22_reportLine("720", 1)
                        isValueMatched = true
                        RBS_CC_22_reportLine("721", 1): for each key in value
                            RBS_CC_22_reportLine("722", 1)
                            fieldValue = value[key]
                            RBS_CC_22_reportLine("723", 1)
                            itemValue = item[key]
                            if RBS_CC_22_reportLine("724", 2) and (not rooibos_common_eqValues(fieldValue, itemValue))
                                RBS_CC_22_reportLine("724", 3)
                                RBS_CC_22_reportLine("725", 1)
                                isValueMatched = false
                                exit for
                            end if
                        end for
                        if RBS_CC_22_reportLine("729", 2) and (isValueMatched)
                            RBS_CC_22_reportLine("729", 3)
                            RBS_CC_22_reportLine("730", 1)
                            isMatched = true
                            exit for
                        end if
                    end if
                end for ' items in array
                if RBS_CC_22_reportLine("735", 2) and (not isMatched)
                    RBS_CC_22_reportLine("735", 3)
                    if RBS_CC_22_reportLine("736", 2) and (msg = "")
                        RBS_CC_22_reportLine("736", 3)
                        RBS_CC_22_reportLine("737", 1)
                        msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to contain " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(value, true))) + chr(34))
                    end if
                    RBS_CC_22_reportLine("739", 1)
                    m.fail(msg, "", "", true)
                    RBS_CC_22_reportLine("740", 1)
                    return false
                end if
            end for 'values to match
            RBS_CC_22_reportLine("743", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("746", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("748", 1)
        return false
    end function
    ' Fail if the array has the item.
    ' @param {Dynamic} array - target array
    ' @param {Dynamic} array - target array
    ' @param {Dynamic} value - value to check - Value to check for
    ' @param {Dynamic} key - A key name for associative array.
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("757", 1)
    instance.assertArrayNotContains = function(array, value, key = invalid, msg = "") as dynamic
        if RBS_CC_22_reportLine("758", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("758", 3)
            RBS_CC_22_reportLine("759", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("762", 2) and (not rooibos_common_isAssociativeArray(array) and not rooibos_common_isArray(array))
                RBS_CC_22_reportLine("762", 3)
                if RBS_CC_22_reportLine("763", 2) and (msg = "")
                    RBS_CC_22_reportLine("763", 3)
                    RBS_CC_22_reportLine("764", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to be an AssociativeArray or Array")
                end if
                RBS_CC_22_reportLine("766", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("767", 1)
                return false
            end if
            if RBS_CC_22_reportLine("769", 2) and (rooibos_common_arrayContains(array, value, key))
                RBS_CC_22_reportLine("769", 3)
                if RBS_CC_22_reportLine("770", 2) and (msg = "")
                    RBS_CC_22_reportLine("770", 3)
                    RBS_CC_22_reportLine("771", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to not contain " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(value, true))) + chr(34))
                end if
                RBS_CC_22_reportLine("773", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("774", 1)
                return false
            end if
            RBS_CC_22_reportLine("776", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("779", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("781", 1)
        return false
    end function
    ' Fail if the array doesn't have the item subset.
    ' @param {Dynamic} array - target array
    ' @param {Dynamic} subset - items to check presence of
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("788", 1)
    instance.assertArrayContainsSubset = function(array, subset, msg = "") as dynamic
        if RBS_CC_22_reportLine("789", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("789", 3)
            RBS_CC_22_reportLine("790", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("793", 2) and (not rooibos_common_isAssociativeArray(array) and not rooibos_common_isArray(array))
                RBS_CC_22_reportLine("793", 3)
                if RBS_CC_22_reportLine("794", 2) and (msg = "")
                    RBS_CC_22_reportLine("794", 3)
                    RBS_CC_22_reportLine("795", 1)
                    msg = ("expected target " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to be an AssociativeArray or Array")
                end if
                RBS_CC_22_reportLine("797", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("798", 1)
                return false
            end if
            if RBS_CC_22_reportLine("800", 2) and (not rooibos_common_isAssociativeArray(subset) and not rooibos_common_isArray(subset))
                RBS_CC_22_reportLine("800", 3)
                if RBS_CC_22_reportLine("801", 2) and (msg = "")
                    RBS_CC_22_reportLine("801", 3)
                    RBS_CC_22_reportLine("802", 1)
                    msg = ("expected subset " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(subset, true))) + chr(34) + " to be an AssociativeArray or Array")
                end if
                RBS_CC_22_reportLine("804", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("805", 1)
                return false
            end if
            if RBS_CC_22_reportLine("807", 2) and (rooibos_common_isAssociativeArray(array) and not rooibos_common_isAssociativeArray(subset))
                RBS_CC_22_reportLine("807", 3)
                if RBS_CC_22_reportLine("808", 2) and (msg = "")
                    RBS_CC_22_reportLine("808", 3)
                    RBS_CC_22_reportLine("809", 1)
                    msg = ("expected subset " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(subset, true))) + chr(34) + " to be an AssociativeArray to match type " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34))
                end if
                RBS_CC_22_reportLine("811", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("812", 1)
                return false
            end if
            if RBS_CC_22_reportLine("814", 2) and (rooibos_common_isArray(array) and not rooibos_common_isArray(subset))
                RBS_CC_22_reportLine("814", 3)
                if RBS_CC_22_reportLine("815", 2) and (msg = "")
                    RBS_CC_22_reportLine("815", 3)
                    RBS_CC_22_reportLine("816", 1)
                    msg = ("expected subset " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(subset, true))) + chr(34) + " to be an Array to match type " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34))
                end if
                RBS_CC_22_reportLine("818", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("819", 1)
                return false
            end if
            RBS_CC_22_reportLine("821", 1)
            isAA = rooibos_common_isAssociativeArray(subset)
            RBS_CC_22_reportLine("822", 1): for each item in subset
                RBS_CC_22_reportLine("823", 1)
                key = invalid
                RBS_CC_22_reportLine("824", 1)
                value = item
                if RBS_CC_22_reportLine("825", 2) and (isAA)
                    RBS_CC_22_reportLine("825", 3)
                    RBS_CC_22_reportLine("826", 1)
                    key = item
                    RBS_CC_22_reportLine("827", 1)
                    value = subset[key]
                end if
                if RBS_CC_22_reportLine("829", 2) and (not rooibos_common_arrayContains(array, value, key))
                    RBS_CC_22_reportLine("829", 3)
                    if RBS_CC_22_reportLine("830", 2) and (msg = "")
                        RBS_CC_22_reportLine("830", 3)
                        if RBS_CC_22_reportLine("831", 2) and (isAA)
                            RBS_CC_22_reportLine("831", 3)
                            RBS_CC_22_reportLine("832", 1)
                            msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to contain property " + chr(34) + bslib_toString(rooibos_common_truncateString(key)) + chr(34) + " with value " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(value, true))) + chr(34))
                        else
                            RBS_CC_22_reportLine("833", 3)
                            RBS_CC_22_reportLine("834", 1)
                            msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to contain " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(value, true))) + chr(34))
                        end if
                    end if
                    RBS_CC_22_reportLine("837", 1)
                    m.fail(msg, "", "", true)
                    RBS_CC_22_reportLine("838", 1)
                    return false
                end if
            end for
            RBS_CC_22_reportLine("841", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("844", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("846", 1)
        return false
    end function
    ' Fail if the array have the item from subset.
    ' @param {Dynamic} array - target array
    ' @param {Dynamic} subset - items to check presence of
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("853", 1)
    instance.assertArrayNotContainsSubset = function(array, subset, msg = "") as dynamic
        if RBS_CC_22_reportLine("854", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("854", 3)
            RBS_CC_22_reportLine("855", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("858", 2) and (not rooibos_common_isAssociativeArray(array) and not rooibos_common_isArray(array))
                RBS_CC_22_reportLine("858", 3)
                if RBS_CC_22_reportLine("859", 2) and (msg = "")
                    RBS_CC_22_reportLine("859", 3)
                    RBS_CC_22_reportLine("860", 1)
                    msg = ("expected target " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to be an AssociativeArray or Array")
                end if
                RBS_CC_22_reportLine("862", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("863", 1)
                return false
            end if
            if RBS_CC_22_reportLine("865", 2) and (not rooibos_common_isAssociativeArray(subset) and not rooibos_common_isArray(subset))
                RBS_CC_22_reportLine("865", 3)
                if RBS_CC_22_reportLine("866", 2) and (msg = "")
                    RBS_CC_22_reportLine("866", 3)
                    RBS_CC_22_reportLine("867", 1)
                    msg = ("expected subset " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(subset, true))) + chr(34) + " to be an AssociativeArray or Array")
                end if
                RBS_CC_22_reportLine("869", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("870", 1)
                return false
            end if
            if RBS_CC_22_reportLine("872", 2) and (rooibos_common_isAssociativeArray(array) and not rooibos_common_isAssociativeArray(subset))
                RBS_CC_22_reportLine("872", 3)
                if RBS_CC_22_reportLine("873", 2) and (msg = "")
                    RBS_CC_22_reportLine("873", 3)
                    RBS_CC_22_reportLine("874", 1)
                    msg = ("expected subset " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(subset, true))) + chr(34) + " to be an AssociativeArray to match type " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34))
                end if
                RBS_CC_22_reportLine("876", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("877", 1)
                return false
            end if
            if RBS_CC_22_reportLine("879", 2) and (rooibos_common_isArray(array) and not rooibos_common_isArray(subset))
                RBS_CC_22_reportLine("879", 3)
                if RBS_CC_22_reportLine("880", 2) and (msg = "")
                    RBS_CC_22_reportLine("880", 3)
                    RBS_CC_22_reportLine("881", 1)
                    msg = ("expected subset " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(subset, true))) + chr(34) + " to be an Array to match type " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34))
                end if
                RBS_CC_22_reportLine("883", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("884", 1)
                return false
            end if
            RBS_CC_22_reportLine("886", 1)
            isAA = rooibos_common_isAssociativeArray(subset)
            RBS_CC_22_reportLine("887", 1): for each item in subset
                RBS_CC_22_reportLine("888", 1)
                key = invalid
                RBS_CC_22_reportLine("889", 1)
                value = item
                if RBS_CC_22_reportLine("890", 2) and (isAA)
                    RBS_CC_22_reportLine("890", 3)
                    RBS_CC_22_reportLine("891", 1)
                    key = item
                    RBS_CC_22_reportLine("892", 1)
                    value = subset[key]
                end if
                if RBS_CC_22_reportLine("894", 2) and (rooibos_common_arrayContains(array, value, key))
                    RBS_CC_22_reportLine("894", 3)
                    if RBS_CC_22_reportLine("895", 2) and (msg = "")
                        RBS_CC_22_reportLine("895", 3)
                        if RBS_CC_22_reportLine("896", 2) and (isAA)
                            RBS_CC_22_reportLine("896", 3)
                            RBS_CC_22_reportLine("897", 1)
                            msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to not contain property " + chr(34) + bslib_toString(rooibos_common_truncateString(key)) + chr(34) + " with value " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(value, true))) + chr(34))
                        else
                            RBS_CC_22_reportLine("898", 3)
                            RBS_CC_22_reportLine("899", 1)
                            msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to not contain " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(value, true))) + chr(34))
                        end if
                    end if
                    RBS_CC_22_reportLine("902", 1)
                    m.fail(msg, "", "", true)
                    RBS_CC_22_reportLine("903", 1)
                    return false
                end if
            end for
            RBS_CC_22_reportLine("906", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("909", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("911", 1)
        return false
    end function
    ' Fail if the array items count <> expected count
    ' @param {Dynamic} array - target array
    ' @param {Dynamic} count - An expected array items count
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("918", 1)
    instance.assertArrayCount = function(array, count, msg = "") as dynamic
        if RBS_CC_22_reportLine("919", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("919", 3)
            RBS_CC_22_reportLine("920", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("923", 2) and (not rooibos_common_isAssociativeArray(array) and not rooibos_common_isArray(array))
                RBS_CC_22_reportLine("923", 3)
                if RBS_CC_22_reportLine("924", 2) and (msg = "")
                    RBS_CC_22_reportLine("924", 3)
                    RBS_CC_22_reportLine("925", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to be an AssociativeArray or Array")
                end if
                RBS_CC_22_reportLine("927", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("928", 1)
                return false
            end if
            if RBS_CC_22_reportLine("930", 2) and (not rooibos_common_isNumber(count))
                RBS_CC_22_reportLine("930", 3)
                if RBS_CC_22_reportLine("931", 2) and (msg = "")
                    RBS_CC_22_reportLine("931", 3)
                    RBS_CC_22_reportLine("932", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(count, true))) + chr(34) + " to be an Number")
                end if
                RBS_CC_22_reportLine("934", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("935", 1)
                return false
            end if
            if RBS_CC_22_reportLine("937", 2) and (rooibos_common_isAssociativeArray(array))
                RBS_CC_22_reportLine("937", 3)
                RBS_CC_22_reportLine("938", 1)
                actualCount = array.ifAssociativeArray.count()
            else
                RBS_CC_22_reportLine("939", 3)
                RBS_CC_22_reportLine("940", 1)
                actualCount = array.count()
            end if
            if RBS_CC_22_reportLine("942", 2) and (actualCount <> count)
                RBS_CC_22_reportLine("942", 3)
                if RBS_CC_22_reportLine("943", 2) and (msg = "")
                    RBS_CC_22_reportLine("943", 3)
                    RBS_CC_22_reportLine("944", 1)
                    msg = ("expected count " + chr(34) + bslib_toString(actualCount) + chr(34) + " to be " + chr(34) + bslib_toString(count) + chr(34))
                end if
                RBS_CC_22_reportLine("946", 1)
                m.fail(msg, rooibos_common_asMultilineString(actualCount, true), rooibos_common_asMultilineString(count, true), true)
                RBS_CC_22_reportLine("947", 1)
                return false
            end if
            RBS_CC_22_reportLine("949", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("952", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("954", 1)
        return false
    end function
    ' Fail if the array items count = expected count.
    ' @param {Dynamic} array - target array
    ' @param {Dynamic} count - An expected array items count.
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("961", 1)
    instance.assertArrayNotCount = function(array, count, msg = "") as dynamic
        if RBS_CC_22_reportLine("962", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("962", 3)
            RBS_CC_22_reportLine("963", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("966", 2) and (not rooibos_common_isAssociativeArray(array) and not rooibos_common_isArray(array))
                RBS_CC_22_reportLine("966", 3)
                if RBS_CC_22_reportLine("967", 2) and (msg = "")
                    RBS_CC_22_reportLine("967", 3)
                    RBS_CC_22_reportLine("968", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to be an AssociativeArray or Array")
                end if
                RBS_CC_22_reportLine("970", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("971", 1)
                return false
            end if
            if RBS_CC_22_reportLine("973", 2) and (not rooibos_common_isNumber(count))
                RBS_CC_22_reportLine("973", 3)
                if RBS_CC_22_reportLine("974", 2) and (msg = "")
                    RBS_CC_22_reportLine("974", 3)
                    RBS_CC_22_reportLine("975", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(count, true))) + chr(34) + " to be an Number")
                end if
                RBS_CC_22_reportLine("977", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("978", 1)
                return false
            end if
            if RBS_CC_22_reportLine("980", 2) and (rooibos_common_isAssociativeArray(array))
                RBS_CC_22_reportLine("980", 3)
                RBS_CC_22_reportLine("981", 1)
                actualCount = array.ifAssociativeArray.count()
            else
                RBS_CC_22_reportLine("982", 3)
                RBS_CC_22_reportLine("983", 1)
                actualCount = array.count()
            end if
            if RBS_CC_22_reportLine("985", 2) and (actualCount = count)
                RBS_CC_22_reportLine("985", 3)
                if RBS_CC_22_reportLine("986", 2) and (msg = "")
                    RBS_CC_22_reportLine("986", 3)
                    RBS_CC_22_reportLine("987", 1)
                    msg = ("expected count " + chr(34) + bslib_toString(actualCount) + chr(34) + " to not be " + chr(34) + bslib_toString(count) + chr(34))
                end if
                RBS_CC_22_reportLine("989", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("990", 1)
                return false
            end if
            RBS_CC_22_reportLine("992", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("995", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("997", 1)
        return false
    end function
    ' Fail if the item is not empty array or string.
    ' @param {Dynamic} item - item to check
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("1003", 1)
    instance.assertEmpty = function(item, msg = "") as dynamic
        if RBS_CC_22_reportLine("1004", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("1004", 3)
            RBS_CC_22_reportLine("1005", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("1008", 2) and (rooibos_common_isAssociativeArray(item))
                RBS_CC_22_reportLine("1008", 3)
                if RBS_CC_22_reportLine("1009", 2) and (not item.isEmpty())
                    RBS_CC_22_reportLine("1009", 3)
                    RBS_CC_22_reportLine("1010", 1)
                    actual = rooibos_common_asMultilineString(item, true)
                    if RBS_CC_22_reportLine("1011", 2) and (msg = "")
                        RBS_CC_22_reportLine("1011", 3)
                        RBS_CC_22_reportLine("1012", 1)
                        msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be empty")
                    end if
                    RBS_CC_22_reportLine("1014", 1)
                    m.fail(msg, actual, rooibos_common_asMultilineString({}, true), true)
                    RBS_CC_22_reportLine("1015", 1)
                    return false
                end if
            else if RBS_CC_22_reportLine("1017", 2) and (rooibos_common_isArray(item))
                RBS_CC_22_reportLine("1017", 3)
                if RBS_CC_22_reportLine("1018", 2) and (not item.isEmpty())
                    RBS_CC_22_reportLine("1018", 3)
                    RBS_CC_22_reportLine("1019", 1)
                    actual = rooibos_common_asMultilineString(item, true)
                    if RBS_CC_22_reportLine("1020", 2) and (msg = "")
                        RBS_CC_22_reportLine("1020", 3)
                        RBS_CC_22_reportLine("1021", 1)
                        msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be empty")
                    end if
                    RBS_CC_22_reportLine("1023", 1)
                    m.fail(msg, actual, rooibos_common_asMultilineString([], true), true)
                    RBS_CC_22_reportLine("1024", 1)
                    return false
                end if
            else if RBS_CC_22_reportLine("1026", 2) and (rooibos_common_isString(item))
                RBS_CC_22_reportLine("1026", 3)
                if RBS_CC_22_reportLine("1027", 2) and (not item.isEmpty())
                    RBS_CC_22_reportLine("1027", 3)
                    RBS_CC_22_reportLine("1028", 1)
                    actual = rooibos_common_asMultilineString(item, true)
                    if RBS_CC_22_reportLine("1029", 2) and (msg = "")
                        RBS_CC_22_reportLine("1029", 3)
                        RBS_CC_22_reportLine("1030", 1)
                        msg = ("expected " + bslib_toString(rooibos_common_truncateString(actual)) + " to be empty")
                    end if
                    RBS_CC_22_reportLine("1032", 1)
                    m.fail(msg, actual, "", true)
                    RBS_CC_22_reportLine("1033", 1)
                    return false
                end if
            else
                RBS_CC_22_reportLine("1035", 3)
                if RBS_CC_22_reportLine("1036", 2) and (msg = "")
                    RBS_CC_22_reportLine("1036", 3)
                    RBS_CC_22_reportLine("1037", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(item, true))) + chr(34) + " to be an AssociativeArray, Array, or String")
                end if
                RBS_CC_22_reportLine("1039", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("1040", 1)
                return false
            end if
            RBS_CC_22_reportLine("1042", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("1045", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("1047", 1)
        return false
    end function
    ' Fail if the item is empty array or string.
    ' @param {Dynamic} item - item to check
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("1053", 1)
    instance.assertNotEmpty = function(item, msg = "") as dynamic
        if RBS_CC_22_reportLine("1054", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("1054", 3)
            RBS_CC_22_reportLine("1055", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("1058", 2) and (rooibos_common_isAssociativeArray(item))
                RBS_CC_22_reportLine("1058", 3)
                if RBS_CC_22_reportLine("1059", 2) and (item.isEmpty())
                    RBS_CC_22_reportLine("1059", 3)
                    if RBS_CC_22_reportLine("1060", 2) and (msg = "")
                        RBS_CC_22_reportLine("1060", 3)
                        RBS_CC_22_reportLine("1061", 1)
                        actual = rooibos_common_asMultilineString(item, true)
                        RBS_CC_22_reportLine("1062", 1)
                        msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to not be empty")
                    end if
                    RBS_CC_22_reportLine("1064", 1)
                    m.fail(msg, "", "", true)
                    RBS_CC_22_reportLine("1065", 1)
                    return false
                end if
            else if RBS_CC_22_reportLine("1067", 2) and (rooibos_common_isArray(item))
                RBS_CC_22_reportLine("1067", 3)
                if RBS_CC_22_reportLine("1068", 2) and (item.isEmpty())
                    RBS_CC_22_reportLine("1068", 3)
                    if RBS_CC_22_reportLine("1069", 2) and (msg = "")
                        RBS_CC_22_reportLine("1069", 3)
                        RBS_CC_22_reportLine("1070", 1)
                        actual = rooibos_common_asMultilineString(item, true)
                        RBS_CC_22_reportLine("1071", 1)
                        msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to not be empty")
                    end if
                    RBS_CC_22_reportLine("1073", 1)
                    m.fail(msg, "", "", true)
                    RBS_CC_22_reportLine("1074", 1)
                    return false
                end if
            else if RBS_CC_22_reportLine("1076", 2) and (rooibos_common_isString(item))
                RBS_CC_22_reportLine("1076", 3)
                if RBS_CC_22_reportLine("1077", 2) and (item.isEmpty())
                    RBS_CC_22_reportLine("1077", 3)
                    if RBS_CC_22_reportLine("1078", 2) and (msg = "")
                        RBS_CC_22_reportLine("1078", 3)
                        RBS_CC_22_reportLine("1079", 1)
                        actual = rooibos_common_asMultilineString(item, true)
                        RBS_CC_22_reportLine("1080", 1)
                        msg = ("expected " + bslib_toString(rooibos_common_truncateString(actual)) + " to be empty")
                    end if
                    RBS_CC_22_reportLine("1082", 1)
                    m.fail(msg, "", "", true)
                    RBS_CC_22_reportLine("1083", 1)
                    return false
                end if
            else
                RBS_CC_22_reportLine("1085", 3)
                if RBS_CC_22_reportLine("1086", 2) and (msg = "")
                    RBS_CC_22_reportLine("1086", 3)
                    RBS_CC_22_reportLine("1087", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(item, true))) + chr(34) + " to be an AssociativeArray, Array, or String")
                end if
                RBS_CC_22_reportLine("1089", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("1090", 1)
                return false
            end if
            RBS_CC_22_reportLine("1092", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("1095", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("1097", 1)
        return false
    end function
    ' Fail if the array doesn't contains items of specific type only.
    ' @param {Dynamic} array - target array
    ' @param {Dynamic} typeStr - type name - must be String, Array, Boolean, or AssociativeArray
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("1104", 1)
    instance.assertArrayContainsOnlyValuesOfType = function(array, typeStr, msg = "") as dynamic
        if RBS_CC_22_reportLine("1105", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("1105", 3)
            RBS_CC_22_reportLine("1106", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("1109", 2) and (typeStr <> "String" and typeStr <> "Integer" and typeStr <> "Boolean" and typeStr <> "Array" and typeStr <> "AssociativeArray")
                RBS_CC_22_reportLine("1109", 3)
                if RBS_CC_22_reportLine("1110", 2) and (msg = "")
                    RBS_CC_22_reportLine("1110", 3)
                    RBS_CC_22_reportLine("1111", 1)
                    msg = ("expect type " + bslib_toString(rooibos_common_asMultilineString(typeStr, true)) + " to be " + chr(34) + "Boolean" + chr(34) + ", " + chr(34) + "String" + chr(34) + ", " + chr(34) + "Integer" + chr(34) + ", " + chr(34) + "Array" + chr(34) + ", or " + chr(34) + "AssociativeArray" + chr(34))
                end if
                RBS_CC_22_reportLine("1113", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("1114", 1)
                return false
            end if
            if RBS_CC_22_reportLine("1116", 2) and (not rooibos_common_isAssociativeArray(array) and not rooibos_common_isArray(array))
                RBS_CC_22_reportLine("1116", 3)
                if RBS_CC_22_reportLine("1117", 2) and (msg = "")
                    RBS_CC_22_reportLine("1117", 3)
                    RBS_CC_22_reportLine("1118", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to be an AssociativeArray or Array")
                end if
                RBS_CC_22_reportLine("1120", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("1121", 1)
                return false
            end if
            RBS_CC_22_reportLine("1123", 1)
            isAA = rooibos_common_isAssociativeArray(array)
            RBS_CC_22_reportLine("1124", 1)
            methodName = "Rooibos_Common_Is" + typeStr
            RBS_CC_22_reportLine("1125", 1)
            typeCheckFunction = m.getIsTypeFunction(methodName)
            if RBS_CC_22_reportLine("1126", 2) and (typeCheckFunction <> invalid)
                RBS_CC_22_reportLine("1126", 3)
                RBS_CC_22_reportLine("1127", 1): for each item in array
                    RBS_CC_22_reportLine("1128", 1)
                    key = invalid
                    if RBS_CC_22_reportLine("1129", 2) and (isAA)
                        RBS_CC_22_reportLine("1129", 3)
                        RBS_CC_22_reportLine("1130", 1)
                        key = item
                        RBS_CC_22_reportLine("1131", 1)
                        item = array[key]
                    end if
                    if RBS_CC_22_reportLine("1133", 2) and (not typeCheckFunction(item))
                        RBS_CC_22_reportLine("1133", 3)
                        if RBS_CC_22_reportLine("1134", 2) and (msg = "")
                            RBS_CC_22_reportLine("1134", 3)
                            if RBS_CC_22_reportLine("1135", 2) and (isAA)
                                RBS_CC_22_reportLine("1135", 3)
                                RBS_CC_22_reportLine("1136", 1)
                                msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(key)) + ": " + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(item, true))) + chr(34) + " to be type " + bslib_toString(rooibos_common_asMultilineString(typeStr, true)))
                            else
                                RBS_CC_22_reportLine("1137", 3)
                                RBS_CC_22_reportLine("1138", 1)
                                msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(item, true))) + chr(34) + " to be type " + bslib_toString(rooibos_common_asMultilineString(typeStr, true)))
                            end if
                        end if
                        RBS_CC_22_reportLine("1141", 1)
                        m.fail(msg, "", "", true)
                        RBS_CC_22_reportLine("1142", 1)
                        return false
                    end if
                end for
            else
                RBS_CC_22_reportLine("1145", 3)
                ' I think we can remove this check, as we are already checking for valid types?
                ' Will revisit this later.
                throw ("could not find comparator for type " + bslib_toString(rooibos_common_asMultilineString(typeStr, true)))
            end if
            RBS_CC_22_reportLine("1150", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("1153", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("1155", 1)
        return false
    end function
    ' @ignore
    RBS_CC_22_reportLine("1158", 1)
    instance.getIsTypeFunction = function(name)
        if RBS_CC_22_reportLine("1159", 2) and (name = "Rooibos_Common_IsFunction")
            RBS_CC_22_reportLine("1159", 3)
            RBS_CC_22_reportLine("1160", 1)
            return rooibos_common_isFunction
        else if RBS_CC_22_reportLine("1161", 2) and (name = "Rooibos_Common_IsXmlElement")
            RBS_CC_22_reportLine("1161", 3)
            RBS_CC_22_reportLine("1162", 1)
            return rooibos_common_isXmlElement
        else if RBS_CC_22_reportLine("1163", 2) and (name = "Rooibos_Common_IsInteger")
            RBS_CC_22_reportLine("1163", 3)
            RBS_CC_22_reportLine("1164", 1)
            return rooibos_common_isInteger
        else if RBS_CC_22_reportLine("1165", 2) and (name = "Rooibos_Common_IsBoolean")
            RBS_CC_22_reportLine("1165", 3)
            RBS_CC_22_reportLine("1166", 1)
            return rooibos_common_isBoolean
        else if RBS_CC_22_reportLine("1167", 2) and (name = "Rooibos_Common_IsFloat")
            RBS_CC_22_reportLine("1167", 3)
            RBS_CC_22_reportLine("1168", 1)
            return rooibos_common_isFloat
        else if RBS_CC_22_reportLine("1169", 2) and (name = "Rooibos_Common_IsDouble")
            RBS_CC_22_reportLine("1169", 3)
            RBS_CC_22_reportLine("1170", 1)
            return rooibos_common_isDouble
        else if RBS_CC_22_reportLine("1171", 2) and (name = "Rooibos_Common_IsLongInteger")
            RBS_CC_22_reportLine("1171", 3)
            RBS_CC_22_reportLine("1172", 1)
            return rooibos_common_isLongInteger
        else if RBS_CC_22_reportLine("1173", 2) and (name = "Rooibos_Common_IsNumber")
            RBS_CC_22_reportLine("1173", 3)
            RBS_CC_22_reportLine("1174", 1)
            return rooibos_common_isNumber
        else if RBS_CC_22_reportLine("1175", 2) and (name = "Rooibos_Common_IsList")
            RBS_CC_22_reportLine("1175", 3)
            RBS_CC_22_reportLine("1176", 1)
            return rooibos_common_isList
        else if RBS_CC_22_reportLine("1177", 2) and (name = "Rooibos_Common_IsArray")
            RBS_CC_22_reportLine("1177", 3)
            RBS_CC_22_reportLine("1178", 1)
            return rooibos_common_isArray
        else if RBS_CC_22_reportLine("1179", 2) and (name = "Rooibos_Common_IsAssociativeArray")
            RBS_CC_22_reportLine("1179", 3)
            RBS_CC_22_reportLine("1180", 1)
            return rooibos_common_isAssociativeArray
        else if RBS_CC_22_reportLine("1181", 2) and (name = "Rooibos_Common_IsSGNode")
            RBS_CC_22_reportLine("1181", 3)
            RBS_CC_22_reportLine("1182", 1)
            return rooibos_common_isSGNode
        else if RBS_CC_22_reportLine("1183", 2) and (name = "Rooibos_Common_IsString")
            RBS_CC_22_reportLine("1183", 3)
            RBS_CC_22_reportLine("1184", 1)
            return rooibos_common_isString
        else if RBS_CC_22_reportLine("1185", 2) and (name = "Rooibos_Common_IsDateTime")
            RBS_CC_22_reportLine("1185", 3)
            RBS_CC_22_reportLine("1186", 1)
            return rooibos_common_isDateTime
        else if RBS_CC_22_reportLine("1187", 2) and (name = "Rooibos_Common_IsUndefined")
            RBS_CC_22_reportLine("1187", 3)
            RBS_CC_22_reportLine("1188", 1)
            return rooibos_common_isUndefined
        else
            RBS_CC_22_reportLine("1189", 3)
            RBS_CC_22_reportLine("1190", 1)
            return invalid
        end if
    end function
    ' Asserts that the value is a node of designated type
    ' @param {Dynamic} value - value to check - target node
    ' @param {Dynamic} typeStr - type name
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("1198", 1)
    instance.assertType = function(value, typeStr, msg = "") as dynamic
        if RBS_CC_22_reportLine("1199", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("1199", 3)
            RBS_CC_22_reportLine("1200", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("1203", 2) and (type(value) <> typeStr)
                RBS_CC_22_reportLine("1203", 3)
                RBS_CC_22_reportLine("1204", 1)
                actual = rooibos_common_asMultilineString(type(value), true)
                RBS_CC_22_reportLine("1205", 1)
                expected = rooibos_common_asMultilineString(typeStr, true)
                if RBS_CC_22_reportLine("1206", 2) and (msg = "")
                    RBS_CC_22_reportLine("1206", 3)
                    RBS_CC_22_reportLine("1207", 1)
                    msg = ("expected " + bslib_toString(rooibos_common_truncateString(actual)) + " to be type " + bslib_toString(rooibos_common_truncateString(expected)))
                end if
                RBS_CC_22_reportLine("1209", 1)
                m.fail(msg, actual, expected, true)
                RBS_CC_22_reportLine("1210", 1)
                return false
            end if
            RBS_CC_22_reportLine("1212", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("1215", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("1217", 1)
        return false
    end function
    ' Asserts that the value is a node of designated subtype
    ' @param {Dynamic} value - value to check - target node
    ' @param {Dynamic} typeStr - type name
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("1224", 1)
    instance.assertSubType = function(value, typeStr, msg = "") as dynamic
        if RBS_CC_22_reportLine("1225", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("1225", 3)
            RBS_CC_22_reportLine("1226", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("1229", 2) and (type(value) <> "roSGNode")
                RBS_CC_22_reportLine("1229", 3)
                RBS_CC_22_reportLine("1230", 1)
                actual = rooibos_common_getTypeWithComponentWrapper(value)
                RBS_CC_22_reportLine("1231", 1)
                expected = ("<Component: roSGNode:" + bslib_toString(typeStr) + ">")
                if RBS_CC_22_reportLine("1232", 2) and (msg = "")
                    RBS_CC_22_reportLine("1232", 3)
                    RBS_CC_22_reportLine("1233", 1)
                    msg = ("expected type " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be type " + chr(34) + bslib_toString(rooibos_common_truncateString(expected)) + chr(34))
                end if
                RBS_CC_22_reportLine("1235", 1)
                m.fail(msg, actual, expected, true)
                RBS_CC_22_reportLine("1236", 1)
                return false
            else if RBS_CC_22_reportLine("1237", 2) and (value.subType() <> typeStr)
                RBS_CC_22_reportLine("1237", 3)
                RBS_CC_22_reportLine("1238", 1)
                actual = rooibos_common_getTypeWithComponentWrapper(value, true)
                RBS_CC_22_reportLine("1239", 1)
                expected = ("<Component: roSGNode:" + bslib_toString(typeStr) + ">")
                if RBS_CC_22_reportLine("1240", 2) and (msg = "")
                    RBS_CC_22_reportLine("1240", 3)
                    RBS_CC_22_reportLine("1241", 1)
                    msg = ("expected type " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be type " + chr(34) + bslib_toString(rooibos_common_truncateString(expected)) + chr(34))
                end if
                RBS_CC_22_reportLine("1243", 1)
                m.fail(msg, actual, expected, true)
                RBS_CC_22_reportLine("1244", 1)
                return false
            end if
            RBS_CC_22_reportLine("1246", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("1249", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("1251", 1)
        return false
    end function
    RBS_CC_22_reportLine("1253", 1)
    instance.assertClass = function(value, expectedClassName, msg = "") as dynamic
        if RBS_CC_22_reportLine("1254", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("1254", 3)
            RBS_CC_22_reportLine("1255", 1)
            return false
        end if
        if RBS_CC_22_reportLine("1257", 2) and (rooibos_common_isFunction(expectedClassName))
            RBS_CC_22_reportLine("1257", 3)
            RBS_CC_22_reportLine("1258", 1)
            expectedClassName = expectedClassName.toStr().mid(10).replace("_", ".")
        end if
        try
            if RBS_CC_22_reportLine("1261", 2) and (not rooibos_common_isAssociativeArray(value))
                RBS_CC_22_reportLine("1261", 3)
                if RBS_CC_22_reportLine("1262", 2) and (msg = "")
                    RBS_CC_22_reportLine("1262", 3)
                    RBS_CC_22_reportLine("1263", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(value, true))) + chr(34) + " to be an instance of " + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(expectedClassName, true))))
                end if
                RBS_CC_22_reportLine("1265", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("1266", 1)
                return false
            end if
            if RBS_CC_22_reportLine("1268", 2) and (not rooibos_common_isString(value?.__classname))
                RBS_CC_22_reportLine("1268", 3)
                if RBS_CC_22_reportLine("1269", 2) and (msg = "")
                    RBS_CC_22_reportLine("1269", 3)
                    RBS_CC_22_reportLine("1270", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(value, true))) + chr(34) + " to be an instance of " + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(expectedClassName, true))))
                end if
                RBS_CC_22_reportLine("1272", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("1273", 1)
                return false
            end if
            RBS_CC_22_reportLine("1275", 1)
            className = value?.__classname
            RBS_CC_22_reportLine("1276", 1)
            fail = false
            if RBS_CC_22_reportLine("1277", 2) and (not rooibos_common_isString(value?.__classname))
                RBS_CC_22_reportLine("1277", 3)
                RBS_CC_22_reportLine("1278", 1)
                className = "Invalid"
                RBS_CC_22_reportLine("1279", 1)
                fail = true
            end if
            RBS_CC_22_reportLine("1281", 1)
            className = lCase(className)
            if RBS_CC_22_reportLine("1282", 2) and (fail or className <> lCase(expectedClassName))
                RBS_CC_22_reportLine("1282", 3)
                RBS_CC_22_reportLine("1283", 1)
                actual = rooibos_common_asMultilineString(className, true)
                RBS_CC_22_reportLine("1284", 1)
                expected = rooibos_common_asMultilineString(lCase(expectedClassName), true)
                if RBS_CC_22_reportLine("1285", 2) and (msg = "")
                    RBS_CC_22_reportLine("1285", 3)
                    RBS_CC_22_reportLine("1286", 1)
                    msg = ("expected class " + bslib_toString(rooibos_common_truncateString(actual)) + " to be an instance of " + bslib_toString(rooibos_common_truncateString(expected)))
                end if
                RBS_CC_22_reportLine("1288", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("1289", 1)
                return false
            end if
            RBS_CC_22_reportLine("1291", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("1294", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("1296", 1)
        return false
    end function
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    '++ NEW NODE ASSERTS
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ' Asserts that the node contains the designated number of children
    ' @param {Dynamic} node - target node
    ' @param {Dynamic} count - expected number of child items
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert w, false otherwise
    RBS_CC_22_reportLine("1306", 1)
    instance.assertNodeCount = function(node, count, msg = "") as dynamic
        if RBS_CC_22_reportLine("1307", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("1307", 3)
            RBS_CC_22_reportLine("1308", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("1311", 2) and (type(node) = "roSGNode")
                RBS_CC_22_reportLine("1311", 3)
                if RBS_CC_22_reportLine("1312", 2) and (node.isSubType("mc_Node"))
                    RBS_CC_22_reportLine("1312", 3)
                    RBS_CC_22_reportLine("1313", 1)
                    childCount = node.length
                else
                    RBS_CC_22_reportLine("1314", 3)
                    RBS_CC_22_reportLine("1315", 1)
                    childCount = node.getChildCount()
                end if
                if RBS_CC_22_reportLine("1317", 2) and (childCount <> count)
                    RBS_CC_22_reportLine("1317", 3)
                    RBS_CC_22_reportLine("1318", 1)
                    actual = rooibos_common_asMultilineString(childCount, true)
                    RBS_CC_22_reportLine("1319", 1)
                    expected = rooibos_common_asMultilineString(count, true)
                    if RBS_CC_22_reportLine("1320", 2) and (msg = "")
                        RBS_CC_22_reportLine("1320", 3)
                        RBS_CC_22_reportLine("1321", 1)
                        msg = ("expected count " + chr(34) + bslib_toString(actual) + chr(34) + " to be " + chr(34) + bslib_toString(expected) + chr(34))
                    end if
                    RBS_CC_22_reportLine("1323", 1)
                    m.fail(msg, actual, expected, true)
                    RBS_CC_22_reportLine("1324", 1)
                    return false
                end if
            else
                RBS_CC_22_reportLine("1326", 3)
                RBS_CC_22_reportLine("1327", 1)
                actual = rooibos_common_getTypeWithComponentWrapper(node)
                RBS_CC_22_reportLine("1328", 1)
                expected = "<Component: roSGNode>"
                if RBS_CC_22_reportLine("1329", 2) and (msg = "")
                    RBS_CC_22_reportLine("1329", 3)
                    RBS_CC_22_reportLine("1330", 1)
                    msg = ("expected type " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be type " + chr(34) + bslib_toString(rooibos_common_truncateString(expected)) + chr(34))
                end if
                RBS_CC_22_reportLine("1332", 1)
                m.fail(msg, actual, expected, true)
                RBS_CC_22_reportLine("1333", 1)
                return false
            end if
            RBS_CC_22_reportLine("1335", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("1338", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("1340", 1)
        return false
    end function
    ' Fail if the node items count = expected count.
    ' @param {Dynamic} node - A target node
    ' @param {Dynamic} count - Expected item count
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("1347", 1)
    instance.assertNodeNotCount = function(node, count, msg = "") as dynamic
        if RBS_CC_22_reportLine("1348", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("1348", 3)
            RBS_CC_22_reportLine("1349", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("1352", 2) and (type(node) = "roSGNode")
                RBS_CC_22_reportLine("1352", 3)
                if RBS_CC_22_reportLine("1353", 2) and (node.isSubType("mc_Node"))
                    RBS_CC_22_reportLine("1353", 3)
                    RBS_CC_22_reportLine("1354", 1)
                    childCount = node.length
                else
                    RBS_CC_22_reportLine("1355", 3)
                    RBS_CC_22_reportLine("1356", 1)
                    childCount = node.getChildCount()
                end if
                if RBS_CC_22_reportLine("1358", 2) and (childCount = count)
                    RBS_CC_22_reportLine("1358", 3)
                    RBS_CC_22_reportLine("1359", 1)
                    actual = rooibos_common_asMultilineString(childCount, true)
                    RBS_CC_22_reportLine("1360", 1)
                    expected = rooibos_common_asMultilineString(count, true)
                    if RBS_CC_22_reportLine("1361", 2) and (msg = "")
                        RBS_CC_22_reportLine("1361", 3)
                        RBS_CC_22_reportLine("1362", 1)
                        msg = ("expected count " + chr(34) + bslib_toString(actual) + chr(34) + " to not be " + chr(34) + bslib_toString(expected) + chr(34))
                    end if
                    RBS_CC_22_reportLine("1364", 1)
                    m.fail(msg, actual, expected, true)
                    RBS_CC_22_reportLine("1365", 1)
                    return false
                end if
            else
                RBS_CC_22_reportLine("1367", 3)
                RBS_CC_22_reportLine("1368", 1)
                actual = rooibos_common_getTypeWithComponentWrapper(node)
                RBS_CC_22_reportLine("1369", 1)
                expected = "<Component: roSGNode>"
                if RBS_CC_22_reportLine("1370", 2) and (msg = "")
                    RBS_CC_22_reportLine("1370", 3)
                    RBS_CC_22_reportLine("1371", 1)
                    msg = ("expected type " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be type " + chr(34) + bslib_toString(rooibos_common_truncateString(expected)) + chr(34))
                end if
                RBS_CC_22_reportLine("1373", 1)
                m.fail(msg, actual, expected, true)
                RBS_CC_22_reportLine("1374", 1)
                return false
            end if
            RBS_CC_22_reportLine("1376", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("1379", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("1381", 1)
        return false
    end function
    ' Asserts the node has no children
    ' @param {Dynamic} node - a node to check
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("1387", 1)
    instance.assertNodeEmpty = function(node, msg = "") as dynamic
        if RBS_CC_22_reportLine("1388", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("1388", 3)
            RBS_CC_22_reportLine("1389", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("1392", 2) and (type(node) = "roSGNode")
                RBS_CC_22_reportLine("1392", 3)
                if RBS_CC_22_reportLine("1393", 2) and (node.isSubType("mc_Node"))
                    RBS_CC_22_reportLine("1393", 3)
                    RBS_CC_22_reportLine("1394", 1)
                    childCount = node.length
                else
                    RBS_CC_22_reportLine("1395", 3)
                    RBS_CC_22_reportLine("1396", 1)
                    childCount = node.getChildCount()
                end if
                if RBS_CC_22_reportLine("1398", 2) and (childCount > 0)
                    RBS_CC_22_reportLine("1398", 3)
                    if RBS_CC_22_reportLine("1399", 2) and (msg = "")
                        RBS_CC_22_reportLine("1399", 3)
                        RBS_CC_22_reportLine("1400", 1)
                        msg = ("expected child count " + chr(34) + bslib_toString(childCount) + chr(34) + " to be " + chr(34) + "0" + chr(34))
                    end if
                    RBS_CC_22_reportLine("1402", 1)
                    m.fail(msg, "", "", true)
                    RBS_CC_22_reportLine("1403", 1)
                    return false
                end if
            else
                RBS_CC_22_reportLine("1405", 3)
                RBS_CC_22_reportLine("1406", 1)
                actual = rooibos_common_getTypeWithComponentWrapper(node)
                RBS_CC_22_reportLine("1407", 1)
                expected = "<Component: roSGNode>"
                if RBS_CC_22_reportLine("1408", 2) and (msg = "")
                    RBS_CC_22_reportLine("1408", 3)
                    RBS_CC_22_reportLine("1409", 1)
                    msg = ("expected type " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be type " + chr(34) + bslib_toString(rooibos_common_truncateString(expected)) + chr(34))
                end if
                RBS_CC_22_reportLine("1411", 1)
                m.fail(msg, actual, expected, true)
                RBS_CC_22_reportLine("1412", 1)
                return false
            end if
            RBS_CC_22_reportLine("1414", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("1417", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("1419", 1)
        return false
    end function
    ' Asserts the node has children
    ' @param {Dynamic} node - a node to check
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("1425", 1)
    instance.assertNodeNotEmpty = function(node, msg = "") as dynamic
        if RBS_CC_22_reportLine("1426", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("1426", 3)
            RBS_CC_22_reportLine("1427", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("1430", 2) and (type(node) = "roSGNode")
                RBS_CC_22_reportLine("1430", 3)
                if RBS_CC_22_reportLine("1431", 2) and (node.isSubType("mc_Node"))
                    RBS_CC_22_reportLine("1431", 3)
                    RBS_CC_22_reportLine("1432", 1)
                    childCount = node.length
                else
                    RBS_CC_22_reportLine("1433", 3)
                    RBS_CC_22_reportLine("1434", 1)
                    childCount = node.getChildCount()
                end if
                if RBS_CC_22_reportLine("1436", 2) and (childCount = 0)
                    RBS_CC_22_reportLine("1436", 3)
                    if RBS_CC_22_reportLine("1437", 2) and (msg = "")
                        RBS_CC_22_reportLine("1437", 3)
                        RBS_CC_22_reportLine("1438", 1)
                        msg = ("expected child count " + chr(34) + bslib_toString(childCount) + chr(34) + " to be greater then " + chr(34) + "0" + chr(34))
                    end if
                    RBS_CC_22_reportLine("1440", 1)
                    m.fail(msg, "", "", true)
                    RBS_CC_22_reportLine("1441", 1)
                    return false
                end if
            else
                RBS_CC_22_reportLine("1443", 3)
                RBS_CC_22_reportLine("1444", 1)
                actual = rooibos_common_getTypeWithComponentWrapper(node)
                RBS_CC_22_reportLine("1445", 1)
                expected = "<Component: roSGNode>"
                if RBS_CC_22_reportLine("1446", 2) and (msg = "")
                    RBS_CC_22_reportLine("1446", 3)
                    RBS_CC_22_reportLine("1447", 1)
                    msg = ("expected type " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be type " + chr(34) + bslib_toString(rooibos_common_truncateString(expected)) + chr(34))
                end if
                RBS_CC_22_reportLine("1449", 1)
                m.fail(msg, actual, expected, true)
                RBS_CC_22_reportLine("1450", 1)
                return false
            end if
            RBS_CC_22_reportLine("1452", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("1455", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("1457", 1)
        return false
    end function
    ' Asserts the node contains the child _value_
    ' @param {Dynamic} node - a node to check
    ' @param {Dynamic} value - value to check - value to look for
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("1464", 1)
    instance.assertNodeContains = function(node, value, msg = "") as dynamic
        if RBS_CC_22_reportLine("1465", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("1465", 3)
            RBS_CC_22_reportLine("1466", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("1469", 2) and (type(node) = "roSGNode")
                RBS_CC_22_reportLine("1469", 3)
                if RBS_CC_22_reportLine("1470", 2) and (not rooibos_common_nodeContains(node, value))
                    RBS_CC_22_reportLine("1470", 3)
                    if RBS_CC_22_reportLine("1471", 2) and (msg = "")
                        RBS_CC_22_reportLine("1471", 3)
                        RBS_CC_22_reportLine("1472", 1)
                        msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_getTypeWithComponentWrapper(node, true))) + chr(34) + " to contain child " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_getTypeWithComponentWrapper(value, true))) + chr(34) + " by reference")
                    end if
                    RBS_CC_22_reportLine("1474", 1)
                    m.fail(msg, "", "", true)
                    RBS_CC_22_reportLine("1475", 1)
                    return false
                end if
            else
                RBS_CC_22_reportLine("1477", 3)
                RBS_CC_22_reportLine("1478", 1)
                actual = rooibos_common_getTypeWithComponentWrapper(node)
                RBS_CC_22_reportLine("1479", 1)
                expected = "<Component: roSGNode>"
                if RBS_CC_22_reportLine("1480", 2) and (msg = "")
                    RBS_CC_22_reportLine("1480", 3)
                    RBS_CC_22_reportLine("1481", 1)
                    msg = ("expected type " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be type " + chr(34) + bslib_toString(rooibos_common_truncateString(expected)) + chr(34))
                end if
                RBS_CC_22_reportLine("1483", 1)
                m.fail(msg, actual, expected, true)
                RBS_CC_22_reportLine("1484", 1)
                return false
            end if
            RBS_CC_22_reportLine("1486", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("1489", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("1491", 1)
        return false
    end function
    ' Asserts the node contains only the child _value_
    ' @param {Dynamic} node - a node to check
    ' @param {Dynamic} value - value to check - value to look for
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("1498", 1)
    instance.assertNodeContainsOnly = function(node, value, msg = "") as dynamic
        if RBS_CC_22_reportLine("1499", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("1499", 3)
            RBS_CC_22_reportLine("1500", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("1503", 2) and (type(node) = "roSGNode")
                RBS_CC_22_reportLine("1503", 3)
                if RBS_CC_22_reportLine("1504", 2) and (not rooibos_common_nodeContains(node, value))
                    RBS_CC_22_reportLine("1504", 3)
                    if RBS_CC_22_reportLine("1505", 2) and (msg = "")
                        RBS_CC_22_reportLine("1505", 3)
                        RBS_CC_22_reportLine("1506", 1)
                        msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_getTypeWithComponentWrapper(node, true))) + chr(34) + " to contain child " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_getTypeWithComponentWrapper(value, true))) + chr(34) + " by reference")
                    end if
                    RBS_CC_22_reportLine("1508", 1)
                    m.fail(msg, "", "", true)
                    RBS_CC_22_reportLine("1509", 1)
                    return false
                else
                    RBS_CC_22_reportLine("1510", 3)
                    if RBS_CC_22_reportLine("1511", 2) and (node.isSubType("mc_Node"))
                        RBS_CC_22_reportLine("1511", 3)
                        RBS_CC_22_reportLine("1512", 1)
                        childCount = node.length
                    else
                        RBS_CC_22_reportLine("1513", 3)
                        RBS_CC_22_reportLine("1514", 1)
                        childCount = node.getChildCount()
                    end if
                    if RBS_CC_22_reportLine("1516", 2) and (childCount <> 1)
                        RBS_CC_22_reportLine("1516", 3)
                        if RBS_CC_22_reportLine("1517", 2) and (msg = "")
                            RBS_CC_22_reportLine("1517", 3)
                            RBS_CC_22_reportLine("1518", 1)
                            msg = ("expected child count " + chr(34) + bslib_toString(childCount) + chr(34) + " to be " + chr(34) + "1" + chr(34))
                        end if
                        RBS_CC_22_reportLine("1520", 1)
                        m.fail(msg, "", "", true)
                        RBS_CC_22_reportLine("1521", 1)
                        return false
                    end if
                end if
            else
                RBS_CC_22_reportLine("1524", 3)
                RBS_CC_22_reportLine("1525", 1)
                actual = rooibos_common_getTypeWithComponentWrapper(node)
                RBS_CC_22_reportLine("1526", 1)
                expected = "<Component: roSGNode>"
                if RBS_CC_22_reportLine("1527", 2) and (msg = "")
                    RBS_CC_22_reportLine("1527", 3)
                    RBS_CC_22_reportLine("1528", 1)
                    msg = ("expected type " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be type " + chr(34) + bslib_toString(rooibos_common_truncateString(expected)) + chr(34))
                end if
                RBS_CC_22_reportLine("1530", 1)
                m.fail(msg, actual, expected, true)
                RBS_CC_22_reportLine("1531", 1)
                return false
            end if
            RBS_CC_22_reportLine("1533", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("1536", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("1538", 1)
        return false
    end function
    ' Fail if the node h item.
    ' @param {Dynamic} node - A target node
    ' @param {Dynamic} value - value to check - a node child
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("1545", 1)
    instance.assertNodeNotContains = function(node, value, msg = "") as dynamic
        if RBS_CC_22_reportLine("1546", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("1546", 3)
            RBS_CC_22_reportLine("1547", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("1550", 2) and (type(node) = "roSGNode")
                RBS_CC_22_reportLine("1550", 3)
                if RBS_CC_22_reportLine("1551", 2) and (rooibos_common_nodeContains(node, value))
                    RBS_CC_22_reportLine("1551", 3)
                    if RBS_CC_22_reportLine("1552", 2) and (msg = "")
                        RBS_CC_22_reportLine("1552", 3)
                        RBS_CC_22_reportLine("1553", 1)
                        msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_getTypeWithComponentWrapper(node, true))) + chr(34) + " to not contain child " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_getTypeWithComponentWrapper(value, true))) + chr(34) + " by reference")
                    end if
                    RBS_CC_22_reportLine("1555", 1)
                    m.fail(msg, "", "", true)
                    RBS_CC_22_reportLine("1556", 1)
                    return false
                end if
            else
                RBS_CC_22_reportLine("1558", 3)
                RBS_CC_22_reportLine("1559", 1)
                actual = rooibos_common_getTypeWithComponentWrapper(node)
                RBS_CC_22_reportLine("1560", 1)
                expected = "<Component: roSGNode>"
                if RBS_CC_22_reportLine("1561", 2) and (msg = "")
                    RBS_CC_22_reportLine("1561", 3)
                    RBS_CC_22_reportLine("1562", 1)
                    msg = ("expected type " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be type " + chr(34) + bslib_toString(rooibos_common_truncateString(expected)) + chr(34))
                end if
                RBS_CC_22_reportLine("1564", 1)
                m.fail(msg, actual, expected, true)
                RBS_CC_22_reportLine("1565", 1)
                return false
            end if
            RBS_CC_22_reportLine("1567", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("1570", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("1572", 1)
        return false
    end function
    ' Fail if the node doesn't have the item subset.
    ' @param {Dynamic} node - A target node
    ' @param {Dynamic} subset - items to check
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("1579", 1)
    instance.assertNodeContainsFields = function(node, subset, ignoredFields = invalid, msg = "") as dynamic
        if RBS_CC_22_reportLine("1580", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("1580", 3)
            RBS_CC_22_reportLine("1581", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("1584", 2) and (not type(node) = "roSGNode")
                RBS_CC_22_reportLine("1584", 3)
                RBS_CC_22_reportLine("1585", 1)
                actual = rooibos_common_getTypeWithComponentWrapper(node)
                RBS_CC_22_reportLine("1586", 1)
                expected = "<Component: roSGNode>"
                if RBS_CC_22_reportLine("1587", 2) and (msg = "")
                    RBS_CC_22_reportLine("1587", 3)
                    RBS_CC_22_reportLine("1588", 1)
                    msg = ("expected type " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be type " + chr(34) + bslib_toString(rooibos_common_truncateString(expected)) + chr(34))
                end if
                RBS_CC_22_reportLine("1590", 1)
                m.fail(msg, actual, expected, true)
                RBS_CC_22_reportLine("1591", 1)
                return false
            end if
            if RBS_CC_22_reportLine("1593", 2) and (not rooibos_common_isAssociativeArray(subset))
                RBS_CC_22_reportLine("1593", 3)
                if RBS_CC_22_reportLine("1594", 2) and (msg = "")
                    RBS_CC_22_reportLine("1594", 3)
                    RBS_CC_22_reportLine("1595", 1)
                    msg = ("expected subset " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(subset, true))) + chr(34) + " to be an AssociativeArray")
                end if
                RBS_CC_22_reportLine("1597", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("1598", 1)
                return false
            end if
            if RBS_CC_22_reportLine("1600", 2) and (rooibos_common_isArray(ignoredFields))
                RBS_CC_22_reportLine("1600", 3)
                RBS_CC_22_reportLine("1601", 1)
                filteredSubset = {}
                RBS_CC_22_reportLine("1602", 1): for each key in subset
                    if RBS_CC_22_reportLine("1603", 2) and (rooibos_common_isString(key) and not rooibos_common_arrayContains(ignoredFields, key))
                        RBS_CC_22_reportLine("1603", 3)
                        RBS_CC_22_reportLine("1604", 1)
                        filteredSubset[key] = subset[key]
                    end if
                end for
            else
                RBS_CC_22_reportLine("1607", 3)
                RBS_CC_22_reportLine("1608", 1)
                filteredSubset = subset
            end if
            RBS_CC_22_reportLine("1610", 1)
            foundValues = {}
            RBS_CC_22_reportLine("1611", 1)
            missingValues = {}
            RBS_CC_22_reportLine("1612", 1): for each key in filteredSubset
                RBS_CC_22_reportLine("1613", 1)
                subsetValue = filteredSubset[key]
                RBS_CC_22_reportLine("1614", 1)
                nodeValue = node[key]
                if RBS_CC_22_reportLine("1615", 2) and (rooibos_common_eqValues(nodeValue, subsetValue))
                    RBS_CC_22_reportLine("1615", 3)
                    RBS_CC_22_reportLine("1616", 1)
                    foundValues[key] = subsetValue
                else
                    RBS_CC_22_reportLine("1617", 3)
                    RBS_CC_22_reportLine("1618", 1)
                    missingValues[key] = subsetValue
                end if
            end for
            if RBS_CC_22_reportLine("1621", 2) and (foundValues.ifAssociativeArray.count() <> filteredSubset.ifAssociativeArray.count())
                RBS_CC_22_reportLine("1621", 3)
                RBS_CC_22_reportLine("1622", 1)
                actual = rooibos_common_asMultilineString(foundValues, true)
                RBS_CC_22_reportLine("1623", 1)
                expected = rooibos_common_asMultilineString(filteredSubset, true)
                if RBS_CC_22_reportLine("1624", 2) and (msg = "")
                    RBS_CC_22_reportLine("1624", 3)
                    if RBS_CC_22_reportLine("1625", 2) and (msg = "")
                        RBS_CC_22_reportLine("1625", 3)
                        RBS_CC_22_reportLine("1626", 1)
                        msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_getTypeWithComponentWrapper(node, true))) + chr(34) + " to have properties " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(missingValues))) + chr(34))
                    end if
                end if
                RBS_CC_22_reportLine("1629", 1)
                m.fail(msg, actual, expected, true)
                RBS_CC_22_reportLine("1630", 1)
                return false
            end if
            RBS_CC_22_reportLine("1632", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("1635", 1)
            m.currentResult.failCrash(error, error.message)
            RBS_CC_22_reportLine("1636", 1)
            return false
        end try
        RBS_CC_22_reportLine("1638", 1)
        return false
    end function
    ' Fail if the node have the item from subset.
    ' @param {Dynamic} node - A target node
    ' @param {Dynamic} subset - the items to check for
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert w, false otherwise
    RBS_CC_22_reportLine("1645", 1)
    instance.assertNodeNotContainsFields = function(node, subset, msg = "") as dynamic
        if RBS_CC_22_reportLine("1646", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("1646", 3)
            RBS_CC_22_reportLine("1647", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("1650", 2) and (not type(node) = "roSGNode")
                RBS_CC_22_reportLine("1650", 3)
                RBS_CC_22_reportLine("1651", 1)
                actual = rooibos_common_getTypeWithComponentWrapper(node)
                RBS_CC_22_reportLine("1652", 1)
                expected = "<Component: roSGNode>"
                if RBS_CC_22_reportLine("1653", 2) and (msg = "")
                    RBS_CC_22_reportLine("1653", 3)
                    RBS_CC_22_reportLine("1654", 1)
                    msg = ("expected type " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be type " + chr(34) + bslib_toString(rooibos_common_truncateString(expected)) + chr(34))
                end if
                RBS_CC_22_reportLine("1656", 1)
                m.fail(msg, actual, expected, true)
                RBS_CC_22_reportLine("1657", 1)
                return false
            end if
            if RBS_CC_22_reportLine("1659", 2) and (rooibos_common_isArray(subset))
                RBS_CC_22_reportLine("1659", 3)
                '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                ' NOTE: Legacy check for children via array support.
                '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                RBS_CC_22_reportLine("1663", 1): for each value in subset
                    if RBS_CC_22_reportLine("1664", 2) and (rooibos_common_nodeContains(node, value))
                        RBS_CC_22_reportLine("1664", 3)
                        if RBS_CC_22_reportLine("1665", 2) and (msg = "")
                            RBS_CC_22_reportLine("1665", 3)
                            RBS_CC_22_reportLine("1666", 1)
                            msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_getTypeWithComponentWrapper(node, true))) + chr(34) + " to not contain child " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_getTypeWithComponentWrapper(value, true))) + chr(34) + " by reference")
                        end if
                        RBS_CC_22_reportLine("1668", 1)
                        m.fail(msg, "", "", true)
                        RBS_CC_22_reportLine("1669", 1)
                        return false
                    end if
                end for
            else if RBS_CC_22_reportLine("1672", 2) and (rooibos_common_isAssociativeArray(subset))
                RBS_CC_22_reportLine("1672", 3)
                RBS_CC_22_reportLine("1673", 1)
                foundValues = {}
                RBS_CC_22_reportLine("1674", 1): for each key in subset
                    RBS_CC_22_reportLine("1675", 1)
                    subsetValue = subset[key]
                    RBS_CC_22_reportLine("1676", 1)
                    nodeValue = node[key]
                    if RBS_CC_22_reportLine("1677", 2) and (rooibos_common_eqValues(nodeValue, subsetValue))
                        RBS_CC_22_reportLine("1677", 3)
                        RBS_CC_22_reportLine("1678", 1)
                        foundValues[key] = subsetValue
                    end if
                end for
                if RBS_CC_22_reportLine("1681", 2) and (foundValues.ifAssociativeArray.count() > 0)
                    RBS_CC_22_reportLine("1681", 3)
                    RBS_CC_22_reportLine("1682", 1)
                    actual = rooibos_common_asMultilineString(foundValues, true)
                    RBS_CC_22_reportLine("1683", 1)
                    expected = rooibos_common_asMultilineString({}, true)
                    if RBS_CC_22_reportLine("1684", 2) and (msg = "")
                        RBS_CC_22_reportLine("1684", 3)
                        RBS_CC_22_reportLine("1685", 1)
                        msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_getTypeWithComponentWrapper(node, true))) + chr(34) + " to have not have properties " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(foundValues))) + chr(34))
                    end if
                    RBS_CC_22_reportLine("1687", 1)
                    m.fail(msg, actual, expected, true)
                    RBS_CC_22_reportLine("1688", 1)
                    return false
                end if
            else
                RBS_CC_22_reportLine("1690", 3)
                if RBS_CC_22_reportLine("1691", 2) and (msg = "")
                    RBS_CC_22_reportLine("1691", 3)
                    RBS_CC_22_reportLine("1692", 1)
                    msg = ("expected subset " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(subset, true))) + chr(34) + " to be an AssociativeArray")
                end if
                RBS_CC_22_reportLine("1694", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("1695", 1)
                return false
            end if
            RBS_CC_22_reportLine("1697", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("1700", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("1702", 1)
        return false
    end function
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    '++ END NODE ASSERTS
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ' Asserts the associative array contains the fields contained in subset; while ignoring the fields in the ignoredFields array
    ' @param {assocarray} array - associative array  to check
    ' @param {assocarray} subset - associative array of values to check for
    ' @param {array} ignoredFields - array of fieldnames to ignore while comparing
    ' @param {string} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    RBS_CC_22_reportLine("1713", 1)
    instance.assertAAContainsSubset = function(array, subset, ignoredFields = invalid, msg = "") as dynamic
        if RBS_CC_22_reportLine("1714", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("1714", 3)
            RBS_CC_22_reportLine("1715", 1)
            return false
        end if
        try
            if RBS_CC_22_reportLine("1718", 2) and (not rooibos_common_isAssociativeArray(array))
                RBS_CC_22_reportLine("1718", 3)
                if RBS_CC_22_reportLine("1719", 2) and (msg = "")
                    RBS_CC_22_reportLine("1719", 3)
                    RBS_CC_22_reportLine("1720", 1)
                    msg = ("expected target " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to be an AssociativeArray")
                end if
                RBS_CC_22_reportLine("1722", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("1723", 1)
                return false
            end if
            if RBS_CC_22_reportLine("1725", 2) and (not rooibos_common_isAssociativeArray(subset))
                RBS_CC_22_reportLine("1725", 3)
                if RBS_CC_22_reportLine("1726", 2) and (msg = "")
                    RBS_CC_22_reportLine("1726", 3)
                    RBS_CC_22_reportLine("1727", 1)
                    msg = ("expected subset " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(subset, true))) + chr(34) + " to be an AssociativeArray")
                end if
                RBS_CC_22_reportLine("1729", 1)
                m.fail(msg, "", "", true)
                RBS_CC_22_reportLine("1730", 1)
                return false
            end if
            if RBS_CC_22_reportLine("1732", 2) and (rooibos_common_isArray(ignoredFields))
                RBS_CC_22_reportLine("1732", 3)
                RBS_CC_22_reportLine("1733", 1)
                filteredSubset = {}
                RBS_CC_22_reportLine("1734", 1): for each key in subset
                    if RBS_CC_22_reportLine("1735", 2) and (rooibos_common_isString(key) and not rooibos_common_arrayContains(ignoredFields, key))
                        RBS_CC_22_reportLine("1735", 3)
                        RBS_CC_22_reportLine("1736", 1)
                        filteredSubset[key] = subset[key]
                    end if
                end for
            else
                RBS_CC_22_reportLine("1739", 3)
                RBS_CC_22_reportLine("1740", 1)
                filteredSubset = subset
            end if
            RBS_CC_22_reportLine("1742", 1)
            foundValues = {}
            RBS_CC_22_reportLine("1743", 1)
            missingValues = {}
            RBS_CC_22_reportLine("1744", 1): for each key in filteredSubset
                RBS_CC_22_reportLine("1745", 1)
                subsetValue = filteredSubset[key]
                RBS_CC_22_reportLine("1746", 1)
                nodeValue = array[key]
                if RBS_CC_22_reportLine("1747", 2) and (rooibos_common_eqValues(nodeValue, subsetValue))
                    RBS_CC_22_reportLine("1747", 3)
                    RBS_CC_22_reportLine("1748", 1)
                    foundValues[key] = subsetValue
                else
                    RBS_CC_22_reportLine("1749", 3)
                    RBS_CC_22_reportLine("1750", 1)
                    missingValues[key] = subsetValue
                end if
            end for
            if RBS_CC_22_reportLine("1753", 2) and (foundValues.ifAssociativeArray.count() <> filteredSubset.ifAssociativeArray.count())
                RBS_CC_22_reportLine("1753", 3)
                RBS_CC_22_reportLine("1754", 1)
                actual = rooibos_common_asMultilineString(foundValues, true)
                RBS_CC_22_reportLine("1755", 1)
                expected = rooibos_common_asMultilineString(filteredSubset, true)
                if RBS_CC_22_reportLine("1756", 2) and (msg = "")
                    RBS_CC_22_reportLine("1756", 3)
                    RBS_CC_22_reportLine("1757", 1)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to have properties " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(missingValues))) + chr(34))
                end if
                RBS_CC_22_reportLine("1759", 1)
                m.fail(msg, actual, expected, true)
                RBS_CC_22_reportLine("1760", 1)
                return false
            end if
            RBS_CC_22_reportLine("1762", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("1765", 1)
            m.currentResult.failCrash(error, msg)
        end try
        RBS_CC_22_reportLine("1767", 1)
        return false
    end function
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    '++ Stubbing helpers
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ' Creates a stub to replace a real method with
    ' @param {Dynamic} target - object on which the method to be stubbed is found
    ' @param {Dynamic} methodName - name of method to stub
    ' @param {Dynamic} [returnValue=invalid] - value that the stub method will return when invoked
    ' @param {boolean} [allowNonExistingMethods=false] - if true, then rooibos will only warn if the method did not exist prior to faking
    ' @returns {Object} - stub that was wired into the real method
    RBS_CC_22_reportLine("1778", 1)
    instance.stub = function(target, methodName, returnValue = invalid, allowNonExistingMethods = false) as object
        if RBS_CC_22_reportLine("1779", 2) and (target = invalid and not rooibos_common_isFunction(methodName))
            RBS_CC_22_reportLine("1779", 3)
            RBS_CC_22_reportLine("1780", 1)
            m.fail("could not create Stub. Global function", methodName, ", is invalid")
            RBS_CC_22_reportLine("1781", 1)
            return {}
        else if RBS_CC_22_reportLine("1782", 2) and (type(target) <> "roAssociativeArray")
            RBS_CC_22_reportLine("1782", 3)
            RBS_CC_22_reportLine("1783", 1)
            m.fail("could not create Stub provided target was null")
            RBS_CC_22_reportLine("1784", 1)
            return {}
        end if
        if RBS_CC_22_reportLine("1786", 2) and (m.stubs = invalid)
            RBS_CC_22_reportLine("1786", 3)
            RBS_CC_22_reportLine("1787", 1)
            m.__stubId = -1
            RBS_CC_22_reportLine("1788", 1)
            m.stubs = {}
        end if
        RBS_CC_22_reportLine("1790", 1)
        m.__stubId++
        if RBS_CC_22_reportLine("1791", 2) and (m.__stubId > 25)
            RBS_CC_22_reportLine("1791", 3)
            RBS_CC_22_reportLine("1792", 1)
            rooibos_common_logError(("ERROR ONLY 25 MOCKS PER TEST ARE SUPPORTED!! you're on # " + bslib_toString(m.__mockId)))
            RBS_CC_22_reportLine("1793", 1)
            rooibos_common_logError("Method was " + methodName)
            RBS_CC_22_reportLine("1794", 1)
            return invalid
        end if
        RBS_CC_22_reportLine("1796", 1)
        id = stri(m.__stubId).trim()
        RBS_CC_22_reportLine("1797", 1)
        fake = m.createFake(id, target, methodName, 1, invalid, returnValue)
        RBS_CC_22_reportLine("1798", 1)
        m.stubs[id] = fake
        if RBS_CC_22_reportLine("1799", 2) and (target.isGlobalCall = true)
            RBS_CC_22_reportLine("1799", 3)
            RBS_CC_22_reportLine("1800", 1)
            rooibos_getMocksByFunctionName()[methodName] = fake
        else
            RBS_CC_22_reportLine("1801", 3)
            RBS_CC_22_reportLine("1802", 1)
            allowNonExisting = m.allowNonExistingMethodsOnMocks = true or allowNonExistingMethods
            RBS_CC_22_reportLine("1803", 1)
            isMethodPresent = type(target[methodName]) = "Function" or type(target[methodName]) = "roFunction"
            if RBS_CC_22_reportLine("1804", 2) and (isMethodPresent or allowNonExisting)
                RBS_CC_22_reportLine("1804", 3)
                RBS_CC_22_reportLine("1805", 1)
                target[methodName] = m["StubCallback" + id]
                RBS_CC_22_reportLine("1806", 1)
                target.__stubs = m.stubs
                ' FIXME: add a log setting for this - and add better detection so that stubs know that they are colliding/don't exist/have correct sigs
                ' if not isMethodPresent
                '   rooibos.common.logWarning(`stubbing call ${methodName} which did not exist on target object`)
                ' end if
            else
                RBS_CC_22_reportLine("1811", 3)
                RBS_CC_22_reportLine("1812", 1)
                rooibos_common_logTrace("Could not create Stub : method not found  " + rooibos_common_asString(target) + "." + methodName)
            end if
        end if
        RBS_CC_22_reportLine("1815", 1)
        return fake
    end function
    RBS_CC_22_reportLine("1817", 1)
    instance.expectLastCallToThrowError = function(error as dynamic)
        try
            RBS_CC_22_reportLine("1819", 1)
            mock = m.mocks[m.__mockId.toStr()]
            RBS_CC_22_reportLine("1820", 1)
            mock.toThrow(error)
        catch error
            RBS_CC_22_reportLine("1822", 1)
            m.log.error("could not add throw to last call", error)
        end try
    end function
    RBS_CC_22_reportLine("1825", 1)
    instance.expectCalled = function(invocation as dynamic, returnValue = invalid as dynamic) as object
        'mock function body - the plugin replaces this
        RBS_CC_22_reportLine("1827", 1)
        return invalid
    end function
    ' @ignore
    RBS_CC_22_reportLine("1830", 1)
    instance._expectCalled = function(target, methodName, rootObject = invalid as dynamic, fullPath = invalid as dynamic, expectedArgs = invalid, returnValue = invalid as dynamic) as object
        try
            if RBS_CC_22_reportLine("1832", 2) and (type(target) <> "roAssociativeArray" and fullPath <> invalid)
                RBS_CC_22_reportLine("1832", 3)
                RBS_CC_22_reportLine("1833", 1)
                target = rooibos_common_makePathStubbable(rootObject, fullPath)
            end if
            RBS_CC_22_reportLine("1835", 1)
            return m.mock(target, methodName, 1, expectedArgs, returnValue, true)
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("1838", 1)
            m.fail("Setting up mock failed: " + error.message, "", "", true)
        end try
        RBS_CC_22_reportLine("1840", 1)
        return invalid
    end function
    RBS_CC_22_reportLine("1842", 1)
    instance.stubCall = function(invocation as dynamic, stubOrReturnValue = invalid as dynamic, functionName = "" as string) as object
        ' When stubbing global functions this will be called. Other wise the test code will be updated to call m._stubCall()
        if RBS_CC_22_reportLine("1844", 2) and (type(invocation).endsWith("Function") and functionName = "")
            RBS_CC_22_reportLine("1844", 3)
            RBS_CC_22_reportLine("1845", 1)
            functionName = invocation.toStr().tokenize(" ").peek()
        else
            RBS_CC_22_reportLine("1846", 3)
            throw "Did not provide a function to be stubbed"
        end if
        if RBS_CC_22_reportLine("1849", 2) and (not type(stubOrReturnValue).endsWith("Function"))
            RBS_CC_22_reportLine("1849", 3)
            ' throw "Did not provide a stub function"
        end if
        ' Store the stub on the component scope
        RBS_CC_22_reportLine("1853", 1)
        globalAa = getGlobalAa()
        if RBS_CC_22_reportLine("1854", 2) and (type(globalAa?.__globalStubs) <> "roAssociativeArray")
            RBS_CC_22_reportLine("1854", 3)
            RBS_CC_22_reportLine("1855", 1)
            globalAa.__globalStubs = {}
        end if
        RBS_CC_22_reportLine("1857", 1)
        globalAa.__globalStubs[lCase(functionName)] = stubOrReturnValue
        RBS_CC_22_reportLine("1858", 1)
        return invalid
    end function
    ' @ignore
    RBS_CC_22_reportLine("1861", 1)
    instance._stubCall = function(target, methodName, rootObject = invalid as dynamic, fullPath = invalid as dynamic, returnValue = invalid as dynamic) as object
        try
            if RBS_CC_22_reportLine("1863", 2) and (type(target) <> "roAssociativeArray" and fullPath <> invalid)
                RBS_CC_22_reportLine("1863", 3)
                RBS_CC_22_reportLine("1864", 1)
                target = rooibos_common_makePathStubbable(rootObject, fullPath)
            end if
            RBS_CC_22_reportLine("1866", 1)
            return m.stub(target, methodName, returnValue, true)
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("1869", 1)
            m.fail("Setting up mock failed: " + error.message, "", "", true)
            RBS_CC_22_reportLine("1870", 1)
            return false
        end try
        RBS_CC_22_reportLine("1872", 1)
        return false
    end function
    RBS_CC_22_reportLine("1874", 1)
    instance.expectNotCalled = function(invocation as dynamic) as object
        'mock function body - the plugin replaces this
        RBS_CC_22_reportLine("1876", 1)
        return invalid
    end function
    ' @ignore
    RBS_CC_22_reportLine("1879", 1)
    instance._expectNotCalled = function(target, methodName, rootObject = invalid as dynamic, fullPath = invalid as dynamic) as object
        try
            if RBS_CC_22_reportLine("1881", 2) and (type(target) <> "roAssociativeArray" and fullPath <> invalid)
                RBS_CC_22_reportLine("1881", 3)
                RBS_CC_22_reportLine("1882", 1)
                target = rooibos_common_makePathStubbable(rootObject, fullPath)
            end if
            RBS_CC_22_reportLine("1884", 1)
            return m.mock(target, methodName, 0, invalid, invalid, true)
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("1887", 1)
            m.fail("Setting up mock failed: " + error.message, "", "", true)
            RBS_CC_22_reportLine("1888", 1)
            return false
        end try
        RBS_CC_22_reportLine("1890", 1)
        return false
    end function
    ' Creates a stub to replace a real method with, which the framework will track. If it was invoked the wrong number of times, or with wrong arguments, it will result in test failure
    ' @param {Dynamic} target - object on which the method to be stubbed is found
    ' @param {Dynamic} methodName - name of method to stub
    ' @param {Dynamic} [expectedArgs=invalid] - array containing the arguments we expect the method to be invoked with
    ' @param {Dynamic} [returnValue=invalid] - value that the stub method will return when invoked
    ' @param {boolean} [allowNonExistingMethods=false] - if true, then rooibos will only warn if the method did not exist prior to faking
    ' @returns {Object} - mock that was wired into the real method
    RBS_CC_22_reportLine("1899", 1)
    instance.expectOnce = function(target, methodName, expectedArgs = invalid, returnValue = invalid, allowNonExistingMethods = false) as object
        'HACK
        'HACK
        'HACK
        'HACK
        'HACK
        ' try
        RBS_CC_22_reportLine("1906", 1)
        return m.mock(target, methodName, 1, expectedArgs, returnValue, allowNonExistingMethods)
        ' catch error
        'bs:disable-next-line
        '   m.fail("Setting up mock failed: " + error.message, "", "", true)
        '   return false
        ' end try
        ' return false
    end function
    ' Toggles between expectOnce and expectNone, to allow for easy paremeterized expect behaviour
    ' @param {Dynamic} target - object on which the method to be stubbed is found
    ' @param {Dynamic} methodName - name of method to stub
    ' @param {Dynamic} isExpected - if true, then this is the same as expectOnce, if false, then this is the same as expectNone
    ' @param {Dynamic} [expectedArgs=invalid] - array containing the arguments we expect the method to be invoked with
    ' @param {Dynamic} [returnValue=invalid] - value that the stub method will return when invoked
    ' @param {boolean} [allowNonExistingMethods=false] - if true, then rooibos will only warn if the method did not exist prior to faking
    ' @returns {Object} - mock that was wired into the real method
    RBS_CC_22_reportLine("1922", 1)
    instance.expectOnceOrNone = function(target, methodName, isExpected, expectedArgs = invalid, returnValue = invalid, allowNonExistingMethods = false) as object
        try
            if RBS_CC_22_reportLine("1924", 2) and (isExpected)
                RBS_CC_22_reportLine("1924", 3)
                RBS_CC_22_reportLine("1925", 1)
                return m.expectOnce(target, methodName, expectedArgs, returnValue, allowNonExistingMethods)
            else
                RBS_CC_22_reportLine("1926", 3)
                RBS_CC_22_reportLine("1927", 1)
                return m.expectNone(target, methodName, allowNonExistingMethods)
            end if
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("1931", 1)
            m.fail("Setting up mock failed: " + error.message, "", "", true)
        end try
        RBS_CC_22_reportLine("1933", 1)
        return false
    end function
    ' Creates a stub to replace a real method with, which the framework will track. If it was invoked, it will result in test failure
    ' @param {Dynamic} target - object on which the method to be stubbed is found
    ' @param {Dynamic} methodName - name of method to stub
    ' @param {boolean} [allowNonExistingMethods=false] - if true, then rooibos will only warn if the method did not exist prior to faking
    ' @returns {Object} - mock that was wired into the real method
    RBS_CC_22_reportLine("1940", 1)
    instance.expectNone = function(target, methodName, allowNonExistingMethods = false) as object
        try
            RBS_CC_22_reportLine("1942", 1)
            return m.mock(target, methodName, 0, invalid, invalid, allowNonExistingMethods)
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("1945", 1)
            m.fail("Setting up mock failed: " + error.message, "", "", true)
        end try
        RBS_CC_22_reportLine("1947", 1)
        return false
    end function
    ' Creates a stub to replace a real method with, which the framework will track. If it was invoked the wrong number of times, or with wrong arguments, it will result in test failure
    ' @param {Dynamic} target - object on which the method to be stubbed is found
    ' @param {Dynamic} methodName - name of method to stub
    ' @param {Dynamic} [expectedInvocations=1] - number of invocations we expect
    ' @param {Dynamic} [expectedArgs=invalid] - array containing the arguments we expect the method to be invoked with
    ' @param {Dynamic} [returnValue=invalid] - value that the stub method will return when invoked
    ' @param {boolean} [allowNonExistingMethods=false] - if true, then rooibos will only warn if the method did not exist prior to faking
    ' @returns {Object} - mock that was wired into the real method
    RBS_CC_22_reportLine("1957", 1)
    instance.expect = function(target, methodName, expectedInvocations = 1, expectedArgs = invalid, returnValue = invalid, allowNonExistingMethods = false) as object
        try
            RBS_CC_22_reportLine("1959", 1)
            return m.mock(target, methodName, expectedInvocations, expectedArgs, returnValue, allowNonExistingMethods)
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("1962", 1)
            m.fail("Setting up mock failed: " + error.message, "", "", true)
        end try
        RBS_CC_22_reportLine("1964", 1)
        return false
    end function
    ' Creates a stub to replace a real method with, which the framework will track. If it was invoked the wrong number of times, or with wrong arguments, it will result in test failure
    ' @param {Dynamic} target - object on which the method to be stubbed is found
    ' @param {Dynamic} methodName - name of method to stub
    ' @param {Dynamic} expectedInvocations - number of invocations we expect
    ' @param {Dynamic} [expectedArgs=invalid] - array containing the arguments we expect the method to be invoked with
    ' @param {Dynamic} [returnValue=invalid] - value that the stub method will return when invoked
    ' @param {boolean} [allowNonExistingMethods=false] - if true, then rooibos will only warn if the method did not exist prior to faking
    ' @returns {Object} - mock that was wired into the real method
    RBS_CC_22_reportLine("1974", 1)
    instance.mock = function(target, methodName, expectedInvocations = 1, expectedArgs = invalid, returnValue = invalid, allowNonExistingMethods = false) as object
        RBS_CC_22_reportLine("1975", 1)
        lineNumber = m.currentAssertLineNumber
        'check params
        if RBS_CC_22_reportLine("1977", 2) and (target <> invalid and not rooibos_common_isFunction(target) and not rooibos_common_isAssociativeArray(target))
            RBS_CC_22_reportLine("1977", 3)
            RBS_CC_22_reportLine("1978", 1)
            methodName = ""
            RBS_CC_22_reportLine("1979", 1)
            m.mockFail(lineNumber, "", "mock args: target should be an AA or in-scope Global function", methodName)
        else if RBS_CC_22_reportLine("1980", 2) and (not rooibos_common_isString(methodName))
            RBS_CC_22_reportLine("1980", 3)
            RBS_CC_22_reportLine("1981", 1)
            methodName = ""
            RBS_CC_22_reportLine("1982", 1)
            m.mockFail(lineNumber, "", "mock args: methodName was not a string")
        else if RBS_CC_22_reportLine("1983", 2) and (not rooibos_common_isNumber(expectedInvocations))
            RBS_CC_22_reportLine("1983", 3)
            RBS_CC_22_reportLine("1984", 1)
            m.mockFail(lineNumber, methodName, "mock args: expectedInvocations was not an int")
        else if RBS_CC_22_reportLine("1985", 2) and (not rooibos_common_isArray(expectedArgs) and rooibos_common_isValid(expectedArgs))
            RBS_CC_22_reportLine("1985", 3)
            RBS_CC_22_reportLine("1986", 1)
            m.mockFail(lineNumber, methodName, "mock args: expectedArgs was not invalid or an array of args")
        else if RBS_CC_22_reportLine("1987", 2) and (rooibos_common_isUndefined(expectedArgs))
            RBS_CC_22_reportLine("1987", 3)
            RBS_CC_22_reportLine("1988", 1)
            m.mockFail(lineNumber, methodName, "mock args: expectedArgs undefined")
        else if RBS_CC_22_reportLine("1989", 2) and (rooibos_common_isUndefined(returnValue))
            RBS_CC_22_reportLine("1989", 3)
            RBS_CC_22_reportLine("1990", 1)
            m.mockFail(lineNumber, methodName, "mock args: returnValue undefined")
        end if
        if RBS_CC_22_reportLine("1992", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("1992", 3)
            RBS_CC_22_reportLine("1993", 1)
            rooibos_common_logError(("Cannot create MOCK. method " + bslib_toString(methodName) + " " + bslib_toString(lineNumber) + " " + bslib_toString(m.currentResult.message)))
            RBS_CC_22_reportLine("1994", 1)
            return {}
        end if
        if RBS_CC_22_reportLine("1996", 2) and (m.mocks = invalid)
            RBS_CC_22_reportLine("1996", 3)
            RBS_CC_22_reportLine("1997", 1)
            m.__mockId = -1
            RBS_CC_22_reportLine("1998", 1)
            m.__mockTargetId = -1
            RBS_CC_22_reportLine("1999", 1)
            m.mocks = {}
            RBS_CC_22_reportLine("2000", 1)
            rooibos_resetMocksByFunctionName()
        end if
        RBS_CC_22_reportLine("2002", 1)
        fake = invalid
        if RBS_CC_22_reportLine("2003", 2) and (rooibos_common_isFunction(target))
            RBS_CC_22_reportLine("2003", 3)
            RBS_CC_22_reportLine("2004", 1)
            target = {
                isGlobalCall: true
            }
        end if
        if RBS_CC_22_reportLine("2008", 2) and (not target.doesExist("__rooibosTargetId"))
            RBS_CC_22_reportLine("2008", 3)
            RBS_CC_22_reportLine("2009", 1)
            m.__mockTargetId++
            RBS_CC_22_reportLine("2010", 1)
            target["__rooibosTargetId"] = m.__mockTargetId
        end if
        'ascertain if mock already exists
        RBS_CC_22_reportLine("2013", 1): for i = 0 to m.__mockId
            RBS_CC_22_reportLine("2014", 1)
            id = stri(i).trim()
            RBS_CC_22_reportLine("2015", 1)
            mock = m.mocks[id]
            if RBS_CC_22_reportLine("2016", 2) and (mock <> invalid and mock.methodName = methodName and (mock.target.__rooibosTargetId = target.__rooibosTargetId or (mock.target.isGlobalCall = true and target.isGlobalCall = true)))
                RBS_CC_22_reportLine("2016", 3)
                RBS_CC_22_reportLine("2017", 1)
                fake = mock
                RBS_CC_22_reportLine("2018", 1)
                fake.lineNumbers.push(lineNumber)
                exit for
            end if
        end for
        if RBS_CC_22_reportLine("2022", 2) and (fake = invalid)
            RBS_CC_22_reportLine("2022", 3)
            RBS_CC_22_reportLine("2023", 1)
            m.__mockId++
            RBS_CC_22_reportLine("2024", 1)
            id = stri(m.__mockId).trim()
            if RBS_CC_22_reportLine("2025", 2) and (m.__mockId > 25)
                RBS_CC_22_reportLine("2025", 3)
                RBS_CC_22_reportLine("2026", 1)
                rooibos_common_logError(("ERROR ONLY 25 MOCKS PER TEST ARE SUPPORTED!! you're on # " + bslib_toString(m.__mockId)))
                RBS_CC_22_reportLine("2027", 1)
                rooibos_common_logError("Method was " + methodName)
                RBS_CC_22_reportLine("2028", 1)
                return invalid
            end if
            RBS_CC_22_reportLine("2030", 1)
            fake = m.createFake(id, target, methodName, expectedInvocations, expectedArgs, returnValue)
            RBS_CC_22_reportLine("2031", 1)
            m.mocks[id] = fake 'this will bind it to m
            if RBS_CC_22_reportLine("2032", 2) and (target.isGlobalCall = true)
                RBS_CC_22_reportLine("2032", 3)
                RBS_CC_22_reportLine("2033", 1)
                rooibos_getMocksByFunctionName()[methodName] = fake
            else
                RBS_CC_22_reportLine("2034", 3)
                RBS_CC_22_reportLine("2035", 1)
                allowNonExisting = m.allowNonExistingMethodsOnMocks = true or allowNonExistingMethods
                RBS_CC_22_reportLine("2036", 1)
                isMethodPresent = type(target[methodName]) = "Function" or type(target[methodName]) = "roFunction"
                if RBS_CC_22_reportLine("2037", 2) and (isMethodPresent or allowNonExisting)
                    RBS_CC_22_reportLine("2037", 3)
                    RBS_CC_22_reportLine("2038", 1)
                    target[methodName] = m["MockCallback" + id]
                    RBS_CC_22_reportLine("2039", 1)
                    target.__mocks = m.mocks
                    if RBS_CC_22_reportLine("2040", 2) and (not isMethodPresent)
                        RBS_CC_22_reportLine("2040", 3)
                        RBS_CC_22_reportLine("2041", 1)
                        rooibos_common_logWarning(("mocking call " + bslib_toString(methodName) + " which did not exist on target object"))
                    end if
                else
                    RBS_CC_22_reportLine("2043", 3)
                    RBS_CC_22_reportLine("2044", 1)
                    rooibos_common_logError(("Could not create Mock : method not found " + bslib_toString(target) + "." + bslib_toString(methodName)))
                end if
            end if
        else
            RBS_CC_22_reportLine("2047", 3)
            RBS_CC_22_reportLine("2048", 1)
            m.combineFakes(fake, m.createFake(id, target, methodName, expectedInvocations, expectedArgs, returnValue))
        end if
        RBS_CC_22_reportLine("2050", 1)
        return fake
    end function
    ' Creates a stub to replace a real method with. This is used internally.
    ' @param {Dynamic} target - object on which the method to be stubbed is found
    ' @param {Dynamic} methodName - name of method to stub
    ' @param {Dynamic} [expectedInvocations=1] - number of invocations we expect
    ' @param {Dynamic} [expectedArgs=invalid] - array containing the arguments we expect the method to be invoked with
    ' @param {Dynamic} [returnValue=invalid] - value that the stub method will return when invoked
    ' @returns {Object} - stub that was wired into the real method
    RBS_CC_22_reportLine("2059", 1)
    instance.createFake = function(id, target, methodName, expectedInvocations = 1, expectedArgs = invalid, returnValue = invalid) as object
        RBS_CC_22_reportLine("2060", 1)
        expectedArgsValues = []
        RBS_CC_22_reportLine("2061", 1)
        lineNumber = m.currentAssertLineNumber
        RBS_CC_22_reportLine("2062", 1)
        hasArgs = rooibos_common_isArray(expectedArgs)
        RBS_CC_22_reportLine("2063", 1)
        defaultValue = m.ignoreValue
        if RBS_CC_22_reportLine("2064", 2) and (hasArgs)
            RBS_CC_22_reportLine("2064", 3)
            RBS_CC_22_reportLine("2065", 1)
            defaultValue = m.invalidValue
        else
            RBS_CC_22_reportLine("2066", 3)
            RBS_CC_22_reportLine("2067", 1)
            expectedArgs = []
        end if
        RBS_CC_22_reportLine("2069", 1)
        lineNumbers = [
            lineNumber
        ]
        RBS_CC_22_reportLine("2072", 1): for i = 0 to 9
            if RBS_CC_22_reportLine("2073", 2) and (hasArgs and expectedArgs.count() > i)
                RBS_CC_22_reportLine("2073", 3)
                'guard against bad values
                RBS_CC_22_reportLine("2075", 1)
                value = expectedArgs[i]
                if RBS_CC_22_reportLine("2076", 2) and (not rooibos_common_isUndefined(value))
                    RBS_CC_22_reportLine("2076", 3)
                    if RBS_CC_22_reportLine("2077", 2) and (rooibos_common_isAssociativeArray(value) and rooibos_common_isValid(value.matcher))
                        RBS_CC_22_reportLine("2077", 3)
                        if RBS_CC_22_reportLine("2078", 2) and (not rooibos_common_isFunction(value.matcher))
                            RBS_CC_22_reportLine("2078", 3)
                            RBS_CC_22_reportLine("2079", 1)
                            rooibos_common_logError("You have specified a matching function; but it is not in scope!")
                            RBS_CC_22_reportLine("2080", 1)
                            expectedArgsValues.push("#ERR-OUT_OF_SCOPE_MATCHER!")
                        else
                            RBS_CC_22_reportLine("2081", 3)
                            RBS_CC_22_reportLine("2082", 1)
                            expectedArgsValues.push(expectedArgs[i])
                        end if
                    else
                        RBS_CC_22_reportLine("2084", 3)
                        RBS_CC_22_reportLine("2085", 1)
                        expectedArgsValues.push(expectedArgs[i])
                    end if
                else
                    RBS_CC_22_reportLine("2087", 3)
                    RBS_CC_22_reportLine("2088", 1)
                    expectedArgsValues.push("#ERR-UNDEFINED!")
                end if
            else
                RBS_CC_22_reportLine("2090", 3)
                RBS_CC_22_reportLine("2091", 1)
                expectedArgsValues.push(defaultValue)
            end if
        end for
        'todo - make into a class
        RBS_CC_22_reportLine("2095", 1)
        fake = {
            id: id
            target: target
            errorToThrow: invalid
            methodName: methodName
            returnValue: returnValue
            lineNumbers: lineNumbers
            isCalled: false
            invocations: 0
            invokedArgs: [
                invalid
                invalid
                invalid
                invalid
                invalid
                invalid
                invalid
                invalid
                invalid
            ]
            expectedArgs: expectedArgsValues
            expectedInvocations: expectedInvocations
            callback: function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
                RBS_CC_22_reportLine("2118", 1)
                rooibos_common_logTrace(("FAKE CALLBACK CALLED FOR " + bslib_toString(m.methodName)))
                'bs:disable-next-line
                if RBS_CC_22_reportLine("2120", 2) and (m.allInvokedArgs = invalid)
                    RBS_CC_22_reportLine("2120", 3)
                    'bs:disable-next-line
                    RBS_CC_22_reportLine("2122", 1)
                    m.allInvokedArgs = []
                end if
                'bs:disable-next-line
                RBS_CC_22_reportLine("2125", 1)
                m.invokedArgs = [
                    arg1
                    arg2
                    arg3
                    arg4
                    arg5
                    arg6
                    arg7
                    arg8
                    arg9
                    arg10
                    arg11
                    arg12
                    arg13
                    arg14
                    arg15
                ]
                'bs:disable-next-line
                RBS_CC_22_reportLine("2143", 1)
                m.allInvokedArgs.push([
                    arg1
                    arg2
                    arg3
                    arg4
                    arg5
                    arg6
                    arg7
                    arg8
                    arg9
                    arg10
                    arg11
                    arg12
                    arg13
                    arg14
                    arg15
                ])
                'bs:disable-next-line
                RBS_CC_22_reportLine("2161", 1)
                m.isCalled = true
                'bs:disable-next-line
                RBS_CC_22_reportLine("2163", 1)
                m.invocations++
                if RBS_CC_22_reportLine("2164", 2) and (m.errorToThrow <> invalid)
                    RBS_CC_22_reportLine("2164", 3)
                    throw m.errorToThrow
                end if
                'bs:disable-next-line
                if RBS_CC_22_reportLine("2168", 2) and (type(m.returnValue) = "roAssociativeArray" and m.returnValue.ifAssociativeArray.doesExist("multiResult"))
                    RBS_CC_22_reportLine("2168", 3)
                    'bs:disable-next-line
                    RBS_CC_22_reportLine("2170", 1)
                    returnValues = m.returnValue["multiResult"]
                    'bs:disable-next-line
                    RBS_CC_22_reportLine("2172", 1)
                    returnIndex = m.invocations - 1
                    if RBS_CC_22_reportLine("2173", 2) and (type(returnValues) = "roArray" and returnValues.count() > 0)
                        RBS_CC_22_reportLine("2173", 3)
                        'bs:disable-next-line
                        if RBS_CC_22_reportLine("2175", 2) and (returnValues.count() <= m.invocations)
                            RBS_CC_22_reportLine("2175", 3)
                            RBS_CC_22_reportLine("2176", 1)
                            returnIndex = returnValues.count() - 1
                            RBS_CC_22_reportLine("2177", 1)
                            rooibos_common_logDebug("Multi return values all used up - repeating last value")
                        end if
                        RBS_CC_22_reportLine("2179", 1)
                        return returnValues[returnIndex]
                    else
                        RBS_CC_22_reportLine("2180", 3)
                        RBS_CC_22_reportLine("2181", 1)
                        rooibos_common_logError("Multi return value was specified; but no array of results were found")
                        RBS_CC_22_reportLine("2182", 1)
                        return invalid
                    end if
                else
                    RBS_CC_22_reportLine("2184", 3)
                    'bs:disable-next-line
                    RBS_CC_22_reportLine("2186", 1)
                    return m.returnValue
                end if
            end function
            toThrow: function(error)
                RBS_CC_22_reportLine("2190", 1)
                m.errorToThrow = error
            end function
        }
        RBS_CC_22_reportLine("2193", 1)
        return fake
    end function
    RBS_CC_22_reportLine("2195", 1)
    instance.combineFakes = function(fake, otherFake)
        'add on the expected invoked args
        RBS_CC_22_reportLine("2197", 1)
        lineNumber = m.currentAssertLineNumber
        if RBS_CC_22_reportLine("2198", 2) and (type(fake.expectedArgs) <> "roAssociativeArray" or not fake.expectedArgs.ifAssociativeArray.doesExist("multiInvoke"))
            RBS_CC_22_reportLine("2198", 3)
            RBS_CC_22_reportLine("2199", 1)
            currentExpectedArgsArgs = fake.expectedArgs
            RBS_CC_22_reportLine("2200", 1)
            fake.expectedArgs = {
                "multiInvoke": [
                    currentExpectedArgsArgs
                ]
            }
        end if
        RBS_CC_22_reportLine("2206", 1): for i = 1 to otherFake.expectedInvocations
            RBS_CC_22_reportLine("2207", 1)
            fake.expectedArgs.multiInvoke.push(otherFake.expectedArgs)
        end for
        'add on the expected return values
        if RBS_CC_22_reportLine("2210", 2) and (type(fake.returnValue) <> "roAssociativeArray" or not fake.returnValue.ifAssociativeArray.doesExist("multiResult"))
            RBS_CC_22_reportLine("2210", 3)
            RBS_CC_22_reportLine("2211", 1)
            currentReturnValue = fake.returnValue
            RBS_CC_22_reportLine("2212", 1)
            fake.returnValue = {
                "multiResult": [
                    currentReturnValue
                ]
            }
        end if
        RBS_CC_22_reportLine("2218", 1): for i = 1 to otherFake.expectedInvocations
            RBS_CC_22_reportLine("2219", 1)
            fake.returnValue.multiResult.push(otherFake.returnValue)
        end for
        RBS_CC_22_reportLine("2221", 1)
        fake.lineNumbers.push(lineNumber)
        RBS_CC_22_reportLine("2222", 1)
        fake.expectedInvocations += otherFake.expectedInvocations
    end function
    ' Will check all mocks that have been created to ensure they were invoked the expected amount of times, with the expected args.
    RBS_CC_22_reportLine("2225", 1)
    instance.assertMocks = function() as void
        if RBS_CC_22_reportLine("2226", 2) and (m.__mockId = invalid or not rooibos_common_isAssociativeArray(m.mocks))
            RBS_CC_22_reportLine("2226", 3)
            RBS_CC_22_reportLine("2227", 1)
            return
        end if
        RBS_CC_22_reportLine("2229", 1): for each id in m.mocks
            RBS_CC_22_reportLine("2230", 1)
            mock = m.mocks[id]
            RBS_CC_22_reportLine("2231", 1)
            methodName = mock.methodName
            if RBS_CC_22_reportLine("2232", 2) and (mock.expectedInvocations <> mock.invocations)
                RBS_CC_22_reportLine("2232", 3)
                RBS_CC_22_reportLine("2233", 1)
                m.mockFail(mock.lineNumbers[0], methodName, "Wrong number of calls. (" + stri(mock.invocations).trim() + " / " + stri(mock.expectedInvocations).trim() + ")")
                RBS_CC_22_reportLine("2234", 1)
                m.cleanMocks()
                RBS_CC_22_reportLine("2235", 1)
                return
            else if RBS_CC_22_reportLine("2236", 2) and (mock.expectedInvocations > 0 and (rooibos_common_isArray(mock.expectedArgs) or (type(mock.expectedArgs) = "roAssociativeArray" and rooibos_common_isArray(mock.expectedArgs.multiInvoke))))
                RBS_CC_22_reportLine("2236", 3)
                RBS_CC_22_reportLine("2237", 1)
                isMultiArgsSupported = type(mock.expectedArgs) = "roAssociativeArray" and rooibos_common_isArray(mock.expectedArgs.multiInvoke)
                RBS_CC_22_reportLine("2238", 1): for invocationIndex = 0 to mock.invocations - 1
                    RBS_CC_22_reportLine("2239", 1)
                    invokedArgs = mock.allInvokedArgs[invocationIndex]
                    if RBS_CC_22_reportLine("2240", 2) and (isMultiArgsSupported)
                        RBS_CC_22_reportLine("2240", 3)
                        RBS_CC_22_reportLine("2241", 1)
                        expectedArgs = mock.expectedArgs.multiInvoke[invocationIndex]
                    else
                        RBS_CC_22_reportLine("2242", 3)
                        RBS_CC_22_reportLine("2243", 1)
                        expectedArgs = mock.expectedArgs
                    end if
                    if RBS_CC_22_reportLine("2245", 2) and (rooibos_common_isAssociativeArray(expectedArgs))
                        RBS_CC_22_reportLine("2245", 3)
                        RBS_CC_22_reportLine("2246", 1)
                        expectedArgsCount = expectedArgs.ifAssociativeArray.count()
                    else
                        RBS_CC_22_reportLine("2247", 3)
                        RBS_CC_22_reportLine("2248", 1)
                        expectedArgsCount = expectedArgs.count()
                    end if
                    RBS_CC_22_reportLine("2250", 1): for i = 0 to expectedArgsCount - 1
                        RBS_CC_22_reportLine("2251", 1)
                        value = invokedArgs[i]
                        RBS_CC_22_reportLine("2252", 1)
                        expected = expectedArgs[i]
                        RBS_CC_22_reportLine("2253", 1)
                        didNotExpectArg = rooibos_common_isString(expected) and expected = m.invalidValue
                        if RBS_CC_22_reportLine("2254", 2) and (didNotExpectArg)
                            RBS_CC_22_reportLine("2254", 3)
                            RBS_CC_22_reportLine("2255", 1)
                            expected = invalid
                        end if
                        RBS_CC_22_reportLine("2257", 1)
                        isUsingMatcher = rooibos_common_isAssociativeArray(expected) and rooibos_common_isFunction(expected.matcher)
                        if RBS_CC_22_reportLine("2258", 2) and (isUsingMatcher)
                            RBS_CC_22_reportLine("2258", 3)
                            if RBS_CC_22_reportLine("2259", 2) and (not expected.matcher(value))
                                RBS_CC_22_reportLine("2259", 3)
                                RBS_CC_22_reportLine("2260", 1)
                                m.mockFail(mock.lineNumbers[invocationIndex], methodName, "on Invocation #" + stri(invocationIndex).trim() + ", expected arg #" + stri(i).trim() + "  to match matching function '" + rooibos_common_asString(expected.matcher) + "' got '" + rooibos_common_asString(value, true) + "')")
                                RBS_CC_22_reportLine("2261", 1)
                                m.cleanMocks()
                            end if
                        else
                            RBS_CC_22_reportLine("2263", 3)
                            if RBS_CC_22_reportLine("2264", 2) and (not (rooibos_common_isString(expected) and expected = m.ignoreValue) and not rooibos_common_eqValues(value, expected))
                                RBS_CC_22_reportLine("2264", 3)
                                if RBS_CC_22_reportLine("2265", 2) and (expected = invalid)
                                    RBS_CC_22_reportLine("2265", 3)
                                    RBS_CC_22_reportLine("2266", 1)
                                    expected = "[INVALID]"
                                end if
                                RBS_CC_22_reportLine("2268", 1)
                                m.mockFail(mock.lineNumbers[invocationIndex], methodName, "on Invocation #" + stri(invocationIndex).trim() + ", expected arg #" + stri(i).trim() + "  to be '" + rooibos_common_asString(expected, true) + "' got '" + rooibos_common_asString(value, true) + "')")
                                RBS_CC_22_reportLine("2269", 1)
                                m.cleanMocks()
                                RBS_CC_22_reportLine("2270", 1)
                                return
                            end if
                        end if
                    end for
                end for
            end if
        end for
        RBS_CC_22_reportLine("2277", 1)
        m.cleanMocks()
    end function
    ' Cleans up all tracking data associated with mocks
    RBS_CC_22_reportLine("2280", 1)
    instance.cleanMocks = function() as void
        if RBS_CC_22_reportLine("2281", 2) and (m.mocks = invalid)
            RBS_CC_22_reportLine("2281", 3)
            RBS_CC_22_reportLine("2282", 1)
            return
        end if
        RBS_CC_22_reportLine("2284", 1): for each id in m.mocks
            RBS_CC_22_reportLine("2285", 1)
            mock = m.mocks[id]
            RBS_CC_22_reportLine("2286", 1)
            mock.target.__mocks = invalid
        end for
        RBS_CC_22_reportLine("2288", 1)
        m.mocks = invalid
        RBS_CC_22_reportLine("2289", 1)
        rooibos_resetMocksByFunctionName()
    end function
    ' Cleans up all tracking data associated with stubs
    RBS_CC_22_reportLine("2292", 1)
    instance.cleanStubs = function() as void
        ' Clean up the global functions mocks as well
        RBS_CC_22_reportLine("2294", 1)
        globalAa = getGlobalAa()
        RBS_CC_22_reportLine("2295", 1)
        globalAa.__globalStubs = invalid
        if RBS_CC_22_reportLine("2296", 2) and (m.stubs = invalid)
            RBS_CC_22_reportLine("2296", 3)
            RBS_CC_22_reportLine("2297", 1)
            return
        end if
        RBS_CC_22_reportLine("2299", 1): for each id in m.stubs
            RBS_CC_22_reportLine("2300", 1)
            stub = m.stubs[id]
            RBS_CC_22_reportLine("2301", 1)
            stub.target.__stubs = invalid
        end for
        RBS_CC_22_reportLine("2303", 1)
        m.stubs = invalid
        RBS_CC_22_reportLine("2304", 1)
        rooibos_resetMocksByFunctionName()
    end function
    RBS_CC_22_reportLine("2306", 1)
    instance.mockFail = function(lineNumber, methodName, message) as dynamic
        if RBS_CC_22_reportLine("2307", 2) and (m.currentResult.isFail)
            RBS_CC_22_reportLine("2307", 3)
            RBS_CC_22_reportLine("2308", 1)
            return false
        end if
        RBS_CC_22_reportLine("2310", 1)
        m.fail("mock failure on '" + methodName + "' : " + message, "", "", true)
        RBS_CC_22_reportLine("2311", 1)
        return false
    end function
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    '++ Fake Stub callback functions - this is required to get scope
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ' @ignore
    RBS_CC_22_reportLine("2317", 1)
    instance.stubCallback0 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2319", 1)
        fake = m.__Stubs["0"]
        RBS_CC_22_reportLine("2320", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2323", 1)
    instance.stubCallback1 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2325", 1)
        fake = m.__Stubs["1"]
        RBS_CC_22_reportLine("2326", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2329", 1)
    instance.stubCallback2 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2331", 1)
        fake = m.__Stubs["2"]
        RBS_CC_22_reportLine("2332", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2335", 1)
    instance.stubCallback3 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2337", 1)
        fake = m.__Stubs["3"]
        RBS_CC_22_reportLine("2338", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2341", 1)
    instance.stubCallback4 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2343", 1)
        fake = m.__Stubs["4"]
        RBS_CC_22_reportLine("2344", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2347", 1)
    instance.stubCallback5 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2349", 1)
        fake = m.__Stubs["5"]
        RBS_CC_22_reportLine("2350", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2353", 1)
    instance.stubCallback6 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2355", 1)
        fake = m.__Stubs["6"]
        RBS_CC_22_reportLine("2356", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2359", 1)
    instance.stubCallback7 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2361", 1)
        fake = m.__Stubs["7"]
        RBS_CC_22_reportLine("2362", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2365", 1)
    instance.stubCallback8 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2367", 1)
        fake = m.__Stubs["8"]
        RBS_CC_22_reportLine("2368", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2371", 1)
    instance.stubCallback9 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2373", 1)
        fake = m.__Stubs["9"]
        RBS_CC_22_reportLine("2374", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2377", 1)
    instance.stubCallback10 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2379", 1)
        fake = m.__Stubs["10"]
        RBS_CC_22_reportLine("2380", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2383", 1)
    instance.stubCallback11 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2385", 1)
        fake = m.__Stubs["11"]
        RBS_CC_22_reportLine("2386", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2389", 1)
    instance.stubCallback12 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2391", 1)
        fake = m.__Stubs["12"]
        RBS_CC_22_reportLine("2392", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2395", 1)
    instance.stubCallback13 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2397", 1)
        fake = m.__Stubs["13"]
        RBS_CC_22_reportLine("2398", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2401", 1)
    instance.stubCallback14 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2403", 1)
        fake = m.__Stubs["14"]
        RBS_CC_22_reportLine("2404", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2407", 1)
    instance.stubCallback15 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2409", 1)
        fake = m.__Stubs["15"]
        RBS_CC_22_reportLine("2410", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2413", 1)
    instance.stubCallback16 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2415", 1)
        fake = m.__Stubs["16"]
        RBS_CC_22_reportLine("2416", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2419", 1)
    instance.stubCallback17 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2421", 1)
        fake = m.__Stubs["17"]
        RBS_CC_22_reportLine("2422", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2425", 1)
    instance.stubCallback18 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2427", 1)
        fake = m.__Stubs["18"]
        RBS_CC_22_reportLine("2428", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2431", 1)
    instance.stubCallback19 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2433", 1)
        fake = m.__Stubs["19"]
        RBS_CC_22_reportLine("2434", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2437", 1)
    instance.stubCallback20 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2439", 1)
        fake = m.__Stubs["20"]
        RBS_CC_22_reportLine("2440", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2443", 1)
    instance.stubCallback21 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2445", 1)
        fake = m.__Stubs["21"]
        RBS_CC_22_reportLine("2446", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2449", 1)
    instance.stubCallback22 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2451", 1)
        fake = m.__Stubs["22"]
        RBS_CC_22_reportLine("2452", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2455", 1)
    instance.stubCallback23 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2457", 1)
        fake = m.__Stubs["23"]
        RBS_CC_22_reportLine("2458", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2461", 1)
    instance.stubCallback24 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2463", 1)
        fake = m.__Stubs["24"]
        RBS_CC_22_reportLine("2464", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2467", 1)
    instance.stubCallback25 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2469", 1)
        fake = m.__Stubs["25"]
        RBS_CC_22_reportLine("2470", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    '++ Fake Mock callback functions - this is required to get scope
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ' @ignore
    RBS_CC_22_reportLine("2476", 1)
    instance.mockCallback0 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2478", 1)
        fake = m.__mocks["0"]
        RBS_CC_22_reportLine("2479", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2482", 1)
    instance.mockCallback1 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2484", 1)
        fake = m.__mocks["1"]
        RBS_CC_22_reportLine("2485", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2488", 1)
    instance.mockCallback2 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2490", 1)
        fake = m.__mocks["2"]
        RBS_CC_22_reportLine("2491", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    RBS_CC_22_reportLine("2493", 1)
    instance.mockCallback3 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2495", 1)
        fake = m.__mocks["3"]
        RBS_CC_22_reportLine("2496", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2499", 1)
    instance.mockCallback4 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2501", 1)
        fake = m.__mocks["4"]
        RBS_CC_22_reportLine("2502", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2505", 1)
    instance.mockCallback5 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2507", 1)
        fake = m.__mocks["5"]
        RBS_CC_22_reportLine("2508", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2511", 1)
    instance.mockCallback6 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2513", 1)
        fake = m.__mocks["6"]
        RBS_CC_22_reportLine("2514", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2517", 1)
    instance.mockCallback7 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2519", 1)
        fake = m.__mocks["7"]
        RBS_CC_22_reportLine("2520", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2523", 1)
    instance.mockCallback8 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2525", 1)
        fake = m.__mocks["8"]
        RBS_CC_22_reportLine("2526", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2529", 1)
    instance.mockCallback9 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2531", 1)
        fake = m.__mocks["9"]
        RBS_CC_22_reportLine("2532", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2535", 1)
    instance.mockCallback10 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2537", 1)
        fake = m.__mocks["10"]
        RBS_CC_22_reportLine("2538", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2541", 1)
    instance.mockCallback11 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2543", 1)
        fake = m.__mocks["11"]
        RBS_CC_22_reportLine("2544", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2547", 1)
    instance.mockCallback12 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2549", 1)
        fake = m.__mocks["12"]
        RBS_CC_22_reportLine("2550", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2553", 1)
    instance.mockCallback13 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2555", 1)
        fake = m.__mocks["13"]
        RBS_CC_22_reportLine("2556", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2559", 1)
    instance.mockCallback14 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2561", 1)
        fake = m.__mocks["14"]
        RBS_CC_22_reportLine("2562", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2565", 1)
    instance.mockCallback15 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2567", 1)
        fake = m.__mocks["15"]
        RBS_CC_22_reportLine("2568", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2571", 1)
    instance.mockCallback16 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2573", 1)
        fake = m.__mocks["16"]
        RBS_CC_22_reportLine("2574", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2577", 1)
    instance.mockCallback17 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2579", 1)
        fake = m.__mocks["17"]
        RBS_CC_22_reportLine("2580", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2583", 1)
    instance.mockCallback18 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2585", 1)
        fake = m.__mocks["18"]
        RBS_CC_22_reportLine("2586", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2589", 1)
    instance.mockCallback19 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2591", 1)
        fake = m.__mocks["19"]
        RBS_CC_22_reportLine("2592", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2595", 1)
    instance.mockCallback20 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2597", 1)
        fake = m.__mocks["20"]
        RBS_CC_22_reportLine("2598", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2601", 1)
    instance.mockCallback21 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2603", 1)
        fake = m.__mocks["21"]
        RBS_CC_22_reportLine("2604", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2607", 1)
    instance.mockCallback22 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2609", 1)
        fake = m.__mocks["22"]
        RBS_CC_22_reportLine("2610", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2613", 1)
    instance.mockCallback23 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2615", 1)
        fake = m.__mocks["23"]
        RBS_CC_22_reportLine("2616", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    RBS_CC_22_reportLine("2619", 1)
    instance.mockCallback24 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        RBS_CC_22_reportLine("2621", 1)
        fake = m.__mocks["24"]
        RBS_CC_22_reportLine("2622", 1)
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    '++ crude async support
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ' observeField doesn't work in regular unit tests, so we have to wait for the result. We can use this to wait for a network task, foe example, and pass the result directly to a handler. Note - we wait for the value TO CHANGE - so make sure that will be the case, or you'll get stuck forever :)
    ' @param {any} target to observe
    ' @param {string} field to observe
    ' @param {int} delay for each wait
    ' @param {int} max attempts
    RBS_CC_22_reportLine("2632", 1)
    instance.waitForField = function(target, fieldName, delay = 500, maxAttempts = 10)
        RBS_CC_22_reportLine("2633", 1)
        attempts = 0
        if RBS_CC_22_reportLine("2634", 2) and (target = invalid)
            RBS_CC_22_reportLine("2634", 3)
            RBS_CC_22_reportLine("2635", 1)
            return false
        end if
        RBS_CC_22_reportLine("2637", 1)
        initialValue = target[fieldName]
        RBS_CC_22_reportLine("2638", 1): while target[fieldName] = initialValue
            RBS_CC_22_reportLine("2639", 1)
            port = CreateObject("roMessagePort")
            RBS_CC_22_reportLine("2640", 1)
            wait(delay, port)
            RBS_CC_22_reportLine("2641", 1)
            attempts++
            if RBS_CC_22_reportLine("2642", 2) and (attempts = maxAttempts)
                RBS_CC_22_reportLine("2642", 3)
                RBS_CC_22_reportLine("2643", 1)
                return false
            end if
            RBS_CC_22_reportLine("2645", 1)
            rooibos_common_logDebug(("Waiting for signal field '" + bslib_toString(fieldName) + "' - " + bslib_toString(attempts)))
        end while
        RBS_CC_22_reportLine("2647", 1)
        return true
    end function
    RBS_CC_22_reportLine("2649", 1)
    instance.wait = function(delay = 1)
        RBS_CC_22_reportLine("2650", 1)
        port = CreateObject("roMessagePort")
        RBS_CC_22_reportLine("2651", 1)
        wait(delay, port)
    end function
    RBS_CC_22_reportLine("2653", 1)
    instance.done = function()
        RBS_CC_22_reportLine("2654", 1)
        rooibos_common_logTrace("Async test is complete")
        if RBS_CC_22_reportLine("2655", 2) and (m.isDoneCalled = false)
            RBS_CC_22_reportLine("2655", 3)
            RBS_CC_22_reportLine("2656", 1)
            m.isDoneCalled = true
            RBS_CC_22_reportLine("2657", 1)
            deferred = m.currentGroup?.currentTest?.deferred
            if RBS_CC_22_reportLine("2658", 2) and (rooibos_promises_isPromise(deferred))
                RBS_CC_22_reportLine("2658", 3)
                RBS_CC_22_reportLine("2659", 1)
                rooibos_promises_resolve(true, deferred)
            end if
        else
            RBS_CC_22_reportLine("2661", 3)
            RBS_CC_22_reportLine("2662", 1)
            rooibos_common_logWarning("extra done call after test is done! Did you properly clean up your observers?")
        end if
    end function
    ' @ignore
    RBS_CC_22_reportLine("2666", 1)
    instance.testSuiteDone = function()
        RBS_CC_22_reportLine("2667", 1)
        rooibos_common_logTrace("Indicating test suite is done")
        RBS_CC_22_reportLine("2668", 1)
        m.notifyReportersOnSuiteComplete()
        RBS_CC_22_reportLine("2669", 1)
        m.testRunner.top.rooibosTestResult = {
            stats: m.stats
            tests: m.tests
            groups: m.groups
        }
    end function
    RBS_CC_22_reportLine("2675", 1)
    instance.assertAsyncField = function(target, fieldName, delay = 500, maxAttempts = 10)
        try
            if RBS_CC_22_reportLine("2677", 2) and (m.currentResult.isFail)
                RBS_CC_22_reportLine("2677", 3)
                RBS_CC_22_reportLine("2678", 1)
                return false
            end if
            if RBS_CC_22_reportLine("2680", 2) and (target = invalid)
                RBS_CC_22_reportLine("2680", 3)
                RBS_CC_22_reportLine("2681", 1)
                m.fail("Target was invalid", "", "", true)
            end if
            RBS_CC_22_reportLine("2683", 1)
            result = m.waitForField(target, fieldName, delay, maxAttempts)
            if RBS_CC_22_reportLine("2684", 2) and (not result)
                RBS_CC_22_reportLine("2684", 3)
                RBS_CC_22_reportLine("2685", 1)
                return m.fail("Timeout waiting for targetField " + fieldName + " to be set on target", "", "", true)
            end if
            RBS_CC_22_reportLine("2687", 1)
            return true
        catch error
            'bs:disable-next-line
            RBS_CC_22_reportLine("2690", 1)
            m.currentResult.fail("Error while waiting: " + error.message, m.currentAssertLineNumber)
        end try
        RBS_CC_22_reportLine("2692", 1)
        return false
    end function
    ' @ignore
    RBS_CC_22_reportLine("2695", 1)
    instance.createNodeClass = function(clazz, useClassAsTop = true, nodeTop = rooibos_utils_MockNode("top"), nodeGlobal = rooibos_utils_MockNode("top"))
        'bs:disable-next-line
        RBS_CC_22_reportLine("2697", 1)
        instance = tests_maestro_nodeClassUtils_createNodeClass(clazz, nodeTop, nodeGlobal)
        if RBS_CC_22_reportLine("2698", 2) and (instance <> invalid and useClassAsTop)
            RBS_CC_22_reportLine("2698", 3)
            'note - we use the clazz itself as TOP, so that we don't have to write tests that do
            'thing.top.value, thing.top.value2, etc all over the place
            RBS_CC_22_reportLine("2701", 1)
            instance.append(nodeTop)
            RBS_CC_22_reportLine("2702", 1)
            instance.top = instance
            RBS_CC_22_reportLine("2703", 1)
            instance.__rooibosSkipFields = {
                "top": true
            }
        end if
        RBS_CC_22_reportLine("2707", 1)
        return instance
    end function
    ' @ignore
    RBS_CC_22_reportLine("2710", 1)
    instance.createMockViews = function(instance as dynamic, bundlePath as string, viewsPath = "views" as string)
        RBS_CC_22_reportLine("2711", 1)
        bundle = m.global.testStyleManager.callfunc("loadBundle", bundlePath)
        'bs:disable-next-line
        RBS_CC_22_reportLine("2713", 1)
        ids = mv_getIdsFromStyleJson(mc_getArray(bundle, viewsPath))
        RBS_CC_22_reportLine("2714", 1): for each id in ids
            RBS_CC_22_reportLine("2715", 1)
            instance[id] = {
                id: id
            }
        end for
    end function
    ' @ignore
    RBS_CC_22_reportLine("2721", 1)
    instance.notifyReportersOnSuiteBegin = sub()
        RBS_CC_22_reportLine("2722", 1): for each reporter in m.testReporters
            if RBS_CC_22_reportLine("2723", 2) and (rooibos_common_isFunction(reporter.onSuiteBegin))
                RBS_CC_22_reportLine("2723", 3)
                RBS_CC_22_reportLine("2724", 1)
                reporter.onSuiteBegin({
                    suite: m
                })
            end if
        end for
    end sub
    ' @ignore
    RBS_CC_22_reportLine("2731", 1)
    instance.notifyReportersOnSuiteComplete = sub()
        RBS_CC_22_reportLine("2732", 1): for each reporter in m.testReporters
            if RBS_CC_22_reportLine("2733", 2) and (rooibos_common_isFunction(reporter.onSuiteComplete))
                RBS_CC_22_reportLine("2733", 3)
                RBS_CC_22_reportLine("2734", 1)
                reporter.onSuiteComplete({
                    suite: m
                })
            end if
        end for
    end sub
    RBS_CC_22_reportLine("2740", 1)
    return instance
end function

function rooibos_BaseTestSuite()
    RBS_CC_22_reportLine("2743", 1)
    instance = __rooibos_BaseTestSuite_builder()
    RBS_CC_22_reportLine("2744", 1)
    instance.new()
    RBS_CC_22_reportLine("2745", 1)
    return instance
end function

' @ignore
function rooibos_getMocksByFunctionName()
    if RBS_CC_22_reportLine("2750", 2) and (m._rMocksByFunctionName = invalid)
        RBS_CC_22_reportLine("2750", 3)
        RBS_CC_22_reportLine("2751", 1)
        m._rMocksByFunctionName = {}
    end if
    RBS_CC_22_reportLine("2753", 1)
    return m._rMocksByFunctionName
end function

' @ignore
function rooibos_resetMocksByFunctionName()
    RBS_CC_22_reportLine("2758", 1)
    m._rMocksByFunctionName = invalid
end function

' @ignore
function rooibos_getMockForFunction(functionName as string)
    RBS_CC_22_reportLine("2763", 1)
    return rooibos_getMocksByFunctionName()[functionName]
end function

' @ignore
function rooibos_isFunctionMocked(functionName as string)
    RBS_CC_22_reportLine("2768", 1)
    return rooibos_getMockForFunction(functionName) <> invalid
end function

'//# sourceMappingURL=./BaseTestSuite.brs.map
function RBS_CC_22_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "22"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "22"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./BaseTestSuite.brs.map