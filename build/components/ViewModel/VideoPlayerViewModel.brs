function VideoPlayerViewModel() as Object
    RBS_CC_19_reportLine("2", 1)
    vm = {}
    RBS_CC_19_reportLine("3", 1)
    vm.savedBookmarkPosition = 0
    RBS_CC_19_reportLine("4", 1)
    vm.shouldResumeFromBookmark = false
    RBS_CC_19_reportLine("5", 1)
    vm.hasResumedFromBookmark = false
    RBS_CC_19_reportLine("7", 1)
    vm.prepareVideoContent = function(content as Object) as Object
        RBS_CC_19_reportLine("8", 1)
        node = CreateObject("roSGNode", "ContentNode")
        RBS_CC_19_reportLine("9", 1)
        node.url = content.url
        RBS_CC_19_reportLine("10", 1)
        node.title = content.title
        RBS_CC_19_reportLine("11", 1)
        return node
    end function
    RBS_CC_19_reportLine("14", 1)
    vm.setupResumeState = function(content as Object, bookmarkData as Object)
        RBS_CC_19_reportLine("15", 1)
        m.savedBookmarkPosition = 0
        RBS_CC_19_reportLine("16", 1)
        m.shouldResumeFromBookmark = false
        RBS_CC_19_reportLine("17", 1)
        m.hasResumedFromBookmark = false
        if RBS_CC_19_reportLine("19", 2) and (content.DoesExist("bookmarkPosition"))
            RBS_CC_19_reportLine("19", 3)
            if RBS_CC_19_reportLine("20", 2) and (content.bookmarkPosition > 5)
                RBS_CC_19_reportLine("20", 3)
                RBS_CC_19_reportLine("21", 1)
                m.savedBookmarkPosition = content.bookmarkPosition
                RBS_CC_19_reportLine("22", 1)
                m.shouldResumeFromBookmark = true
                RBS_CC_19_reportLine("23", 1)
                return invalid
            end if
        end if
        if RBS_CC_19_reportLine("27", 2) and (bookmarkData.position > 5)
            RBS_CC_19_reportLine("27", 3)
            RBS_CC_19_reportLine("28", 1)
            m.savedBookmarkPosition = bookmarkData.position
            RBS_CC_19_reportLine("29", 1)
            m.shouldResumeFromBookmark = true
        end if
    end function
    RBS_CC_19_reportLine("33", 1)
    vm.shouldSeek = function(duration as Integer) as Boolean
        RBS_CC_19_reportLine("34", 1)
        return (m.savedBookmarkPosition > 0 and not m.hasResumedFromBookmark and duration > m.savedBookmarkPosition)
    end function
    RBS_CC_19_reportLine("37", 1)
    vm.markResumed = function()
        RBS_CC_19_reportLine("38", 1)
        m.hasResumedFromBookmark = true
    end function
    RBS_CC_19_reportLine("41", 1)
    return vm
end function

function RBS_CC_19_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "19"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "19"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./VideoPlayerViewModel.brs.map