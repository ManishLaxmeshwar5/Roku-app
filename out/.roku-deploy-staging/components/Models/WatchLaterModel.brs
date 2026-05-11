function WatchLaterModel() as Object

    model = {}
    model.toggleWatchLater = function(content as Object,watchLaterList as Object) as Object

        item = {
            title: content.ShortDescriptionLine1
            description: content.ShortDescriptionLine2
            url: content.url
            poster: content.HDPosterUrl
        }

        for i = 0 to watchLaterList.count() - 1
            if watchLaterList[i].title = item.title
                watchLaterList.delete(i)

                return {
                    added: false
                    updatedList: watchLaterList
                }
            end if
        end for
        watchLaterList.push(item)

        return {
            added: true
            updatedList: watchLaterList
        }
    end function
    return model
end function