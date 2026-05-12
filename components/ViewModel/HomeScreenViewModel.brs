sub init()
    m.allRowData = []
    m.laodedRows = {}
    m.bookmarks = {}
    m.registry = CreateObject("roRegistrySection", "VideoBookmarks")
end sub


function loadContent()

    jsonText = ReadAsciiFile("pkg:/source/gridContent.json")
    data = ParseJson(jsonText)
    carouselRoot = createContentNode()

    for each item in data.featured

        node = createContentNode()
        node.ShortDescriptionLine1 = item.name
        node.ShortDescriptionLine2 = item.description
        node.HDPosterUrl = item.thumbnail
        node.url = item.url

        carouselRoot.appendChild(node)
    end for

    m.top.carouselContent = carouselRoot
    m.allRowData = data.rows
    root = createContentNode()

    for each rowData in data.rows
        row = createContentNode()
        row.addField("icon", "string", false)
        row.addField("title", "string", false)
        row.title = rowData.title
        row.icon = rowData.icon
        root.appendChild(row)
    end for
    m.rowListContentNode = root

    m.top.rowListContent = root

    loadRowData(0)
    loadRowData(1)
    loadRowData(2)
    loadRowData(3)
        return true
    end function


function loadRowData(rowIndex as integer)

    if m.laodedRows[rowIndex.ToStr()] = true then return true

    if rowIndex >= m.allRowData.Count() then return true
    rowData = m.allRowData[rowIndex]
    row = m.top.rowListContent.getChild(rowIndex)
    ' row = m.rowListContentNode.getChild(rowIndex)

    if row = invalid then return true

    for each video in rowData.videos
        itemNode = createContentNode()
        itemNode.ShortDescriptionLine1 = video.name
        itemNode.ShortDescriptionLine2 = video.description
        itemNode.HDPosterUrl = video.thumbnail
        itemNode.url = "https://storage.googleapis.com/shaka-demo-assets/angel-one-hls/hls.m3u8"
        itemNode.addField("screenType", "string", false)
        itemNode.screenType = "home"
        row.appendChild(itemNode)
    end for

    m.laodedRows[rowIndex.ToStr()] = true
    m.top.rowListContent = invalid
    m.top.rowListContent = m.rowListContentNode
    return true
end function


function loadContinueWatching()
    if not isValid(m.registry) then return true
    m.bookmarks = {}
    keys = m.registry.GetKeyList()

    for each key in keys
        value = m.registry.Read(key)
        if value <> ""
            parsed = ParseJSON(value)

            if isValid(parsed) and parsed.DoesExist("position") and parsed.position > 0
                titleKey = LCase(parsed.title.Trim())
                m.bookmarks[titleKey] = parsed
            end if
        end if
    end for

    if m.bookmarks.Count() = 0
        m.top.continueWatchingVisible = false
        return true
    end if

    jsonText = ReadAsciiFile("pkg:/source/search1.json")
    if jsonText = "" then return true
    searchData = ParseJson(jsonText)
    if searchData = invalid then return true
    continueRow = createContentNode()
    for each rowData in searchData.rows
        row = continueRow.createChild("ContentNode")
        row.addField("icon", "string", false)
        row.addField("title", "string", false)
        
        row.title = rowData.title
        row.icon = rowData.icon
        for each data in rowData.content
            videoTitle = LCase(data.name.Trim())
            if m.bookmarks.DoesExist(videoTitle)
                itemNode = row.createChild("ContentNode")
                itemNode.url = data.url
                itemNode.ShortDescriptionLine1 = data.name
                itemNode.ShortDescriptionLine2 = data.description
                itemNode.HDPosterUrl = data.thumbnail
                itemNode.addField("screenType", "string", false)
                itemNode.screenType = "home"
            end if
        end for
    end for
    m.top.continueWatchingContent = continueRow
    m.top.continueWatchingVisible = true
    return true
end function