function createScreenManager()
    RBS_CC_6_reportLine("1", 1)
    return {
        stack: []
        pushScreen: function(screen)
            RBS_CC_6_reportLine("4", 1)
            m.stack.push(screen)
            RBS_CC_6_reportLine("5", 1)
            print "navigation Stack : " m.stack
        end function
        popScreen: function()
            if RBS_CC_6_reportLine("8", 2) and (m.stack.count() > 0)
                RBS_CC_6_reportLine("8", 3)
                RBS_CC_6_reportLine("9", 1)
                print "navigation Stack pop : " m.stack
                RBS_CC_6_reportLine("10", 1)
                return m.stack.pop()
            end if
            RBS_CC_6_reportLine("13", 1)
            return invalid
        end function
        getTopScreen: function()
            if RBS_CC_6_reportLine("17", 2) and (m.stack.count() > 0)
                RBS_CC_6_reportLine("17", 3)
                RBS_CC_6_reportLine("18", 1)
                return m.stack[m.stack.count() - 1]
            end if
            RBS_CC_6_reportLine("20", 1)
            return invalid
        end function
        hasScreens: function()
            RBS_CC_6_reportLine("23", 1)
            return m.stack.count() > 0
        end function
    }
end function

function RBS_CC_6_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "6"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "6"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./ScreenManager.brs.map