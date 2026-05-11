function BookmarkModel() as Object

    model = {}

    model.registry =CreateObject("roRegistrySection","VideoBookmarks")
    model.saveBookmark = function(videoUrl as String,title as String,position as Integer)

        if title = invalid or title = ""
            return invalid
        end if

        bookmarkData = {
            url: videoUrl
            title: title
            position: position
        }

        key = LCase(title.Trim())
        m.registry.Write(key,FormatJson(bookmarkData))
        m.registry.Flush()
    end function

    model.getBookmark = function(title as String) as Object

        result = {
            url: ""
            title: title
            position: 0
        }
        if title = invalid or title = ""
            return result
        end if
        key = LCase(title.Trim())
        value = m.registry.Read(key)
        if value <> invalid and value <> ""
            parsed = ParseJson(value)
            if type(parsed) = "roAssociativeArray"
                result = parsed
            end if
        end if
        return result
    end function

    model.clearBookmark = function(title as String)

        if title = invalid or title = ""
            return invalid
        end if
        key = LCase(title.Trim())
        m.registry.Delete(key)
        m.registry.Flush()
    end function
    return model
end function