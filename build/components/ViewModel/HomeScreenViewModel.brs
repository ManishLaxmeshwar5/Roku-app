sub init()
    RBS_CC_15_reportLine("1", 1)
    m.allRowData = []
    RBS_CC_15_reportLine("2", 1)
    m.laodedRows = {}
    RBS_CC_15_reportLine("3", 1)
    m.bookmarks = {}
    RBS_CC_15_reportLine("4", 1)
    m.registry = CreateObject("roRegistrySection", "VideoBookmarks")
end sub

function loadContent()
    RBS_CC_15_reportLine("10", 1)
    jsonText = ReadAsciiFile("pkg:/source/gridContent1.json")
    RBS_CC_15_reportLine("11", 1)
    data = ParseJson(jsonText)
    RBS_CC_15_reportLine("12", 1)
    carouselRoot = createContentNode()
    RBS_CC_15_reportLine("14", 1): for each item in data.featured
        ' node = createContentNode()
        ' node.ShortDescriptionLine1 = item.name
        ' node.ShortDescriptionLine2 = item.description
        RBS_CC_15_reportLine("19", 1)
        node = createContentNode()
        RBS_CC_15_reportLine("20", 1)
        fields = getLocalizedFields(item)
        RBS_CC_15_reportLine("22", 1)
        node.ShortDescriptionLine1 = fields.name
        RBS_CC_15_reportLine("23", 1)
        node.ShortDescriptionLine2 = fields.description
        RBS_CC_15_reportLine("24", 1)
        node.HDPosterUrl = item.thumbnail
        RBS_CC_15_reportLine("25", 1)
        node.url = item.url
        RBS_CC_15_reportLine("27", 1)
        carouselRoot.appendChild(node)
    end for
    RBS_CC_15_reportLine("30", 1)
    m.top.carouselContent = carouselRoot
    RBS_CC_15_reportLine("31", 1)
    m.allRowData = data.rows
    RBS_CC_15_reportLine("33", 1)
    root = createContentNode()
    RBS_CC_15_reportLine("35", 1): for each rowData in data.rows
        RBS_CC_15_reportLine("36", 1)
        row = createContentNode()
        RBS_CC_15_reportLine("37", 1)
        row.addField("icon", "string", false)
        RBS_CC_15_reportLine("38", 1)
        row.addField("title", "string", false)
        ' row.title = rowData.title
        RBS_CC_15_reportLine("40", 1)
        row.title = getLocalizedRowTitle(rowData)
        RBS_CC_15_reportLine("41", 1)
        row.icon = rowData.icon
        RBS_CC_15_reportLine("42", 1)
        root.appendChild(row)
    end for
    RBS_CC_15_reportLine("44", 1)
    m.rowListContentNode = root
    RBS_CC_15_reportLine("46", 1)
    m.top.rowListContent = root
    RBS_CC_15_reportLine("48", 1)
    loadRowData(0)
    RBS_CC_15_reportLine("49", 1)
    loadRowData(1)
    RBS_CC_15_reportLine("50", 1)
    loadRowData(2)
    RBS_CC_15_reportLine("51", 1)
    loadRowData(3)
    RBS_CC_15_reportLine("52", 1)
    return true
end function

function loadRowData(rowIndex as integer)
    if RBS_CC_15_reportLine("58", 2) and (m.laodedRows[rowIndex.ToStr()] = true) then
        RBS_CC_15_reportLine("58", 3)
        RBS_CC_15_reportLine("58", 1)
        return true
    end if
    if RBS_CC_15_reportLine("60", 2) and (rowIndex >= m.allRowData.Count()) then
        RBS_CC_15_reportLine("60", 3)
        RBS_CC_15_reportLine("60", 1)
        return true
    end if
    RBS_CC_15_reportLine("61", 1)
    rowData = m.allRowData[rowIndex]
    RBS_CC_15_reportLine("62", 1)
    row = m.top.rowListContent.getChild(rowIndex)
    ' row = m.rowListContentNode.getChild(rowIndex)
    if RBS_CC_15_reportLine("65", 2) and (row = invalid) then
        RBS_CC_15_reportLine("65", 3)
        RBS_CC_15_reportLine("65", 1)
        return true
    end if
    RBS_CC_15_reportLine("67", 1): for each video in rowData.videos
        RBS_CC_15_reportLine("68", 1)
        itemNode = createContentNode()
        RBS_CC_15_reportLine("69", 1)
        fields = getLocalizedFields(video)
        RBS_CC_15_reportLine("71", 1)
        itemNode.ShortDescriptionLine1 = fields.name
        RBS_CC_15_reportLine("72", 1)
        itemNode.ShortDescriptionLine2 = fields.description
        RBS_CC_15_reportLine("73", 1)
        itemNode.HDPosterUrl = video.thumbnail
        RBS_CC_15_reportLine("74", 1)
        itemNode.url = "https://storage.googleapis.com/shaka-demo-assets/angel-one-hls/hls.m3u8"
        RBS_CC_15_reportLine("75", 1)
        itemNode.addField("screenType", "string", false)
        RBS_CC_15_reportLine("76", 1)
        itemNode.screenType = "home"
        RBS_CC_15_reportLine("77", 1)
        row.appendChild(itemNode)
    end for
    RBS_CC_15_reportLine("80", 1)
    m.laodedRows[rowIndex.ToStr()] = true
    RBS_CC_15_reportLine("81", 1)
    m.top.rowListContent = invalid
    RBS_CC_15_reportLine("82", 1)
    m.top.rowListContent = m.rowListContentNode
    RBS_CC_15_reportLine("83", 1)
    return true
end function

function getLocalizedFields(video as Object) as Object
    RBS_CC_15_reportLine("90", 1)
    lang = getCurrentLang()
    if RBS_CC_15_reportLine("92", 2) and (video.DoesExist("translations"))
        RBS_CC_15_reportLine("92", 3)
        RBS_CC_15_reportLine("93", 1)
        localized = video.translations[lang]
        if RBS_CC_15_reportLine("95", 2) and (localized = invalid)
            RBS_CC_15_reportLine("95", 3)
            RBS_CC_15_reportLine("96", 1)
            localized = video.translations["en"]
        end if
        if RBS_CC_15_reportLine("99", 2) and (localized <> invalid)
            RBS_CC_15_reportLine("99", 3)
            RBS_CC_15_reportLine("100", 1)
            return {
                name: localized.name
                description: localized.description
            }
        end if
    end if
    RBS_CC_15_reportLine("107", 1)
    return {
        name: video.name
        description: video.description
    }
end function

function getLocalizedRowTitle(rowData as Object) as String
    RBS_CC_15_reportLine("114", 1)
    lang = getCurrentLang()
    if RBS_CC_15_reportLine("116", 2) and (rowData.DoesExist("titles"))
        RBS_CC_15_reportLine("116", 3)
        RBS_CC_15_reportLine("117", 1)
        localizedTitle = rowData.titles[lang]
        if RBS_CC_15_reportLine("118", 2) and (localizedTitle = invalid)
            RBS_CC_15_reportLine("118", 3)
            RBS_CC_15_reportLine("119", 1)
            localizedTitle = rowData.titles["en"]
        end if
        if RBS_CC_15_reportLine("121", 2) and (localizedTitle <> invalid)
            RBS_CC_15_reportLine("121", 3)
            RBS_CC_15_reportLine("122", 1)
            return localizedTitle
        end if
    end if
    ' old flat format fallback
    if RBS_CC_15_reportLine("127", 2) and (rowData.DoesExist("title")) then
        RBS_CC_15_reportLine("127", 3)
        RBS_CC_15_reportLine("127", 1)
        return rowData.title
    end if
    RBS_CC_15_reportLine("128", 1)
    return ""
end function

function loadContinueWatching()
    if RBS_CC_15_reportLine("133", 2) and (not isValid(m.registry)) then
        RBS_CC_15_reportLine("133", 3)
        RBS_CC_15_reportLine("133", 1)
        return true
    end if
    RBS_CC_15_reportLine("134", 1)
    m.bookmarks = {}
    RBS_CC_15_reportLine("135", 1)
    keys = m.registry.GetKeyList()
    RBS_CC_15_reportLine("137", 1): for each key in keys
        RBS_CC_15_reportLine("138", 1)
        value = m.registry.Read(key)
        if RBS_CC_15_reportLine("139", 2) and (value <> "")
            RBS_CC_15_reportLine("139", 3)
            RBS_CC_15_reportLine("140", 1)
            parsed = ParseJSON(value)
            if RBS_CC_15_reportLine("142", 2) and (isValid(parsed) and parsed.DoesExist("position") and parsed.position > 0)
                RBS_CC_15_reportLine("142", 3)
                RBS_CC_15_reportLine("143", 1)
                titleKey = LCase(parsed.title.Trim())
                RBS_CC_15_reportLine("144", 1)
                m.bookmarks[titleKey] = parsed
            end if
        end if
    end for
    if RBS_CC_15_reportLine("149", 2) and (m.bookmarks.Count() = 0)
        RBS_CC_15_reportLine("149", 3)
        RBS_CC_15_reportLine("150", 1)
        m.top.continueWatchingVisible = false
        RBS_CC_15_reportLine("151", 1)
        return true
    end if
    RBS_CC_15_reportLine("154", 1)
    jsonText = ReadAsciiFile("pkg:/source/search1.json")
    if RBS_CC_15_reportLine("155", 2) and (jsonText = "") then
        RBS_CC_15_reportLine("155", 3)
        RBS_CC_15_reportLine("155", 1)
        return true
    end if
    RBS_CC_15_reportLine("156", 1)
    searchData = ParseJson(jsonText)
    if RBS_CC_15_reportLine("157", 2) and (searchData = invalid) then
        RBS_CC_15_reportLine("157", 3)
        RBS_CC_15_reportLine("157", 1)
        return true
    end if
    RBS_CC_15_reportLine("158", 1)
    continueRow = createContentNode()
    RBS_CC_15_reportLine("159", 1): for each rowData in searchData.rows
        RBS_CC_15_reportLine("160", 1)
        row = continueRow.createChild("ContentNode")
        RBS_CC_15_reportLine("161", 1)
        row.addField("icon", "string", false)
        RBS_CC_15_reportLine("162", 1)
        row.addField("title", "string", false)
        ' row.title = rowData.title
        RBS_CC_15_reportLine("165", 1)
        row.title = getLocalizedRowTitle(rowData)
        RBS_CC_15_reportLine("166", 1)
        row.icon = rowData.icon
        RBS_CC_15_reportLine("167", 1): for each data in rowData.content
            RBS_CC_15_reportLine("168", 1)
            fields = getLocalizedFields(data)
            RBS_CC_15_reportLine("169", 1)
            videoTitle = LCase(data.name.Trim())
            if RBS_CC_15_reportLine("170", 2) and (m.bookmarks.DoesExist(videoTitle))
                RBS_CC_15_reportLine("170", 3)
                RBS_CC_15_reportLine("171", 1)
                itemNode = row.createChild("ContentNode")
                RBS_CC_15_reportLine("172", 1)
                itemNode.url = data.url
                RBS_CC_15_reportLine("173", 1)
                itemNode.ShortDescriptionLine1 = data.name
                RBS_CC_15_reportLine("174", 1)
                itemNode.ShortDescriptionLine2 = data.description
                RBS_CC_15_reportLine("175", 1)
                itemNode.HDPosterUrl = data.thumbnail
                RBS_CC_15_reportLine("176", 1)
                itemNode.addField("screenType", "string", false)
                RBS_CC_15_reportLine("177", 1)
                itemNode.screenType = "home"
            end if
        end for
    end for
    RBS_CC_15_reportLine("181", 1)
    m.top.continueWatchingContent = continueRow
    RBS_CC_15_reportLine("182", 1)
    m.top.continueWatchingVisible = true
    RBS_CC_15_reportLine("183", 1)
    return true
end function

function RBS_CC_15_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "15"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "15"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./HomeScreenViewModel.brs.map