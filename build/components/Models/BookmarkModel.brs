function BookmarkModel() as Object
    RBS_CC_2_reportLine("2", 1)
    model = {}
    RBS_CC_2_reportLine("4", 1)
    model.registry = CreateObject("roRegistrySection", "VideoBookmarks")
    RBS_CC_2_reportLine("5", 1)
    model.saveBookmark = function(videoUrl as String, title as String, position as Integer)
        if RBS_CC_2_reportLine("7", 2) and (title = invalid or title = "")
            RBS_CC_2_reportLine("7", 3)
            RBS_CC_2_reportLine("8", 1)
            return invalid
        end if
        RBS_CC_2_reportLine("11", 1)
        bookmarkData = {
            url: videoUrl
            title: title
            position: position
        }
        RBS_CC_2_reportLine("17", 1)
        key = LCase(title.Trim())
        RBS_CC_2_reportLine("18", 1)
        m.registry.Write(key, FormatJson(bookmarkData))
        RBS_CC_2_reportLine("19", 1)
        m.registry.Flush()
    end function
    RBS_CC_2_reportLine("22", 1)
    model.getBookmark = function(title as String) as Object
        RBS_CC_2_reportLine("24", 1)
        result = {
            url: ""
            title: title
            position: 0
        }
        if RBS_CC_2_reportLine("29", 2) and (title = invalid or title = "")
            RBS_CC_2_reportLine("29", 3)
            RBS_CC_2_reportLine("30", 1)
            return result
        end if
        RBS_CC_2_reportLine("32", 1)
        key = LCase(title.Trim())
        RBS_CC_2_reportLine("33", 1)
        value = m.registry.Read(key)
        if RBS_CC_2_reportLine("34", 2) and (value <> invalid and value <> "")
            RBS_CC_2_reportLine("34", 3)
            RBS_CC_2_reportLine("35", 1)
            parsed = ParseJson(value)
            if RBS_CC_2_reportLine("36", 2) and (type(parsed) = "roAssociativeArray")
                RBS_CC_2_reportLine("36", 3)
                RBS_CC_2_reportLine("37", 1)
                result = parsed
            end if
        end if
        RBS_CC_2_reportLine("40", 1)
        return result
    end function
    RBS_CC_2_reportLine("43", 1)
    model.clearBookmark = function(title as String)
        if RBS_CC_2_reportLine("45", 2) and (title = invalid or title = "")
            RBS_CC_2_reportLine("45", 3)
            RBS_CC_2_reportLine("46", 1)
            return invalid
        end if
        RBS_CC_2_reportLine("48", 1)
        key = LCase(title.Trim())
        RBS_CC_2_reportLine("49", 1)
        m.registry.Delete(key)
        RBS_CC_2_reportLine("50", 1)
        m.registry.Flush()
    end function
    RBS_CC_2_reportLine("52", 1)
    return model
end function

function RBS_CC_2_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "2"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "2"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./BookmarkModel.brs.map