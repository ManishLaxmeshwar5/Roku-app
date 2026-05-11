sub Main(args as Dynamic)
    showChannelSGScreen(args)
end sub

sub showChannelSGScreen(args as Dynamic)
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("MainScene")
    screen.show()

    if args<> invalid and args.ContentId <> invalid and args.mediaType <> invalid
        print "deepink detected"
        print "contentId=";args.contentId
        print "mediatype=";args.mediaType

        scene.deepLinkData = args
    end if
    scene.observeField("exitApp", m.port)
    scene.setFocus(true)
    
    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        
        if msgType = "roSGScreenEvent" then
            if msg.isScreenClosed() then 
                return
            end if
        else if msgType = "roSGNodeEvent" then
        field = msg.getField()
        data = msg.getData()
        print "Field changed:";field;data
        if field = "exitApp" and data = true then
            print "Main.brs recieved exitApp"
            return
        end if
        end if
    end while
end sub