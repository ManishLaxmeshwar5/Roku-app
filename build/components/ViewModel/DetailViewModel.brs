function DetailViewModel() as Object
    RBS_CC_14_reportLine("2", 1)
    vm = {}
    RBS_CC_14_reportLine("4", 1)
    vm.content = invalid
    RBS_CC_14_reportLine("5", 1)
    vm.isInWatchLater = false
    RBS_CC_14_reportLine("7", 1)
    vm.setContent = function(content as Object, watchLaterList as Object)
        RBS_CC_14_reportLine("9", 1)
        m.content = content
        RBS_CC_14_reportLine("11", 1)
        m.isInWatchLater = false
        RBS_CC_14_reportLine("12", 1): for each item in watchLaterList
            if RBS_CC_14_reportLine("13", 2) and (item.title = content.ShortDescriptionLine1)
                RBS_CC_14_reportLine("13", 3)
                RBS_CC_14_reportLine("14", 1)
                m.isInWatchLater = true
                exit for
            end if
        end for
    end function
    RBS_CC_14_reportLine("20", 1)
    vm.getNavigationPayload = function() as Object
        RBS_CC_14_reportLine("21", 1)
        return {
            type: "navigate"
            screen: "VideoPlayer"
            payload: {
                url: m.content.url
                title: m.content.ShortDescriptionLine1
            }
        }
    end function
    RBS_CC_14_reportLine("30", 1)
    return vm
end function

function RBS_CC_14_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "14"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "14"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./DetailViewModel.brs.map