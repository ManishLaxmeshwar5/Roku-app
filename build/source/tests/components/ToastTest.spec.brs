'import "pkg:/source/tests/BaseTestSuite.spec.bs"
function __tests_ToastTests_builder()
    instance = __tests_BaseTestSuite_builder()
    instance.super1_new = instance.new
    instance.new = sub()
        m.super1_new()
    end sub
    instance.super1_setup = instance.setup
    instance.setup = function()
        m.global.toast = {
            message: "Hello Toast"
            duration: 3
        }
        'Setup the logger or anything else you need for all your tests
    end function
    instance.rooiboos_test_case_9d3e1b862bf8883795f8947db9aa2186_0 = function()
        'bs:disable-next-line
        onToastRequested()
        m.currentAssertLineNumber = 22
        m.assertEqual(m.node.toastLabel.text, "Hello Toast")
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 23
        m.assertEqual(m.node.top.visible, true)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 24
        m.assertEqual(m.node.slideOut.control, "stop")
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 25
        m.assertEqual(m.node.hideTimer.control, "start")
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 26
        m.assertEqual(m.node.hideAfterSlideTimer.control, "stop")
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 27
        m.assertEqual(CInt(m.node.hideTimer.duration), 3)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 28
        m.assertEqual(m.node.toastBg.translation, [
            350.0
            -270.0
        ])
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
    end function
    instance.rooiboos_test_case_9d3e1b862bf8883795f8947db9aa2186_1 = function()
        'bs:disable-next-line
        result = onHideTimer()
        print m.node
        m.currentAssertLineNumber = 36
        m.assertEqual(m.node.slideIn.control, "stop")
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 37
        m.assertEqual(m.node.slideOut.control, "start")
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 38
        m.assertEqual(m.node.hideAfterSlideTimer.control, "start")
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
    end function
    instance.rooiboos_test_case_9d3e1b862bf8883795f8947db9aa2186_2 = function()
        'bs:disable-next-line
        result = onSlideOutDone()
        m.currentAssertLineNumber = 45
        m.assertEqual(m.node.top.visible, false)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
    end function
    instance.super1_getTestSuiteData = instance.getTestSuiteData
    instance.getTestSuiteData = function()
        return {
            name: "ToastTests"
            isSolo: false
            noCatch: false
            isIgnored: false
            isAsync: false
            pkgPath: "source/tests/components/ToastTest.spec.bs"
            filePath: "/Users/manishkumarsl/Desktop/Manish_Roku/demo/Roku-app/source/tests/components/ToastTest.spec.bs"
            lineNumber: 5
            valid: true
            hasFailures: false
            hasSoloTests: false
            hasIgnoredTests: false
            hasSoloGroups: false
            setupFunctionName: ""
            tearDownFunctionName: ""
            beforeEachFunctionName: ""
            afterEachFunctionName: ""
            isNodeTest: true
            isAsync: false
            asyncTimeout: 60000
            nodeName: "Toast"
            generatedNodeName: "ToastTests"
            testGroups: [
                {
                    name: "onToastRequested"
                    isSolo: false
                    isIgnored: false
                    isAsync: false
                    filename: "source/tests/components/ToastTest.spec.bs"
                    lineNumber: "6"
                    setupFunctionName: ""
                    tearDownFunctionName: ""
                    beforeEachFunctionName: ""
                    afterEachFunctionName: ""
                    testCases: [
                        {
                            isSolo: false
                            noCatch: false
                            funcName: "rooiboos_test_case_9d3e1b862bf8883795f8947db9aa2186_0"
                            isIgnored: false
                            isAsync: false
                            asyncTimeout: 2000
                            slow: 75
                            isParamTest: false
                            name: "show toast"
                            lineNumber: 19
                            paramLineNumber: 0
                            assertIndex: 0
                            rawParams: invalid
                            paramTestIndex: 0
                            expectedNumberOfParams: 0
                            isParamsValid: true
                        }
                        {
                            isSolo: false
                            noCatch: false
                            funcName: "rooiboos_test_case_9d3e1b862bf8883795f8947db9aa2186_1"
                            isIgnored: false
                            isAsync: false
                            asyncTimeout: 2000
                            slow: 75
                            isParamTest: false
                            name: "onHideTimer : Test"
                            lineNumber: 32
                            paramLineNumber: 0
                            assertIndex: 0
                            rawParams: invalid
                            paramTestIndex: 0
                            expectedNumberOfParams: 0
                            isParamsValid: true
                        }
                        {
                            isSolo: false
                            noCatch: false
                            funcName: "rooiboos_test_case_9d3e1b862bf8883795f8947db9aa2186_2"
                            isIgnored: false
                            isAsync: false
                            asyncTimeout: 2000
                            slow: 75
                            isParamTest: false
                            name: "onSlideOutDone: slide out test"
                            lineNumber: 42
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
function tests_ToastTests()
    instance = __tests_ToastTests_builder()
    instance.new()
    return instance
end function
'//# sourceMappingURL=./ToastTest.spec.brs.map