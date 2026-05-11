function WatchLaterViewModel() as Object

    vm = {}

    vm.items = []
    vm.isEmpty = true


    vm.setWatchLaterList = function(list as Object)

        m.items = []

        if not isValid(list)
            m.isEmpty = true
            return invalid
        end if

        if list.count() = 0
            m.isEmpty = true
            return invalid
        end if


        m.isEmpty = false

        for each item in list

            node = CreateObject("roSGNode", "ContentNode")
            node.ShortDescriptionLine1 = item.title
            node.ShortDescriptionLine2 = item.description
            node.HDPosterUrl = item.poster
            node.url = item.url
            m.items.push(node)
        end for
    end function

    vm.getGridContent = function() as Object
        root = CreateObject("roSGNode", "ContentNode")
        for each item in m.items
            root.appendChild(item)
        end for
        return root
    end function


    vm.getNavigationPayload = function(selectedItem as Object) as Object
        return {
            type: "navigate"
            screen: "DetailScreen"
            payload: selectedItem
        }
    end function
    return vm
end function