function createScreenManager()
    return {
        stack: [],
        pushScreen: function(screen)
            m.stack.push(screen)
            print "navigation Stack : " m.stack
        end function,
        popScreen: function()
            if m.stack.count() > 0
                print "navigation Stack pop : " m.stack
                return m.stack.pop()
            end if

            return invalid

        end function,
        getTopScreen: function()
            if m.stack.count() > 0
                return m.stack[m.stack.count() - 1]
            end if
            return invalid
        end function,
        hasScreens: function()
            return m.stack.count() > 0
        end function
    }
end function