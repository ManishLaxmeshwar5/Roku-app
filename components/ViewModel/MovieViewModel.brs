function loadContent(contentType as string)
    if contentType = "series"
        loadSeriesContent()
    else
        loadMoviesContent()
    end if
    return true
end function

sub loadMoviesContent()
    jsonText = ReadAsciiFile("pkg:/source/moviesContent.json")
    if jsonText = invalid or jsonText = "" then return
    data = ParseJson(jsonText)
    root = CreateObject("roSGNode", "ContentNode")

    actionRow = CreateObject("roSGNode", "ContentNode")
    actionRow.title = "Action Movies"

    dramaRow = CreateObject("roSGNode", "ContentNode")
    dramaRow.title = "Drama Movies"

    comedyRow = CreateObject("roSGNode", "ContentNode")
    comedyRow.title = "Comedy Movies"

    for each movie in data.movies

        itemNode = CreateObject("roSGNode", "ContentNode")
        itemNode.ShortDescriptionLine1 = movie.name
        itemNode.HDPosterUrl = movie.thumbnail
        itemNode.url = movie.url
        itemNode.ShortDescriptionLine2 = movie.description

        if movie.genre = "Action"
            actionRow.appendChild(itemNode)
        else if movie.genre = "Drama"
            dramaRow.appendChild(itemNode)
        else if movie.genre = "Comedy"
            comedyRow.appendChild(itemNode)
        end if
    end for

    if actionRow.getChildCount() > 0 then root.appendChild(actionRow)
    if dramaRow.getChildCount() > 0 then root.appendChild(dramaRow)
    if comedyRow.getChildCount() > 0 then root.appendChild(comedyRow)

    m.top.movieContent = invalid
    m.top.movieContent = root
end sub

sub loadSeriesContent()

    jsonText = ReadAsciiFile("pkg:/source/seriesContent.json")
    if jsonText = invalid or jsonText = "" then return
    data = ParseJson(jsonText)
    if data = invalid or data.series = invalid then return
    root = CreateObject("roSGNode", "ContentNode")

    actionRow = CreateObject("roSGNode", "ContentNode")
    actionRow.title = "Action Series"

    dramaRow = CreateObject("roSGNode", "ContentNode")
    dramaRow.title = "Drama Series"

    comedyRow = CreateObject("roSGNode", "ContentNode")
    comedyRow.title = "Comedy Series"

    for each series in data.series

        itemNode = CreateObject("roSGNode", "ContentNode")
        itemNode.ShortDescriptionLine1 = series.name
        itemNode.HDPosterUrl = series.thumbnail
        itemNode.url = series.url
        itemNode.ShortDescriptionLine2 = series.description

        if series.genre = "Action"
            actionRow.appendChild(itemNode)
        else if series.genre = "Drama"
            dramaRow.appendChild(itemNode)
        else if series.genre = "Comedy"
            comedyRow.appendChild(itemNode)
        end if
    end for

    if actionRow.getChildCount() > 0 then root.appendChild(actionRow)
    if dramaRow.getChildCount() > 0 then root.appendChild(dramaRow)
    if comedyRow.getChildCount() > 0 then root.appendChild(comedyRow)

    m.top.movieContent = invalid
    m.top.movieContent = root
end sub

function handleDeepLink(deepLinkId as string, contentType as string)
    root = m.top.movieContent
    if not isValid(root) then return true
    for rowIndex = 0 to root.getChildCount() - 1
        row = root.getChild(rowIndex)
        for itemIndex = 0 to row.getChildCount() - 1
            item = row.getChild(itemIndex)
            if isValid(item) and item.ShortDescriptionLine1 = deepLinkId
                item.addField("mediaType", "string", false)
                item.mediaType = contentType
                m.top.deepLinkItem = item
                return true
            end if
        end for
    end for
    return true
end function