function __rooibos_BaseTestSuite_builder()
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
    instance.new = function()
        m.name = "BaseTestSuite"
        m.filePath = invalid
        m.pkgPath = invalid
        m.isValid = false
        m.hasSoloTests = false
        m.hasIgnoredTests = false
        m.isSolo = false
        m.isIgnored = false
        m.noCatch = false
        m.isNodeTest = false
        m.nodeName = invalid
        m.lineNumber = 1
        m.groups = []
        m.groupsData = []
        m.stats = invalid
        m.currentAssertLineNumber = -1
        m.valid = false
        m.hasFailures = false
        m.hasSoloGroups = false
        m.isFailingFast = false
        m.stubs = invalid
        m.mocks = invalid
        m.__stubId = -1
        m.__mockId = -1
        m.__mockTargetId = -1
        m.currentExecutionTime = 0
        m.timedOut = false
        m.deferred = invalid
        m.invalidValue = "#ROIBOS#INVALID_VALUE"
        m.ignoreValue = "#ROIBOS#IGNORE_VALUE"
        m.anyStringMatcher = {
            "matcher": Rooibos_Matcher_anyString
        }
        m.anyBoolMatcher = {
            "matcher": Rooibos_Matcher_anyBool
        }
        m.anyNumberMatcher = {
            "matcher": Rooibos_Matcher_anyNumber
        }
        m.anyAAMatcher = {
            "matcher": Rooibos_Matcher_anyAA
        }
        m.anyArrayMatcher = {
            "matcher": Rooibos_Matcher_anyArray
        }
        m.anyNodeMatcher = {
            "matcher": Rooibos_Matcher_anyNode
        }
        m.allowNonExistingMethodsOnMocks = true
        m.isAutoAssertingMocks = true
        m.currentResult = invalid
        m.global = invalid
        m.catchCrashes = false
        m.throwOnFailedAssertion = false
        data = m.getTestSuitedata()
        if data = invalid
            rooibos_common_logError("ERROR RETRIEVING TEST SUITE DATA!! this is a rooibos BUG - please report the suite that resulted in a corrupt test. Thanks")
        else
            m.name = data.name
            m.filePath = data.filePath
            m.pkgPath = data.pkgPath
            m.valid = data.valid
            m.hasFailures = data.hasFailures
            m.hasSoloTests = data.hasSoloTests
            m.hasIgnoredTests = data.hasIgnoredTests
            m.hasSoloGroups = data.hasSoloGroups
            m.isSolo = data.isSolo
            m.isIgnored = data.isIgnored
            m.isAsync = data.isAsync
            m.asyncTimeout = data.asyncTimeout
            m.noCatch = data.noCatch
            m.groupsData = data.testGroups
            m.lineNumber = data.lineNumber
            m.isNodeTest = data.isNodeTest
            m.nodeName = data.nodeName
            m.generatedNodeName = data.generatedNodeName
            m.isFailingFast = false
            if m.isNodeTest
                m.deferred = rooibos_promises_create()
            end if
            m.stats = rooibos_Stats()
        end if
    end function
    ' @ignore
    instance.getTestSuiteData = function()
        'this will be injected by the plugin
    end function
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    '++ used for entire suite - use annotations to use elsewhere
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    instance.setup = function()
    end function
    instance.tearDown = function()
    end function
    instance.beforeEach = function()
    end function
    instance.afterEach = function()
    end function
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    '++ running
    '++++++++++++++++++++++++++++++++++++?+++++++++++++++++++++++++
    ' @ignore
    instance.run = function()
        m.notifyReportersOnSuiteBegin()
        rooibos_common_logTrace(">>>>>>>>>>>>")
        rooibos_common_logTrace("RUNNING TEST SUITE")
        if m.isNodeTest = true
            rooibos_common_logTrace("THIS GROUP IS ASYNC")
            m.runAsync()
        else
            rooibos_common_logTrace("THIS GROUP IS SYNC")
            m.runSync()
        end if
    end function
    ' @ignore
    instance.runSync = function()
        for each groupData in m.groupsData
            'bs:disable-next-line
            group = rooibos_TestGroup(m, groupData)
            'bs:disable-next-line
            m.groups.push(group)
            'bs:disable-next-line
            group.run()
            'bs:disable-next-line
            m.stats.merge(group.stats)
            if m.stats.hasFailures and m.isFailingFast = true
                rooibos_common_logDebug("Terminating suite due to failed group")
                exit for
            end if
        end for
        m.notifyReportersOnSuiteComplete()
    end function
    ' @ignore
    instance.runASync = function()
        rooibos_common_logTrace("Running groups async")
        m.groups = []
        for each groupData in m.groupsData
            'bs:disable-next-line
            group = rooibos_TestGroup(m, groupData)
            m.groups.push(group)
        end for
        m.currentGroupIndex = -1
        m.runNextAsync()
    end function
    ' @ignore
    instance.runNextAsync = function()
        rooibos_common_logTrace("Getting next async group")
        m.currentGroupIndex++
        m.currentGroup = m.groups[m.currentGroupIndex]
        if m.currentGroup = invalid
            rooibos_common_logTrace("All groups are finished")
            'finished
            m.testSuiteDone()
        else
            group = m.currentGroup
            group.run()
            if rooibos_promises_isPromise(group.deferred)
                rooibos_promises_onFinally(group.deferred, sub(context)
                    context.self.onAsyncGroupComplete(context.group)
                end sub, {
                    group: group
                    self: m
                })
            else
                m.onAsyncGroupComplete(group)
            end if
        end if
    end function
    ' @ignore
    instance.onAsyncGroupComplete = function(group = invalid) as void
        rooibos_common_logTrace("++ CURRENT GROUP COMPLETED")
        group = (function(__bsCondition, group, m)
                if __bsCondition then
                    return m.currentGroup
                else
                    return group
                end if
            end function)(group = invalid, group, m)
        if group = invalid
            rooibos_common_logError("Cannot find test group to mark async finished for?!")
            return
        end if
        'bs:disable-next-line
        m.stats.merge(group.stats)
        if m.stats.hasFailures and m.isFailingFast
            rooibos_common_logTrace("Terminating group due to failed test")
            m.isTestFailedDueToEarlyExit = true
            m.testSuiteDone()
        else
            m.runNextAsync()
        end if
    end function
    ' calculate if the suite has timed out. Will return true if the suite flipped the timedOut flag
    ' @ignore
    instance.isSuiteTimedOut = function()
        if m.isNodeTest and m.asyncTimeout > 0 and m.currentExecutionTime >= m.asyncTimeout
            m.timedOut = true
            return true
        end if
        return false
    end function
    ' @ignore
    instance.runTest = function(test as object)
        m.currentResult = test.result
        if test.isIgnored
            m.currentResult.skip("Test is ignored")
            return invalid
        end if
        ' Fail the test if the suite has timed out.
        ' Currently, this will only happen if the suite is a node test.
        if m.isNodeTest and m.timedOut
            m.currentResult.fail("Suite test execution exceeded " + m.asyncTimeout.toStr() + "ms")
            return invalid
        end if
        m.currentAssertLineNumber = -1
        m.currentResult.throwOnFailedAssertion = m.throwOnFailedAssertion
        if m.catchCrashes and not test.noCatch and not m.noCatch
            try
                test.run()
                if m.isAutoAssertingMocks = true and test.deferred = invalid
                    m.AssertMocks()
                    m.CleanMocks()
                    m.CleanStubs()
                end if
            catch error
                'bs:disable-next-line
                m.currentResult.crash("test crashed!", error)
                if rooibos_promises_isPromise(test.deferred)
                    rooibos_promises_reject(error, test.deferred)
                end if
            end try
        else
            test.run()
            if m.isAutoAssertingMocks = true and test.deferred = invalid
                m.AssertMocks()
                m.CleanMocks()
                m.CleanStubs()
            end if
        end if
        return test.deferred
    end function
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    '++ Assertions
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ' Fail immediately, with the given message
    ' @param {Dynamic} [msg=""] - message to display in the test report
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.fail = function(msg = "Error" as string, actual = "" as string, expected = "" as string, createError = false as boolean) as dynamic
        if m.currentResult.isFail
            if m.throwOnFailedAssertion
                throw m.currentResult.getMessage()
            end if
            return false
        end if
        error = invalid
        if createError
            try
                throw msg
            catch error
            end try
        end if
        m.currentResult.fail(msg, m.currentAssertLineNumber, actual, expected, error)
        return false
    end function
    ' Fail immediately, with the given message
    ' @ignore
    ' @param {Dynamic} [msg=""] - message to display in the test report
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.skip = function(msg = "Skipped" as string) as dynamic
        if m.currentResult.isFail
            if m.throwOnFailedAssertion
                throw m.currentResult.getMessage()
            end if
            return false
        end if
        m.currentResult.skip(msg)
        return false
    end function
    ' Fail immediately, with the given exception
    ' @param {Dynamic} [error] - exception to fail on
    ' @param {Dynamic} [msg=""] - message to display in the test report
    ' @returns {boolean} - true if failure was set, false if the test is already failed
    instance.failCrash = function(error as dynamic, msg = "" as string) as dynamic
        if m.currentResult.isFail
            if m.throwOnFailedAssertion
                throw m.currentResult.getMessage()
            end if
            return false
        end if
        if msg = ""
            msg = error.message
        end if
        m.currentResult.fail(msg, m.currentAssertLineNumber)
        m.currentResult.crash(msg, error)
        return true
    end function
    instance.failBecauseOfTimeOut = function() as dynamic
        if m.currentResult.isFail
            return false
        end if
        m.currentResult.fail("Async test execution exceeded " + m.currentTimeout.toStr() + "ms")
        m.done()
        return false
    end function
    ' Fail the test if the expression is true.
    ' @param {Dynamic} expr - An expression to evaluate.
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertFalse = function(expr as dynamic, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if not rooibos_common_isBoolean(expr) or expr
                actual = rooibos_common_asMultilineString(expr, true)
                expected = rooibos_common_asMultilineString(false, true)
                if msg = ""
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be " + bslib_toString(rooibos_common_truncateString(expected)))
                end if
                return m.fail(msg, actual, expected, true)
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Fail the test unless the expression is true.
    ' @param {Dynamic} expr - An expression to evaluate.
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertTrue = function(expr, msg = "")
        if m.currentResult.isFail
            return false
        end if
        try
            if not rooibos_common_isBoolean(expr) or not expr
                actual = rooibos_common_asMultilineString(expr, true)
                expected = rooibos_common_asMultilineString(true, true)
                if msg = ""
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be " + bslib_toString(rooibos_common_truncateString(expected)))
                end if
                return m.fail(msg, actual, expected, true)
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Fail if the two objects are unequal as determined by the '<>' operator.
    ' @param {Dynamic} first - first object to compare
    ' @param {Dynamic} second - second object to compare
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertEqual = function(first, second, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if not rooibos_common_eqValues(first, second)
                actual = rooibos_common_asMultilineString(first, true)
                expected = rooibos_common_asMultilineString(second, true)
                if msg = ""
                    messageActual = rooibos_common_truncateString(actual)
                    messageExpected = rooibos_common_truncateString(expected)
                    msg = ("expected " + chr(34) + bslib_toString(messageActual) + chr(34) + " to equal " + chr(34) + bslib_toString(messageExpected) + chr(34))
                end if
                m.fail(msg, actual, expected, true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' does a fuzzy comparison
    ' @param {Dynamic} first - first object to compare
    ' @param {Dynamic} second - second object to compare
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertLike = function(first, second, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if not rooibos_common_eqValues(first, second, true)
                actual = rooibos_common_asMultilineString(first, true)
                expected = rooibos_common_asMultilineString(second, true)
                if msg = ""
                    messageActual = rooibos_common_truncateString(actual)
                    messageExpected = rooibos_common_truncateString(expected)
                    msg = ("expected " + chr(34) + bslib_toString(messageActual) + chr(34) + " to be like " + chr(34) + bslib_toString(messageExpected) + chr(34))
                end if
                m.fail(msg, actual, expected, true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Fail if the two objects are equal as determined by the '=' operator.
    ' @param {Dynamic} first - first object to compare
    ' @param {Dynamic} second - second object to compare
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertNotEqual = function(first, second, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if rooibos_common_eqValues(first, second)
                actual = rooibos_common_asMultilineString(first, true)
                expected = rooibos_common_asMultilineString(second, true)
                if msg = ""
                    messageActual = rooibos_common_truncateString(actual)
                    messageExpected = rooibos_common_truncateString(expected)
                    msg = ("expected " + chr(34) + bslib_toString(messageActual) + chr(34) + " to not equal " + chr(34) + bslib_toString(messageExpected) + chr(34))
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Fail if the value is not invalid.
    ' @param {Dynamic} value - value to check - value to check for
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertInvalid = function(value, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if rooibos_common_getSafeType(value) <> "Invalid"
                if msg = ""
                    actual = rooibos_common_asMultilineString(value, true)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be invalid")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Fail if the value is invalid.
    ' @param {Dynamic} value - value to check - value to check for
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertNotInvalid = function(value, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if rooibos_common_getSafeType(value) = "Invalid"
                if msg = ""
                    actual = rooibos_common_asMultilineString(value, true)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to not be invalid")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Fail if the aa doesn't have the key.
    ' @param {Dynamic} aa - target aa
    ' @param {Dynamic} key - key name
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertAAHasKey = function(aa, key, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if not rooibos_common_isAssociativeArray(aa)
                if msg = ""
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(aa, true))) + chr(34) + " to be an AssociativeArray")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            if not aa.ifAssociativeArray.DoesExist(key)
                if msg = ""
                    actual = rooibos_common_asMultilineString(aa, true)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to have property " + chr(34) + bslib_toString(key) + chr(34))
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Fail if the aa has the key.
    ' @param {Dynamic} aa - target aa
    ' @param {Dynamic} key - key name
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertAANotHasKey = function(aa, key, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if not rooibos_common_isAssociativeArray(aa)
                if msg = ""
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(aa, true))) + chr(34) + " to be an AssociativeArray")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            if aa.ifAssociativeArray.DoesExist(key)
                if msg = ""
                    actual = rooibos_common_asMultilineString(aa, true)
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to not have property " + chr(34) + bslib_toString(key) + chr(34))
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Fail if the aa doesn't have the keys list.
    ' @param {Dynamic} aa - A target associative array.
    ' @param {Dynamic} keys - Array of key names.
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertAAHasKeys = function(aa, keys, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if not rooibos_common_isAssociativeArray(aa)
                if msg = ""
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(aa, true))) + chr(34) + " to be an AssociativeArray")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            if not rooibos_common_isArray(keys)
                if msg = ""
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(keys, true))) + chr(34) + " to be an Array")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            foundKeys = []
            missingKeys = []
            for each key in keys
                if not aa.ifAssociativeArray.DoesExist(key)
                    missingKeys.push(key)
                else
                    foundKeys.push(key)
                end if
            end for
            if missingKeys.count() > 0
                actual = rooibos_common_asMultilineString(foundKeys, true)
                expected = rooibos_common_asMultilineString(keys, true)
                if msg = ""
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(aa, true))) + chr(34) + " to have properties " + bslib_toString(rooibos_common_truncateString(missingKeys.join(", "))))
                end if
                m.fail(msg, actual, expected, true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Fail if the aa has the keys list.
    ' @param {Dynamic} aa - A target associative array.
    ' @param {Dynamic} keys - Array of key names.
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertAANotHasKeys = function(aa, keys, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if not rooibos_common_isAssociativeArray(aa)
                if msg = ""
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(aa, true))) + chr(34) + " to be an AssociativeArray")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            if not rooibos_common_isArray(keys)
                if msg = ""
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(keys, true))) + chr(34) + " to be an Array")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            foundKeys = []
            for each key in keys
                if aa.ifAssociativeArray.DoesExist(key)
                    foundKeys.push(formatJson(key))
                end if
            end for
            if foundKeys.count() > 0
                if msg = ""
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(aa, true))) + chr(34) + " to not have properties " + bslib_toString(rooibos_common_truncateString(foundKeys.join(", "))))
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Fail if the array doesn't have the item.
    ' @param {Dynamic} array - target array
    ' @param {Dynamic} value - value to check - value to check for
    ' @param {Dynamic} key - key name in associative array
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertArrayContains = function(array, value, key = invalid, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if not rooibos_common_isAssociativeArray(array) and not rooibos_common_isArray(array)
                if msg = ""
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to be an AssociativeArray or Array")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            if not rooibos_common_arrayContains(array, value, key)
                if msg = ""
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to contain " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(value, true))) + chr(34))
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Fail if the array does not contain all of the aa's in the values array.
    ' @param {Dynamic} array - target array
    ' @param {Dynamic} values - array of aas to look for in target array
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertArrayContainsAAs = function(array, values, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if not rooibos_common_isArray(values)
                if msg = ""
                    msg = ("expected value " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(values, true))) + chr(34) + " must be an Array")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            if not rooibos_common_isArray(array)
                if msg = ""
                    msg = ("actual value " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " must be an Array")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            for each value in values
                isMatched = false
                if not rooibos_common_isAssociativeArray(value)
                    if msg = ""
                        msg = ("expected search value " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(value, true))) + chr(34) + " to be an AssociativeArray")
                    end if
                    m.fail(msg, "", "", true)
                    return false
                end if
                for each item in array
                    if rooibos_common_IsAssociativeArray(item)
                        isValueMatched = true
                        for each key in value
                            fieldValue = value[key]
                            itemValue = item[key]
                            if not rooibos_common_eqValues(fieldValue, itemValue)
                                isValueMatched = false
                                exit for
                            end if
                        end for
                        if isValueMatched
                            isMatched = true
                            exit for
                        end if
                    end if
                end for ' items in array
                if not isMatched
                    if msg = ""
                        msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to contain " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(value, true))) + chr(34))
                    end if
                    m.fail(msg, "", "", true)
                    return false
                end if
            end for 'values to match
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Fail if the array has the item.
    ' @param {Dynamic} array - target array
    ' @param {Dynamic} array - target array
    ' @param {Dynamic} value - value to check - Value to check for
    ' @param {Dynamic} key - A key name for associative array.
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertArrayNotContains = function(array, value, key = invalid, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if not rooibos_common_isAssociativeArray(array) and not rooibos_common_isArray(array)
                if msg = ""
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to be an AssociativeArray or Array")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            if rooibos_common_arrayContains(array, value, key)
                if msg = ""
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to not contain " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(value, true))) + chr(34))
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Fail if the array doesn't have the item subset.
    ' @param {Dynamic} array - target array
    ' @param {Dynamic} subset - items to check presence of
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertArrayContainsSubset = function(array, subset, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if not rooibos_common_isAssociativeArray(array) and not rooibos_common_isArray(array)
                if msg = ""
                    msg = ("expected target " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to be an AssociativeArray or Array")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            if not rooibos_common_isAssociativeArray(subset) and not rooibos_common_isArray(subset)
                if msg = ""
                    msg = ("expected subset " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(subset, true))) + chr(34) + " to be an AssociativeArray or Array")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            if rooibos_common_isAssociativeArray(array) and not rooibos_common_isAssociativeArray(subset)
                if msg = ""
                    msg = ("expected subset " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(subset, true))) + chr(34) + " to be an AssociativeArray to match type " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34))
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            if rooibos_common_isArray(array) and not rooibos_common_isArray(subset)
                if msg = ""
                    msg = ("expected subset " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(subset, true))) + chr(34) + " to be an Array to match type " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34))
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            isAA = rooibos_common_isAssociativeArray(subset)
            for each item in subset
                key = invalid
                value = item
                if isAA
                    key = item
                    value = subset[key]
                end if
                if not rooibos_common_arrayContains(array, value, key)
                    if msg = ""
                        if isAA
                            msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to contain property " + chr(34) + bslib_toString(rooibos_common_truncateString(key)) + chr(34) + " with value " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(value, true))) + chr(34))
                        else
                            msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to contain " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(value, true))) + chr(34))
                        end if
                    end if
                    m.fail(msg, "", "", true)
                    return false
                end if
            end for
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Fail if the array have the item from subset.
    ' @param {Dynamic} array - target array
    ' @param {Dynamic} subset - items to check presence of
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertArrayNotContainsSubset = function(array, subset, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if not rooibos_common_isAssociativeArray(array) and not rooibos_common_isArray(array)
                if msg = ""
                    msg = ("expected target " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to be an AssociativeArray or Array")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            if not rooibos_common_isAssociativeArray(subset) and not rooibos_common_isArray(subset)
                if msg = ""
                    msg = ("expected subset " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(subset, true))) + chr(34) + " to be an AssociativeArray or Array")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            if rooibos_common_isAssociativeArray(array) and not rooibos_common_isAssociativeArray(subset)
                if msg = ""
                    msg = ("expected subset " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(subset, true))) + chr(34) + " to be an AssociativeArray to match type " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34))
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            if rooibos_common_isArray(array) and not rooibos_common_isArray(subset)
                if msg = ""
                    msg = ("expected subset " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(subset, true))) + chr(34) + " to be an Array to match type " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34))
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            isAA = rooibos_common_isAssociativeArray(subset)
            for each item in subset
                key = invalid
                value = item
                if isAA
                    key = item
                    value = subset[key]
                end if
                if rooibos_common_arrayContains(array, value, key)
                    if msg = ""
                        if isAA
                            msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to not contain property " + chr(34) + bslib_toString(rooibos_common_truncateString(key)) + chr(34) + " with value " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(value, true))) + chr(34))
                        else
                            msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to not contain " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(value, true))) + chr(34))
                        end if
                    end if
                    m.fail(msg, "", "", true)
                    return false
                end if
            end for
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Fail if the array items count <> expected count
    ' @param {Dynamic} array - target array
    ' @param {Dynamic} count - An expected array items count
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertArrayCount = function(array, count, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if not rooibos_common_isAssociativeArray(array) and not rooibos_common_isArray(array)
                if msg = ""
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to be an AssociativeArray or Array")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            if not rooibos_common_isNumber(count)
                if msg = ""
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(count, true))) + chr(34) + " to be an Number")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            if rooibos_common_isAssociativeArray(array)
                actualCount = array.ifAssociativeArray.count()
            else
                actualCount = array.count()
            end if
            if actualCount <> count
                if msg = ""
                    msg = ("expected count " + chr(34) + bslib_toString(actualCount) + chr(34) + " to be " + chr(34) + bslib_toString(count) + chr(34))
                end if
                m.fail(msg, rooibos_common_asMultilineString(actualCount, true), rooibos_common_asMultilineString(count, true), true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Fail if the array items count = expected count.
    ' @param {Dynamic} array - target array
    ' @param {Dynamic} count - An expected array items count.
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertArrayNotCount = function(array, count, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if not rooibos_common_isAssociativeArray(array) and not rooibos_common_isArray(array)
                if msg = ""
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to be an AssociativeArray or Array")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            if not rooibos_common_isNumber(count)
                if msg = ""
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(count, true))) + chr(34) + " to be an Number")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            if rooibos_common_isAssociativeArray(array)
                actualCount = array.ifAssociativeArray.count()
            else
                actualCount = array.count()
            end if
            if actualCount = count
                if msg = ""
                    msg = ("expected count " + chr(34) + bslib_toString(actualCount) + chr(34) + " to not be " + chr(34) + bslib_toString(count) + chr(34))
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Fail if the item is not empty array or string.
    ' @param {Dynamic} item - item to check
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertEmpty = function(item, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if rooibos_common_isAssociativeArray(item)
                if not item.isEmpty()
                    actual = rooibos_common_asMultilineString(item, true)
                    if msg = ""
                        msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be empty")
                    end if
                    m.fail(msg, actual, rooibos_common_asMultilineString({}, true), true)
                    return false
                end if
            else if rooibos_common_isArray(item)
                if not item.isEmpty()
                    actual = rooibos_common_asMultilineString(item, true)
                    if msg = ""
                        msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be empty")
                    end if
                    m.fail(msg, actual, rooibos_common_asMultilineString([], true), true)
                    return false
                end if
            else if rooibos_common_isString(item)
                if not item.isEmpty()
                    actual = rooibos_common_asMultilineString(item, true)
                    if msg = ""
                        msg = ("expected " + bslib_toString(rooibos_common_truncateString(actual)) + " to be empty")
                    end if
                    m.fail(msg, actual, "", true)
                    return false
                end if
            else
                if msg = ""
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(item, true))) + chr(34) + " to be an AssociativeArray, Array, or String")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Fail if the item is empty array or string.
    ' @param {Dynamic} item - item to check
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertNotEmpty = function(item, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if rooibos_common_isAssociativeArray(item)
                if item.isEmpty()
                    if msg = ""
                        actual = rooibos_common_asMultilineString(item, true)
                        msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to not be empty")
                    end if
                    m.fail(msg, "", "", true)
                    return false
                end if
            else if rooibos_common_isArray(item)
                if item.isEmpty()
                    if msg = ""
                        actual = rooibos_common_asMultilineString(item, true)
                        msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to not be empty")
                    end if
                    m.fail(msg, "", "", true)
                    return false
                end if
            else if rooibos_common_isString(item)
                if item.isEmpty()
                    if msg = ""
                        actual = rooibos_common_asMultilineString(item, true)
                        msg = ("expected " + bslib_toString(rooibos_common_truncateString(actual)) + " to be empty")
                    end if
                    m.fail(msg, "", "", true)
                    return false
                end if
            else
                if msg = ""
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(item, true))) + chr(34) + " to be an AssociativeArray, Array, or String")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Fail if the array doesn't contains items of specific type only.
    ' @param {Dynamic} array - target array
    ' @param {Dynamic} typeStr - type name - must be String, Array, Boolean, or AssociativeArray
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertArrayContainsOnlyValuesOfType = function(array, typeStr, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if typeStr <> "String" and typeStr <> "Integer" and typeStr <> "Boolean" and typeStr <> "Array" and typeStr <> "AssociativeArray"
                if msg = ""
                    msg = ("expect type " + bslib_toString(rooibos_common_asMultilineString(typeStr, true)) + " to be " + chr(34) + "Boolean" + chr(34) + ", " + chr(34) + "String" + chr(34) + ", " + chr(34) + "Integer" + chr(34) + ", " + chr(34) + "Array" + chr(34) + ", or " + chr(34) + "AssociativeArray" + chr(34))
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            if not rooibos_common_isAssociativeArray(array) and not rooibos_common_isArray(array)
                if msg = ""
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to be an AssociativeArray or Array")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            isAA = rooibos_common_isAssociativeArray(array)
            methodName = "Rooibos_Common_Is" + typeStr
            typeCheckFunction = m.getIsTypeFunction(methodName)
            if typeCheckFunction <> invalid
                for each item in array
                    key = invalid
                    if isAA
                        key = item
                        item = array[key]
                    end if
                    if not typeCheckFunction(item)
                        if msg = ""
                            if isAA
                                msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(key)) + ": " + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(item, true))) + chr(34) + " to be type " + bslib_toString(rooibos_common_asMultilineString(typeStr, true)))
                            else
                                msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(item, true))) + chr(34) + " to be type " + bslib_toString(rooibos_common_asMultilineString(typeStr, true)))
                            end if
                        end if
                        m.fail(msg, "", "", true)
                        return false
                    end if
                end for
            else
                ' I think we can remove this check, as we are already checking for valid types?
                ' Will revisit this later.
                throw ("could not find comparator for type " + bslib_toString(rooibos_common_asMultilineString(typeStr, true)))
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' @ignore
    instance.getIsTypeFunction = function(name)
        if name = "Rooibos_Common_IsFunction"
            return rooibos_common_isFunction
        else if name = "Rooibos_Common_IsXmlElement"
            return rooibos_common_isXmlElement
        else if name = "Rooibos_Common_IsInteger"
            return rooibos_common_isInteger
        else if name = "Rooibos_Common_IsBoolean"
            return rooibos_common_isBoolean
        else if name = "Rooibos_Common_IsFloat"
            return rooibos_common_isFloat
        else if name = "Rooibos_Common_IsDouble"
            return rooibos_common_isDouble
        else if name = "Rooibos_Common_IsLongInteger"
            return rooibos_common_isLongInteger
        else if name = "Rooibos_Common_IsNumber"
            return rooibos_common_isNumber
        else if name = "Rooibos_Common_IsList"
            return rooibos_common_isList
        else if name = "Rooibos_Common_IsArray"
            return rooibos_common_isArray
        else if name = "Rooibos_Common_IsAssociativeArray"
            return rooibos_common_isAssociativeArray
        else if name = "Rooibos_Common_IsSGNode"
            return rooibos_common_isSGNode
        else if name = "Rooibos_Common_IsString"
            return rooibos_common_isString
        else if name = "Rooibos_Common_IsDateTime"
            return rooibos_common_isDateTime
        else if name = "Rooibos_Common_IsUndefined"
            return rooibos_common_isUndefined
        else
            return invalid
        end if
    end function
    ' Asserts that the value is a node of designated type
    ' @param {Dynamic} value - value to check - target node
    ' @param {Dynamic} typeStr - type name
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertType = function(value, typeStr, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if type(value) <> typeStr
                actual = rooibos_common_asMultilineString(type(value), true)
                expected = rooibos_common_asMultilineString(typeStr, true)
                if msg = ""
                    msg = ("expected " + bslib_toString(rooibos_common_truncateString(actual)) + " to be type " + bslib_toString(rooibos_common_truncateString(expected)))
                end if
                m.fail(msg, actual, expected, true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Asserts that the value is a node of designated subtype
    ' @param {Dynamic} value - value to check - target node
    ' @param {Dynamic} typeStr - type name
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertSubType = function(value, typeStr, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if type(value) <> "roSGNode"
                actual = rooibos_common_getTypeWithComponentWrapper(value)
                expected = ("<Component: roSGNode:" + bslib_toString(typeStr) + ">")
                if msg = ""
                    msg = ("expected type " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be type " + chr(34) + bslib_toString(rooibos_common_truncateString(expected)) + chr(34))
                end if
                m.fail(msg, actual, expected, true)
                return false
            else if value.subType() <> typeStr
                actual = rooibos_common_getTypeWithComponentWrapper(value, true)
                expected = ("<Component: roSGNode:" + bslib_toString(typeStr) + ">")
                if msg = ""
                    msg = ("expected type " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be type " + chr(34) + bslib_toString(rooibos_common_truncateString(expected)) + chr(34))
                end if
                m.fail(msg, actual, expected, true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    instance.assertClass = function(value, expectedClassName, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        if rooibos_common_isFunction(expectedClassName)
            expectedClassName = expectedClassName.toStr().mid(10).replace("_", ".")
        end if
        try
            if not rooibos_common_isAssociativeArray(value)
                if msg = ""
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(value, true))) + chr(34) + " to be an instance of " + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(expectedClassName, true))))
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            if not rooibos_common_isString(value?.__classname)
                if msg = ""
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(value, true))) + chr(34) + " to be an instance of " + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(expectedClassName, true))))
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            className = value?.__classname
            fail = false
            if not rooibos_common_isString(value?.__classname)
                className = "Invalid"
                fail = true
            end if
            className = lCase(className)
            if fail or className <> lCase(expectedClassName)
                actual = rooibos_common_asMultilineString(className, true)
                expected = rooibos_common_asMultilineString(lCase(expectedClassName), true)
                if msg = ""
                    msg = ("expected class " + bslib_toString(rooibos_common_truncateString(actual)) + " to be an instance of " + bslib_toString(rooibos_common_truncateString(expected)))
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
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
    instance.assertNodeCount = function(node, count, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if type(node) = "roSGNode"
                if node.isSubType("mc_Node")
                    childCount = node.length
                else
                    childCount = node.getChildCount()
                end if
                if childCount <> count
                    actual = rooibos_common_asMultilineString(childCount, true)
                    expected = rooibos_common_asMultilineString(count, true)
                    if msg = ""
                        msg = ("expected count " + chr(34) + bslib_toString(actual) + chr(34) + " to be " + chr(34) + bslib_toString(expected) + chr(34))
                    end if
                    m.fail(msg, actual, expected, true)
                    return false
                end if
            else
                actual = rooibos_common_getTypeWithComponentWrapper(node)
                expected = "<Component: roSGNode>"
                if msg = ""
                    msg = ("expected type " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be type " + chr(34) + bslib_toString(rooibos_common_truncateString(expected)) + chr(34))
                end if
                m.fail(msg, actual, expected, true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Fail if the node items count = expected count.
    ' @param {Dynamic} node - A target node
    ' @param {Dynamic} count - Expected item count
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertNodeNotCount = function(node, count, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if type(node) = "roSGNode"
                if node.isSubType("mc_Node")
                    childCount = node.length
                else
                    childCount = node.getChildCount()
                end if
                if childCount = count
                    actual = rooibos_common_asMultilineString(childCount, true)
                    expected = rooibos_common_asMultilineString(count, true)
                    if msg = ""
                        msg = ("expected count " + chr(34) + bslib_toString(actual) + chr(34) + " to not be " + chr(34) + bslib_toString(expected) + chr(34))
                    end if
                    m.fail(msg, actual, expected, true)
                    return false
                end if
            else
                actual = rooibos_common_getTypeWithComponentWrapper(node)
                expected = "<Component: roSGNode>"
                if msg = ""
                    msg = ("expected type " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be type " + chr(34) + bslib_toString(rooibos_common_truncateString(expected)) + chr(34))
                end if
                m.fail(msg, actual, expected, true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Asserts the node has no children
    ' @param {Dynamic} node - a node to check
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertNodeEmpty = function(node, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if type(node) = "roSGNode"
                if node.isSubType("mc_Node")
                    childCount = node.length
                else
                    childCount = node.getChildCount()
                end if
                if childCount > 0
                    if msg = ""
                        msg = ("expected child count " + chr(34) + bslib_toString(childCount) + chr(34) + " to be " + chr(34) + "0" + chr(34))
                    end if
                    m.fail(msg, "", "", true)
                    return false
                end if
            else
                actual = rooibos_common_getTypeWithComponentWrapper(node)
                expected = "<Component: roSGNode>"
                if msg = ""
                    msg = ("expected type " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be type " + chr(34) + bslib_toString(rooibos_common_truncateString(expected)) + chr(34))
                end if
                m.fail(msg, actual, expected, true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Asserts the node has children
    ' @param {Dynamic} node - a node to check
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertNodeNotEmpty = function(node, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if type(node) = "roSGNode"
                if node.isSubType("mc_Node")
                    childCount = node.length
                else
                    childCount = node.getChildCount()
                end if
                if childCount = 0
                    if msg = ""
                        msg = ("expected child count " + chr(34) + bslib_toString(childCount) + chr(34) + " to be greater then " + chr(34) + "0" + chr(34))
                    end if
                    m.fail(msg, "", "", true)
                    return false
                end if
            else
                actual = rooibos_common_getTypeWithComponentWrapper(node)
                expected = "<Component: roSGNode>"
                if msg = ""
                    msg = ("expected type " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be type " + chr(34) + bslib_toString(rooibos_common_truncateString(expected)) + chr(34))
                end if
                m.fail(msg, actual, expected, true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Asserts the node contains the child _value_
    ' @param {Dynamic} node - a node to check
    ' @param {Dynamic} value - value to check - value to look for
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertNodeContains = function(node, value, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if type(node) = "roSGNode"
                if not rooibos_common_nodeContains(node, value)
                    if msg = ""
                        msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_getTypeWithComponentWrapper(node, true))) + chr(34) + " to contain child " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_getTypeWithComponentWrapper(value, true))) + chr(34) + " by reference")
                    end if
                    m.fail(msg, "", "", true)
                    return false
                end if
            else
                actual = rooibos_common_getTypeWithComponentWrapper(node)
                expected = "<Component: roSGNode>"
                if msg = ""
                    msg = ("expected type " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be type " + chr(34) + bslib_toString(rooibos_common_truncateString(expected)) + chr(34))
                end if
                m.fail(msg, actual, expected, true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Asserts the node contains only the child _value_
    ' @param {Dynamic} node - a node to check
    ' @param {Dynamic} value - value to check - value to look for
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertNodeContainsOnly = function(node, value, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if type(node) = "roSGNode"
                if not rooibos_common_nodeContains(node, value)
                    if msg = ""
                        msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_getTypeWithComponentWrapper(node, true))) + chr(34) + " to contain child " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_getTypeWithComponentWrapper(value, true))) + chr(34) + " by reference")
                    end if
                    m.fail(msg, "", "", true)
                    return false
                else
                    if node.isSubType("mc_Node")
                        childCount = node.length
                    else
                        childCount = node.getChildCount()
                    end if
                    if childCount <> 1
                        if msg = ""
                            msg = ("expected child count " + chr(34) + bslib_toString(childCount) + chr(34) + " to be " + chr(34) + "1" + chr(34))
                        end if
                        m.fail(msg, "", "", true)
                        return false
                    end if
                end if
            else
                actual = rooibos_common_getTypeWithComponentWrapper(node)
                expected = "<Component: roSGNode>"
                if msg = ""
                    msg = ("expected type " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be type " + chr(34) + bslib_toString(rooibos_common_truncateString(expected)) + chr(34))
                end if
                m.fail(msg, actual, expected, true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Fail if the node h item.
    ' @param {Dynamic} node - A target node
    ' @param {Dynamic} value - value to check - a node child
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertNodeNotContains = function(node, value, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if type(node) = "roSGNode"
                if rooibos_common_nodeContains(node, value)
                    if msg = ""
                        msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_getTypeWithComponentWrapper(node, true))) + chr(34) + " to not contain child " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_getTypeWithComponentWrapper(value, true))) + chr(34) + " by reference")
                    end if
                    m.fail(msg, "", "", true)
                    return false
                end if
            else
                actual = rooibos_common_getTypeWithComponentWrapper(node)
                expected = "<Component: roSGNode>"
                if msg = ""
                    msg = ("expected type " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be type " + chr(34) + bslib_toString(rooibos_common_truncateString(expected)) + chr(34))
                end if
                m.fail(msg, actual, expected, true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
        return false
    end function
    ' Fail if the node doesn't have the item subset.
    ' @param {Dynamic} node - A target node
    ' @param {Dynamic} subset - items to check
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert was satisfied, false otherwise
    instance.assertNodeContainsFields = function(node, subset, ignoredFields = invalid, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if not type(node) = "roSGNode"
                actual = rooibos_common_getTypeWithComponentWrapper(node)
                expected = "<Component: roSGNode>"
                if msg = ""
                    msg = ("expected type " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be type " + chr(34) + bslib_toString(rooibos_common_truncateString(expected)) + chr(34))
                end if
                m.fail(msg, actual, expected, true)
                return false
            end if
            if not rooibos_common_isAssociativeArray(subset)
                if msg = ""
                    msg = ("expected subset " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(subset, true))) + chr(34) + " to be an AssociativeArray")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            if rooibos_common_isArray(ignoredFields)
                filteredSubset = {}
                for each key in subset
                    if rooibos_common_isString(key) and not rooibos_common_arrayContains(ignoredFields, key)
                        filteredSubset[key] = subset[key]
                    end if
                end for
            else
                filteredSubset = subset
            end if
            foundValues = {}
            missingValues = {}
            for each key in filteredSubset
                subsetValue = filteredSubset[key]
                nodeValue = node[key]
                if rooibos_common_eqValues(nodeValue, subsetValue)
                    foundValues[key] = subsetValue
                else
                    missingValues[key] = subsetValue
                end if
            end for
            if foundValues.ifAssociativeArray.count() <> filteredSubset.ifAssociativeArray.count()
                actual = rooibos_common_asMultilineString(foundValues, true)
                expected = rooibos_common_asMultilineString(filteredSubset, true)
                if msg = ""
                    if msg = ""
                        msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_getTypeWithComponentWrapper(node, true))) + chr(34) + " to have properties " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(missingValues))) + chr(34))
                    end if
                end if
                m.fail(msg, actual, expected, true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, error.message)
            return false
        end try
        return false
    end function
    ' Fail if the node have the item from subset.
    ' @param {Dynamic} node - A target node
    ' @param {Dynamic} subset - the items to check for
    ' @param {Dynamic} [msg=""] - alternate error message
    ' @returns {boolean} - true if the assert w, false otherwise
    instance.assertNodeNotContainsFields = function(node, subset, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if not type(node) = "roSGNode"
                actual = rooibos_common_getTypeWithComponentWrapper(node)
                expected = "<Component: roSGNode>"
                if msg = ""
                    msg = ("expected type " + chr(34) + bslib_toString(rooibos_common_truncateString(actual)) + chr(34) + " to be type " + chr(34) + bslib_toString(rooibos_common_truncateString(expected)) + chr(34))
                end if
                m.fail(msg, actual, expected, true)
                return false
            end if
            if rooibos_common_isArray(subset)
                '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                ' NOTE: Legacy check for children via array support.
                '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                for each value in subset
                    if rooibos_common_nodeContains(node, value)
                        if msg = ""
                            msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_getTypeWithComponentWrapper(node, true))) + chr(34) + " to not contain child " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_getTypeWithComponentWrapper(value, true))) + chr(34) + " by reference")
                        end if
                        m.fail(msg, "", "", true)
                        return false
                    end if
                end for
            else if rooibos_common_isAssociativeArray(subset)
                foundValues = {}
                for each key in subset
                    subsetValue = subset[key]
                    nodeValue = node[key]
                    if rooibos_common_eqValues(nodeValue, subsetValue)
                        foundValues[key] = subsetValue
                    end if
                end for
                if foundValues.ifAssociativeArray.count() > 0
                    actual = rooibos_common_asMultilineString(foundValues, true)
                    expected = rooibos_common_asMultilineString({}, true)
                    if msg = ""
                        msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_getTypeWithComponentWrapper(node, true))) + chr(34) + " to have not have properties " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(foundValues))) + chr(34))
                    end if
                    m.fail(msg, actual, expected, true)
                    return false
                end if
            else
                if msg = ""
                    msg = ("expected subset " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(subset, true))) + chr(34) + " to be an AssociativeArray")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
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
    instance.assertAAContainsSubset = function(array, subset, ignoredFields = invalid, msg = "") as dynamic
        if m.currentResult.isFail
            return false
        end if
        try
            if not rooibos_common_isAssociativeArray(array)
                if msg = ""
                    msg = ("expected target " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to be an AssociativeArray")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            if not rooibos_common_isAssociativeArray(subset)
                if msg = ""
                    msg = ("expected subset " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(subset, true))) + chr(34) + " to be an AssociativeArray")
                end if
                m.fail(msg, "", "", true)
                return false
            end if
            if rooibos_common_isArray(ignoredFields)
                filteredSubset = {}
                for each key in subset
                    if rooibos_common_isString(key) and not rooibos_common_arrayContains(ignoredFields, key)
                        filteredSubset[key] = subset[key]
                    end if
                end for
            else
                filteredSubset = subset
            end if
            foundValues = {}
            missingValues = {}
            for each key in filteredSubset
                subsetValue = filteredSubset[key]
                nodeValue = array[key]
                if rooibos_common_eqValues(nodeValue, subsetValue)
                    foundValues[key] = subsetValue
                else
                    missingValues[key] = subsetValue
                end if
            end for
            if foundValues.ifAssociativeArray.count() <> filteredSubset.ifAssociativeArray.count()
                actual = rooibos_common_asMultilineString(foundValues, true)
                expected = rooibos_common_asMultilineString(filteredSubset, true)
                if msg = ""
                    msg = ("expected " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(array, true))) + chr(34) + " to have properties " + chr(34) + bslib_toString(rooibos_common_truncateString(rooibos_common_asMultilineString(missingValues))) + chr(34))
                end if
                m.fail(msg, actual, expected, true)
                return false
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.failCrash(error, msg)
        end try
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
    instance.stub = function(target, methodName, returnValue = invalid, allowNonExistingMethods = false) as object
        if target = invalid and not rooibos_common_isFunction(methodName)
            m.fail("could not create Stub. Global function", methodName, ", is invalid")
            return {}
        else if type(target) <> "roAssociativeArray"
            m.fail("could not create Stub provided target was null")
            return {}
        end if
        if m.stubs = invalid
            m.__stubId = -1
            m.stubs = {}
        end if
        m.__stubId++
        if m.__stubId > 25
            rooibos_common_logError(("ERROR ONLY 25 MOCKS PER TEST ARE SUPPORTED!! you're on # " + bslib_toString(m.__mockId)))
            rooibos_common_logError("Method was " + methodName)
            return invalid
        end if
        id = stri(m.__stubId).trim()
        fake = m.createFake(id, target, methodName, 1, invalid, returnValue)
        m.stubs[id] = fake
        if target.isGlobalCall = true
            rooibos_getMocksByFunctionName()[methodName] = fake
        else
            allowNonExisting = m.allowNonExistingMethodsOnMocks = true or allowNonExistingMethods
            isMethodPresent = type(target[methodName]) = "Function" or type(target[methodName]) = "roFunction"
            if isMethodPresent or allowNonExisting
                target[methodName] = m["StubCallback" + id]
                target.__stubs = m.stubs
                ' FIXME: add a log setting for this - and add better detection so that stubs know that they are colliding/don't exist/have correct sigs
                ' if not isMethodPresent
                '   rooibos.common.logWarning(`stubbing call ${methodName} which did not exist on target object`)
                ' end if
            else
                rooibos_common_logTrace("Could not create Stub : method not found  " + rooibos_common_asString(target) + "." + methodName)
            end if
        end if
        return fake
    end function
    instance.expectLastCallToThrowError = function(error as dynamic)
        try
            mock = m.mocks[m.__mockId.toStr()]
            mock.toThrow(error)
        catch error
            m.log.error("could not add throw to last call", error)
        end try
    end function
    instance.expectCalled = function(invocation as dynamic, returnValue = invalid as dynamic) as object
        'mock function body - the plugin replaces this
        return invalid
    end function
    ' @ignore
    instance._expectCalled = function(target, methodName, rootObject = invalid as dynamic, fullPath = invalid as dynamic, expectedArgs = invalid, returnValue = invalid as dynamic) as object
        try
            if type(target) <> "roAssociativeArray" and fullPath <> invalid
                target = rooibos_common_makePathStubbable(rootObject, fullPath)
            end if
            return m.mock(target, methodName, 1, expectedArgs, returnValue, true)
        catch error
            'bs:disable-next-line
            m.fail("Setting up mock failed: " + error.message, "", "", true)
        end try
        return invalid
    end function
    instance.stubCall = function(invocation as dynamic, stubOrReturnValue = invalid as dynamic, functionName = "" as string) as object
        ' When stubbing global functions this will be called. Other wise the test code will be updated to call m._stubCall()
        if type(invocation).endsWith("Function") and functionName = ""
            functionName = invocation.toStr().tokenize(" ").peek()
        else
            throw "Did not provide a function to be stubbed"
        end if
        if not type(stubOrReturnValue).endsWith("Function")
            ' throw "Did not provide a stub function"
        end if
        ' Store the stub on the component scope
        globalAa = getGlobalAa()
        if type(globalAa?.__globalStubs) <> "roAssociativeArray"
            globalAa.__globalStubs = {}
        end if
        globalAa.__globalStubs[lCase(functionName)] = stubOrReturnValue
        return invalid
    end function
    ' @ignore
    instance._stubCall = function(target, methodName, rootObject = invalid as dynamic, fullPath = invalid as dynamic, returnValue = invalid as dynamic) as object
        try
            if type(target) <> "roAssociativeArray" and fullPath <> invalid
                target = rooibos_common_makePathStubbable(rootObject, fullPath)
            end if
            return m.stub(target, methodName, returnValue, true)
        catch error
            'bs:disable-next-line
            m.fail("Setting up mock failed: " + error.message, "", "", true)
            return false
        end try
        return false
    end function
    instance.expectNotCalled = function(invocation as dynamic) as object
        'mock function body - the plugin replaces this
        return invalid
    end function
    ' @ignore
    instance._expectNotCalled = function(target, methodName, rootObject = invalid as dynamic, fullPath = invalid as dynamic) as object
        try
            if type(target) <> "roAssociativeArray" and fullPath <> invalid
                target = rooibos_common_makePathStubbable(rootObject, fullPath)
            end if
            return m.mock(target, methodName, 0, invalid, invalid, true)
        catch error
            'bs:disable-next-line
            m.fail("Setting up mock failed: " + error.message, "", "", true)
            return false
        end try
        return false
    end function
    ' Creates a stub to replace a real method with, which the framework will track. If it was invoked the wrong number of times, or with wrong arguments, it will result in test failure
    ' @param {Dynamic} target - object on which the method to be stubbed is found
    ' @param {Dynamic} methodName - name of method to stub
    ' @param {Dynamic} [expectedArgs=invalid] - array containing the arguments we expect the method to be invoked with
    ' @param {Dynamic} [returnValue=invalid] - value that the stub method will return when invoked
    ' @param {boolean} [allowNonExistingMethods=false] - if true, then rooibos will only warn if the method did not exist prior to faking
    ' @returns {Object} - mock that was wired into the real method
    instance.expectOnce = function(target, methodName, expectedArgs = invalid, returnValue = invalid, allowNonExistingMethods = false) as object
        'HACK
        'HACK
        'HACK
        'HACK
        'HACK
        ' try
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
    instance.expectOnceOrNone = function(target, methodName, isExpected, expectedArgs = invalid, returnValue = invalid, allowNonExistingMethods = false) as object
        try
            if isExpected
                return m.expectOnce(target, methodName, expectedArgs, returnValue, allowNonExistingMethods)
            else
                return m.expectNone(target, methodName, allowNonExistingMethods)
            end if
        catch error
            'bs:disable-next-line
            m.fail("Setting up mock failed: " + error.message, "", "", true)
        end try
        return false
    end function
    ' Creates a stub to replace a real method with, which the framework will track. If it was invoked, it will result in test failure
    ' @param {Dynamic} target - object on which the method to be stubbed is found
    ' @param {Dynamic} methodName - name of method to stub
    ' @param {boolean} [allowNonExistingMethods=false] - if true, then rooibos will only warn if the method did not exist prior to faking
    ' @returns {Object} - mock that was wired into the real method
    instance.expectNone = function(target, methodName, allowNonExistingMethods = false) as object
        try
            return m.mock(target, methodName, 0, invalid, invalid, allowNonExistingMethods)
        catch error
            'bs:disable-next-line
            m.fail("Setting up mock failed: " + error.message, "", "", true)
        end try
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
    instance.expect = function(target, methodName, expectedInvocations = 1, expectedArgs = invalid, returnValue = invalid, allowNonExistingMethods = false) as object
        try
            return m.mock(target, methodName, expectedInvocations, expectedArgs, returnValue, allowNonExistingMethods)
        catch error
            'bs:disable-next-line
            m.fail("Setting up mock failed: " + error.message, "", "", true)
        end try
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
    instance.mock = function(target, methodName, expectedInvocations = 1, expectedArgs = invalid, returnValue = invalid, allowNonExistingMethods = false) as object
        lineNumber = m.currentAssertLineNumber
        'check params
        if target <> invalid and not rooibos_common_isFunction(target) and not rooibos_common_isAssociativeArray(target)
            methodName = ""
            m.mockFail(lineNumber, "", "mock args: target should be an AA or in-scope Global function", methodName)
        else if not rooibos_common_isString(methodName)
            methodName = ""
            m.mockFail(lineNumber, "", "mock args: methodName was not a string")
        else if not rooibos_common_isNumber(expectedInvocations)
            m.mockFail(lineNumber, methodName, "mock args: expectedInvocations was not an int")
        else if not rooibos_common_isArray(expectedArgs) and rooibos_common_isValid(expectedArgs)
            m.mockFail(lineNumber, methodName, "mock args: expectedArgs was not invalid or an array of args")
        else if rooibos_common_isUndefined(expectedArgs)
            m.mockFail(lineNumber, methodName, "mock args: expectedArgs undefined")
        else if rooibos_common_isUndefined(returnValue)
            m.mockFail(lineNumber, methodName, "mock args: returnValue undefined")
        end if
        if m.currentResult.isFail
            rooibos_common_logError(("Cannot create MOCK. method " + bslib_toString(methodName) + " " + bslib_toString(lineNumber) + " " + bslib_toString(m.currentResult.message)))
            return {}
        end if
        if m.mocks = invalid
            m.__mockId = -1
            m.__mockTargetId = -1
            m.mocks = {}
            rooibos_resetMocksByFunctionName()
        end if
        fake = invalid
        if rooibos_common_isFunction(target)
            target = {
                isGlobalCall: true
            }
        end if
        if not target.doesExist("__rooibosTargetId")
            m.__mockTargetId++
            target["__rooibosTargetId"] = m.__mockTargetId
        end if
        'ascertain if mock already exists
        for i = 0 to m.__mockId
            id = stri(i).trim()
            mock = m.mocks[id]
            if mock <> invalid and mock.methodName = methodName and (mock.target.__rooibosTargetId = target.__rooibosTargetId or (mock.target.isGlobalCall = true and target.isGlobalCall = true))
                fake = mock
                fake.lineNumbers.push(lineNumber)
                exit for
            end if
        end for
        if fake = invalid
            m.__mockId++
            id = stri(m.__mockId).trim()
            if m.__mockId > 25
                rooibos_common_logError(("ERROR ONLY 25 MOCKS PER TEST ARE SUPPORTED!! you're on # " + bslib_toString(m.__mockId)))
                rooibos_common_logError("Method was " + methodName)
                return invalid
            end if
            fake = m.createFake(id, target, methodName, expectedInvocations, expectedArgs, returnValue)
            m.mocks[id] = fake 'this will bind it to m
            if target.isGlobalCall = true
                rooibos_getMocksByFunctionName()[methodName] = fake
            else
                allowNonExisting = m.allowNonExistingMethodsOnMocks = true or allowNonExistingMethods
                isMethodPresent = type(target[methodName]) = "Function" or type(target[methodName]) = "roFunction"
                if isMethodPresent or allowNonExisting
                    target[methodName] = m["MockCallback" + id]
                    target.__mocks = m.mocks
                    if not isMethodPresent
                        rooibos_common_logWarning(("mocking call " + bslib_toString(methodName) + " which did not exist on target object"))
                    end if
                else
                    rooibos_common_logError(("Could not create Mock : method not found " + bslib_toString(target) + "." + bslib_toString(methodName)))
                end if
            end if
        else
            m.combineFakes(fake, m.createFake(id, target, methodName, expectedInvocations, expectedArgs, returnValue))
        end if
        return fake
    end function
    ' Creates a stub to replace a real method with. This is used internally.
    ' @param {Dynamic} target - object on which the method to be stubbed is found
    ' @param {Dynamic} methodName - name of method to stub
    ' @param {Dynamic} [expectedInvocations=1] - number of invocations we expect
    ' @param {Dynamic} [expectedArgs=invalid] - array containing the arguments we expect the method to be invoked with
    ' @param {Dynamic} [returnValue=invalid] - value that the stub method will return when invoked
    ' @returns {Object} - stub that was wired into the real method
    instance.createFake = function(id, target, methodName, expectedInvocations = 1, expectedArgs = invalid, returnValue = invalid) as object
        expectedArgsValues = []
        lineNumber = m.currentAssertLineNumber
        hasArgs = rooibos_common_isArray(expectedArgs)
        defaultValue = m.ignoreValue
        if hasArgs
            defaultValue = m.invalidValue
        else
            expectedArgs = []
        end if
        lineNumbers = [
            lineNumber
        ]
        for i = 0 to 9
            if hasArgs and expectedArgs.count() > i
                'guard against bad values
                value = expectedArgs[i]
                if not rooibos_common_isUndefined(value)
                    if rooibos_common_isAssociativeArray(value) and rooibos_common_isValid(value.matcher)
                        if not rooibos_common_isFunction(value.matcher)
                            rooibos_common_logError("You have specified a matching function; but it is not in scope!")
                            expectedArgsValues.push("#ERR-OUT_OF_SCOPE_MATCHER!")
                        else
                            expectedArgsValues.push(expectedArgs[i])
                        end if
                    else
                        expectedArgsValues.push(expectedArgs[i])
                    end if
                else
                    expectedArgsValues.push("#ERR-UNDEFINED!")
                end if
            else
                expectedArgsValues.push(defaultValue)
            end if
        end for
        'todo - make into a class
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
                rooibos_common_logTrace(("FAKE CALLBACK CALLED FOR " + bslib_toString(m.methodName)))
                'bs:disable-next-line
                if m.allInvokedArgs = invalid
                    'bs:disable-next-line
                    m.allInvokedArgs = []
                end if
                'bs:disable-next-line
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
                m.isCalled = true
                'bs:disable-next-line
                m.invocations++
                if m.errorToThrow <> invalid
                    throw m.errorToThrow
                end if
                'bs:disable-next-line
                if type(m.returnValue) = "roAssociativeArray" and m.returnValue.ifAssociativeArray.doesExist("multiResult")
                    'bs:disable-next-line
                    returnValues = m.returnValue["multiResult"]
                    'bs:disable-next-line
                    returnIndex = m.invocations - 1
                    if type(returnValues) = "roArray" and returnValues.count() > 0
                        'bs:disable-next-line
                        if returnValues.count() <= m.invocations
                            returnIndex = returnValues.count() - 1
                            rooibos_common_logDebug("Multi return values all used up - repeating last value")
                        end if
                        return returnValues[returnIndex]
                    else
                        rooibos_common_logError("Multi return value was specified; but no array of results were found")
                        return invalid
                    end if
                else
                    'bs:disable-next-line
                    return m.returnValue
                end if
            end function
            toThrow: function(error)
                m.errorToThrow = error
            end function
        }
        return fake
    end function
    instance.combineFakes = function(fake, otherFake)
        'add on the expected invoked args
        lineNumber = m.currentAssertLineNumber
        if type(fake.expectedArgs) <> "roAssociativeArray" or not fake.expectedArgs.ifAssociativeArray.doesExist("multiInvoke")
            currentExpectedArgsArgs = fake.expectedArgs
            fake.expectedArgs = {
                "multiInvoke": [
                    currentExpectedArgsArgs
                ]
            }
        end if
        for i = 1 to otherFake.expectedInvocations
            fake.expectedArgs.multiInvoke.push(otherFake.expectedArgs)
        end for
        'add on the expected return values
        if type(fake.returnValue) <> "roAssociativeArray" or not fake.returnValue.ifAssociativeArray.doesExist("multiResult")
            currentReturnValue = fake.returnValue
            fake.returnValue = {
                "multiResult": [
                    currentReturnValue
                ]
            }
        end if
        for i = 1 to otherFake.expectedInvocations
            fake.returnValue.multiResult.push(otherFake.returnValue)
        end for
        fake.lineNumbers.push(lineNumber)
        fake.expectedInvocations += otherFake.expectedInvocations
    end function
    ' Will check all mocks that have been created to ensure they were invoked the expected amount of times, with the expected args.
    instance.assertMocks = function() as void
        if m.__mockId = invalid or not rooibos_common_isAssociativeArray(m.mocks)
            return
        end if
        for each id in m.mocks
            mock = m.mocks[id]
            methodName = mock.methodName
            if mock.expectedInvocations <> mock.invocations
                m.mockFail(mock.lineNumbers[0], methodName, "Wrong number of calls. (" + stri(mock.invocations).trim() + " / " + stri(mock.expectedInvocations).trim() + ")")
                m.cleanMocks()
                return
            else if mock.expectedInvocations > 0 and (rooibos_common_isArray(mock.expectedArgs) or (type(mock.expectedArgs) = "roAssociativeArray" and rooibos_common_isArray(mock.expectedArgs.multiInvoke)))
                isMultiArgsSupported = type(mock.expectedArgs) = "roAssociativeArray" and rooibos_common_isArray(mock.expectedArgs.multiInvoke)
                for invocationIndex = 0 to mock.invocations - 1
                    invokedArgs = mock.allInvokedArgs[invocationIndex]
                    if isMultiArgsSupported
                        expectedArgs = mock.expectedArgs.multiInvoke[invocationIndex]
                    else
                        expectedArgs = mock.expectedArgs
                    end if
                    if rooibos_common_isAssociativeArray(expectedArgs)
                        expectedArgsCount = expectedArgs.ifAssociativeArray.count()
                    else
                        expectedArgsCount = expectedArgs.count()
                    end if
                    for i = 0 to expectedArgsCount - 1
                        value = invokedArgs[i]
                        expected = expectedArgs[i]
                        didNotExpectArg = rooibos_common_isString(expected) and expected = m.invalidValue
                        if didNotExpectArg
                            expected = invalid
                        end if
                        isUsingMatcher = rooibos_common_isAssociativeArray(expected) and rooibos_common_isFunction(expected.matcher)
                        if isUsingMatcher
                            if not expected.matcher(value)
                                m.mockFail(mock.lineNumbers[invocationIndex], methodName, "on Invocation #" + stri(invocationIndex).trim() + ", expected arg #" + stri(i).trim() + "  to match matching function '" + rooibos_common_asString(expected.matcher) + "' got '" + rooibos_common_asString(value, true) + "')")
                                m.cleanMocks()
                            end if
                        else
                            if not (rooibos_common_isString(expected) and expected = m.ignoreValue) and not rooibos_common_eqValues(value, expected)
                                if expected = invalid
                                    expected = "[INVALID]"
                                end if
                                m.mockFail(mock.lineNumbers[invocationIndex], methodName, "on Invocation #" + stri(invocationIndex).trim() + ", expected arg #" + stri(i).trim() + "  to be '" + rooibos_common_asString(expected, true) + "' got '" + rooibos_common_asString(value, true) + "')")
                                m.cleanMocks()
                                return
                            end if
                        end if
                    end for
                end for
            end if
        end for
        m.cleanMocks()
    end function
    ' Cleans up all tracking data associated with mocks
    instance.cleanMocks = function() as void
        if m.mocks = invalid
            return
        end if
        for each id in m.mocks
            mock = m.mocks[id]
            mock.target.__mocks = invalid
        end for
        m.mocks = invalid
        rooibos_resetMocksByFunctionName()
    end function
    ' Cleans up all tracking data associated with stubs
    instance.cleanStubs = function() as void
        ' Clean up the global functions mocks as well
        globalAa = getGlobalAa()
        globalAa.__globalStubs = invalid
        if m.stubs = invalid
            return
        end if
        for each id in m.stubs
            stub = m.stubs[id]
            stub.target.__stubs = invalid
        end for
        m.stubs = invalid
        rooibos_resetMocksByFunctionName()
    end function
    instance.mockFail = function(lineNumber, methodName, message) as dynamic
        if m.currentResult.isFail
            return false
        end if
        m.fail("mock failure on '" + methodName + "' : " + message, "", "", true)
        return false
    end function
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    '++ Fake Stub callback functions - this is required to get scope
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ' @ignore
    instance.stubCallback0 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["0"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback1 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["1"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback2 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["2"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback3 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["3"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback4 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["4"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback5 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["5"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback6 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["6"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback7 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["7"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback8 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["8"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback9 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["9"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback10 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["10"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback11 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["11"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback12 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["12"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback13 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["13"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback14 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["14"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback15 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["15"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback16 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["16"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback17 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["17"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback18 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["18"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback19 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["19"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback20 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["20"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback21 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["21"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback22 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["22"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback23 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["23"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback24 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["24"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.stubCallback25 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__Stubs["25"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    '++ Fake Mock callback functions - this is required to get scope
    '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ' @ignore
    instance.mockCallback0 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["0"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.mockCallback1 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["1"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.mockCallback2 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["2"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    instance.mockCallback3 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["3"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.mockCallback4 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["4"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.mockCallback5 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["5"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.mockCallback6 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["6"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.mockCallback7 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["7"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.mockCallback8 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["8"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.mockCallback9 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["9"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.mockCallback10 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["10"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.mockCallback11 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["11"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.mockCallback12 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["12"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.mockCallback13 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["13"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.mockCallback14 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["14"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.mockCallback15 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["15"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.mockCallback16 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["16"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.mockCallback17 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["17"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.mockCallback18 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["18"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.mockCallback19 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["19"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.mockCallback20 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["20"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.mockCallback21 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["21"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.mockCallback22 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["22"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.mockCallback23 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["23"]
        return fake.callback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    end function
    ' @ignore
    instance.mockCallback24 = function(arg1 = invalid, arg2 = invalid, arg3 = invalid, arg4 = invalid, arg5 = invalid, arg6 = invalid, arg7 = invalid, arg8 = invalid, arg9 = invalid, arg10 = invalid, arg11 = invalid, arg12 = invalid, arg13 = invalid, arg14 = invalid, arg15 = invalid) as dynamic
        'bs:disable-next-line
        fake = m.__mocks["24"]
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
            rooibos_common_logDebug(("Waiting for signal field '" + bslib_toString(fieldName) + "' - " + bslib_toString(attempts)))
        end while
        return true
    end function
    instance.wait = function(delay = 1)
        port = CreateObject("roMessagePort")
        wait(delay, port)
    end function
    instance.done = function()
        rooibos_common_logTrace("Async test is complete")
        if m.isDoneCalled = false
            m.isDoneCalled = true
            deferred = m.currentGroup?.currentTest?.deferred
            if rooibos_promises_isPromise(deferred)
                rooibos_promises_resolve(true, deferred)
            end if
        else
            rooibos_common_logWarning("extra done call after test is done! Did you properly clean up your observers?")
        end if
    end function
    ' @ignore
    instance.testSuiteDone = function()
        rooibos_common_logTrace("Indicating test suite is done")
        m.notifyReportersOnSuiteComplete()
        m.testRunner.top.rooibosTestResult = {
            stats: m.stats
            tests: m.tests
            groups: m.groups
        }
    end function
    instance.assertAsyncField = function(target, fieldName, delay = 500, maxAttempts = 10)
        try
            if m.currentResult.isFail
                return false
            end if
            if target = invalid
                m.fail("Target was invalid", "", "", true)
            end if
            result = m.waitForField(target, fieldName, delay, maxAttempts)
            if not result
                return m.fail("Timeout waiting for targetField " + fieldName + " to be set on target", "", "", true)
            end if
            return true
        catch error
            'bs:disable-next-line
            m.currentResult.fail("Error while waiting: " + error.message, m.currentAssertLineNumber)
        end try
        return false
    end function
    ' @ignore
    instance.createNodeClass = function(clazz, useClassAsTop = true, nodeTop = rooibos_utils_MockNode("top"), nodeGlobal = rooibos_utils_MockNode("top"))
        'bs:disable-next-line
        instance = tests_maestro_nodeClassUtils_createNodeClass(clazz, nodeTop, nodeGlobal)
        if instance <> invalid and useClassAsTop
            'note - we use the clazz itself as TOP, so that we don't have to write tests that do
            'thing.top.value, thing.top.value2, etc all over the place
            instance.append(nodeTop)
            instance.top = instance
            instance.__rooibosSkipFields = {
                "top": true
            }
        end if
        return instance
    end function
    ' @ignore
    instance.createMockViews = function(instance as dynamic, bundlePath as string, viewsPath = "views" as string)
        bundle = m.global.testStyleManager.callfunc("loadBundle", bundlePath)
        'bs:disable-next-line
        ids = mv_getIdsFromStyleJson(mc_getArray(bundle, viewsPath))
        for each id in ids
            instance[id] = {
                id: id
            }
        end for
    end function
    ' @ignore
    instance.notifyReportersOnSuiteBegin = sub()
        for each reporter in m.testReporters
            if rooibos_common_isFunction(reporter.onSuiteBegin)
                reporter.onSuiteBegin({
                    suite: m
                })
            end if
        end for
    end sub
    ' @ignore
    instance.notifyReportersOnSuiteComplete = sub()
        for each reporter in m.testReporters
            if rooibos_common_isFunction(reporter.onSuiteComplete)
                reporter.onSuiteComplete({
                    suite: m
                })
            end if
        end for
    end sub
    return instance
end function
function rooibos_BaseTestSuite()
    instance = __rooibos_BaseTestSuite_builder()
    instance.new()
    return instance
end function

' @ignore
function rooibos_getMocksByFunctionName()
    if m._rMocksByFunctionName = invalid
        m._rMocksByFunctionName = {}
    end if
    return m._rMocksByFunctionName
end function

' @ignore
function rooibos_resetMocksByFunctionName()
    m._rMocksByFunctionName = invalid
end function

' @ignore
function rooibos_getMockForFunction(functionName as string)
    return rooibos_getMocksByFunctionName()[functionName]
end function

' @ignore
function rooibos_isFunctionMocked(functionName as string)
    return rooibos_getMockForFunction(functionName) <> invalid
end function
'//# sourceMappingURL=./BaseTestSuite.brs.map