sub Main(args as Dynamic)
    RBS_CC_49_reportLine("0", 1)
    Rooibos_init("RooibosScene")
    RBS_CC_49_reportLine("1", 1)
    showChannelSGScreen(args)
end sub

sub showChannelSGScreen(args as Dynamic)
    RBS_CC_49_reportLine("5", 1)
    screen = CreateObject("roSGScreen")
    RBS_CC_49_reportLine("6", 1)
    m.port = CreateObject("roMessagePort")
    RBS_CC_49_reportLine("7", 1)
    screen.setMessagePort(m.port)
    RBS_CC_49_reportLine("8", 1)
    scene = screen.CreateScene("MainScene")
    ' scene = screen.CreateScene("RooibosScene")
    RBS_CC_49_reportLine("10", 1)
    screen.show()
    if RBS_CC_49_reportLine("12", 2) and (args <> invalid and args.ContentId <> invalid and args.mediaType <> invalid)
        RBS_CC_49_reportLine("12", 3)
        RBS_CC_49_reportLine("13", 1)
        print "deepink detected"
        RBS_CC_49_reportLine("14", 1)
        print "contentId="; args.contentId
        RBS_CC_49_reportLine("15", 1)
        print "mediatype="; args.mediaType
        RBS_CC_49_reportLine("17", 1)
        scene.deepLinkData = args
    end if
    RBS_CC_49_reportLine("19", 1)
    scene.observeField("exitApp", m.port)
    RBS_CC_49_reportLine("20", 1)
    scene.setFocus(true)
    RBS_CC_49_reportLine("22", 1): while (true)
        RBS_CC_49_reportLine("23", 1)
        msg = wait(0, m.port)
        RBS_CC_49_reportLine("24", 1)
        msgType = type(msg)
        if RBS_CC_49_reportLine("26", 2) and (msgType = "roSGScreenEvent") then
            RBS_CC_49_reportLine("26", 3)
            if RBS_CC_49_reportLine("27", 2) and (msg.isScreenClosed()) then
                RBS_CC_49_reportLine("27", 3)
                RBS_CC_49_reportLine("28", 1)
                return
            end if
        else if RBS_CC_49_reportLine("30", 2) and (msgType = "roSGNodeEvent") then
            RBS_CC_49_reportLine("30", 3)
            RBS_CC_49_reportLine("31", 1)
            field = msg.getField()
            RBS_CC_49_reportLine("32", 1)
            data = msg.getData()
            RBS_CC_49_reportLine("33", 1)
            print "Field changed:"; field; data
            if RBS_CC_49_reportLine("34", 2) and (field = "exitApp" and data = true) then
                RBS_CC_49_reportLine("34", 3)
                RBS_CC_49_reportLine("35", 1)
                print "Main.brs recieved exitApp"
                RBS_CC_49_reportLine("36", 1)
                return
            end if
        end if
    end while
end sub

function RBS_CC_49_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "49"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "49"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./main.brs.map