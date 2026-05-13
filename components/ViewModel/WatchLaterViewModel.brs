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

    ' vm.getGridContent = function() as Object
    '     root = CreateObject("roSGNode", "ContentNode")
    '     for each item in m.items
    '         root.appendChild(item)
    '     end for
    '     return root
    ' end function
vm.getGridContent = function() as Object
    root = CreateObject("roSGNode", "ContentNode")
    row = root.createChild("ContentNode")
    row.title = "Watch Later"

    ' ✅ Set item size on the ROW node, not item nodes
    row.addField("rowItemSize", "vector2d", false)
    row.rowItemSize = [200, 250]

    ' Optional: spacing between items in the row
    row.addField("rowItemSpacing", "vector2d", false)
    row.rowItemSpacing = [20, 0]

    for each item in m.items
        node = row.createChild("ContentNode")
        node.ShortDescriptionLine1 = item.ShortDescriptionLine1
        node.ShortDescriptionLine2 = item.ShortDescriptionLine2
        node.HDPosterUrl = item.HDPosterUrl
        print node.HDPosterUrl
        node.url = item.url

        node.addField("screenType", "string", false)
        node.screenType = "watchlater"
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