function DetailViewModel() as Object

    vm = {}

    vm.content = invalid
    vm.isInWatchLater = false

    vm.setContent = function(content as Object, watchLaterList as Object)

        m.content = content

        m.isInWatchLater = false
        for each item in watchLaterList
            if item.title = content.ShortDescriptionLine1
                m.isInWatchLater = true
                exit for
            end if
        end for
    end function

    vm.getNavigationPayload = function() as Object
        return {
            type: "navigate"
            screen: "VideoPlayer"
            payload: {
                url: m.content.url
                title: m.content.ShortDescriptionLine1
            }
        }
    end function
    return vm
end function