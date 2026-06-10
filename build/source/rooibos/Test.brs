' @ignore
function __rooibos_Test_builder()
    instance = {}
    instance.new = function(testGroup, data, testSuite = invalid)
        m.name = invalid
        m.isSolo = invalid
        m.noCatch = false
        m.funcName = invalid
        m.isIgnored = invalid
        m.lineNumber = invalid
        m.paramLineNumber = invalid
        m.testSuite = invalid
        m.testGroup = invalid
        m.deferred = invalid
        m.rawParams = invalid
        m.paramTestIndex = invalid
        m.isParamTest = false
        m.isParamsValid = false
        m.expectedNumberOfParams = 0
        m.result = invalid
        m.testGroup = testGroup
        if testSuite <> invalid
            m.testSuite = testSuite
        else
            m.testSuite = testGroup.testSuite
        end if
        m.isSolo = data.isSolo
        m.noCatch = data.noCatch
        m.funcName = data.funcName
        m.isIgnored = data.isIgnored
        m.isAsync = data.isAsync
        m.asyncTimeout = data.asyncTimeout
        m.slow = data.slow
        m.name = data.name
        m.lineNumber = data.lineNumber
        m.paramLineNumber = data.paramLineNumber
        m.rawParams = data.rawParams
        m.paramTestIndex = data.paramTestIndex
        m.isParamTest = data.isParamTest
        m.expectedNumberOfParams = data.expectedNumberOfParams
        if m.testSuite.isNodeTest
            m.deferred = rooibos_promises_create()
        end if
        if m.isParamTest
            m.name = m.name + stri(m.paramTestIndex)
        end if
        m.result = rooibos_TestResult(m)
    end function
    instance.run = function()
        m.rooibosTimer = createObject("roTimespan")
        if m.isParamTest
            m.rooibosTimer.mark()
            promise = m.runParamsTest()
        else
            promise = m.testSuite[m.funcName]()
        end if
        if rooibos_promises_isPromise(promise)
            if m.testSuite.isNodeTest
                m.markDoneWhenTestCompletes(promise)
            else
                throw "Can not return a promise from a non-node test"
            end if
        else if m.testSuite.isNodeTest and not m.isAsync
            ' The test is a node test and not async so we need to resolve the deferred
            ' immediately
            m.recordExecutionTime()
            rooibos_promises_resolve(invalid, m.deferred)
        end if
        if m.deferred <> invalid
            m.recordExecutionTimeWhenDone()
            m.registerTimeout()
        else
            m.recordExecutionTime()
        end if
        return m.deferred
    end function
    ' Sets up a promise chain to link the deferred to the test promise results
    ' and resolves or rejects the deferred based on the result of the test promise.
    ' Also records the execution time of the test if not already recorded.
    instance.markDoneWhenTestCompletes = function(testPromise)
        rooibos_promises_chain(testPromise, m).then(sub(result, m)
            m.recordExecutionTime()
            rooibos_common_logDebug("Test promise resolved")
            rooibos_promises_resolve(result, m.deferred)
        end sub).catch(sub(error, m)
            m.recordExecutionTime()
            rooibos_common_logDebug("Test promise rejected")
            rooibos_promises_reject(error, m.deferred)
        end sub)
    end function
    instance.registerTimeout = function()
        rooibos_promises_internal_delay(sub(m)
            if not rooibos_promises_isComplete(m.deferred)
                m.recordExecutionTime(m.asyncTimeout)
                m.testSuite.fail(("Test execution exceeded " + bslib_toString(m.asyncTimeout) + "ms"))
                rooibos_promises_resolve(invalid, m.deferred)
            end if
        end sub, m, m.asyncTimeout / 1000)
    end function
    instance.recordExecutionTimeWhenDone = function()
        rooibos_promises_chain(m.deferred, m).then(sub(result, m)
            m.recordExecutionTime()
            rooibos_promises_resolve(result, m.deferred)
        end sub).catch(sub(error, m)
            m.recordExecutionTime()
            rooibos_promises_reject(error, m.deferred)
        end sub)
    end function
    instance.recordExecutionTime = function(time = m.rooibosTimer.totalMilliseconds())
        if m.result.time = -1
            m.result.time = time
        end if
    end function
    instance.runParamsTest = function()
        testParams = m.getTestParams()
        if m.expectedNumberOfParams = 1
            m.rooibosTimer.mark()
            return m.testSuite[m.funcName](testParams[0])
        else if m.expectedNumberOfParams = 2
            m.rooibosTimer.mark()
            return m.testSuite[m.funcName](testParams[0], testParams[1])
        else if m.expectedNumberOfParams = 3
            m.rooibosTimer.mark()
            return m.testSuite[m.funcName](testParams[0], testParams[1], testParams[2])
        else if m.expectedNumberOfParams = 4
            m.rooibosTimer.mark()
            return m.testSuite[m.funcName](testParams[0], testParams[1], testParams[2], testParams[3])
        else if m.expectedNumberOfParams = 5
            m.rooibosTimer.mark()
            return m.testSuite[m.funcName](testParams[0], testParams[1], testParams[2], testParams[3], testParams[4])
        else if m.expectedNumberOfParams = 6
            m.rooibosTimer.mark()
            return m.testSuite[m.funcName](testParams[0], testParams[1], testParams[2], testParams[3], testParams[4], testParams[5])
        else if m.expectedNumberOfParams = 7
            m.rooibosTimer.mark()
            return m.testSuite[m.funcName](testParams[0], testParams[1], testParams[2], testParams[3], testParams[4], testParams[5], testParams[6])
        else if m.expectedNumberOfParams = 8
            m.rooibosTimer.mark()
            return m.testSuite[m.funcName](testParams[0], testParams[1], testParams[2], testParams[3], testParams[4], testParams[5], testParams[6], testParams[7])
        else if m.expectedNumberOfParams = 9
            m.rooibosTimer.mark()
            return m.testSuite[m.funcName](testParams[0], testParams[1], testParams[2], testParams[3], testParams[4], testParams[5], testParams[6], testParams[7], testParams[8])
        else if m.expectedNumberOfParams = 10
            m.rooibosTimer.mark()
            return m.testSuite[m.funcName](testParams[0], testParams[1], testParams[2], testParams[3], testParams[4], testParams[5], testParams[6], testParams[7], testParams[8], testParams[9])
        else if m.expectedNumberOfParams = 11
            m.rooibosTimer.mark()
            return m.testSuite[m.funcName](testParams[0], testParams[1], testParams[2], testParams[3], testParams[4], testParams[5], testParams[6], testParams[7], testParams[8], testParams[9], testParams[10])
        else if m.expectedNumberOfParams = 12
            m.rooibosTimer.mark()
            return m.testSuite[m.funcName](testParams[0], testParams[1], testParams[2], testParams[3], testParams[4], testParams[5], testParams[6], testParams[7], testParams[8], testParams[9], testParams[10], testParams[11])
        else if m.expectedNumberOfParams > 12
            m.rooibosTimer.mark()
            m.testSuite.fail("Test case had more than 12 params. Max of 12 params is supported")
        end if
    end function
    instance.getTestParams = function()
        params = []
        for paramIndex = 0 to m.rawParams.count()
            paramValue = m.rawParams[paramIndex]
            if type(paramValue) = "roString" and len(paramValue) >= 8 and left(paramValue, 8) = "#RBSNode"
                nodeType = "ContentNode"
                paramDirectiveArgs = paramValue.split("|")
                if paramDirectiveArgs.count() > 1
                    nodeType = paramDirectiveArgs[1]
                end if
                paramValue = createObject("roSGNode", nodeType)
            end if
            params.push(paramValue)
        end for
        return params
    end function
    return instance
end function
function rooibos_Test(testGroup, data, testSuite = invalid)
    instance = __rooibos_Test_builder()
    instance.new(testGroup, data, testSuite)
    return instance
end function
'//# sourceMappingURL=./Test.brs.map