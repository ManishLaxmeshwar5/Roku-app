' @ignore
function rooibos_init(testSceneName = invalid) as void
    if RBS_CC_30_reportLine("2", 2) and (createObject("roAPPInfo").IsDev() <> true)
        RBS_CC_30_reportLine("2", 3)
        RBS_CC_30_reportLine("3", 1)
        rooibos_common_logError(" not running in dev mode! - rooibos tests only support sideloaded builds - aborting")
        RBS_CC_30_reportLine("4", 1)
        return
    end if
    RBS_CC_30_reportLine("6", 1)
    screen = CreateObject("roSGScreen")
    RBS_CC_30_reportLine("7", 1)
    m.port = CreateObject("roMessagePort")
    RBS_CC_30_reportLine("8", 1)
    screen.setMessagePort(m.port)
    if RBS_CC_30_reportLine("9", 2) and (testSceneName = invalid or testSceneName = "")
        RBS_CC_30_reportLine("9", 3)
        RBS_CC_30_reportLine("10", 1)
        testSceneName = "RooibosScene"
    end if
    RBS_CC_30_reportLine("12", 1)
    rooibos_common_logInfo(("Starting test using test scene with name RooibosScene " + bslib_toString(testSceneName)))
    RBS_CC_30_reportLine("13", 1)
    scene = screen.CreateScene(testSceneName)
    RBS_CC_30_reportLine("14", 1)
    scene.id = "ROOT"
    RBS_CC_30_reportLine("15", 1)
    screen.show()
    RBS_CC_30_reportLine("16", 1)
    m.global = screen.getGlobalNode()
    RBS_CC_30_reportLine("17", 1)
    m.global.addFields({
        "testsScene": scene
        "_rbs_ccn": createObject("roSGNode", "CodeCoverage") ' bs:disable-line
    })
    if RBS_CC_30_reportLine("21", 2) and (scene.hasField("isReadyToStartTests") and scene.isReadyToStartTests = false)
        RBS_CC_30_reportLine("21", 3)
        RBS_CC_30_reportLine("22", 1)
        rooibos_common_logInfo("The scene is not ready yet - waiting for it to set isReadyToStartTests to true")
        RBS_CC_30_reportLine("23", 1)
        scene.observeField("isReadyToStartTests", m.port)
    else
        RBS_CC_30_reportLine("24", 3)
        RBS_CC_30_reportLine("25", 1)
        rooibos_common_logInfo("scene is ready; running tests now")
        RBS_CC_30_reportLine("26", 1)
        print ""
        RBS_CC_30_reportLine("27", 1)
        runner = rooibos_TestRunner(scene, m)
        RBS_CC_30_reportLine("28", 1)
        runner.Run()
        if RBS_CC_30_reportLine("29", 2) and (runner.config.keepAppOpen = false)
            RBS_CC_30_reportLine("29", 3)
            RBS_CC_30_reportLine("30", 1)
            rooibos_common_logInfo("keepAppOpen is false; exiting Rooibos")
            ' End statement will also exit the caller of this function
            ' leading to an instant exit of the application
            ' Give the io port time to finish sending all the logs
            RBS_CC_30_reportLine("34", 1)
            sleep(400)
            end
        end if
    end if
    RBS_CC_30_reportLine("38", 1): while true
        RBS_CC_30_reportLine("39", 1)
        msg = wait(0, m.port)
        RBS_CC_30_reportLine("40", 1)
        msgType = type(msg)
        if RBS_CC_30_reportLine("41", 2) and (msgType = "roSGScreenEvent")
            RBS_CC_30_reportLine("41", 3)
            if RBS_CC_30_reportLine("42", 2) and (msg.isScreenClosed())
                RBS_CC_30_reportLine("42", 3)
                RBS_CC_30_reportLine("43", 1)
                return
            end if
        else if RBS_CC_30_reportLine("45", 2) and (msgType = "roSGNodeEvent")
            RBS_CC_30_reportLine("45", 3)
            if RBS_CC_30_reportLine("46", 2) and (msg.getField() = "isReadyToStartTests" and msg.getData() = true)
                RBS_CC_30_reportLine("46", 3)
                RBS_CC_30_reportLine("47", 1)
                rooibos_common_logInfo("scene is ready; running tests now")
                RBS_CC_30_reportLine("48", 1)
                print ""
                RBS_CC_30_reportLine("49", 1)
                runner = rooibos_TestRunner(scene, m)
                RBS_CC_30_reportLine("50", 1)
                runner.Run()
            end if
        end if
    end while
end function

' @ignore
function rooibos_versionCompare(v1, v2)
    RBS_CC_30_reportLine("58", 1)
    v1parts = v1.split(".")
    RBS_CC_30_reportLine("59", 1)
    v2parts = v2.split(".")
    RBS_CC_30_reportLine("60", 1): while v1parts.count() < v2parts.count()
        RBS_CC_30_reportLine("61", 1)
        v1parts.push("0")
    end while
    RBS_CC_30_reportLine("63", 1): while v2parts.count() < v1parts.count()
        RBS_CC_30_reportLine("64", 1)
        v2parts.push("0")
    end while
    RBS_CC_30_reportLine("66", 1): for i = 0 to v1parts.count() - 1
        if RBS_CC_30_reportLine("67", 2) and (v2parts.count() = i)
            RBS_CC_30_reportLine("67", 3)
            RBS_CC_30_reportLine("68", 1)
            return 1
        end if
        if RBS_CC_30_reportLine("70", 2) and (v1parts[i] <> v2parts[i])
            RBS_CC_30_reportLine("70", 3)
            if RBS_CC_30_reportLine("71", 2) and (v1parts[i] > v2parts[i])
                RBS_CC_30_reportLine("71", 3)
                RBS_CC_30_reportLine("72", 1)
                return 1
            else
                RBS_CC_30_reportLine("73", 3)
                RBS_CC_30_reportLine("74", 1)
                return -1
            end if
        end if
    end for
    if RBS_CC_30_reportLine("78", 2) and (v1parts.count() <> v2parts.count())
        RBS_CC_30_reportLine("78", 3)
        RBS_CC_30_reportLine("79", 1)
        return -1
    end if
    RBS_CC_30_reportLine("81", 1)
    return 0
end function

'//# sourceMappingURL=./Rooibos.brs.map
function RBS_CC_30_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "30"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "30"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./Rooibos.brs.map