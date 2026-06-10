function __tests_H_builder()
    instance = __tests_BaseTestSuite_builder()
    instance.super1_new = instance.new
    instance.new = sub()
        m.super1_new()
    end sub
    instance.rooiboos_test_case_25356c284e817cc5f46d36235c44303b_0 = function()
        m.currentAssertLineNumber = 10
        m.assertTrue(true)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
    end function
    instance.super1_getTestSuiteData = instance.getTestSuiteData
    instance.getTestSuiteData = function()
        return {
            name: "H"
            isSolo: false
            noCatch: false
            isIgnored: false
            isAsync: false
            pkgPath: "source/tests/BasicTests.spec.bs"
            filePath: "/Users/manishkumarsl/Desktop/Manish_Roku/demo/Roku-app/source/tests/BasicTests.spec.bs"
            lineNumber: 4
            valid: true
            hasFailures: false
            hasSoloTests: false
            hasIgnoredTests: false
            hasSoloGroups: false
            setupFunctionName: ""
            tearDownFunctionName: ""
            beforeEachFunctionName: ""
            afterEachFunctionName: ""
            isNodeTest: false
            isAsync: false
            asyncTimeout: 60000
            nodeName: ""
            generatedNodeName: "H"
            testGroups: [
                {
                    name: "Basic Tests"
                    isSolo: false
                    isIgnored: false
                    isAsync: false
                    filename: "source/tests/BasicTests.spec.bs"
                    lineNumber: "6"
                    setupFunctionName: ""
                    tearDownFunctionName: ""
                    beforeEachFunctionName: ""
                    afterEachFunctionName: ""
                    testCases: [
                        {
                            isSolo: false
                            noCatch: false
                            funcName: "rooiboos_test_case_25356c284e817cc5f46d36235c44303b_0"
                            isIgnored: false
                            isAsync: false
                            asyncTimeout: 2000
                            slow: 75
                            isParamTest: false
                            name: "should pass"
                            lineNumber: 9
                            paramLineNumber: 0
                            assertIndex: 0
                            rawParams: invalid
                            paramTestIndex: 0
                            expectedNumberOfParams: 0
                            isParamsValid: true
                        }
                    ]
                }
            ]
        }
    end function
    return instance
end function
function tests_H()
    instance = __tests_H_builder()
    instance.new()
    return instance
end function
'//# sourceMappingURL=./BasicTests.spec.brs.map