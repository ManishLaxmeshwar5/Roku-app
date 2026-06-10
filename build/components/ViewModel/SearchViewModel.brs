sub init()
    RBS_CC_17_reportLine("1", 1)
    m.allItems = []
    RBS_CC_17_reportLine("2", 1)
    m.prevQuery = ""
    RBS_CC_17_reportLine("3", 1)
    m.prevResults = []
    RBS_CC_17_reportLine("4", 1)
    loadSearchData()
end sub

sub loadSearchData()
    RBS_CC_17_reportLine("9", 1)
    data = readJsonFile("pkg:/source/search.json")
    if RBS_CC_17_reportLine("10", 2) and (not isValid(data) or not isValid(data.content))
        RBS_CC_17_reportLine("10", 3)
        RBS_CC_17_reportLine("11", 1)
        m.allItems = []
        RBS_CC_17_reportLine("12", 1)
        return
    end if
    RBS_CC_17_reportLine("14", 1)
    m.allItems = data.content
end sub

function search(query as string)
    RBS_CC_17_reportLine("19", 1)
    query = LCase(query)
    if RBS_CC_17_reportLine("21", 2) and (query = "")
        RBS_CC_17_reportLine("21", 3)
        RBS_CC_17_reportLine("22", 1)
        m.top.isEmptyQuery = true
        RBS_CC_17_reportLine("23", 1)
        m.top.hasResults = false
        RBS_CC_17_reportLine("24", 1)
        m.top.searchResults = invalid
        RBS_CC_17_reportLine("25", 1)
        m.prevResults = []
        RBS_CC_17_reportLine("26", 1)
        m.prevQuery = invalid
        RBS_CC_17_reportLine("27", 1)
        return true
    end if
    RBS_CC_17_reportLine("29", 1)
    m.top.isEmptyQuery = false
    if RBS_CC_17_reportLine("30", 2) and (m.prevQuery <> invalid and Left(query, Len(m.prevQuery)) = m.prevQuery)
        RBS_CC_17_reportLine("30", 3)
        RBS_CC_17_reportLine("31", 1)
        source = m.prevResults
        RBS_CC_17_reportLine("32", 1)
        print "Searching from previous results"
    else
        RBS_CC_17_reportLine("33", 3)
        RBS_CC_17_reportLine("34", 1)
        source = m.allItems
        RBS_CC_17_reportLine("35", 1)
        print "Searching from all items"
    end if
    RBS_CC_17_reportLine("37", 1)
    results = []
    RBS_CC_17_reportLine("38", 1): for each item in m.allItems
        if RBS_CC_17_reportLine("39", 2) and (Instr(1, LCase(item.name), query) > 0)
            RBS_CC_17_reportLine("39", 3)
            RBS_CC_17_reportLine("40", 1)
            results.push(item)
        end if
    end for
    RBS_CC_17_reportLine("43", 1)
    m.prevQuery = query
    RBS_CC_17_reportLine("44", 1)
    m.prevResults = results
    if RBS_CC_17_reportLine("45", 2) and (results.count() > 0)
        RBS_CC_17_reportLine("45", 3)
        RBS_CC_17_reportLine("46", 1)
        m.top.hasResults = true
        RBS_CC_17_reportLine("47", 1)
        m.top.searchResults = buildContent(results)
    else
        RBS_CC_17_reportLine("48", 3)
        RBS_CC_17_reportLine("49", 1)
        m.top.hasResults = false
        RBS_CC_17_reportLine("50", 1)
        m.top.searchResults = invalid
    end if
end function

function buildContent(items as object) as object
    RBS_CC_17_reportLine("56", 1)
    content = CreateObject("roSGNode", "ContentNode")
    RBS_CC_17_reportLine("57", 1)
    row = content.createChild("ContentNode")
    RBS_CC_17_reportLine("58", 1)
    m.json = translate()
    RBS_CC_17_reportLine("59", 1)
    row.title = m.json["messages"]["results"][m.global.currentLang]
    RBS_CC_17_reportLine("60", 1): for each item in items
        RBS_CC_17_reportLine("61", 1)
        node = row.createChild("ContentNode")
        RBS_CC_17_reportLine("62", 1)
        node.ShortDescriptionLine1 = item.name
        RBS_CC_17_reportLine("63", 1)
        node.ShortDescriptionLine2 = item.description
        RBS_CC_17_reportLine("64", 1)
        node.HDPosterUrl = item.thumbnail
        RBS_CC_17_reportLine("65", 1)
        node.url = item.url
        RBS_CC_17_reportLine("66", 1)
        node.addField("itemWidth", "integer", false)
        RBS_CC_17_reportLine("67", 1)
        node.addField("itemHeight", "integer", false)
        RBS_CC_17_reportLine("69", 1)
        node.itemWidth = 200
        RBS_CC_17_reportLine("70", 1)
        node.itemHeight = 300
    end for
    RBS_CC_17_reportLine("72", 1)
    return content
end function

function RBS_CC_17_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "17"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "17"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./SearchViewModel.brs.map