' @ignore
function rooibos_init(testSceneName = invalid) as void
    if createObject("roAPPInfo").IsDev() <> true
        rooibos_common_logError(" not running in dev mode! - rooibos tests only support sideloaded builds - aborting")
        return
    end if
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    if testSceneName = invalid or testSceneName = ""
        testSceneName = "RooibosScene"
    end if
    rooibos_common_logInfo(("Starting test using test scene with name RooibosScene " + bslib_toString(testSceneName)))
    scene = screen.CreateScene(testSceneName)
    scene.id = "ROOT"
    screen.show()
    m.global = screen.getGlobalNode()
    m.global.addFields({
        "testsScene": scene
        "_rbs_ccn": createObject("roSGNode", "CodeCoverage") ' bs:disable-line
    })
    if scene.hasField("isReadyToStartTests") and scene.isReadyToStartTests = false
        rooibos_common_logInfo("The scene is not ready yet - waiting for it to set isReadyToStartTests to true")
        scene.observeField("isReadyToStartTests", m.port)
    else
        rooibos_common_logInfo("scene is ready; running tests now")
        print ""
        runner = rooibos_TestRunner(scene, m)
        runner.Run()
        if runner.config.keepAppOpen = false
            rooibos_common_logInfo("keepAppOpen is false; exiting Rooibos")
            ' End statement will also exit the caller of this function
            ' leading to an instant exit of the application
            ' Give the io port time to finish sending all the logs
            sleep(400)
            end
        end if
    end if
    while true
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed()
                return
            end if
        else if msgType = "roSGNodeEvent"
            if msg.getField() = "isReadyToStartTests" and msg.getData() = true
                rooibos_common_logInfo("scene is ready; running tests now")
                print ""
                runner = rooibos_TestRunner(scene, m)
                runner.Run()
            end if
        end if
    end while
end function

' @ignore
function rooibos_versionCompare(v1, v2)
    v1parts = v1.split(".")
    v2parts = v2.split(".")
    while v1parts.count() < v2parts.count()
        v1parts.push("0")
    end while
    while v2parts.count() < v1parts.count()
        v2parts.push("0")
    end while
    for i = 0 to v1parts.count() - 1
        if v2parts.count() = i
            return 1
        end if
        if v1parts[i] <> v2parts[i]
            if v1parts[i] > v2parts[i]
                return 1
            else
                return -1
            end if
        end if
    end for
    if v1parts.count() <> v2parts.count()
        return -1
    end if
    return 0
end function
'//# sourceMappingURL=./Rooibos.brs.map