'import "pkg:/source/tests/BaseTestSuite.spec.bs"
function __tests_movieScreenTests_builder()
    instance = __tests_BaseTestSuite_builder()
    instance.super1_new = instance.new
    instance.new = sub()
        m.super1_new()
    end sub
    instance.super1_setup = instance.setup
    instance.setup = function()
        m.global.addFields({
            "ttsEnabled": true
            "currentLang": "en"
        })
        content = CreateObject("roSGNode", "ContentNode")
        row = content.createChild("ContentNode")
        item = row.createChild("ContentNode")
        item.title = "Test Movie"
        item.ShortDescriptionLine1 = "Test Title"
        item.ShortDescriptionLine2 = "Test Description"
        m.contentNode = content
        m.viewModel = {
            deepLinkItem: {
                title: "Test Movie"
                ShortDescriptionLine1: "Test Title"
                ShortDescriptionLine2: "Test Description"
            }
        }
    end function
    instance.rooiboos_test_case_7cc084df865c441705372819b5686674_0 = function()
        'bs:disable-next-line
        onFocusRequest()
        m.currentAssertLineNumber = 35
        m.assertTrue(m.node.movieRowList.hasFocus())
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
    end function
    instance.rooiboos_test_case_7cc084df865c441705372819b5686674_1 = function()
        m.node.movieRowList.content = m.contentNode
        m.node.movieRowList.rowItemFocused = [
            0
            0
        ]
        ? "m.global.ttsEnabled" m.global.ttsEnabled
        'bs:disable-next-line
        onMovieFocused()
        ' ? "nodes"
        ' ? m.node
        m.currentAssertLineNumber = 49
        m.assertNotInvalid(m.node.top.events)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 50
        m.assertEqual(m.node.top.events.type, "speak")
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 51
        m.assertEqual(m.node.top.events.text, "Test Title")
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
    end function
    instance.rooiboos_test_case_7cc084df865c441705372819b5686674_2 = function()
        m.node.movieRowList.content = m.contentNode
        m.node.movieRowList.rowItemSelected = [
            0
            0
        ]
        'bs:disable-next-line
        onMovieSelected()
        m.currentAssertLineNumber = 61
        m.assertNotInvalid(m.node.top.events)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 62
        m.assertEqual(m.node.top.events.type, "navigate")
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 63
        m.assertEqual(m.node.top.events.screen, "DetailScreen")
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 64
        m.assertEqual(m.node.top.events.payload.ShortDescriptionLine1, "Test Title")
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
    end function
    instance.rooiboos_test_case_7cc084df865c441705372819b5686674_3 = function()
        m.viewModel = {
            deepLinkItem: {
                title: "Test Movie"
            }
        }
        'bs:disable-next-line
        onDeepLinkItemFound()
        m.currentAssertLineNumber = 77
        m.assertTrue(true)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 78
        m.assertFalse(m.node.isDeepLink)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 79
        m.assertInvalid(m.node.deepLinkId)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 80
        m.assertInvalid(m.node.top.deepLinkPayload)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
    end function
    instance.super1_getTestSuiteData = instance.getTestSuiteData
    instance.getTestSuiteData = function()
        return {
            name: "MovieScreenTests"
            isSolo: false
            noCatch: false
            isIgnored: false
            isAsync: false
            pkgPath: "source/tests/components/screens/HomeScreen/MovieScreenTest.spec.bs"
            filePath: "/Users/manishkumarsl/Desktop/Manish_Roku/demo/Roku-app/source/tests/components/screens/HomeScreen/MovieScreenTest.spec.bs"
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
            nodeName: "MovieScreen"
            generatedNodeName: "MovieScreenTests"
            testGroups: [
                {
                    name: "MovieScreenTests"
                    isSolo: false
                    isIgnored: false
                    isAsync: false
                    filename: "source/tests/components/screens/HomeScreen/MovieScreenTest.spec.bs"
                    lineNumber: "6"
                    setupFunctionName: ""
                    tearDownFunctionName: ""
                    beforeEachFunctionName: ""
                    afterEachFunctionName: ""
                    testCases: [
                        {
                            isSolo: false
                            noCatch: false
                            funcName: "rooiboos_test_case_7cc084df865c441705372819b5686674_0"
                            isIgnored: false
                            isAsync: false
                            asyncTimeout: 2000
                            slow: 75
                            isParamTest: false
                            name: "onMovieFocusReuqest:Test"
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
                            funcName: "rooiboos_test_case_7cc084df865c441705372819b5686674_1"
                            isIgnored: false
                            isAsync: false
                            asyncTimeout: 2000
                            slow: 75
                            isParamTest: false
                            name: "onMovieFocused: Test"
                            lineNumber: 39
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
                            funcName: "rooiboos_test_case_7cc084df865c441705372819b5686674_2"
                            isIgnored: false
                            isAsync: false
                            asyncTimeout: 2000
                            slow: 75
                            isParamTest: false
                            name: "onMovieSelected: Test"
                            lineNumber: 55
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
                            funcName: "rooiboos_test_case_7cc084df865c441705372819b5686674_3"
                            isIgnored: false
                            isAsync: false
                            asyncTimeout: 2000
                            slow: 75
                            isParamTest: false
                            name: "onDeepLinkItemFound: Test"
                            lineNumber: 68
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
function tests_movieScreenTests()
    instance = __tests_movieScreenTests_builder()
    instance.new()
    return instance
end function
'//# sourceMappingURL=./MovieScreenTest.spec.brs.map