' @ignore
function __rooibos_TestResult_builder()
    instance = {}
    instance.new = function(test)
        m.isFail = false
        m.isCrash = false
        m.isSkipped = false
        m.actual = invalid
        m.expected = invalid
        m.message = ""
        m.lineNumber = -1
        m.test = invalid
        m.time = -1
        m.error = invalid
        m.throwOnFailedAssertion = false
        m.test = test
    end function
    instance.merge = function(other)
        m.isFail = other.isFail
        m.isCrash = other.isCrash
        m.actual = other.actual
        m.expected = other.expected
        m.message = other.message
        m.lineNumber = other.lineNumber
        m.time = other.time
        m.error = other.error
    end function
    instance.reset = function() as void
        m.isFail = false
        m.isCrash = false
        m.time = -1
        m.message = ""
        m.lineNumber = -1
    end function
    instance.fail = function(message as string, lineNumber = -1, actual = "", expected = "", error = invalid)
        if message <> "" and not m.isFail
            if not m.isFail
                m.lineNumber = lineNumber
                m.isFail = true
                m.message = message
                m.actual = actual
                m.expected = expected
                m.error = error
            end if
        end if
        if m.throwOnFailedAssertion
            throw m.getMessage()
        end if
    end function
    instance.skip = function(message as string)
        if message <> "" and not m.isFail
            if not m.isFail
                m.isSkipped = true
                m.message = message
            end if
        end if
    end function
    instance.crash = function(message as string, error)
        if message <> "" and not m.isCrash
            if not m.isCrash
                m.error = error
                m.message = "test crashed!"
                m.isFail = true
                m.isCrash = true
            end if
        end if
    end function
    instance.getMessage = function() as string
        if m.isFail
            if m.message <> invalid
                return m.message
            else
                return "unknown test failure"
            end if
        else if m.isCrash
            if m.message <> invalid
                return m.message
            else
                return "unknown test crash"
            end if
        else
            return ""
        end if
    end function
    instance.getStatusText = function()
        if m.isCrash
            return "CRASH"
        else if m.isFail
            return "FAIL"
        else if m.isSkipped
            return "SKIP"
        else
            return "PASS"
        end if
    end function
    return instance
end function
function rooibos_TestResult(test)
    instance = __rooibos_TestResult_builder()
    instance.new(test)
    return instance
end function
'//# sourceMappingURL=./TestResult.brs.map