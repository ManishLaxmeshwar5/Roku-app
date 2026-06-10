'import "pkg:/source/tests/BaseTestSuite.spec.bs"
function __tests_Detailtest_builder()
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
            toast: createObject("roAssociativeArray")
        })
        m.node.top.addFields({
            itemContent: createObject("ROSGNode", "ContentNode")
        })
        m.contentNode = createObject("ROSGNode", "ContentNode")
        m.contentNode.addFields({
            "id": "movie-1"
            "title": "Test Movie"
            "HDPosterUrl": "http://fake.com/poster.jpg"
            "ShortDescriptionLine1": "Test Title"
            "ShortDescriptionLine2": "Test Description"
        })
        print "Setup completes"
        'Setup the logger or anything else you need for all your tests
    end function
    instance.rooiboos_test_case_fc1c997a83f6554098d68998b205ddb6_0 = function()
        print "Testing updateUI"
        m.node.top.itemContent = m.contentNode
        'bs:disable-next-line
        result = updateUI()
        m.currentAssertLineNumber = 45
        m.assertEqual(m.node.poster.uri, "http://fake.com/poster.jpg")
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 46
        m.assertEqual(m.node.bgPoster.uri, "http://fake.com/poster.jpg")
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 47
        m.assertEqual(m.node.title.text, "Test Title")
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 48
        m.assertEqual(m.node.desc.text, "Test Description")
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 49
        m.assertEqual(m.node.watchLaterIcon.opacity, 0.5)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.node.viewModel.isInWatchLater = true
        'bs:disable-next-line
        result = updateUI()
        m.currentAssertLineNumber = 54
        m.assertEqual(m.node.watchLaterIcon.opacity, 1.0)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
    end function
    instance.rooiboos_test_case_fc1c997a83f6554098d68998b205ddb6_1 = function()
        'bs:disable-next-line
        result = setupAutoPlay()
        m.currentAssertLineNumber = 62
        m.assertEqual(CInt(m.node.autoPlayTimer.duration), 0)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 63
        m.assertEqual(m.node.autoPlayTimer.repeat, false)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
    end function
    instance.rooiboos_test_case_fc1c997a83f6554098d68998b205ddb6_2 = function()
        m.node.watchLaterFocused = true
        'bs:disable-next-line
        result = onFocusRequest()
        m.currentAssertLineNumber = 72
        m.assertTrue(m.node.watchLaterGroup.hasFocus())
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 73
        m.assertFalse(m.node.playBtn.hasFocus())
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.node.watchLaterFocused = false
        'bs:disable-next-line
        result = onFocusRequest()
        m.currentAssertLineNumber = 78
        m.assertFalse(m.node.watchLaterGroup.hasFocus())
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 79
        m.assertTrue(m.node.playBtn.hasFocus())
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
    end function
    instance.rooiboos_test_case_fc1c997a83f6554098d68998b205ddb6_3 = function()
        content = {
            title: "Batman"
            ShortDescriptionLine1: "Batman"
        }
        m.node.itemContent = content
        m.global.addFields({
            watchLaterList: []
            currentLang: "en"
            toast: invalid
        })
        m.node.watchLaterIcon.opacity = 0.5
        m.node.watchLaterModel = {
            toggleWatchLater: function(content, list)
                return {
                    added: true
                    updatedList: [
                        {
                            title: "Batman"
                        }
                    ]
                }
            end function
        }
        m.node.json = {
            messages: {
                watchlater_added: {
                    en: "Added to Watch Later"
                }
            }
        }
        'bs:disable-next-line
        watchLater()
        m.currentAssertLineNumber = 124
        m.assertEqual(m.node.watchLaterIcon.opacity, 1.0)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 125
        m.assertEqual(m.global.watchLaterList.count(), 1)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 126
        m.assertEqual(m.global.toast.message, "Added to Watch Later")
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
    end function
    instance.rooiboos_test_case_fc1c997a83f6554098d68998b205ddb6_4 = function()
        content = {
            title: "Batman"
            ShortDescriptionLine1: "Batman"
        }
        m.node.itemContent = content
        m.global.addFields({
            watchLaterList: [
                {
                    title: "Batman"
                }
            ]
            currentLang: "en"
            toast: invalid
        })
        m.node.watchLaterIcon.opacity = 1.0
        m.node.watchLaterModel = {
            toggleWatchLater: function(content, list)
                return {
                    added: false
                    updatedList: []
                }
            end function
        }
        m.node.json = {
            messages: {
                watchlater_removed: {
                    en: "Removed from Watch Later"
                }
            }
        }
        'bs:disable-next-line
        watchLater()
        m.currentAssertLineNumber = 172
        m.assertEqual(m.node.watchLaterIcon.opacity, 0.5)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 173
        m.assertEqual(m.global.watchLaterList.count(), 0)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 174
        m.assertEqual(m.global.toast.message, "Removed from Watch Later")
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
    end function
    instance.rooiboos_test_case_fc1c997a83f6554098d68998b205ddb6_5 = function()
        m.node.watchLaterFocused = false
        'bs:disable-next-line
        result = onKeyEvent("right", true)
        m.currentAssertLineNumber = 183
        m.assertTrue(result)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 184
        m.assertTrue(m.node.watchLaterFocused)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 185
        m.assertFalse(m.node.playBtn.hasFocus())
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
    end function
    instance._ = function()
        m.node.watchLaterFocused = true
        'bs:disable-next-line
        result = onKeyEvent("left", true)
        m.assertTrue(result)
        m.assertFalse(m.node.watchLaterFocused)
        m.assertTrue(m.node.playBtn.hasFocus())
    end function
    instance.rooiboos_test_case_fc1c997a83f6554098d68998b205ddb6_6 = function()
        m.node.watchLaterFocused = true
        m.node.itemContent = {
            ShortDescriptionLine1: "Batman"
        }
        m.global.addFields({
            watchLaterList: []
            currentLang: "en"
        })
        m.watchLaterModel = {
            toggleWatchLater: function(content, list)
                return {
                    added: true
                    updatedList: [
                        {
                            title: "Batman"
                        }
                    ]
                }
            end function
        }
        m.json = {
            messages: {
                watchlater_added: {
                    en: "Added"
                }
            }
        }
        'bs:disable-next-line
        result = onKeyEvent("OK", true)
        m.currentAssertLineNumber = 231
        m.assertTrue(result)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
        m.currentAssertLineNumber = 232
        m.assertEqual(m.node.watchLaterIcon.opacity, 0.5)
        if m.currentResult?.isFail = true then
            m.done()
            return invalid
        end if
    end function
    instance.rooiboos_test_case_fc1c997a83f6554098d68998b205ddb6_7 = function()
        m.viewModel = {
            getNavigationPayload: function()
                return {
                    type: "navigate"
                    screen: "VideoPlayer"
                }
            end function
        }
        'bs:disable-next-line
        onPlayButtonSelected()
    end function
    instance.super1_getTestSuiteData = instance.getTestSuiteData
    instance.getTestSuiteData = function()
        return {
            name: "DetailscreenTests"
            isSolo: false
            noCatch: false
            isIgnored: false
            isAsync: false
            pkgPath: "source/tests/components/screens/HomeScreen/DetailScreenTest.spec.bs"
            filePath: "/Users/manishkumarsl/Desktop/Manish_Roku/demo/Roku-app/source/tests/components/screens/HomeScreen/DetailScreenTest.spec.bs"
            lineNumber: 8
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
            nodeName: "DetailScreen"
            generatedNodeName: "DetailscreenTests"
            testGroups: [
                {
                    name: "DetailscreenTest"
                    isSolo: false
                    isIgnored: false
                    isAsync: false
                    filename: "source/tests/components/screens/HomeScreen/DetailScreenTest.spec.bs"
                    lineNumber: "10"
                    setupFunctionName: ""
                    tearDownFunctionName: ""
                    beforeEachFunctionName: ""
                    afterEachFunctionName: ""
                    testCases: [
                        {
                            isSolo: false
                            noCatch: false
                            funcName: "rooiboos_test_case_fc1c997a83f6554098d68998b205ddb6_0"
                            isIgnored: false
                            isAsync: false
                            asyncTimeout: 2000
                            slow: 75
                            isParamTest: false
                            name: "UpdateUI: Test"
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
                            funcName: "rooiboos_test_case_fc1c997a83f6554098d68998b205ddb6_1"
                            isIgnored: false
                            isAsync: false
                            asyncTimeout: 2000
                            slow: 75
                            isParamTest: false
                            name: "setupAutoPlay: Test"
                            lineNumber: 58
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
                            funcName: "rooiboos_test_case_fc1c997a83f6554098d68998b205ddb6_2"
                            isIgnored: false
                            isAsync: false
                            asyncTimeout: 2000
                            slow: 75
                            isParamTest: false
                            name: "onFocusRequest: Test"
                            lineNumber: 67
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
                            funcName: "rooiboos_test_case_fc1c997a83f6554098d68998b205ddb6_3"
                            isIgnored: false
                            isAsync: false
                            asyncTimeout: 2000
                            slow: 75
                            isParamTest: false
                            name: "watchLater adds item to watch later"
                            lineNumber: 83
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
                            funcName: "rooiboos_test_case_fc1c997a83f6554098d68998b205ddb6_4"
                            isIgnored: false
                            isAsync: false
                            asyncTimeout: 2000
                            slow: 75
                            isParamTest: false
                            name: "watchLater removes item from watch later"
                            lineNumber: 131
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
                            funcName: "rooiboos_test_case_fc1c997a83f6554098d68998b205ddb6_5"
                            isIgnored: false
                            isAsync: false
                            asyncTimeout: 2000
                            slow: 75
                            isParamTest: false
                            name: "onKeyEvent: right"
                            lineNumber: 179
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
                            funcName: "rooiboos_test_case_fc1c997a83f6554098d68998b205ddb6_6"
                            isIgnored: false
                            isAsync: false
                            asyncTimeout: 2000
                            slow: 75
                            isParamTest: false
                            name: "onKeyEvent: OK on WatchLater"
                            lineNumber: 199
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
                            funcName: "rooiboos_test_case_fc1c997a83f6554098d68998b205ddb6_7"
                            isIgnored: false
                            isAsync: false
                            asyncTimeout: 2000
                            slow: 75
                            isParamTest: false
                            name: "onKeyEvent: OK on Play"
                            lineNumber: 236
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
function tests_Detailtest()
    instance = __tests_Detailtest_builder()
    instance.new()
    return instance
end function
'//# sourceMappingURL=./DetailScreenTest.spec.brs.map