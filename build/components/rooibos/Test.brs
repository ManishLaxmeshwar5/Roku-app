' @ignore
function __rooibos_Test_builder()
    RBS_CC_33_reportLine("2", 1)
    instance = {}
    RBS_CC_33_reportLine("3", 1)
    instance.new = function(testGroup, data, testSuite = invalid)
        RBS_CC_33_reportLine("4", 1)
        m.name = invalid
        RBS_CC_33_reportLine("5", 1)
        m.isSolo = invalid
        RBS_CC_33_reportLine("6", 1)
        m.noCatch = false
        RBS_CC_33_reportLine("7", 1)
        m.funcName = invalid
        RBS_CC_33_reportLine("8", 1)
        m.isIgnored = invalid
        RBS_CC_33_reportLine("9", 1)
        m.lineNumber = invalid
        RBS_CC_33_reportLine("10", 1)
        m.paramLineNumber = invalid
        RBS_CC_33_reportLine("11", 1)
        m.testSuite = invalid
        RBS_CC_33_reportLine("12", 1)
        m.testGroup = invalid
        RBS_CC_33_reportLine("13", 1)
        m.deferred = invalid
        RBS_CC_33_reportLine("14", 1)
        m.rawParams = invalid
        RBS_CC_33_reportLine("15", 1)
        m.paramTestIndex = invalid
        RBS_CC_33_reportLine("16", 1)
        m.isParamTest = false
        RBS_CC_33_reportLine("17", 1)
        m.isParamsValid = false
        RBS_CC_33_reportLine("18", 1)
        m.expectedNumberOfParams = 0
        RBS_CC_33_reportLine("19", 1)
        m.result = invalid
        RBS_CC_33_reportLine("20", 1)
        m.testGroup = testGroup
        if RBS_CC_33_reportLine("21", 2) and (testSuite <> invalid)
            RBS_CC_33_reportLine("21", 3)
            RBS_CC_33_reportLine("22", 1)
            m.testSuite = testSuite
        else
            RBS_CC_33_reportLine("23", 3)
            RBS_CC_33_reportLine("24", 1)
            m.testSuite = testGroup.testSuite
        end if
        RBS_CC_33_reportLine("26", 1)
        m.isSolo = data.isSolo
        RBS_CC_33_reportLine("27", 1)
        m.noCatch = data.noCatch
        RBS_CC_33_reportLine("28", 1)
        m.funcName = data.funcName
        RBS_CC_33_reportLine("29", 1)
        m.isIgnored = data.isIgnored
        RBS_CC_33_reportLine("30", 1)
        m.isAsync = data.isAsync
        RBS_CC_33_reportLine("31", 1)
        m.asyncTimeout = data.asyncTimeout
        RBS_CC_33_reportLine("32", 1)
        m.slow = data.slow
        RBS_CC_33_reportLine("33", 1)
        m.name = data.name
        RBS_CC_33_reportLine("34", 1)
        m.lineNumber = data.lineNumber
        RBS_CC_33_reportLine("35", 1)
        m.paramLineNumber = data.paramLineNumber
        RBS_CC_33_reportLine("36", 1)
        m.rawParams = data.rawParams
        RBS_CC_33_reportLine("37", 1)
        m.paramTestIndex = data.paramTestIndex
        RBS_CC_33_reportLine("38", 1)
        m.isParamTest = data.isParamTest
        RBS_CC_33_reportLine("39", 1)
        m.expectedNumberOfParams = data.expectedNumberOfParams
        if RBS_CC_33_reportLine("40", 2) and (m.testSuite.isNodeTest)
            RBS_CC_33_reportLine("40", 3)
            RBS_CC_33_reportLine("41", 1)
            m.deferred = rooibos_promises_create()
        end if
        if RBS_CC_33_reportLine("43", 2) and (m.isParamTest)
            RBS_CC_33_reportLine("43", 3)
            RBS_CC_33_reportLine("44", 1)
            m.name = m.name + stri(m.paramTestIndex)
        end if
        RBS_CC_33_reportLine("46", 1)
        m.result = rooibos_TestResult(m)
    end function
    RBS_CC_33_reportLine("48", 1)
    instance.run = function()
        RBS_CC_33_reportLine("49", 1)
        m.rooibosTimer = createObject("roTimespan")
        if RBS_CC_33_reportLine("50", 2) and (m.isParamTest)
            RBS_CC_33_reportLine("50", 3)
            RBS_CC_33_reportLine("51", 1)
            m.rooibosTimer.mark()
            RBS_CC_33_reportLine("52", 1)
            promise = m.runParamsTest()
        else
            RBS_CC_33_reportLine("53", 3)
            RBS_CC_33_reportLine("54", 1)
            promise = m.testSuite[m.funcName]()
        end if
        if RBS_CC_33_reportLine("56", 2) and (rooibos_promises_isPromise(promise))
            RBS_CC_33_reportLine("56", 3)
            if RBS_CC_33_reportLine("57", 2) and (m.testSuite.isNodeTest)
                RBS_CC_33_reportLine("57", 3)
                RBS_CC_33_reportLine("58", 1)
                m.markDoneWhenTestCompletes(promise)
            else
                RBS_CC_33_reportLine("59", 3)
                throw "Can not return a promise from a non-node test"
            end if
        else if RBS_CC_33_reportLine("62", 2) and (m.testSuite.isNodeTest and not m.isAsync)
            RBS_CC_33_reportLine("62", 3)
            ' The test is a node test and not async so we need to resolve the deferred
            ' immediately
            RBS_CC_33_reportLine("65", 1)
            m.recordExecutionTime()
            RBS_CC_33_reportLine("66", 1)
            rooibos_promises_resolve(invalid, m.deferred)
        end if
        if RBS_CC_33_reportLine("68", 2) and (m.deferred <> invalid)
            RBS_CC_33_reportLine("68", 3)
            RBS_CC_33_reportLine("69", 1)
            m.recordExecutionTimeWhenDone()
            RBS_CC_33_reportLine("70", 1)
            m.registerTimeout()
        else
            RBS_CC_33_reportLine("71", 3)
            RBS_CC_33_reportLine("72", 1)
            m.recordExecutionTime()
        end if
        RBS_CC_33_reportLine("74", 1)
        return m.deferred
    end function
    ' Sets up a promise chain to link the deferred to the test promise results
    ' and resolves or rejects the deferred based on the result of the test promise.
    ' Also records the execution time of the test if not already recorded.
    RBS_CC_33_reportLine("79", 1)
    instance.markDoneWhenTestCompletes = function(testPromise)
        RBS_CC_33_reportLine("80", 1)
        rooibos_promises_chain(testPromise, m).then(sub(result, m)
            RBS_CC_33_reportLine("81", 1)
            m.recordExecutionTime()
            RBS_CC_33_reportLine("82", 1)
            rooibos_common_logDebug("Test promise resolved")
            RBS_CC_33_reportLine("83", 1)
            rooibos_promises_resolve(result, m.deferred)
        end sub).catch(sub(error, m)
            RBS_CC_33_reportLine("85", 1)
            m.recordExecutionTime()
            RBS_CC_33_reportLine("86", 1)
            rooibos_common_logDebug("Test promise rejected")
            RBS_CC_33_reportLine("87", 1)
            rooibos_promises_reject(error, m.deferred)
        end sub)
    end function
    RBS_CC_33_reportLine("90", 1)
    instance.registerTimeout = function()
        RBS_CC_33_reportLine("91", 1)
        rooibos_promises_internal_delay(sub(m)
            if RBS_CC_33_reportLine("92", 2) and (not rooibos_promises_isComplete(m.deferred))
                RBS_CC_33_reportLine("92", 3)
                RBS_CC_33_reportLine("93", 1)
                m.recordExecutionTime(m.asyncTimeout)
                RBS_CC_33_reportLine("94", 1)
                m.testSuite.fail(("Test execution exceeded " + bslib_toString(m.asyncTimeout) + "ms"))
                RBS_CC_33_reportLine("95", 1)
                rooibos_promises_resolve(invalid, m.deferred)
            end if
        end sub, m, m.asyncTimeout / 1000)
    end function
    RBS_CC_33_reportLine("99", 1)
    instance.recordExecutionTimeWhenDone = function()
        RBS_CC_33_reportLine("100", 1)
        rooibos_promises_chain(m.deferred, m).then(sub(result, m)
            RBS_CC_33_reportLine("101", 1)
            m.recordExecutionTime()
            RBS_CC_33_reportLine("102", 1)
            rooibos_promises_resolve(result, m.deferred)
        end sub).catch(sub(error, m)
            RBS_CC_33_reportLine("104", 1)
            m.recordExecutionTime()
            RBS_CC_33_reportLine("105", 1)
            rooibos_promises_reject(error, m.deferred)
        end sub)
    end function
    RBS_CC_33_reportLine("108", 1)
    instance.recordExecutionTime = function(time = m.rooibosTimer.totalMilliseconds())
        if RBS_CC_33_reportLine("109", 2) and (m.result.time = -1)
            RBS_CC_33_reportLine("109", 3)
            RBS_CC_33_reportLine("110", 1)
            m.result.time = time
        end if
    end function
    RBS_CC_33_reportLine("113", 1)
    instance.runParamsTest = function()
        RBS_CC_33_reportLine("114", 1)
        testParams = m.getTestParams()
        if RBS_CC_33_reportLine("115", 2) and (m.expectedNumberOfParams = 1)
            RBS_CC_33_reportLine("115", 3)
            RBS_CC_33_reportLine("116", 1)
            m.rooibosTimer.mark()
            RBS_CC_33_reportLine("117", 1)
            return m.testSuite[m.funcName](testParams[0])
        else if RBS_CC_33_reportLine("118", 2) and (m.expectedNumberOfParams = 2)
            RBS_CC_33_reportLine("118", 3)
            RBS_CC_33_reportLine("119", 1)
            m.rooibosTimer.mark()
            RBS_CC_33_reportLine("120", 1)
            return m.testSuite[m.funcName](testParams[0], testParams[1])
        else if RBS_CC_33_reportLine("121", 2) and (m.expectedNumberOfParams = 3)
            RBS_CC_33_reportLine("121", 3)
            RBS_CC_33_reportLine("122", 1)
            m.rooibosTimer.mark()
            RBS_CC_33_reportLine("123", 1)
            return m.testSuite[m.funcName](testParams[0], testParams[1], testParams[2])
        else if RBS_CC_33_reportLine("124", 2) and (m.expectedNumberOfParams = 4)
            RBS_CC_33_reportLine("124", 3)
            RBS_CC_33_reportLine("125", 1)
            m.rooibosTimer.mark()
            RBS_CC_33_reportLine("126", 1)
            return m.testSuite[m.funcName](testParams[0], testParams[1], testParams[2], testParams[3])
        else if RBS_CC_33_reportLine("127", 2) and (m.expectedNumberOfParams = 5)
            RBS_CC_33_reportLine("127", 3)
            RBS_CC_33_reportLine("128", 1)
            m.rooibosTimer.mark()
            RBS_CC_33_reportLine("129", 1)
            return m.testSuite[m.funcName](testParams[0], testParams[1], testParams[2], testParams[3], testParams[4])
        else if RBS_CC_33_reportLine("130", 2) and (m.expectedNumberOfParams = 6)
            RBS_CC_33_reportLine("130", 3)
            RBS_CC_33_reportLine("131", 1)
            m.rooibosTimer.mark()
            RBS_CC_33_reportLine("132", 1)
            return m.testSuite[m.funcName](testParams[0], testParams[1], testParams[2], testParams[3], testParams[4], testParams[5])
        else if RBS_CC_33_reportLine("133", 2) and (m.expectedNumberOfParams = 7)
            RBS_CC_33_reportLine("133", 3)
            RBS_CC_33_reportLine("134", 1)
            m.rooibosTimer.mark()
            RBS_CC_33_reportLine("135", 1)
            return m.testSuite[m.funcName](testParams[0], testParams[1], testParams[2], testParams[3], testParams[4], testParams[5], testParams[6])
        else if RBS_CC_33_reportLine("136", 2) and (m.expectedNumberOfParams = 8)
            RBS_CC_33_reportLine("136", 3)
            RBS_CC_33_reportLine("137", 1)
            m.rooibosTimer.mark()
            RBS_CC_33_reportLine("138", 1)
            return m.testSuite[m.funcName](testParams[0], testParams[1], testParams[2], testParams[3], testParams[4], testParams[5], testParams[6], testParams[7])
        else if RBS_CC_33_reportLine("139", 2) and (m.expectedNumberOfParams = 9)
            RBS_CC_33_reportLine("139", 3)
            RBS_CC_33_reportLine("140", 1)
            m.rooibosTimer.mark()
            RBS_CC_33_reportLine("141", 1)
            return m.testSuite[m.funcName](testParams[0], testParams[1], testParams[2], testParams[3], testParams[4], testParams[5], testParams[6], testParams[7], testParams[8])
        else if RBS_CC_33_reportLine("142", 2) and (m.expectedNumberOfParams = 10)
            RBS_CC_33_reportLine("142", 3)
            RBS_CC_33_reportLine("143", 1)
            m.rooibosTimer.mark()
            RBS_CC_33_reportLine("144", 1)
            return m.testSuite[m.funcName](testParams[0], testParams[1], testParams[2], testParams[3], testParams[4], testParams[5], testParams[6], testParams[7], testParams[8], testParams[9])
        else if RBS_CC_33_reportLine("145", 2) and (m.expectedNumberOfParams = 11)
            RBS_CC_33_reportLine("145", 3)
            RBS_CC_33_reportLine("146", 1)
            m.rooibosTimer.mark()
            RBS_CC_33_reportLine("147", 1)
            return m.testSuite[m.funcName](testParams[0], testParams[1], testParams[2], testParams[3], testParams[4], testParams[5], testParams[6], testParams[7], testParams[8], testParams[9], testParams[10])
        else if RBS_CC_33_reportLine("148", 2) and (m.expectedNumberOfParams = 12)
            RBS_CC_33_reportLine("148", 3)
            RBS_CC_33_reportLine("149", 1)
            m.rooibosTimer.mark()
            RBS_CC_33_reportLine("150", 1)
            return m.testSuite[m.funcName](testParams[0], testParams[1], testParams[2], testParams[3], testParams[4], testParams[5], testParams[6], testParams[7], testParams[8], testParams[9], testParams[10], testParams[11])
        else if RBS_CC_33_reportLine("151", 2) and (m.expectedNumberOfParams > 12)
            RBS_CC_33_reportLine("151", 3)
            RBS_CC_33_reportLine("152", 1)
            m.rooibosTimer.mark()
            RBS_CC_33_reportLine("153", 1)
            m.testSuite.fail("Test case had more than 12 params. Max of 12 params is supported")
        end if
    end function
    RBS_CC_33_reportLine("156", 1)
    instance.getTestParams = function()
        RBS_CC_33_reportLine("157", 1)
        params = []
        RBS_CC_33_reportLine("158", 1): for paramIndex = 0 to m.rawParams.count()
            RBS_CC_33_reportLine("159", 1)
            paramValue = m.rawParams[paramIndex]
            if RBS_CC_33_reportLine("160", 2) and (type(paramValue) = "roString" and len(paramValue) >= 8 and left(paramValue, 8) = "#RBSNode")
                RBS_CC_33_reportLine("160", 3)
                RBS_CC_33_reportLine("161", 1)
                nodeType = "ContentNode"
                RBS_CC_33_reportLine("162", 1)
                paramDirectiveArgs = paramValue.split("|")
                if RBS_CC_33_reportLine("163", 2) and (paramDirectiveArgs.count() > 1)
                    RBS_CC_33_reportLine("163", 3)
                    RBS_CC_33_reportLine("164", 1)
                    nodeType = paramDirectiveArgs[1]
                end if
                RBS_CC_33_reportLine("166", 1)
                paramValue = createObject("roSGNode", nodeType)
            end if
            RBS_CC_33_reportLine("168", 1)
            params.push(paramValue)
        end for
        RBS_CC_33_reportLine("170", 1)
        return params
    end function
    RBS_CC_33_reportLine("172", 1)
    return instance
end function

function rooibos_Test(testGroup, data, testSuite = invalid)
    RBS_CC_33_reportLine("175", 1)
    instance = __rooibos_Test_builder()
    RBS_CC_33_reportLine("176", 1)
    instance.new(testGroup, data, testSuite)
    RBS_CC_33_reportLine("177", 1)
    return instance
end function

'//# sourceMappingURL=./Test.brs.map
function RBS_CC_33_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "33"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "33"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./Test.brs.map