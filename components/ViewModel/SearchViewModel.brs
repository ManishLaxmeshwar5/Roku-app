sub init()
    m.allItems = []
    m.prevQuery = ""
    m.prevResults = []
    loadSearchData()
end sub


sub loadSearchData()
    data = readJsonFile("pkg:/source/search.json")
    if not isValid(data) or not isValid(data.content)
        m.allItems = []
        return
    end if
    m.allItems = data.content
end sub


function search(query as string)
    query = LCase(query)

    if query = ""
        m.top.isEmptyQuery = true
        m.top.hasResults = false
        m.top.searchResults = invalid
        m.prevResults = []
        m.prevQuery = invalid
        return true
    end if
    m.top.isEmptyQuery = false
    if m.prevQuery <> invalid AND Left(query, Len(m.prevQuery)) = m.prevQuery
        source = m.prevResults
        print "Searching from previous results"
    else
        source = m.allItems
        print "Searching from all items"
    end if
    results = []
    for each item in m.allItems
        if Instr(LCase(item.name), query) > 0
            results.push(item)
        end if
    end for
    m.prevQuery = query
    m.prevResults = results
    if results.count() > 0
        m.top.hasResults = true
        m.top.searchResults = buildContent(results)
    else
        m.top.hasResults = false
        m.top.searchResults = invalid
    end if
end function


function buildContent(items as object) as object
    content = CreateObject("roSGNode", "ContentNode")
    row = content.createChild("ContentNode")
    row.title = "Results"
    for each item in items
        node = row.createChild("ContentNode")
        node.ShortDescriptionLine1 = item.name
        node.ShortDescriptionLine2 = item.description
        node.HDPosterUrl = item.thumbnail
        node.url = item.url
        node.addField("itemWidth", "integer", false)
        node.addField("itemHeight", "integer", false)

    node.itemWidth = 200
    node.itemHeight = 300
    end for
    return content
end function