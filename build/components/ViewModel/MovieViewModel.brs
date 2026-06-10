function loadContent(contentType as string)
    if RBS_CC_16_reportLine("1", 2) and (contentType = "series")
        RBS_CC_16_reportLine("1", 3)
        RBS_CC_16_reportLine("2", 1)
        loadSeriesContent()
    else
        RBS_CC_16_reportLine("3", 3)
        RBS_CC_16_reportLine("4", 1)
        loadMoviesContent()
    end if
    RBS_CC_16_reportLine("6", 1)
    return true
end function

sub loadMoviesContent()
    RBS_CC_16_reportLine("10", 1)
    lang = m.global.currentLang
    RBS_CC_16_reportLine("11", 1)
    print "from movies:" lang
    RBS_CC_16_reportLine("12", 1)
    jsonText = ReadAsciiFile("pkg:/source/moviesContent.json")
    if RBS_CC_16_reportLine("13", 2) and (jsonText = invalid or jsonText = "") then
        RBS_CC_16_reportLine("13", 3)
        RBS_CC_16_reportLine("13", 1)
        return
    end if
    RBS_CC_16_reportLine("14", 1)
    data = ParseJson(jsonText)
    RBS_CC_16_reportLine("15", 1)
    root = CreateObject("roSGNode", "ContentNode")
    RBS_CC_16_reportLine("17", 1)
    actionTitles = {
        en: "Action Movies"
        pt: "Filmes de Ação"
        fr: "Films d’Action"
        es: "Películas de Acción"
        de: "Actionfilme"
    }
    RBS_CC_16_reportLine("25", 1)
    dramaTitles = {
        en: "Drama Movies"
        pt: "Filmes de Drama"
        fr: "Films Dramatiques"
        es: "Películas Dramáticas"
        de: "Dramafilme"
    }
    RBS_CC_16_reportLine("33", 1)
    comedyTitles = {
        en: "Comedy Movies"
        pt: "Filmes de Comédia"
        fr: "Films Comiques"
        es: "Películas de Comedia"
        de: "Komödien"
    }
    RBS_CC_16_reportLine("41", 1)
    actionRow = CreateObject("roSGNode", "ContentNode")
    RBS_CC_16_reportLine("42", 1)
    actionRow.title = actionTitles[lang]
    RBS_CC_16_reportLine("44", 1)
    dramaRow = CreateObject("roSGNode", "ContentNode")
    RBS_CC_16_reportLine("45", 1)
    dramaRow.title = dramaTitles[lang]
    RBS_CC_16_reportLine("47", 1)
    comedyRow = CreateObject("roSGNode", "ContentNode")
    RBS_CC_16_reportLine("48", 1)
    comedyRow.title = comedyTitles[lang]
    RBS_CC_16_reportLine("50", 1): for each movie in data.movies
        RBS_CC_16_reportLine("52", 1)
        itemNode = CreateObject("roSGNode", "ContentNode")
        RBS_CC_16_reportLine("53", 1)
        itemNode.ShortDescriptionLine1 = movie.translations[lang].name
        RBS_CC_16_reportLine("54", 1)
        print "movietitle:" itemNode.ShortDescriptionLine1
        RBS_CC_16_reportLine("55", 1)
        itemNode.HDPosterUrl = movie.thumbnail
        RBS_CC_16_reportLine("56", 1)
        itemNode.url = movie.url
        RBS_CC_16_reportLine("57", 1)
        itemNode.ShortDescriptionLine2 = movie.translations[lang].description
        if RBS_CC_16_reportLine("58", 2) and (movie.genre.en = "Action")
            RBS_CC_16_reportLine("58", 3)
            RBS_CC_16_reportLine("59", 1)
            actionRow.appendChild(itemNode)
        else if RBS_CC_16_reportLine("60", 2) and (movie.genre.en = "Drama")
            RBS_CC_16_reportLine("60", 3)
            RBS_CC_16_reportLine("61", 1)
            dramaRow.appendChild(itemNode)
        else if RBS_CC_16_reportLine("62", 2) and (movie.genre.en = "Comedy")
            RBS_CC_16_reportLine("62", 3)
            RBS_CC_16_reportLine("63", 1)
            comedyRow.appendChild(itemNode)
        end if
    end for
    if RBS_CC_16_reportLine("67", 2) and (actionRow.getChildCount() > 0) then
        RBS_CC_16_reportLine("67", 3)
        RBS_CC_16_reportLine("67", 1)
        root.appendChild(actionRow)
    end if
    if RBS_CC_16_reportLine("68", 2) and (dramaRow.getChildCount() > 0) then
        RBS_CC_16_reportLine("68", 3)
        RBS_CC_16_reportLine("68", 1)
        root.appendChild(dramaRow)
    end if
    if RBS_CC_16_reportLine("69", 2) and (comedyRow.getChildCount() > 0) then
        RBS_CC_16_reportLine("69", 3)
        RBS_CC_16_reportLine("69", 1)
        root.appendChild(comedyRow)
    end if
    RBS_CC_16_reportLine("71", 1)
    m.top.movieContent = invalid
    RBS_CC_16_reportLine("72", 1)
    m.top.movieContent = root
end sub

sub loadSeriesContent()
    RBS_CC_16_reportLine("76", 1)
    lang = m.global.currentLang
    RBS_CC_16_reportLine("77", 1)
    jsonText = ReadAsciiFile("pkg:/source/seriesContent.json")
    if RBS_CC_16_reportLine("78", 2) and (jsonText = invalid or jsonText = "") then
        RBS_CC_16_reportLine("78", 3)
        RBS_CC_16_reportLine("78", 1)
        return
    end if
    RBS_CC_16_reportLine("79", 1)
    data = ParseJson(jsonText)
    if RBS_CC_16_reportLine("80", 2) and (data = invalid or data.series = invalid) then
        RBS_CC_16_reportLine("80", 3)
        RBS_CC_16_reportLine("80", 1)
        return
    end if
    RBS_CC_16_reportLine("81", 1)
    root = CreateObject("roSGNode", "ContentNode")
    ' actionRow = CreateObject("roSGNode", "ContentNode")
    ' actionRow.title = "Action Series"
    ' dramaRow = CreateObject("roSGNode", "ContentNode")
    ' dramaRow.title = "Drama Series"
    ' comedyRow = CreateObject("roSGNode", "ContentNode")
    ' comedyRow.title = "Comedy Series"
    RBS_CC_16_reportLine("91", 1)
    actionTitles = {
        en: "Action Series"
        pt: "Séries de Ação"
        fr: "Séries d’Action"
        es: "Series de Acción"
        de: "Actionserien"
    }
    RBS_CC_16_reportLine("99", 1)
    dramaTitles = {
        en: "Drama Series"
        pt: "Séries Dramáticas"
        fr: "Séries Dramatiques"
        es: "Series Dramáticas"
        de: "Dramaserien"
    }
    RBS_CC_16_reportLine("107", 1)
    comedyTitles = {
        en: "Comedy Series"
        pt: "Séries de Comédia"
        fr: "Séries Comiques"
        es: "Series de Comedia"
        de: "Comedyserien"
    }
    RBS_CC_16_reportLine("115", 1)
    actionRow = CreateObject("roSGNode", "ContentNode")
    RBS_CC_16_reportLine("116", 1)
    actionRow.title = actionTitles[lang]
    RBS_CC_16_reportLine("118", 1)
    dramaRow = CreateObject("roSGNode", "ContentNode")
    RBS_CC_16_reportLine("119", 1)
    dramaRow.title = dramaTitles[lang]
    RBS_CC_16_reportLine("121", 1)
    comedyRow = CreateObject("roSGNode", "ContentNode")
    RBS_CC_16_reportLine("122", 1)
    comedyRow.title = comedyTitles[lang]
    RBS_CC_16_reportLine("124", 1): for each series in data.series
        RBS_CC_16_reportLine("126", 1)
        itemNode = CreateObject("roSGNode", "ContentNode")
        RBS_CC_16_reportLine("127", 1)
        itemNode.ShortDescriptionLine1 = series.translations[lang].name
        RBS_CC_16_reportLine("128", 1)
        itemNode.HDPosterUrl = series.thumbnail
        RBS_CC_16_reportLine("129", 1)
        itemNode.url = series.url
        RBS_CC_16_reportLine("130", 1)
        itemNode.ShortDescriptionLine2 = series.translations[lang].description
        if RBS_CC_16_reportLine("132", 2) and (series.genre.en = "Action")
            RBS_CC_16_reportLine("132", 3)
            RBS_CC_16_reportLine("133", 1)
            actionRow.appendChild(itemNode)
        else if RBS_CC_16_reportLine("134", 2) and (series.genre.en = "Drama")
            RBS_CC_16_reportLine("134", 3)
            RBS_CC_16_reportLine("135", 1)
            dramaRow.appendChild(itemNode)
        else if RBS_CC_16_reportLine("136", 2) and (series.genre.en = "Comedy")
            RBS_CC_16_reportLine("136", 3)
            RBS_CC_16_reportLine("137", 1)
            comedyRow.appendChild(itemNode)
        end if
    end for
    if RBS_CC_16_reportLine("141", 2) and (actionRow.getChildCount() > 0) then
        RBS_CC_16_reportLine("141", 3)
        RBS_CC_16_reportLine("141", 1)
        root.appendChild(actionRow)
    end if
    if RBS_CC_16_reportLine("142", 2) and (dramaRow.getChildCount() > 0) then
        RBS_CC_16_reportLine("142", 3)
        RBS_CC_16_reportLine("142", 1)
        root.appendChild(dramaRow)
    end if
    if RBS_CC_16_reportLine("143", 2) and (comedyRow.getChildCount() > 0) then
        RBS_CC_16_reportLine("143", 3)
        RBS_CC_16_reportLine("143", 1)
        root.appendChild(comedyRow)
    end if
    RBS_CC_16_reportLine("145", 1)
    m.top.movieContent = invalid
    RBS_CC_16_reportLine("146", 1)
    m.top.movieContent = root
end sub

function handleDeepLink(deepLinkId as string, contentType as string)
    RBS_CC_16_reportLine("150", 1)
    root = m.top.movieContent
    if RBS_CC_16_reportLine("151", 2) and (not isValid(root)) then
        RBS_CC_16_reportLine("151", 3)
        RBS_CC_16_reportLine("151", 1)
        return true
    end if
    RBS_CC_16_reportLine("152", 1): for rowIndex = 0 to root.getChildCount() - 1
        RBS_CC_16_reportLine("153", 1)
        row = root.getChild(rowIndex)
        RBS_CC_16_reportLine("154", 1): for itemIndex = 0 to row.getChildCount() - 1
            RBS_CC_16_reportLine("155", 1)
            item = row.getChild(itemIndex)
            if RBS_CC_16_reportLine("156", 2) and (isValid(item) and item.ShortDescriptionLine1 = deepLinkId)
                RBS_CC_16_reportLine("156", 3)
                RBS_CC_16_reportLine("157", 1)
                item.addField("mediaType", "string", false)
                RBS_CC_16_reportLine("158", 1)
                item.mediaType = contentType
                RBS_CC_16_reportLine("159", 1)
                m.top.deepLinkItem = item
                RBS_CC_16_reportLine("160", 1)
                return true
            end if
        end for
    end for
    RBS_CC_16_reportLine("164", 1)
    return true
end function

function RBS_CC_16_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "16"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "16"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./MovieViewModel.brs.map