' @ignore
function __rooibos_TestResult_builder()
    RBS_CC_35_reportLine("2", 1)
    instance = {}
    RBS_CC_35_reportLine("3", 1)
    instance.new = function(test)
        RBS_CC_35_reportLine("4", 1)
        m.isFail = false
        RBS_CC_35_reportLine("5", 1)
        m.isCrash = false
        RBS_CC_35_reportLine("6", 1)
        m.isSkipped = false
        RBS_CC_35_reportLine("7", 1)
        m.actual = invalid
        RBS_CC_35_reportLine("8", 1)
        m.expected = invalid
        RBS_CC_35_reportLine("9", 1)
        m.message = ""
        RBS_CC_35_reportLine("10", 1)
        m.lineNumber = -1
        RBS_CC_35_reportLine("11", 1)
        m.test = invalid
        RBS_CC_35_reportLine("12", 1)
        m.time = -1
        RBS_CC_35_reportLine("13", 1)
        m.error = invalid
        RBS_CC_35_reportLine("14", 1)
        m.throwOnFailedAssertion = false
        RBS_CC_35_reportLine("15", 1)
        m.test = test
    end function
    RBS_CC_35_reportLine("17", 1)
    instance.merge = function(other)
        RBS_CC_35_reportLine("18", 1)
        m.isFail = other.isFail
        RBS_CC_35_reportLine("19", 1)
        m.isCrash = other.isCrash
        RBS_CC_35_reportLine("20", 1)
        m.actual = other.actual
        RBS_CC_35_reportLine("21", 1)
        m.expected = other.expected
        RBS_CC_35_reportLine("22", 1)
        m.message = other.message
        RBS_CC_35_reportLine("23", 1)
        m.lineNumber = other.lineNumber
        RBS_CC_35_reportLine("24", 1)
        m.time = other.time
        RBS_CC_35_reportLine("25", 1)
        m.error = other.error
    end function
    RBS_CC_35_reportLine("27", 1)
    instance.reset = function() as void
        RBS_CC_35_reportLine("28", 1)
        m.isFail = false
        RBS_CC_35_reportLine("29", 1)
        m.isCrash = false
        RBS_CC_35_reportLine("30", 1)
        m.time = -1
        RBS_CC_35_reportLine("31", 1)
        m.message = ""
        RBS_CC_35_reportLine("32", 1)
        m.lineNumber = -1
    end function
    RBS_CC_35_reportLine("34", 1)
    instance.fail = function(message as string, lineNumber = -1, actual = "", expected = "", error = invalid)
        if RBS_CC_35_reportLine("35", 2) and (message <> "" and not m.isFail)
            RBS_CC_35_reportLine("35", 3)
            if RBS_CC_35_reportLine("36", 2) and (not m.isFail)
                RBS_CC_35_reportLine("36", 3)
                RBS_CC_35_reportLine("37", 1)
                m.lineNumber = lineNumber
                RBS_CC_35_reportLine("38", 1)
                m.isFail = true
                RBS_CC_35_reportLine("39", 1)
                m.message = message
                RBS_CC_35_reportLine("40", 1)
                m.actual = actual
                RBS_CC_35_reportLine("41", 1)
                m.expected = expected
                RBS_CC_35_reportLine("42", 1)
                m.error = error
            end if
        end if
        if RBS_CC_35_reportLine("45", 2) and (m.throwOnFailedAssertion)
            RBS_CC_35_reportLine("45", 3)
            throw m.getMessage()
        end if
    end function
    RBS_CC_35_reportLine("49", 1)
    instance.skip = function(message as string)
        if RBS_CC_35_reportLine("50", 2) and (message <> "" and not m.isFail)
            RBS_CC_35_reportLine("50", 3)
            if RBS_CC_35_reportLine("51", 2) and (not m.isFail)
                RBS_CC_35_reportLine("51", 3)
                RBS_CC_35_reportLine("52", 1)
                m.isSkipped = true
                RBS_CC_35_reportLine("53", 1)
                m.message = message
            end if
        end if
    end function
    RBS_CC_35_reportLine("57", 1)
    instance.crash = function(message as string, error)
        if RBS_CC_35_reportLine("58", 2) and (message <> "" and not m.isCrash)
            RBS_CC_35_reportLine("58", 3)
            if RBS_CC_35_reportLine("59", 2) and (not m.isCrash)
                RBS_CC_35_reportLine("59", 3)
                RBS_CC_35_reportLine("60", 1)
                m.error = error
                RBS_CC_35_reportLine("61", 1)
                m.message = "test crashed!"
                RBS_CC_35_reportLine("62", 1)
                m.isFail = true
                RBS_CC_35_reportLine("63", 1)
                m.isCrash = true
            end if
        end if
    end function
    RBS_CC_35_reportLine("67", 1)
    instance.getMessage = function() as string
        if RBS_CC_35_reportLine("68", 2) and (m.isFail)
            RBS_CC_35_reportLine("68", 3)
            if RBS_CC_35_reportLine("69", 2) and (m.message <> invalid)
                RBS_CC_35_reportLine("69", 3)
                RBS_CC_35_reportLine("70", 1)
                return m.message
            else
                RBS_CC_35_reportLine("71", 3)
                RBS_CC_35_reportLine("72", 1)
                return "unknown test failure"
            end if
        else if RBS_CC_35_reportLine("74", 2) and (m.isCrash)
            RBS_CC_35_reportLine("74", 3)
            if RBS_CC_35_reportLine("75", 2) and (m.message <> invalid)
                RBS_CC_35_reportLine("75", 3)
                RBS_CC_35_reportLine("76", 1)
                return m.message
            else
                RBS_CC_35_reportLine("77", 3)
                RBS_CC_35_reportLine("78", 1)
                return "unknown test crash"
            end if
        else
            RBS_CC_35_reportLine("80", 3)
            RBS_CC_35_reportLine("81", 1)
            return ""
        end if
    end function
    RBS_CC_35_reportLine("84", 1)
    instance.getStatusText = function()
        if RBS_CC_35_reportLine("85", 2) and (m.isCrash)
            RBS_CC_35_reportLine("85", 3)
            RBS_CC_35_reportLine("86", 1)
            return "CRASH"
        else if RBS_CC_35_reportLine("87", 2) and (m.isFail)
            RBS_CC_35_reportLine("87", 3)
            RBS_CC_35_reportLine("88", 1)
            return "FAIL"
        else if RBS_CC_35_reportLine("89", 2) and (m.isSkipped)
            RBS_CC_35_reportLine("89", 3)
            RBS_CC_35_reportLine("90", 1)
            return "SKIP"
        else
            RBS_CC_35_reportLine("91", 3)
            RBS_CC_35_reportLine("92", 1)
            return "PASS"
        end if
    end function
    RBS_CC_35_reportLine("95", 1)
    return instance
end function

function rooibos_TestResult(test)
    RBS_CC_35_reportLine("98", 1)
    instance = __rooibos_TestResult_builder()
    RBS_CC_35_reportLine("99", 1)
    instance.new(test)
    RBS_CC_35_reportLine("100", 1)
    return instance
end function

'//# sourceMappingURL=./TestResult.brs.map
function RBS_CC_35_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "35"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "35"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./TestResult.brs.map