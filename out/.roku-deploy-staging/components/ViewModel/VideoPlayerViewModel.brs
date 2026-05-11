function VideoPlayerViewModel() as Object

    vm = {}
    vm.savedBookmarkPosition = 0
    vm.shouldResumeFromBookmark = false
    vm.hasResumedFromBookmark = false

    vm.prepareVideoContent = function(content as Object) as Object
        node = CreateObject("roSGNode","ContentNode")
        node.url = content.url
        node.title = content.title
        return node
    end function

    vm.setupResumeState = function(content as Object,bookmarkData as Object)
        m.savedBookmarkPosition = 0
        m.shouldResumeFromBookmark = false
        m.hasResumedFromBookmark = false

        if content.DoesExist("bookmarkPosition")
            if content.bookmarkPosition > 5
                m.savedBookmarkPosition =content.bookmarkPosition
                m.shouldResumeFromBookmark = true
                return invalid
            end if
        end if

        if bookmarkData.position > 5
            m.savedBookmarkPosition =bookmarkData.position
            m.shouldResumeFromBookmark = true
        end if
    end function

    vm.shouldSeek = function(duration as Integer) as Boolean
        return (m.savedBookmarkPosition > 0 and not m.hasResumedFromBookmark and duration > m.savedBookmarkPosition)
    end function

    vm.markResumed = function()
        m.hasResumedFromBookmark = true
    end function

    return vm
end function