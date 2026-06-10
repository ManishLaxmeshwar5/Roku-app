function WatchLaterViewModel() as Object
    RBS_CC_20_reportLine("2", 1)
    vm = {}
    RBS_CC_20_reportLine("4", 1)
    vm.items = []
    RBS_CC_20_reportLine("5", 1)
    vm.isEmpty = true
    RBS_CC_20_reportLine("8", 1)
    vm.setWatchLaterList = function(list as Object)
        RBS_CC_20_reportLine("10", 1)
        m.items = []
        ' if not isValid(list)
        '     m.isEmpty = true
        '     return invalid
        ' end if
        if RBS_CC_20_reportLine("17", 2) and (list.count() = 0)
            RBS_CC_20_reportLine("17", 3)
            RBS_CC_20_reportLine("18", 1)
            m.isEmpty = true
            RBS_CC_20_reportLine("19", 1)
            return invalid
        end if
        RBS_CC_20_reportLine("23", 1)
        m.isEmpty = false
        RBS_CC_20_reportLine("25", 1): for each item in list
            RBS_CC_20_reportLine("27", 1)
            node = CreateObject("roSGNode", "ContentNode")
            RBS_CC_20_reportLine("28", 1)
            node.ShortDescriptionLine1 = item.title
            RBS_CC_20_reportLine("29", 1)
            node.ShortDescriptionLine2 = item.description
            RBS_CC_20_reportLine("30", 1)
            node.HDPosterUrl = item.poster
            RBS_CC_20_reportLine("31", 1)
            node.url = item.url
            RBS_CC_20_reportLine("32", 1)
            m.items.push(node)
        end for
    end function
    ' vm.getGridContent = function() as Object
    '     root = CreateObject("roSGNode", "ContentNode")
    '     for each item in m.items
    '         root.appendChild(item)
    '     end for
    '     return root
    ' end function
    RBS_CC_20_reportLine("43", 1)
    vm.getGridContent = function() as Object
        RBS_CC_20_reportLine("44", 1)
        root = CreateObject("roSGNode", "ContentNode")
        RBS_CC_20_reportLine("45", 1)
        row = root.createChild("ContentNode")
        RBS_CC_20_reportLine("46", 1)
        row.title = "Watch Later"
        RBS_CC_20_reportLine("49", 1)
        row.addField("rowItemSize", "vector2d", false)
        RBS_CC_20_reportLine("50", 1)
        row.rowItemSize = [
            200
            250
        ]
        ' Optional: spacing between items in the row
        RBS_CC_20_reportLine("53", 1)
        row.addField("rowItemSpacing", "vector2d", false)
        RBS_CC_20_reportLine("54", 1)
        row.rowItemSpacing = [
            20
            0
        ]
        RBS_CC_20_reportLine("56", 1): for each item in m.items
            RBS_CC_20_reportLine("57", 1)
            node = row.createChild("ContentNode")
            RBS_CC_20_reportLine("58", 1)
            node.ShortDescriptionLine1 = item.ShortDescriptionLine1
            RBS_CC_20_reportLine("59", 1)
            node.ShortDescriptionLine2 = item.ShortDescriptionLine2
            RBS_CC_20_reportLine("60", 1)
            node.HDPosterUrl = item.HDPosterUrl
            RBS_CC_20_reportLine("61", 1)
            print node.HDPosterUrl
            RBS_CC_20_reportLine("62", 1)
            node.url = item.url
            RBS_CC_20_reportLine("64", 1)
            node.addField("screenType", "string", false)
            RBS_CC_20_reportLine("65", 1)
            node.screenType = "watchlater"
        end for
        RBS_CC_20_reportLine("68", 1)
        return root
    end function
    RBS_CC_20_reportLine("72", 1)
    vm.getNavigationPayload = function(selectedItem as Object) as Object
        RBS_CC_20_reportLine("73", 1)
        return {
            type: "navigate"
            screen: "DetailScreen"
            payload: selectedItem
        }
    end function
    RBS_CC_20_reportLine("79", 1)
    return vm
end function

function RBS_CC_20_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "20"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "20"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./WatchLaterViewModel.brs.map