' @ignore
function __rooibos_RuntimeConfig_builder()
    instance = {}
    instance.new = function()
        m.testSuites = m.getTestSuiteClassMap()
    end function
    instance.getVersionText = function()
        return "5.15.7"
    end function
    instance.getRuntimeConfig = function()
        return {
            "reporters": [
                rooibos_ConsoleTestReporter
            ]
            "failFast": false
            "sendHomeOnFinish": false
            "logLevel": 0
            "showOnlyFailures": false
            "printTestTimes": true
            "lineWidth": 70
            "printLcov": false
            "port": "invalid"
            "catchCrashes": true
            "colorizeOutput": false
            "throwOnFailedAssertion": false
            "keepAppOpen": true
            "isRecordingCodeCoverage": true
        }
    end function
    instance.getTestSuiteClassMap = function()
        return {
            "DetailscreenTests": tests_Detailtest
            "H": tests_H
            "MovieScreenTests": tests_movieScreenTests
            "ToastTests": tests_ToastTests
            "watchLaterTests": tests_watchLaterTests
        }
    end function
    instance.getTestSuiteClassWithName = function(name)
        return m.testSuites[name]
    end function
    instance.getAllTestSuitesNames = function()
        return m.testSuites.keys()
    end function
    instance.getIgnoredTestInfo = function()
        return {
            "count": 0
            "items": []
        }
    end function
    return instance
end function
function rooibos_RuntimeConfig()
    instance = __rooibos_RuntimeConfig_builder()
    instance.new()
    return instance
end function
'//# sourceMappingURL=./RuntimeConfig.brs.map