' @ignore
function __rooibos_BaseTestReporter_builder()
    instance = {}
    instance.new = sub(runner as dynamic)
        m.testRunner = invalid
        m.config = invalid
        m.allStats = invalid
        m.colorizeOutput = false
        m.testRunner = runner
        m.config = runner.config
        m.allStats = runner.stats
        m.colorizeOutput = runner.config.colorizeOutput = true
    end sub
    instance.onBegin = sub(event as object)
        'override me
        rooibos_common_logDebug("BaseTestReporter.onBegin")
    end sub
    instance.onSuiteBegin = sub(event as object)
        'override me
    end sub
    instance.onTestGroupBegin = sub(event as object)
        'override me
    end sub
    instance.onTestBegin = sub(event as object)
        'override me
    end sub
    instance.onTestComplete = sub(event as object)
        'override me
    end sub
    instance.onTestGroupComplete = sub(event as object)
        'override me
    end sub
    instance.onSuiteComplete = sub(event as object)
        'override me
    end sub
    instance.onEnd = sub(event as object)
        'override me
        rooibos_common_logDebug("BaseTestReporter.onEnd")
    end sub
    return instance
end function
function rooibos_BaseTestReporter(runner as dynamic)
    instance = __rooibos_BaseTestReporter_builder()
    instance.new(runner)
    return instance
end function
' @ignore

' @ignore

' @ignore

' @ignore

' @ignore

' @ignore

' @ignore

' @ignore
' @deprecated use rooibos.TestReporterOnEndEvent

' @ignore

'//# sourceMappingURL=./BaseTestReporter.brs.map