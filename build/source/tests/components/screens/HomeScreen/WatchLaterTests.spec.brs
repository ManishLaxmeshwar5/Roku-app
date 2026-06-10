'import "pkg:/source/tests/BaseTestSuite.spec.bs"
function __tests_watchLaterTests_builder()
    instance = __tests_BaseTestSuite_builder()
    instance.super1_new = instance.new
    instance.new = sub()
        m.super1_new()
    end sub
    instance.super1_setup = instance.setup
    instance.setup = function()
        m.global.addFields({
            "watchLaterList": [
                {
                    "id": "movie-1"
                    "title": "Test Movie"
                }
            ]
            "currentLang": "en"
        })
        m.contentNode = createObject("ROSGNode", "ContentNode")
        m.contentNode.addFields({
            "id": "movie-1"
            "title": "Test Movie"
            "HDPosterUrl": "http://fake.com/poster.jpg"
            "ShortDescriptionLine1": "Test Title"
            "ShortDescriptionLine2": "Test Description"
            "url": "http://fake.com/movie"
        })
        m.viewModel = {
            isEmpty: true
            setWatchLaterList: function(list as object)
                m.viewModel.isEmpty = list.count() = 0
            end function
            getGridContent: function() as object
                return {}
            end function
        }
    end function
    instance.rooiboos_test_case_09e2db3270a86abb01aa188310dfcad7_0 = function()
        m.global.watchLaterList = []
        'bs:disable-next-line
        loadContent()
        m.currentAssertLineNumber = 45
        m.assertEqual(m.node.screenTitle.text, "Watch Later")
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 46
        m.assertEqual(m.node.emptyLabel.text, "Your WatchLater List is empty")
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 47
        m.assertFalse(m.node.grid.visible)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
    end function
    instance.rooiboos_test_case_09e2db3270a86abb01aa188310dfcad7_1 = function()
        m.global.watchLaterList = [
            {
                id: "1"
                title: "Test Movie"
                ShortDescriptionLine1: "Test Title"
            }
        ]
        root = m.node.grid.content
        row = root.getChild(0)
        item = row.getChild(0)
        'bs:disable-next-line
        loadContent()
        m.currentAssertLineNumber = 64
        m.assertFalse(m.node.emptyLabel.visible)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 65
        m.assertTrue(m.node.grid.visible)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 66
        m.assertEqual(item.ShortDescriptionLine1, "Test Movie")
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
    end function
    instance.rooiboos_test_case_09e2db3270a86abb01aa188310dfcad7_2 = function()
        m.global.watchLaterList = [
            {
                id: "1"
                title: "Test Movie"
            }
            {
                id: "2"
                title: "Other Movie"
            }
        ]
        m.node.grid.itemFocused = 0
        'bs:disable-next-line
        result = onKeyEvent("options", true)
        m.currentAssertLineNumber = 89
        m.assertTrue(result)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 90
        m.assertEqual(m.global.watchLaterList.count(), 1)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 91
        m.assertTrue(m.node.grid.hasFocus())
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 92
        m.assertEqual(m.global.toast.message, "Test MovieSuccessfully removed from Watch Later :(")
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
    end function
    instance.rooiboos_test_case_09e2db3270a86abb01aa188310dfcad7_3 = function()
        'bs:disable-next-line
        onFocusRequest()
        m.currentAssertLineNumber = 100
        m.assertTrue(m.node.grid.hasFocus())
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
    end function
    instance.super1_getTestSuiteData = instance.getTestSuiteData
    instance.getTestSuiteData = function()
        return {
            name: "watchLaterTests"
            isSolo: false
            noCatch: false
            isIgnored: false
            isAsync: false
            pkgPath: "source/tests/components/screens/HomeScreen/WatchLaterTests.spec.bs"
            filePath: "/Users/manishkumarsl/Desktop/Manish_Roku/demo/Roku-app/source/tests/components/screens/HomeScreen/WatchLaterTests.spec.bs"
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
            nodeName: "WatchlaterScreen"
            generatedNodeName: "watchLaterTests"
            testGroups: [
                {
                    name: "WatchLaterScreenTests"
                    isSolo: false
                    isIgnored: false
                    isAsync: false
                    filename: "source/tests/components/screens/HomeScreen/WatchLaterTests.spec.bs"
                    lineNumber: "6"
                    setupFunctionName: ""
                    tearDownFunctionName: ""
                    beforeEachFunctionName: ""
                    afterEachFunctionName: ""
                    testCases: [
                        {
                            isSolo: false
                            noCatch: false
                            funcName: "rooiboos_test_case_09e2db3270a86abb01aa188310dfcad7_0"
                            isIgnored: false
                            isAsync: false
                            asyncTimeout: 2000
                            slow: 75
                            isParamTest: false
                            name: "loadContent watchLater Empty: Test"
                            lineNumber: 40
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
                            funcName: "rooiboos_test_case_09e2db3270a86abb01aa188310dfcad7_1"
                            isIgnored: false
                            isAsync: false
                            asyncTimeout: 2000
                            slow: 75
                            isParamTest: false
                            name: "loadContent watchLater not empty: Test"
                            lineNumber: 51
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
                            funcName: "rooiboos_test_case_09e2db3270a86abb01aa188310dfcad7_2"
                            isIgnored: false
                            isAsync: false
                            asyncTimeout: 2000
                            slow: 75
                            isParamTest: false
                            name: "onKeyEvent options removes selected item and sets toast"
                            lineNumber: 71
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
                            funcName: "rooiboos_test_case_09e2db3270a86abb01aa188310dfcad7_3"
                            isIgnored: false
                            isAsync: false
                            asyncTimeout: 2000
                            slow: 75
                            isParamTest: false
                            name: "onFocusRequest: Test"
                            lineNumber: 96
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
function tests_watchLaterTests()
    instance = __tests_watchLaterTests_builder()
    instance.new()
    return instance
end function
'//# sourceMappingURL=./WatchLaterTests.spec.brs.map