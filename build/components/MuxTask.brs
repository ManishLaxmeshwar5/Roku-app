sub init()
    RBS_CC_5_reportLine("1", 1)
    m.MUX_SDK_VERSION = "2.6.2"
    RBS_CC_5_reportLine("2", 1)
    m.top.id = "mux"
    RBS_CC_5_reportLine("3", 1)
    m.top.functionName = "runBeaconLoop"
    ' Store randomMuxViewerId in m scope to avoid rendezvous in task thread
    RBS_CC_5_reportLine("6", 1)
    m.randomMuxViewerId = m.top.randomMuxViewerId
end sub

function runBeaconLoop()
    RBS_CC_5_reportLine("10", 1)
    m.messagePort = _createPort()
    RBS_CC_5_reportLine("11", 1)
    appInfo = _createAppInfo()
    RBS_CC_5_reportLine("13", 1)
    m.MAX_BEACON_SIZE = 300 'controls size of a single beacon (in events)
    RBS_CC_5_reportLine("14", 1)
    m.MAX_QUEUE_LENGTH = 3600 '1 minute to clean a full queue
    RBS_CC_5_reportLine("15", 1)
    m.BASE_TIME_BETWEEN_BEACONS = 10000
    RBS_CC_5_reportLine("16", 1)
    m.HEARTBEAT_INTERVAL = 10000
    RBS_CC_5_reportLine("17", 1)
    m.POSITION_TIMER_INTERVAL = 250 '250
    RBS_CC_5_reportLine("18", 1)
    m.SEEK_THRESHOLD = 1250 'ms jump in position before a seek is considered'
    RBS_CC_5_reportLine("19", 1)
    m.HTTP_RETRIES = 10 'number of times to reattempt http call'
    RBS_CC_5_reportLine("20", 1)
    m.MAX_VIDEO_POSITION_JUMP = 2000000000
    RBS_CC_5_reportLine("22", 1)
    m.pollTimer = CreateObject("roSGNode", "Timer")
    RBS_CC_5_reportLine("23", 1)
    m.pollTimer.setFields({
        id: "pollTimer"
        repeat: true
        duration: m.POSITION_TIMER_INTERVAL / 1000
    })
    ' m.heartbeatTimer = m.top.findNode("heartbeatTimer")
    RBS_CC_5_reportLine("30", 1)
    m.heartbeatTimer = CreateObject("roSGNode", "Timer")
    RBS_CC_5_reportLine("31", 1)
    m.heartbeatTimer.id = "heartbeatTimer"
    RBS_CC_5_reportLine("32", 1)
    m.heartbeatTimer.repeat = true
    RBS_CC_5_reportLine("33", 1)
    m.heartbeatTimer.duration = m.HEARTBEAT_INTERVAL / 1000
    RBS_CC_5_reportLine("35", 1)
    m.beaconTimer = CreateObject("roSGNode", "Timer")
    RBS_CC_5_reportLine("36", 1)
    m.beaconTimer.id = "beaconTimer"
    RBS_CC_5_reportLine("37", 1)
    m.beaconTimer.repeat = true
    RBS_CC_5_reportLine("38", 1)
    m.beaconTimer.duration = m.BASE_TIME_BETWEEN_BEACONS / 1000
    RBS_CC_5_reportLine("39", 1)
    m.beaconTimer.control = "start"
    RBS_CC_5_reportLine("41", 1)
    m.httpPort = _createPort()
    RBS_CC_5_reportLine("43", 1)
    useRandomMuxViewerId = false
    if RBS_CC_5_reportLine("44", 2) and (m.randomMuxViewerId <> invalid)
        RBS_CC_5_reportLine("44", 3)
        RBS_CC_5_reportLine("45", 1)
        useRandomMuxViewerId = m.randomMuxViewerId
    end if
    RBS_CC_5_reportLine("48", 1)
    m.mxa = muxAnalytics()
    RBS_CC_5_reportLine("49", 1)
    m.mxa.MUX_SDK_VERSION = m.MUX_SDK_VERSION
    RBS_CC_5_reportLine("51", 1)
    print "[mux-analytics] running task loop"
    RBS_CC_5_reportLine("53", 1)
    systemConfig = {
        MAX_BEACON_SIZE: m.MAX_BEACON_SIZE
        MAX_QUEUE_LENGTH: m.MAX_QUEUE_LENGTH
        MAX_VIDEO_POSITION_JUMP: m.MAX_VIDEO_POSITION_JUMP
        HTTP_RETRIES: m.HTTP_RETRIES
        BASE_TIME_BETWEEN_BEACONS: m.BASE_TIME_BETWEEN_BEACONS
        HEARTBEAT_INTERVAL: m.HEARTBEAT_INTERVAL
        POSITION_TIMER_INTERVAL: m.POSITION_TIMER_INTERVAL
        SEEK_THRESHOLD: m.SEEK_THRESHOLD
        USE_RANDOM_MUX_VIEWER_ID: useRandomMuxViewerId
    }
    RBS_CC_5_reportLine("64", 1)
    m.mxa.init(appInfo, systemConfig, m.top.config, m.heartbeatTimer, m.pollTimer, m.httpPort)
    RBS_CC_5_reportLine("66", 1)
    m.top.ObserveField("rafEvent", m.messagePort)
    if RBS_CC_5_reportLine("68", 2) and (m.top.video = invalid)
        RBS_CC_5_reportLine("68", 3)
        RBS_CC_5_reportLine("69", 1)
        m.top.ObserveField("video", m.messagePort)
    else
        RBS_CC_5_reportLine("70", 3)
        RBS_CC_5_reportLine("71", 1)
        m.mxa.videoAddedHandler(m.top.video)
        RBS_CC_5_reportLine("72", 1)
        m.top.video.ObserveField("state", m.messagePort)
        RBS_CC_5_reportLine("73", 1)
        m.top.video.ObserveField("content", m.messagePort)
        RBS_CC_5_reportLine("74", 1)
        m.top.video.ObserveField("control", m.messagePort)
        RBS_CC_5_reportLine("75", 1)
        m.top.video.ObserveField("licenseStatus", m.messagePort)
        RBS_CC_5_reportLine("76", 1)
        m.top.video.ObserveField("contentIndex", m.messagePort)
        RBS_CC_5_reportLine("77", 1)
        m.top.video.ObserveField("downloadedSegment", m.messagePort)
        RBS_CC_5_reportLine("78", 1)
        m.top.video.ObserveField("streamingSegment", m.messagePort)
        RBS_CC_5_reportLine("79", 1)
        m.top.video.ObserveField("position", m.messagePort)
        if RBS_CC_5_reportLine("80", 2) and (m.top.disableDecoderStats <> true and m.top.video.enableDecoderStats <> invalid)
            RBS_CC_5_reportLine("80", 3)
            RBS_CC_5_reportLine("81", 1)
            m.top.video.enableDecoderStats = true
            RBS_CC_5_reportLine("82", 1)
            m.top.video.ObserveField("decoderStats", m.messagePort)
        end if
    end if
    if RBS_CC_5_reportLine("86", 2) and (m.top.view <> invalid and m.top.view <> "")
        RBS_CC_5_reportLine("86", 3)
        RBS_CC_5_reportLine("87", 1)
        m.mxa.videoViewChangeHandler(m.top.view)
    end if
    RBS_CC_5_reportLine("89", 1)
    m.top.ObserveField("view", m.messagePort)
    if RBS_CC_5_reportLine("91", 2) and (m.top.config <> invalid)
        RBS_CC_5_reportLine("91", 3)
        RBS_CC_5_reportLine("92", 1)
        m.mxa.configChangeHandler(m.top.config)
    end if
    RBS_CC_5_reportLine("94", 1)
    m.top.ObserveField("config", m.messagePort)
    if RBS_CC_5_reportLine("96", 2) and (m.top.useRenderStitchedStream <> invalid)
        RBS_CC_5_reportLine("96", 3)
        RBS_CC_5_reportLine("97", 1)
        m.mxa.useRenderStitchedStreamHandler(m.top.useRenderStitchedStream)
    end if
    RBS_CC_5_reportLine("99", 1)
    m.top.ObserveField("useRenderStitchedStream", m.messagePort)
    if RBS_CC_5_reportLine("101", 2) and (m.top.useSSAI <> invalid)
        RBS_CC_5_reportLine("101", 3)
        RBS_CC_5_reportLine("102", 1)
        m.mxa.useSSAIHandler(m.top.useSSAI)
    end if
    RBS_CC_5_reportLine("104", 1)
    m.top.ObserveField("useSSAI", m.messagePort)
    if RBS_CC_5_reportLine("106", 2) and (m.top.disableAutomaticErrorTracking <> invalid)
        RBS_CC_5_reportLine("106", 3)
        RBS_CC_5_reportLine("107", 1)
        m.mxa.disableAutomaticErrorTrackingHandler(m.top.disableAutomaticErrorTracking)
    end if
    RBS_CC_5_reportLine("109", 1)
    m.top.ObserveField("disableAutomaticErrorTracking", m.messagePort)
    if RBS_CC_5_reportLine("111", 2) and (m.top.error <> invalid)
        RBS_CC_5_reportLine("111", 3)
        RBS_CC_5_reportLine("112", 1)
        m.mxa.videoErrorHandler(m.top.error)
    end if
    RBS_CC_5_reportLine("114", 1)
    m.top.ObserveField("error", m.messagePort)
    if RBS_CC_5_reportLine("116", 2) and (m.top.cdn <> invalid)
        RBS_CC_5_reportLine("116", 3)
        RBS_CC_5_reportLine("117", 1)
        m.mxa.cdnChangeHandler(m.top.cdn)
    end if
    RBS_CC_5_reportLine("119", 1)
    m.top.ObserveField("cdn", m.messagePort)
    if RBS_CC_5_reportLine("121", 2) and (m.top.disablePlayheadRebufferTracking <> invalid)
        RBS_CC_5_reportLine("121", 3)
        RBS_CC_5_reportLine("122", 1)
        m.mxa.disablePlayheadRebufferTrackingHandler(m.top.disablePlayheadRebufferTracking)
    end if
    RBS_CC_5_reportLine("124", 1)
    m.top.ObserveField("disablePlayheadRebufferTracking", m.messagePort)
    RBS_CC_5_reportLine("126", 1)
    m.top.ObserveField("rebufferstart", m.messagePort)
    RBS_CC_5_reportLine("127", 1)
    m.top.ObserveField("rebufferend", m.messagePort)
    if RBS_CC_5_reportLine("129", 2) and (m.top.playback_mode <> invalid)
        RBS_CC_5_reportLine("129", 3)
        RBS_CC_5_reportLine("130", 1)
        m.mxa.playbackModeHandler(m.top.playback_mode)
    end if
    RBS_CC_5_reportLine("132", 1)
    m.top.ObserveField("playback_mode", m.messagePort)
    RBS_CC_5_reportLine("134", 1)
    m.top.ObserveField("request", m.messagePort)
    RBS_CC_5_reportLine("136", 1)
    m.pollTimer.ObserveField("fire", m.messagePort)
    RBS_CC_5_reportLine("137", 1)
    m.beaconTimer.ObserveField("fire", m.messagePort)
    RBS_CC_5_reportLine("138", 1)
    m.heartbeatTimer.ObserveField("fire", m.messagePort)
    ' Try to enable network events - these methods are available on Roku OS 10+
    RBS_CC_5_reportLine("141", 1)
    firmwareVersion = m.mxa._sessionProperties.viewer_os_version
    ' Parse major version from firmware string (e.g., "10.1" -> 10, "9.2" -> 9)
    RBS_CC_5_reportLine("143", 1)
    majorVersion = 0
    if RBS_CC_5_reportLine("144", 2) and (firmwareVersion <> invalid and Type(firmwareVersion) = "String" and firmwareVersion <> "")
        RBS_CC_5_reportLine("144", 3)
        RBS_CC_5_reportLine("145", 1)
        firmwareParts = firmwareVersion.Tokenize(".")
        if RBS_CC_5_reportLine("146", 2) and (firmwareParts.Count() > 0)
            RBS_CC_5_reportLine("146", 3)
            RBS_CC_5_reportLine("147", 1)
            majorVersion = Val(firmwareParts[0])
        end if
    end if
    RBS_CC_5_reportLine("151", 1)
    linkEventEnabled = invalid
    RBS_CC_5_reportLine("152", 1)
    internetEventEnabled = invalid
    if RBS_CC_5_reportLine("154", 2) and (majorVersion >= 10)
        RBS_CC_5_reportLine("154", 3)
        RBS_CC_5_reportLine("155", 1)
        m.mxa.deviceInfo.SetMessagePort(m.messagePort)
        RBS_CC_5_reportLine("156", 1)
        linkEventEnabled = m.mxa.deviceInfo.EnableLinkStatusEvent(true)
        RBS_CC_5_reportLine("157", 1)
        internetEventEnabled = m.mxa.deviceInfo.EnableInternetStatusEvent(true)
        if RBS_CC_5_reportLine("159", 2) and (linkEventEnabled = true and internetEventEnabled = true)
            RBS_CC_5_reportLine("159", 3)
            RBS_CC_5_reportLine("160", 1)
            print "[mux-analytics] Network status events enabled successfully"
            RBS_CC_5_reportLine("161", 1)
            m.mxa._networkEventsSupported = true
        else
            RBS_CC_5_reportLine("162", 3)
            RBS_CC_5_reportLine("163", 1)
            print "[mux-analytics] WARNING: Network event methods returned false, falling back to polling"
            RBS_CC_5_reportLine("164", 1)
            print "[mux-analytics] EnableLinkStatusEvent: "; linkEventEnabled; ", EnableInternetStatusEvent: "; internetEventEnabled
            RBS_CC_5_reportLine("165", 1)
            m.mxa._networkEventsSupported = false
        end if
    else
        RBS_CC_5_reportLine("167", 3)
        RBS_CC_5_reportLine("168", 1)
        print "[mux-analytics] Roku OS "; firmwareVersion; " detected. Network events require OS 10+, using polling instead"
        RBS_CC_5_reportLine("169", 1)
        m.mxa._networkEventsSupported = false
    end if
    ' Track exit on a separate port per Roku's guidance
    RBS_CC_5_reportLine("173", 1)
    m.exitPort = _createPort()
    RBS_CC_5_reportLine("174", 1)
    m.top.ObserveField("exit", m.exitPort)
    RBS_CC_5_reportLine("176", 1)
    running = true
    RBS_CC_5_reportLine("177", 1): while running
        RBS_CC_5_reportLine("178", 1)
        exitMsg = wait(10, m.exitPort)
        RBS_CC_5_reportLine("179", 1)
        httpMsg = wait(10, m.httpPort)
        RBS_CC_5_reportLine("180", 1)
        msg = wait(30, m.messagePort)
        if RBS_CC_5_reportLine("181", 2) and (exitMsg <> invalid)
            RBS_CC_5_reportLine("181", 3)
            RBS_CC_5_reportLine("182", 1)
            data = exitMsg.getData()
            if RBS_CC_5_reportLine("183", 2) and (data = true)
                RBS_CC_5_reportLine("183", 3)
                RBS_CC_5_reportLine("184", 1)
                running = false
            end if
        end if
        if RBS_CC_5_reportLine("187", 2) and (httpMsg <> invalid)
            RBS_CC_5_reportLine("187", 3)
            RBS_CC_5_reportLine("188", 1)
            m.mxa._handleHttpEvent(httpMsg)
        end if
        if RBS_CC_5_reportLine("190", 2) and (msg <> invalid)
            RBS_CC_5_reportLine("190", 3)
            RBS_CC_5_reportLine("191", 1)
            msgType = type(msg)
            if RBS_CC_5_reportLine("192", 2) and (msgType = "roSGNodeEvent")
                RBS_CC_5_reportLine("192", 3)
                RBS_CC_5_reportLine("193", 1)
                field = msg.getField()
                if RBS_CC_5_reportLine("194", 2) and (field = "video")
                    RBS_CC_5_reportLine("194", 3)
                    if RBS_CC_5_reportLine("195", 2) and (m.top.video = invalid)
                        RBS_CC_5_reportLine("195", 3)
                        RBS_CC_5_reportLine("196", 1)
                        m.top.UnobserveField("video")
                        RBS_CC_5_reportLine("197", 1)
                        data = msg.getData()
                        RBS_CC_5_reportLine("198", 1)
                        m.mxa.videoAddedHandler(data)
                        RBS_CC_5_reportLine("199", 1)
                        m.top.video.ObserveField("state", m.messagePort)
                        RBS_CC_5_reportLine("200", 1)
                        m.top.video.ObserveField("content", m.messagePort)
                        RBS_CC_5_reportLine("201", 1)
                        m.top.video.ObserveField("control", m.messagePort)
                        RBS_CC_5_reportLine("202", 1)
                        m.top.video.ObserveField("licenseStatus", m.messagePort)
                        RBS_CC_5_reportLine("203", 1)
                        m.top.video.ObserveField("contentIndex", m.messagePort)
                        RBS_CC_5_reportLine("204", 1)
                        m.top.video.ObserveField("downloadedSegment", m.messagePort)
                        RBS_CC_5_reportLine("205", 1)
                        m.top.video.ObserveField("streamingSegment", m.messagePort)
                        RBS_CC_5_reportLine("206", 1)
                        m.top.video.ObserveField("position", m.messagePort)
                        if RBS_CC_5_reportLine("207", 2) and (m.top.disableDecoderStats <> true and m.top.video.enableDecoderStats <> invalid)
                            RBS_CC_5_reportLine("207", 3)
                            RBS_CC_5_reportLine("208", 1)
                            m.top.video.enableDecoderStats = true
                            RBS_CC_5_reportLine("209", 1)
                            m.top.video.ObserveField("decoderStats", m.messagePort)
                        end if
                    end if
                else if RBS_CC_5_reportLine("212", 2) and (field = "config")
                    RBS_CC_5_reportLine("212", 3)
                    RBS_CC_5_reportLine("213", 1)
                    m.mxa.configChangeHandler(msg.getData())
                else if RBS_CC_5_reportLine("214", 2) and (field = "useRenderStitchedStream")
                    RBS_CC_5_reportLine("214", 3)
                    RBS_CC_5_reportLine("215", 1)
                    m.mxa.useRenderStitchedStreamHandler(msg.getData())
                else if RBS_CC_5_reportLine("216", 2) and (field = "useSSAI")
                    RBS_CC_5_reportLine("216", 3)
                    RBS_CC_5_reportLine("217", 1)
                    m.mxa.useSSAIHandler(msg.getData())
                else if RBS_CC_5_reportLine("218", 2) and (field = "disableAutomaticErrorTracking")
                    RBS_CC_5_reportLine("218", 3)
                    RBS_CC_5_reportLine("219", 1)
                    m.mxa.disableAutomaticErrorTrackingHandler(msg.getData())
                else if RBS_CC_5_reportLine("220", 2) and (field = "error")
                    RBS_CC_5_reportLine("220", 3)
                    RBS_CC_5_reportLine("221", 1)
                    m.mxa.videoErrorHandler(msg.getData())
                else if RBS_CC_5_reportLine("222", 2) and (field = "control")
                    RBS_CC_5_reportLine("222", 3)
                    RBS_CC_5_reportLine("223", 1)
                    m.mxa.videoControlChangeHandler(msg.getData())
                else if RBS_CC_5_reportLine("224", 2) and (field = "contentIndex")
                    RBS_CC_5_reportLine("224", 3)
                    RBS_CC_5_reportLine("225", 1)
                    m.mxa.videoContentIndexChangeHandler(msg.getData())
                else if RBS_CC_5_reportLine("226", 2) and (field = "streamingSegment")
                    RBS_CC_5_reportLine("226", 3)
                    RBS_CC_5_reportLine("227", 1)
                    m.mxa.videoStreamingSegmentChangeHandler(msg.getData())
                else if RBS_CC_5_reportLine("228", 2) and (field = "downloadedSegment")
                    RBS_CC_5_reportLine("228", 3)
                    RBS_CC_5_reportLine("229", 1)
                    m.mxa.videoDownloadedSegmentChangeHandler(msg.getData())
                else if RBS_CC_5_reportLine("230", 2) and (field = "decoderStats")
                    RBS_CC_5_reportLine("230", 3)
                    RBS_CC_5_reportLine("231", 1)
                    m.mxa.videoDecoderStatsChangeHandler(msg.getData())
                else if RBS_CC_5_reportLine("232", 2) and (field = "licenseStatus")
                    RBS_CC_5_reportLine("232", 3)
                    RBS_CC_5_reportLine("233", 1)
                    m.mxa.drmLicenseStatusChangeHandler(msg.getData())
                else if RBS_CC_5_reportLine("234", 2) and (field = "view")
                    RBS_CC_5_reportLine("234", 3)
                    RBS_CC_5_reportLine("235", 1)
                    m.mxa.videoViewChangeHandler(msg.getData())
                else if RBS_CC_5_reportLine("236", 2) and (field = "state")
                    RBS_CC_5_reportLine("236", 3)
                    RBS_CC_5_reportLine("237", 1)
                    msgData = msg.getData()
                    if RBS_CC_5_reportLine("238", 2) and (msgData <> invalid and type(msgData) = "roString")
                        RBS_CC_5_reportLine("238", 3)
                        RBS_CC_5_reportLine("239", 1)
                        m.mxa.videoStateChangeHandler(msgData)
                    end if
                else if RBS_CC_5_reportLine("241", 2) and (field = "position")
                    RBS_CC_5_reportLine("241", 3)
                    RBS_CC_5_reportLine("242", 1)
                    m.mxa.videoPositionChangeHandler(msg.getData())
                else if RBS_CC_5_reportLine("243", 2) and (field = "rafEvent")
                    RBS_CC_5_reportLine("243", 3)
                    RBS_CC_5_reportLine("244", 1)
                    m.mxa.rafEventHandler(msg)
                else if RBS_CC_5_reportLine("245", 2) and (field = "fire")
                    RBS_CC_5_reportLine("245", 3)
                    RBS_CC_5_reportLine("246", 1)
                    node = msg.getNode()
                    if RBS_CC_5_reportLine("247", 2) and (node = "pollTimer")
                        RBS_CC_5_reportLine("247", 3)
                        RBS_CC_5_reportLine("248", 1)
                        m.mxa.pollingIntervalHandler(msg)
                    else if RBS_CC_5_reportLine("249", 2) and (node = "beaconTimer")
                        RBS_CC_5_reportLine("249", 3)
                        RBS_CC_5_reportLine("250", 1)
                        m.mxa.beaconIntervalHandler(msg)
                    else if RBS_CC_5_reportLine("251", 2) and (node = "heartbeatTimer")
                        RBS_CC_5_reportLine("251", 3)
                        RBS_CC_5_reportLine("252", 1)
                        m.mxa.heartbeatIntervalHandler(msg)
                    end if
                else if RBS_CC_5_reportLine("254", 2) and (field = "cdn")
                    RBS_CC_5_reportLine("254", 3)
                    RBS_CC_5_reportLine("255", 1)
                    m.mxa.cdnChangeHandler(msg.getData())
                else if RBS_CC_5_reportLine("256", 2) and (field = "disablePlayheadRebufferTracking")
                    RBS_CC_5_reportLine("256", 3)
                    RBS_CC_5_reportLine("257", 1)
                    m.mxa.disablePlayheadRebufferTrackingHandler(msg.getData())
                else if RBS_CC_5_reportLine("258", 2) and (field = "rebufferstart")
                    RBS_CC_5_reportLine("258", 3)
                    RBS_CC_5_reportLine("259", 1)
                    m.mxa.rebufferStartHandler()
                else if RBS_CC_5_reportLine("260", 2) and (field = "rebufferend")
                    RBS_CC_5_reportLine("260", 3)
                    RBS_CC_5_reportLine("261", 1)
                    m.mxa.rebufferEndHandler()
                else if RBS_CC_5_reportLine("262", 2) and (field = "playback_mode")
                    RBS_CC_5_reportLine("262", 3)
                    RBS_CC_5_reportLine("263", 1)
                    m.mxa.playbackModeHandler(msg.getData())
                else if RBS_CC_5_reportLine("264", 2) and (field = "request")
                    RBS_CC_5_reportLine("264", 3)
                    RBS_CC_5_reportLine("265", 1)
                    m.mxa.requestHandler(msg.getData())
                end if
            else if RBS_CC_5_reportLine("267", 2) and (msgType = "roDeviceInfoEvent")
                RBS_CC_5_reportLine("267", 3)
                RBS_CC_5_reportLine("268", 1)
                m.mxa.networkStatusEventHandler(msg)
            end if
        end if
        ' Check to see if we need to retry
        RBS_CC_5_reportLine("273", 1)
        m.mxa._retryBeacon()
    end while
    RBS_CC_5_reportLine("275", 1)
    m.beaconTimer.control = "stop"
    RBS_CC_5_reportLine("276", 1)
    m.heartbeatTimer.control = "stop"
    RBS_CC_5_reportLine("277", 1)
    m.mxa._Flag_heartbeatTimerRunning = false
    RBS_CC_5_reportLine("278", 1)
    m.pollTimer.control = "stop"
    RBS_CC_5_reportLine("280", 1)
    m.beaconTimer.UnobserveField("fire")
    RBS_CC_5_reportLine("281", 1)
    m.heartbeatTimer.UnobserveField("fire")
    RBS_CC_5_reportLine("282", 1)
    m.pollTimer.UnobserveField("fire")
    RBS_CC_5_reportLine("284", 1)
    m.top.UnobserveField("rafEvent")
    RBS_CC_5_reportLine("285", 1)
    m.top.UnobserveField("video")
    RBS_CC_5_reportLine("286", 1)
    m.top.UnobserveField("config")
    RBS_CC_5_reportLine("287", 1)
    m.top.UnobserveField("view")
    RBS_CC_5_reportLine("288", 1)
    m.top.UnobserveField("useRenderStitchedStream")
    RBS_CC_5_reportLine("289", 1)
    m.top.UnobserveField("useSSAI")
    RBS_CC_5_reportLine("290", 1)
    m.top.UnobserveField("disableAutomaticErrorTracking")
    RBS_CC_5_reportLine("291", 1)
    m.top.UnobserveField("error")
    RBS_CC_5_reportLine("292", 1)
    m.top.UnobserveField("cdn")
    RBS_CC_5_reportLine("293", 1)
    m.top.UnobserveField("disablePlayheadRebufferTracking")
    RBS_CC_5_reportLine("294", 1)
    m.top.UnobserveField("rebufferstart")
    RBS_CC_5_reportLine("295", 1)
    m.top.UnobserveField("rebufferend")
    RBS_CC_5_reportLine("296", 1)
    m.top.UnobserveField("playback_mode")
    RBS_CC_5_reportLine("297", 1)
    m.top.UnobserveField("request")
    if RBS_CC_5_reportLine("298", 2) and (m.top.video <> invalid)
        RBS_CC_5_reportLine("298", 3)
        RBS_CC_5_reportLine("299", 1)
        m.top.video.UnobserveField("position")
    end if
    if RBS_CC_5_reportLine("302", 2) and (m.top.exitType = "soft")
        RBS_CC_5_reportLine("302", 3)
        RBS_CC_5_reportLine("303", 1): while not m.mxa.isQueueEmpty()
            RBS_CC_5_reportLine("304", 1)
            m.mxa.LIGHT_THE_BEACONS()
        end while
    end if
    'video player doesn't reset the playlist field. Has to reset it default to prevent crash on next video play
    if RBS_CC_5_reportLine("309", 2) and (m.top.video <> invalid and m.top.video.contentIsPlaylist = true)
        RBS_CC_5_reportLine("309", 3)
        RBS_CC_5_reportLine("310", 1)
        m.top.video.content = invalid
        RBS_CC_5_reportLine("311", 1)
        m.top.video.contentIsPlaylist = false
    end if
    RBS_CC_5_reportLine("314", 1)
    m.top.exit = false
    RBS_CC_5_reportLine("316", 1)
    print "[mux-analytics] end running task loop"
    RBS_CC_5_reportLine("317", 1)
    return true
end function

function _createConnection(port as object) as object
    RBS_CC_5_reportLine("321", 1)
    connection = CreateObject("roUrlTransfer")
    RBS_CC_5_reportLine("322", 1)
    connection.SetPort(port)
    RBS_CC_5_reportLine("323", 1)
    connection.SetCertificatesFile("common:/certs/ca-bundle.crt")
    RBS_CC_5_reportLine("324", 1)
    connection.AddHeader("Content-Type", "application/json")
    RBS_CC_5_reportLine("325", 1)
    connection.AddHeader("Accept", "*/*")
    RBS_CC_5_reportLine("326", 1)
    connection.AddHeader("Expect", "")
    RBS_CC_5_reportLine("327", 1)
    connection.AddHeader("Connection", "keep-alive")
    RBS_CC_5_reportLine("328", 1)
    connection.AddHeader("Accept-Encoding", "gzip, deflate, br")
    RBS_CC_5_reportLine("329", 1)
    connection.EnableEncodings(true)
    RBS_CC_5_reportLine("330", 1)
    return connection
end function

function _createDeviceInfo() as object
    RBS_CC_5_reportLine("334", 1)
    return CreateObject("roDeviceInfo")
end function

function _createPort() as object
    RBS_CC_5_reportLine("338", 1)
    return CreateObject("roMessagePort")
end function

function _createByteArray() as object
    RBS_CC_5_reportLine("342", 1)
    return CreateObject("roByteArray")
end function

function _createAppInfo() as object
    RBS_CC_5_reportLine("346", 1)
    return CreateObject("roAppInfo")
end function

function _createRegistry() as object
    RBS_CC_5_reportLine("350", 1)
    return CreateObject("roRegistrySection", "mux")
end function

' Firmware Version Number
' Return 8.01, 9.01, etc if FW 9.1 or less
' Otherwise return 9.2, 9.3, 10.1, etc
function _firmwareVersionNumber(deviceInfo as object)
    if RBS_CC_5_reportLine("357", 2) and (FindMemberFunction(deviceInfo, "GetOSVersion") = invalid)
        RBS_CC_5_reportLine("357", 3)
        RBS_CC_5_reportLine("358", 1)
        version = deviceInfo.GetVersion().Mid(2, 4)
    else
        RBS_CC_5_reportLine("359", 3)
        RBS_CC_5_reportLine("360", 1)
        osVersion = deviceInfo.GetOSVersion()
        RBS_CC_5_reportLine("361", 1)
        version = osVersion["major"] + "." + osVersion["minor"]
    end if
    RBS_CC_5_reportLine("363", 1)
    return version
end function

function _getConnectionType(deviceInfo as object)
    RBS_CC_5_reportLine("367", 1)
    connectionType = deviceInfo.GetConnectionType()
    if RBS_CC_5_reportLine("368", 2) and (connectionType = "")
        RBS_CC_5_reportLine("368", 3)
        RBS_CC_5_reportLine("369", 1)
        return invalid
    end if
    if RBS_CC_5_reportLine("371", 2) and (connectionType = "WiFiConnection")
        RBS_CC_5_reportLine("371", 3)
        RBS_CC_5_reportLine("372", 1)
        return "wifi"
    end if
    if RBS_CC_5_reportLine("374", 2) and (connectionType = "WiredConnection")
        RBS_CC_5_reportLine("374", 3)
        RBS_CC_5_reportLine("375", 1)
        return "wired"
    end if
    RBS_CC_5_reportLine("378", 1)
    return "other"
end function

function muxAnalytics() as object
    RBS_CC_5_reportLine("382", 1)
    prototype = {}
    RBS_CC_5_reportLine("384", 1)
    prototype.MUX_SDK_VERSION = ""
    RBS_CC_5_reportLine("385", 1)
    prototype.MUX_SDK_NAME = "roku-mux"
    RBS_CC_5_reportLine("386", 1)
    prototype.PLAYER_SOFTWARE_NAME = "RokuSG"
    RBS_CC_5_reportLine("387", 1)
    prototype.MUX_API_VERSION = "2.1" ' 2.1 because of GUIDs for player instance IDs
    RBS_CC_5_reportLine("388", 1)
    prototype.PLAYER_IS_FULLSCREEN = "true"
    RBS_CC_5_reportLine("390", 1)
    prototype.init = sub(appInfo as object, systemConfig as object, customerConfig as object, hbt as object, pp as object, hp as object)
        RBS_CC_5_reportLine("391", 1)
        m.httpPort = hp
        RBS_CC_5_reportLine("392", 1)
        m.connection = _createConnection(m.httpPort)
        RBS_CC_5_reportLine("393", 1)
        m.httpRetries = 5
        RBS_CC_5_reportLine("394", 1)
        m.httpTimeout = 1500
        RBS_CC_5_reportLine("395", 1)
        m.heartbeatTimer = hbt
        RBS_CC_5_reportLine("396", 1)
        m.pollTimer = pp
        RBS_CC_5_reportLine("397", 1)
        m.loggingPrefix = "[mux-analytics] "
        RBS_CC_5_reportLine("398", 1)
        m.DEFAULT_DRY_RUN = false
        RBS_CC_5_reportLine("399", 1)
        m.DEFAULT_DEBUG_EVENTS = "none"
        RBS_CC_5_reportLine("400", 1)
        m.DEFAULT_DEBUG_BEACONS = "none" 'full','partial','none'
        RBS_CC_5_reportLine("401", 1)
        m.DEFAULT_BEACON_URL = "https://img.litix.io"
        RBS_CC_5_reportLine("403", 1)
        manifestDryRun = appInfo.GetValue("mux_dry_run")
        RBS_CC_5_reportLine("404", 1)
        m.manifestBaseUrl = appInfo.GetValue("mux_base_url")
        RBS_CC_5_reportLine("405", 1)
        manifestDebugEvents = appInfo.GetValue("mux_debug_events")
        RBS_CC_5_reportLine("406", 1)
        manifestDebugBeacons = appInfo.GetValue("mux_debug_beacons")
        RBS_CC_5_reportLine("408", 1)
        m.debugEvents = m.DEFAULT_DEBUG_EVENTS
        if RBS_CC_5_reportLine("409", 2) and (manifestDebugEvents <> "")
            RBS_CC_5_reportLine("409", 3)
            if RBS_CC_5_reportLine("410", 2) and (manifestDebugEvents = "full" or manifestDebugEvents = "partial" or manifestDebugEvents = "none")
                RBS_CC_5_reportLine("410", 3)
                RBS_CC_5_reportLine("411", 1)
                m.debugEvents = manifestDebugEvents
            end if
        end if
        RBS_CC_5_reportLine("415", 1)
        m.debugBeacons = m.DEFAULT_DEBUG_BEACONS
        if RBS_CC_5_reportLine("416", 2) and (manifestDebugBeacons <> "")
            RBS_CC_5_reportLine("416", 3)
            if RBS_CC_5_reportLine("417", 2) and (manifestDebugBeacons = "full" or manifestDebugBeacons = "partial" or manifestDebugBeacons = "none")
                RBS_CC_5_reportLine("417", 3)
                RBS_CC_5_reportLine("418", 1)
                m.debugBeacons = manifestDebugBeacons
            end if
        end if
        RBS_CC_5_reportLine("422", 1)
        m.dryRun = m.DEFAULT_DRY_RUN
        if RBS_CC_5_reportLine("423", 2) and (manifestDryRun <> "")
            RBS_CC_5_reportLine("423", 3)
            if RBS_CC_5_reportLine("424", 2) and (manifestDryRun = "true")
                RBS_CC_5_reportLine("424", 3)
                RBS_CC_5_reportLine("425", 1)
                m.dryRun = true
            else
                RBS_CC_5_reportLine("426", 3)
                RBS_CC_5_reportLine("427", 1)
                m.dryRun = false
            end if
        end if
        RBS_CC_5_reportLine("431", 1)
        m.beaconUrl = m.DEFAULT_BEACON_URL
        if RBS_CC_5_reportLine("433", 2) and (m.manifestBaseUrl <> "")
            RBS_CC_5_reportLine("433", 3)
            RBS_CC_5_reportLine("434", 1)
            m.beaconUrl = m.manifestBaseUrl
        end if
        RBS_CC_5_reportLine("437", 1)
        m.MAX_BEACON_SIZE = systemConfig.MAX_BEACON_SIZE
        RBS_CC_5_reportLine("438", 1)
        m.MAX_QUEUE_LENGTH = systemConfig.MAX_QUEUE_LENGTH
        RBS_CC_5_reportLine("439", 1)
        m.MAX_VIDEO_POSITION_JUMP = systemConfig.MAX_VIDEO_POSITION_JUMP
        RBS_CC_5_reportLine("440", 1)
        m.HTTP_RETRIES = systemConfig.HTTP_RETRIES
        RBS_CC_5_reportLine("441", 1)
        m.BASE_TIME_BETWEEN_BEACONS = systemConfig.BASE_TIME_BETWEEN_BEACONS
        RBS_CC_5_reportLine("442", 1)
        m.HEARTBEAT_INTERVAL = systemConfig.HEARTBEAT_INTERVAL
        RBS_CC_5_reportLine("443", 1)
        m.POSITION_TIMER_INTERVAL = systemConfig.POSITION_TIMER_INTERVAL
        RBS_CC_5_reportLine("444", 1)
        m.SEEK_THRESHOLD = systemConfig.SEEK_THRESHOLD
        RBS_CC_5_reportLine("445", 1)
        m.MAX_API_ENCRYPTION_REQUESTS_PER_VIEW = 5
        if RBS_CC_5_reportLine("447", 2) and (customerConfig <> invalid)
            RBS_CC_5_reportLine("447", 3)
            RBS_CC_5_reportLine("448", 1)
            m._configProperties = customerConfig
        else
            RBS_CC_5_reportLine("449", 3)
            RBS_CC_5_reportLine("450", 1)
            m._configProperties = {}
        end if
        RBS_CC_5_reportLine("453", 1)
        m._eventQueue = []
        RBS_CC_5_reportLine("454", 1)
        m._seekThreshold = m.SEEK_THRESHOLD / 1000
        ' variables
        RBS_CC_5_reportLine("457", 1)
        m._beaconCount = 0
        RBS_CC_5_reportLine("458", 1)
        m._inView = false
        RBS_CC_5_reportLine("459", 1)
        m._playerSequence = 0
        RBS_CC_5_reportLine("460", 1)
        m._startTimestamp = invalid
        RBS_CC_5_reportLine("461", 1)
        m._viewStartTimestamp = invalid
        RBS_CC_5_reportLine("462", 1)
        m._playerViewCount = invalid
        RBS_CC_5_reportLine("463", 1)
        m._viewSequence = invalid
        RBS_CC_5_reportLine("464", 1)
        m._viewId = invalid
        RBS_CC_5_reportLine("465", 1)
        m._playerPlayheadTime = invalid
        RBS_CC_5_reportLine("466", 1)
        m._viewTimeToFirstFrame = invalid
        RBS_CC_5_reportLine("467", 1)
        m._playerTimeToFirstFrame = invalid
        RBS_CC_5_reportLine("468", 1)
        m._contentPlaybackTime = invalid
        RBS_CC_5_reportLine("469", 1)
        m._viewWatchTime = invalid
        RBS_CC_5_reportLine("470", 1)
        m._viewRebufferCount = invalid
        RBS_CC_5_reportLine("471", 1)
        m._viewRebufferDuration = invalid
        RBS_CC_5_reportLine("472", 1)
        m._viewRebufferFrequency! = invalid
        RBS_CC_5_reportLine("473", 1)
        m._viewRebufferPercentage = invalid
        RBS_CC_5_reportLine("474", 1)
        m._viewSeekCount = invalid
        RBS_CC_5_reportLine("475", 1)
        m._viewSeekStartTimeStamp = invalid
        RBS_CC_5_reportLine("476", 1)
        m._viewSeekDuration = invalid
        RBS_CC_5_reportLine("477", 1)
        m._viewAdPlayedCount = invalid
        RBS_CC_5_reportLine("478", 1)
        m._viewPrerollPlayedCount = invalid
        RBS_CC_5_reportLine("479", 1)
        m._videoSourceFormat = invalid
        RBS_CC_5_reportLine("480", 1)
        m._audioSourceFormat = invalid
        RBS_CC_5_reportLine("481", 1)
        m._videoSourceDuration = invalid
        RBS_CC_5_reportLine("482", 1)
        m._videoCurrentCdn = invalid
        RBS_CC_5_reportLine("483", 1)
        m._viewPrerollPlayedCount = invalid
        RBS_CC_5_reportLine("484", 1)
        m._totalAdWatchTime = invalid
        RBS_CC_5_reportLine("485", 1)
        m._adWatchTime = invalid
        RBS_CC_5_reportLine("486", 1)
        m._cumulativePlayingTime = invalid
        RBS_CC_5_reportLine("487", 1)
        m._lastAdResumeTime = invalid
        ' Specifically means playhead when the video node sent a 'paused' state, not synthetic pause events we trigger
        RBS_CC_5_reportLine("489", 1)
        m._playheadAtLastPause = invalid
        RBS_CC_5_reportLine("491", 1)
        m._lastSourceWidth = invalid
        RBS_CC_5_reportLine("492", 1)
        m._lastSourceHeight = invalid
        RBS_CC_5_reportLine("493", 1)
        m._lastPlayheadPosition = invalid
        RBS_CC_5_reportLine("494", 1)
        m._lastVideoSegmentBitrate = invalid
        RBS_CC_5_reportLine("495", 1)
        m._viewMaxUpscalePercentage = invalid
        RBS_CC_5_reportLine("496", 1)
        m._viewMaxDownscalePercentage = invalid
        RBS_CC_5_reportLine("497", 1)
        m._viewTotalUpscaling = invalid
        RBS_CC_5_reportLine("498", 1)
        m._viewTotalDownscaling = invalid
        RBS_CC_5_reportLine("499", 1)
        m._viewTotalContentPlaybackTime = invalid
        RBS_CC_5_reportLine("500", 1)
        m._totalBytes = invalid
        RBS_CC_5_reportLine("501", 1)
        m._totalLoadTime = invalid
        RBS_CC_5_reportLine("502", 1)
        m._segmentRequestCount = invalid
        RBS_CC_5_reportLine("503", 1)
        m._segmentRequestFailedCount = invalid
        RBS_CC_5_reportLine("504", 1)
        m._viewMinRequestThroughput = invalid
        RBS_CC_5_reportLine("505", 1)
        m._viewAverageRequestThroughput = invalid
        RBS_CC_5_reportLine("506", 1)
        m._viewRequestCount = invalid
        RBS_CC_5_reportLine("507", 1)
        m._viewApiEncryptionRequestCount = invalid
        ' Latency tracking variables
        RBS_CC_5_reportLine("510", 1)
        m._totalLatency = invalid
        RBS_CC_5_reportLine("511", 1)
        m._requestCompletedCount = invalid
        RBS_CC_5_reportLine("512", 1)
        m._viewMaxRequestLatency = invalid
        RBS_CC_5_reportLine("513", 1)
        m._viewAverageRequestLatency = invalid
        ' Calculate player width and height
        RBS_CC_5_reportLine("516", 1)
        m.deviceInfo = m._getDeviceInfo()
        RBS_CC_5_reportLine("517", 1)
        videoMode = m.deviceInfo.GetVideoMode()
        RBS_CC_5_reportLine("518", 1)
        m._lastPlayerWidth = Val(m._getVideoPlaybackMetric(videoMode, "width"))
        RBS_CC_5_reportLine("519", 1)
        m._lastPlayerHeight = Val(m._getVideoPlaybackMetric(videoMode, "height"))
        ' flags
        RBS_CC_5_reportLine("522", 1)
        m._Flag_lastVideoState = "none"
        RBS_CC_5_reportLine("523", 1)
        m._Flag_isPaused = false
        RBS_CC_5_reportLine("524", 1)
        m._Flag_atLeastOnePlayEventForContent = false
        RBS_CC_5_reportLine("525", 1)
        m._Flag_RebufferingStarted = false
        RBS_CC_5_reportLine("526", 1)
        m._Flag_isSeeking = false
        RBS_CC_5_reportLine("527", 1)
        m._Flag_lastReportedPosition = 0
        RBS_CC_5_reportLine("528", 1)
        m._Flag_FailedAdsErrorSet = false
        RBS_CC_5_reportLine("529", 1)
        m._Flag_useSSAI = false
        RBS_CC_5_reportLine("530", 1)
        m._Flag_automaticErrorTracking = true
        RBS_CC_5_reportLine("531", 1)
        m._Flag_automaticRebufferTracking = true
        ' Flags specifically for when renderStitchedStream is used
        RBS_CC_5_reportLine("534", 1)
        m._Flag_useRenderStitchedStream = false
        RBS_CC_5_reportLine("535", 1)
        m._Flag_rssInAdBreak = false
        RBS_CC_5_reportLine("536", 1)
        m._Flag_rssAdEnded = false
        RBS_CC_5_reportLine("537", 1)
        m._Flag_rssContentPlayingAfterAds = false
        ' Flag for a beacon currently being retried
        RBS_CC_5_reportLine("540", 1)
        m._Flag_beaconRequestInProgress = false
        ' Flag for whether or not to use a random mux viewer ID
        RBS_CC_5_reportLine("543", 1)
        m._Flag_useRandomMuxViewerId = systemConfig.USE_RANDOM_MUX_VIEWER_ID
        ' Flag to track heartbeat timer state to avoid rendezvous
        RBS_CC_5_reportLine("546", 1)
        m._Flag_heartbeatTimerRunning = false
        ' Network monitoring
        RBS_CC_5_reportLine("549", 1)
        m._lastConnectionType = invalid
        RBS_CC_5_reportLine("550", 1)
        m._networkEventsSupported = false
        ' kick off analytics
        RBS_CC_5_reportLine("553", 1)
        date = m._getDateTime()
        RBS_CC_5_reportLine("554", 1)
        m._startTimestamp = 0# + date.AsSeconds() * 1000.0# + date.GetMilliseconds()
        RBS_CC_5_reportLine("555", 1)
        m._playerViewCount = 0
        RBS_CC_5_reportLine("556", 1)
        m._sessionProperties = m._getSessionProperties()
        RBS_CC_5_reportLine("557", 1)
        m._addEventToQueue(m._createEvent("playerready"))
    end sub
    RBS_CC_5_reportLine("560", 1)
    prototype.beaconIntervalHandler = sub(beaconIntervalEvent)
        RBS_CC_5_reportLine("561", 1)
        data = beaconIntervalEvent.getData()
        RBS_CC_5_reportLine("562", 1)
        m.LIGHT_THE_BEACONS()
        ' If network events are not supported, poll network status
        if RBS_CC_5_reportLine("565", 2) and (m._networkEventsSupported = false)
            RBS_CC_5_reportLine("565", 3)
            RBS_CC_5_reportLine("566", 1)
            m.networkStatusEventHandler(invalid)
        end if
    end sub
    ' Handler for roDeviceInfoEvent network status changes (or polling)
    ' event can be Invalid when called from polling
    RBS_CC_5_reportLine("572", 1)
    prototype.networkStatusEventHandler = sub(event as dynamic)
        RBS_CC_5_reportLine("573", 1)
        currentConnectionType = _getConnectionType(m.deviceInfo)
        ' Check if connection type has changed
        if RBS_CC_5_reportLine("575", 2) and (currentConnectionType <> m._lastConnectionType)
            RBS_CC_5_reportLine("575", 3)
            RBS_CC_5_reportLine("576", 1)
            m._fireNetworkChangeEvent(currentConnectionType)
            RBS_CC_5_reportLine("577", 1)
            m._lastConnectionType = currentConnectionType
            ' Update session properties with new connection type
            if RBS_CC_5_reportLine("579", 2) and (m._sessionProperties <> invalid)
                RBS_CC_5_reportLine("579", 3)
                RBS_CC_5_reportLine("580", 1)
                m._sessionProperties.viewer_connection_type = currentConnectionType
            end if
        end if
    end sub
    RBS_CC_5_reportLine("585", 1)
    prototype._fireNetworkChangeEvent = sub(connectionType as dynamic)
        RBS_CC_5_reportLine("586", 1)
        props = {}
        if RBS_CC_5_reportLine("587", 2) and (connectionType = invalid)
            RBS_CC_5_reportLine("587", 3)
            RBS_CC_5_reportLine("588", 1)
            props.viewer_connection_type = invalid
        else
            RBS_CC_5_reportLine("589", 3)
            RBS_CC_5_reportLine("590", 1)
            props.viewer_connection_type = connectionType
        end if
        RBS_CC_5_reportLine("592", 1)
        m._addEventToQueue(m._createEvent("networkchange", props))
    end sub
    RBS_CC_5_reportLine("595", 1)
    prototype.heartbeatIntervalHandler = sub(heartbeatIntervalEvent)
        RBS_CC_5_reportLine("596", 1)
        data = heartbeatIntervalEvent.getData()
        if RBS_CC_5_reportLine("597", 2) and (m._Flag_isPaused <> true)
            RBS_CC_5_reportLine("597", 3)
            RBS_CC_5_reportLine("598", 1)
            m._addEventToQueue(m._createEvent("hb"))
        end if
    end sub
    RBS_CC_5_reportLine("602", 1)
    prototype.videoAddedHandler = sub(video as object)
        RBS_CC_5_reportLine("603", 1)
        m._videoProperties = m._getVideoProperties(video)
        if RBS_CC_5_reportLine("604", 2) and (video.contentIsPlaylist = true)
            RBS_CC_5_reportLine("604", 3)
            RBS_CC_5_reportLine("605", 1)
            m._videoContentProperties = m._getVideoContentProperties(video.content.getChild(video.contentIndex))
        else
            RBS_CC_5_reportLine("606", 3)
            RBS_CC_5_reportLine("607", 1)
            m._videoContentProperties = m._getVideoContentProperties(video.content)
        end if
        RBS_CC_5_reportLine("609", 1)
        m.video = video
        ' Initialize player playhead time
        if RBS_CC_5_reportLine("612", 2) and (video <> invalid and video.position <> invalid)
            RBS_CC_5_reportLine("612", 3)
            RBS_CC_5_reportLine("613", 1)
            m._playerPlayheadTime = video.position
        else
            RBS_CC_5_reportLine("614", 3)
            RBS_CC_5_reportLine("615", 1)
            m._playerPlayheadTime = 0
        end if
        if RBS_CC_5_reportLine("618", 2) and (video <> invalid)
            RBS_CC_5_reportLine("618", 3)
            RBS_CC_5_reportLine("619", 1)
            maximumPossiblePositionChange = ((video.notificationInterval * 1000) + m.POSITION_TIMER_INTERVAL) / 1000
            if RBS_CC_5_reportLine("620", 2) and (m._seekThreshold < maximumPossiblePositionChange)
                RBS_CC_5_reportLine("620", 3)
                RBS_CC_5_reportLine("621", 1)
                m._seekThreshold = maximumPossiblePositionChange
            end if
        end if
    end sub
    RBS_CC_5_reportLine("626", 1)
    prototype.videoPositionChangeHandler = sub(position as double)
        if RBS_CC_5_reportLine("627", 2) and (position < m.MAX_VIDEO_POSITION_JUMP)
            RBS_CC_5_reportLine("627", 3)
            RBS_CC_5_reportLine("628", 1)
            m._playerPlayheadTime = position
        end if
    end sub
    RBS_CC_5_reportLine("632", 1)
    prototype.videoStateChangeHandler = sub(videoState as string)
        RBS_CC_5_reportLine("633", 1)
        m.video_state = videoState
        RBS_CC_5_reportLine("634", 1)
        previouslyLastReportedPosition = m._Flag_lastReportedPosition
        ' Position is now handled by videoPositionChangeHandler to avoid rendezvous
        ' if m.video.position < m.MAX_VIDEO_POSITION_JUMP
        '   m._playerPlayheadTime = m.video.position
        ' end if
        if RBS_CC_5_reportLine("639", 2) and (m._playerPlayheadTime <> invalid)
            RBS_CC_5_reportLine("639", 3)
            RBS_CC_5_reportLine("640", 1)
            m._Flag_lastReportedPosition = m._playerPlayheadTime
        else if RBS_CC_5_reportLine("641", 2) and (m._Flag_lastReportedPosition = invalid)
            RBS_CC_5_reportLine("641", 3)
            RBS_CC_5_reportLine("642", 1)
            m._Flag_lastReportedPosition = 0
        end if
        ' Need to actually infer seek all the way out here
        if RBS_CC_5_reportLine("646", 2) and (m._Flag_isSeeking <> true)
            RBS_CC_5_reportLine("646", 3)
            ' If we've gone backwards at all or forwards by more than the threshold
            if RBS_CC_5_reportLine("648", 2) and (m._playerPlayheadTime <> invalid and previouslyLastReportedPosition <> invalid and ((m._playerPlayheadTime < previouslyLastReportedPosition) or (m._playerPlayheadTime > (previouslyLastReportedPosition + m._seekThreshold))))
                RBS_CC_5_reportLine("648", 3)
                if RBS_CC_5_reportLine("649", 2) and (videoState = "buffering")
                    RBS_CC_5_reportLine("649", 3)
                    RBS_CC_5_reportLine("650", 1)
                    m._addEventToQueue(m._createEvent("pause"))
                end if
                if RBS_CC_5_reportLine("653", 2) and (m._playheadAtLastPause <> invalid)
                    RBS_CC_5_reportLine("653", 3)
                    RBS_CC_5_reportLine("654", 1)
                    m._endPlaybackRange(m._playheadAtLastPause)
                end if
                RBS_CC_5_reportLine("657", 1)
                m._addEventToQueue(m._createEvent("seeking"))
                RBS_CC_5_reportLine("658", 1)
                date = m._getDateTime()
                RBS_CC_5_reportLine("659", 1)
                m._viewSeekStartTimeStamp = 0# + date.AsSeconds() * 1000.0# + date.GetMilliseconds()
                if RBS_CC_5_reportLine("660", 2) and (m._viewSeekCount <> invalid)
                    RBS_CC_5_reportLine("660", 3)
                    RBS_CC_5_reportLine("661", 1)
                    m._viewSeekCount++
                end if
                RBS_CC_5_reportLine("663", 1)
                m._Flag_isSeeking = true
            end if
        end if
        RBS_CC_5_reportLine("667", 1)
        m._Flag_isPaused = (videoState = "paused")
        if RBS_CC_5_reportLine("669", 2) and (videoState = "buffering")
            RBS_CC_5_reportLine("669", 3)
            ' Bail out if we aren't supposed to track automatic rebuffer events
            if RBS_CC_5_reportLine("671", 2) and (not m._Flag_automaticRebufferTracking) then
                RBS_CC_5_reportLine("671", 3)
                RBS_CC_5_reportLine("671", 1)
                return
            end if
            if RBS_CC_5_reportLine("673", 2) and (m._Flag_atLeastOnePlayEventForContent = true)
                RBS_CC_5_reportLine("673", 3)
                RBS_CC_5_reportLine("674", 1)
                m._addEventToQueue(m._createEvent("rebufferstart"))
                RBS_CC_5_reportLine("675", 1)
                m._Flag_RebufferingStarted = true
                if RBS_CC_5_reportLine("676", 2) and (m._viewRebufferCount <> invalid)
                    RBS_CC_5_reportLine("676", 3)
                    RBS_CC_5_reportLine("677", 1)
                    m._viewRebufferCount++
                    if RBS_CC_5_reportLine("678", 2) and (m._viewWatchTime <> invalid and m._viewWatchTime > 0)
                        RBS_CC_5_reportLine("678", 3)
                        RBS_CC_5_reportLine("679", 1)
                        m._viewRebufferFrequency! = m._viewRebufferCount / m._viewWatchTime
                    end if
                end if
            end if
        else if RBS_CC_5_reportLine("683", 2) and (videoState = "paused")
            RBS_CC_5_reportLine("683", 3)
            RBS_CC_5_reportLine("684", 1)
            m._playheadAtLastPause = m._playerPlayheadTime
            RBS_CC_5_reportLine("686", 1)
            m._addEventToQueue(m._createEvent("pause"))
        else if RBS_CC_5_reportLine("687", 2) and (videoState = "playing")
            RBS_CC_5_reportLine("687", 3)
            RBS_CC_5_reportLine("688", 1)
            m._videoProperties = m._getVideoProperties(m.video)
            if RBS_CC_5_reportLine("690", 2) and (m._Flag_lastVideoState = "buffering" and m._Flag_automaticRebufferTracking)
                RBS_CC_5_reportLine("690", 3)
                if RBS_CC_5_reportLine("691", 2) and (m._Flag_RebufferingStarted = true)
                    RBS_CC_5_reportLine("691", 3)
                    RBS_CC_5_reportLine("693", 1)
                    m._addEventToQueue(m._createEvent("rebufferend"))
                    RBS_CC_5_reportLine("694", 1)
                    m._Flag_RebufferingStarted = false
                end if
            end if
            if RBS_CC_5_reportLine("698", 2) and (m._Flag_isSeeking = true)
                RBS_CC_5_reportLine("698", 3)
                RBS_CC_5_reportLine("699", 1)
                date = m._getDateTime()
                RBS_CC_5_reportLine("700", 1)
                now = 0# + date.AsSeconds() * 1000.0# + date.GetMilliseconds()
                RBS_CC_5_reportLine("701", 1)
                seekStartTs = 0#
                if RBS_CC_5_reportLine("702", 2) and (m._viewSeekStartTimeStamp <> invalid)
                    RBS_CC_5_reportLine("702", 3)
                    RBS_CC_5_reportLine("703", 1)
                    seekStartTs = m._viewSeekStartTimeStamp
                end if
                if RBS_CC_5_reportLine("705", 2) and (m._viewSeekDuration <> invalid)
                    RBS_CC_5_reportLine("705", 3)
                    RBS_CC_5_reportLine("706", 1)
                    m._viewSeekDuration = m._viewSeekDuration + (now - seekStartTs)
                end if
                RBS_CC_5_reportLine("709", 1)
                m._addEventToQueue(m._createEvent("seeked"))
                RBS_CC_5_reportLine("710", 1)
                m._Flag_isSeeking = false
                ' We will emit the play from paused states further down if needed
                if RBS_CC_5_reportLine("713", 2) and (m._Flag_lastVideoState <> "paused")
                    RBS_CC_5_reportLine("713", 3)
                    RBS_CC_5_reportLine("714", 1)
                    m._addEventToQueue(m._createEvent("play"))
                end if
            end if
            if RBS_CC_5_reportLine("718", 2) and (m._Flag_atLeastOnePlayEventForContent = false)
                RBS_CC_5_reportLine("718", 3)
                if RBS_CC_5_reportLine("719", 2) and (m._viewTimeToFirstFrame = invalid)
                    RBS_CC_5_reportLine("719", 3)
                    if RBS_CC_5_reportLine("720", 2) and (m._viewStartTimestamp <> invalid and m._viewStartTimestamp <> 0)
                        RBS_CC_5_reportLine("720", 3)
                        RBS_CC_5_reportLine("721", 1)
                        date = m._getDateTime()
                        RBS_CC_5_reportLine("722", 1)
                        now = 0# + date.AsSeconds() * 1000.0# + date.GetMilliseconds()
                        RBS_CC_5_reportLine("723", 1)
                        m._viewTimeToFirstFrame = now - m._viewStartTimestamp
                    end if
                end if
            end if
            if RBS_CC_5_reportLine("727", 2) and (m._Flag_lastVideoState = "paused")
                RBS_CC_5_reportLine("727", 3)
                RBS_CC_5_reportLine("728", 1)
                m._addEventToQueue(m._createEvent("play"))
            end if
            ' if we haven't gotten any playhead updates yet, don't try to start a range
            if RBS_CC_5_reportLine("732", 2) and (m._playerPlayheadTime <> invalid)
                RBS_CC_5_reportLine("732", 3)
                RBS_CC_5_reportLine("733", 1)
                m._startPlaybackRange(m._playerPlayheadTime)
            end if
            RBS_CC_5_reportLine("736", 1)
            m._addEventToQueue(m._createEvent("playing"))
            RBS_CC_5_reportLine("738", 1)
            m._Flag_isSeeking = false
            RBS_CC_5_reportLine("739", 1)
            m._Flag_atLeastOnePlayEventForContent = true
        else if RBS_CC_5_reportLine("740", 2) and (videoState = "stopped")
            RBS_CC_5_reportLine("740", 3)
        else if RBS_CC_5_reportLine("741", 2) and (videoState = "finished")
            RBS_CC_5_reportLine("741", 3)
            ' Only send ended event if it played to completion
            RBS_CC_5_reportLine("743", 1)
            completedStreamInfo = m.video.completedStreamInfo
            if RBS_CC_5_reportLine("744", 2) and (completedStreamInfo <> invalid)
                RBS_CC_5_reportLine("744", 3)
                if RBS_CC_5_reportLine("745", 2) and (completedStreamInfo.isFullResult)
                    RBS_CC_5_reportLine("745", 3)
                    RBS_CC_5_reportLine("747", 1)
                    m._endPlaybackRange(m._playerPlayheadTime)
                    RBS_CC_5_reportLine("748", 1)
                    m._addEventToQueue(m._createEvent("ended"))
                end if
            end if
        else if RBS_CC_5_reportLine("751", 2) and (videoState = "error")
            RBS_CC_5_reportLine("751", 3)
            ' Bail out if we aren't supposed to track automatic errors
            if RBS_CC_5_reportLine("753", 2) and (not m._Flag_automaticErrorTracking) then
                RBS_CC_5_reportLine("753", 3)
                RBS_CC_5_reportLine("753", 1)
                return
            end if
            RBS_CC_5_reportLine("755", 1)
            errorCode = ""
            RBS_CC_5_reportLine("756", 1)
            errorMessage = ""
            RBS_CC_5_reportLine("757", 1)
            errorContext = ""
            if RBS_CC_5_reportLine("758", 2) and (m.video <> invalid)
                RBS_CC_5_reportLine("758", 3)
                if RBS_CC_5_reportLine("759", 2) and (m.video.errorCode <> invalid)
                    RBS_CC_5_reportLine("759", 3)
                    RBS_CC_5_reportLine("760", 1)
                    errorCode = m.video.errorCode
                end if
                if RBS_CC_5_reportLine("762", 2) and (m.video.errorMsg <> invalid)
                    RBS_CC_5_reportLine("762", 3)
                    RBS_CC_5_reportLine("763", 1)
                    errorMessage = m.video.errorMsg
                end if
                if RBS_CC_5_reportLine("765", 2) and (m.video.errorStr <> invalid)
                    RBS_CC_5_reportLine("765", 3)
                    RBS_CC_5_reportLine("766", 1)
                    errorContext = m.video.errorStr
                end if
            end if
            RBS_CC_5_reportLine("769", 1)
            m._addEventToQueue(m._createEvent("error", {
                player_error_code: errorCode
                player_error_message: errorMessage
                player_error_context: errorContext
            }))
        end if
        RBS_CC_5_reportLine("771", 1)
        m._Flag_lastVideoState = videoState
    end sub
    RBS_CC_5_reportLine("774", 1)
    prototype.drmLicenseStatusChangeHandler = sub(licenseStatus as object)
        if RBS_CC_5_reportLine("775", 2) and (licenseStatus <> invalid)
            RBS_CC_5_reportLine("775", 3)
            if RBS_CC_5_reportLine("776", 2) and (licenseStatus.keysystem <> invalid)
                RBS_CC_5_reportLine("776", 3)
                RBS_CC_5_reportLine("777", 1)
                m.drmType = licenseStatus.keysystem
            end if
        end if
    end sub
    RBS_CC_5_reportLine("782", 1)
    prototype.videoViewChangeHandler = sub(view as string)
        if RBS_CC_5_reportLine("783", 2) and (view = "end")
            RBS_CC_5_reportLine("783", 3)
            RBS_CC_5_reportLine("784", 1)
            m._endView(true)
        else if RBS_CC_5_reportLine("785", 2) and (view = "start")
            RBS_CC_5_reportLine("785", 3)
            RBS_CC_5_reportLine("786", 1)
            m._startView(true)
        end if
    end sub
    RBS_CC_5_reportLine("790", 1)
    prototype.cdnChangeHandler = sub(cdn as string)
        RBS_CC_5_reportLine("791", 1)
        previousCdn = ""
        if RBS_CC_5_reportLine("792", 2) and (m._videoCurrentCdn <> invalid)
            RBS_CC_5_reportLine("792", 3)
            RBS_CC_5_reportLine("793", 1)
            previousCdn = m._videoCurrentCdn
        end if
        if RBS_CC_5_reportLine("796", 2) and (cdn <> invalid and cdn <> previousCdn)
            RBS_CC_5_reportLine("796", 3)
            RBS_CC_5_reportLine("797", 1)
            m._addEventToQueue(m._createEvent("cdnchange", {
                video_cdn: cdn
                video_previous_cdn: previousCdn
            }))
            RBS_CC_5_reportLine("798", 1)
            m._videoCurrentCdn = cdn
        end if
    end sub
    RBS_CC_5_reportLine("802", 1)
    prototype._triggerPlayEvent = sub()
        if RBS_CC_5_reportLine("803", 2) and (m.video <> invalid)
            RBS_CC_5_reportLine("803", 3)
            if RBS_CC_5_reportLine("804", 2) and (m.video.content <> invalid)
                RBS_CC_5_reportLine("804", 3)
                if RBS_CC_5_reportLine("805", 2) and (m.video.contentIsPlaylist)
                    RBS_CC_5_reportLine("805", 3)
                    RBS_CC_5_reportLine("806", 1)
                    m._videoContentProperties = m._getVideoContentProperties(m.video.content.getChild(m.video.contentIndex))
                else
                    RBS_CC_5_reportLine("807", 3)
                    RBS_CC_5_reportLine("808", 1)
                    m._videoContentProperties = m._getVideoContentProperties(m.video.content)
                end if
            end if
            RBS_CC_5_reportLine("811", 1)
            m._videoProperties = m._getVideoProperties(m.video)
        end if
        RBS_CC_5_reportLine("813", 1)
        m._addEventToQueue(m._createEvent("play"))
    end sub
    RBS_CC_5_reportLine("816", 1)
    prototype.videoControlChangeHandler = sub(control as string)
        if RBS_CC_5_reportLine("817", 2) and (control = "play")
            RBS_CC_5_reportLine("817", 3)
            RBS_CC_5_reportLine("818", 1)
            m._startView()
            RBS_CC_5_reportLine("819", 1)
            m._triggerPlayEvent()
        else if RBS_CC_5_reportLine("820", 2) and (control = "stop")
            RBS_CC_5_reportLine("820", 3)
            RBS_CC_5_reportLine("821", 1)
            m._endView()
        end if
    end sub
    RBS_CC_5_reportLine("825", 1)
    prototype.videoContentChangeHandler = sub(videoContent as object)
        if RBS_CC_5_reportLine("826", 2) and (m._clientOperatedStartAndEnd <> true)
            RBS_CC_5_reportLine("826", 3)
            RBS_CC_5_reportLine("827", 1)
            m._endView()
            RBS_CC_5_reportLine("828", 1)
            m._startView()
        end if
    end sub
    RBS_CC_5_reportLine("832", 1)
    prototype.videoContentIndexChangeHandler = sub(contentIndex as integer)
        if RBS_CC_5_reportLine("833", 2) and (contentIndex > 0)
            RBS_CC_5_reportLine("833", 3)
            RBS_CC_5_reportLine("834", 1)
            m._addEventToQueue(m._createEvent("ended"))
            RBS_CC_5_reportLine("835", 1)
            m._endView(true)
            RBS_CC_5_reportLine("836", 1)
            m._startView(true)
            RBS_CC_5_reportLine("837", 1)
            m._triggerPlayEvent()
            if RBS_CC_5_reportLine("838", 2) and (m._Flag_atLeastOnePlayEventForContent = false)
                RBS_CC_5_reportLine("838", 3)
                if RBS_CC_5_reportLine("839", 2) and (m._viewTimeToFirstFrame = invalid)
                    RBS_CC_5_reportLine("839", 3)
                    if RBS_CC_5_reportLine("840", 2) and (m._viewStartTimestamp <> invalid and m._viewStartTimestamp <> 0)
                        RBS_CC_5_reportLine("840", 3)
                        RBS_CC_5_reportLine("841", 1)
                        date = m._getDateTime()
                        RBS_CC_5_reportLine("842", 1)
                        now = 0# + date.AsSeconds() * 1000.0# + date.GetMilliseconds()
                        RBS_CC_5_reportLine("843", 1)
                        m._viewTimeToFirstFrame = now - m._viewStartTimestamp
                    end if
                end if
            end if
            RBS_CC_5_reportLine("848", 1)
            m._startPlaybackRange(m._playerPlayheadTime)
            RBS_CC_5_reportLine("849", 1)
            m._addEventToQueue(m._createEvent("playing"))
        end if
    end sub
    RBS_CC_5_reportLine("853", 1)
    prototype.videoStreamingSegmentChangeHandler = sub(videoSegment as object)
        if RBS_CC_5_reportLine("854", 2) and (videoSegment <> invalid)
            RBS_CC_5_reportLine("854", 3)
            ' For now, we only listen for video or media segments for all of our calculations
            if RBS_CC_5_reportLine("856", 2) and (videoSegment.segType = 0 or videoSegment.segType = 2)
                RBS_CC_5_reportLine("856", 3)
                if RBS_CC_5_reportLine("857", 2) and (m._lastPlayerWidth <> invalid and m._lastPlayerHeight <> invalid and m._lastPlayheadPosition <> invalid and m._lastSourceWidth <> invalid and m._lastSourceHeight <> invalid and videoSegment.segStartTime <> invalid)
                    RBS_CC_5_reportLine("857", 3)
                    RBS_CC_5_reportLine("858", 1)
                    player_playhead_time = Int(videoSegment.segStartTime * 1000)
                    if RBS_CC_5_reportLine("859", 2) and (m._lastPlayerWidth >= 0 and m._lastPlayerHeight >= 0 and m._lastPlayheadPosition >= 0 and player_playhead_time >= 0 and m._lastSourceWidth > 0 and m._lastSourceHeight > 0)
                        RBS_CC_5_reportLine("859", 3)
                        RBS_CC_5_reportLine("860", 1)
                        timeDiff = player_playhead_time - m._lastPlayheadPosition
                        RBS_CC_5_reportLine("861", 1)
                        scale = m._min(m._lastPlayerWidth / m._lastSourceWidth, m._lastPlayerHeight / m._lastSourceHeight)
                        RBS_CC_5_reportLine("862", 1)
                        upscale = m._max(0, scale - 1)
                        RBS_CC_5_reportLine("863", 1)
                        downscale = m._max(0, 1 - scale)
                        RBS_CC_5_reportLine("864", 1)
                        m._viewMaxUpscalePercentage = m._max(m._viewMaxUpscalePercentage, upscale)
                        RBS_CC_5_reportLine("865", 1)
                        m._viewMaxDownscalePercentage = m._max(m._viewMaxDownscalePercentage, downscale)
                        RBS_CC_5_reportLine("866", 1)
                        m._viewTotalContentPlaybackTime = m._safeAdd(m._viewTotalContentPlaybackTime, timeDiff)
                        RBS_CC_5_reportLine("867", 1)
                        m._viewTotalUpscaling = m._safeAdd(m._viewTotalUpscaling, upscale * timeDiff)
                        RBS_CC_5_reportLine("868", 1)
                        m._viewTotalDownscaling = m._safeAdd(m._viewTotalDownscaling, downscale * timeDiff)
                    end if
                end if
                if RBS_CC_5_reportLine("871", 2) and (videoSegment.width <> invalid and videoSegment.height <> invalid and videoSegment.segBitrateBps <> invalid)
                    RBS_CC_5_reportLine("871", 3)
                    if RBS_CC_5_reportLine("872", 2) and (m._lastSourceWidth <> invalid and m._lastSourceWidth <> videoSegment.width or m._lastSourceHeight <> invalid and m._lastSourceHeight <> videoSegment.height or m._lastVideoSegmentBitrate <> invalid and m._lastVideoSegmentBitrate <> videoSegment.segBitrateBps)
                        RBS_CC_5_reportLine("872", 3)
                        RBS_CC_5_reportLine("873", 1)
                        details = {
                            video_source_width: videoSegment.width
                            video_source_height: videoSegment.height
                            video_source_bitrate: videoSegment.segBitrateBps
                            video_codec: m._videoSourceFormat
                            video_source_codec: m._videoSourceFormat
                            video_audio_codec: m._audioSourceFormat
                        }
                        RBS_CC_5_reportLine("874", 1)
                        m._addEventToQueue(m._createEvent("renditionchange", details))
                    end if
                end if
                RBS_CC_5_reportLine("877", 1)
                m._lastSourceWidth = videoSegment.width
                RBS_CC_5_reportLine("878", 1)
                m._lastSourceHeight = videoSegment.height
                RBS_CC_5_reportLine("879", 1)
                m._lastVideoSegmentBitrate = videoSegment.segBitrateBps
                RBS_CC_5_reportLine("880", 1)
                m._lastPlayheadPosition = Int(videoSegment.segStartTime * 1000)
            end if
        end if
    end sub
    RBS_CC_5_reportLine("885", 1)
    prototype.videoDownloadedSegmentChangeHandler = sub(videoSegment as object)
        if RBS_CC_5_reportLine("886", 2) and (m._segmentRequestCount = invalid) then
            RBS_CC_5_reportLine("886", 3)
            RBS_CC_5_reportLine("886", 1)
            m._segmentRequestCount = 0
        end if
        RBS_CC_5_reportLine("887", 1)
        m._segmentRequestCount++
        if RBS_CC_5_reportLine("888", 2) and (videoSegment <> invalid)
            RBS_CC_5_reportLine("888", 3)
            ' Validate that request belongs to current view by comparing timestamps
            ' If request_start < view_start, the request was initiated before the current view started
            ' This means it's a stale request from a previous video during view transitions
            if RBS_CC_5_reportLine("892", 2) and (m._viewStartTimestamp <> invalid and videoSegment.downloadDuration <> invalid)
                RBS_CC_5_reportLine("892", 3)
                RBS_CC_5_reportLine("893", 1)
                date = m._getDateTime()
                RBS_CC_5_reportLine("894", 1)
                now = 0# + date.AsSeconds() * 1000.0# + date.GetMilliseconds()
                RBS_CC_5_reportLine("895", 1)
                requestStartTime = now - videoSegment.downloadDuration
                if RBS_CC_5_reportLine("896", 2) and (requestStartTime < m._viewStartTimestamp)
                    RBS_CC_5_reportLine("896", 3)
                    ' Request started before current view - it's from a previous video
                    RBS_CC_5_reportLine("898", 1)
                    print "[mux-analytics] DISCARDING stale request from previous view"
                    RBS_CC_5_reportLine("899", 1)
                    print "  request_start: " + Str(requestStartTime)
                    RBS_CC_5_reportLine("900", 1)
                    print "  view_start: " + Str(m._viewStartTimestamp)
                    RBS_CC_5_reportLine("901", 1)
                    print "  difference_ms: " + Str(m._viewStartTimestamp - requestStartTime)
                    RBS_CC_5_reportLine("902", 1)
                    return
                end if
            end if
            RBS_CC_5_reportLine("906", 1)
            props = {}
            if RBS_CC_5_reportLine("907", 2) and (videoSegment.segType <> invalid)
                RBS_CC_5_reportLine("907", 3)
                if RBS_CC_5_reportLine("908", 2) and (videoSegment.segType = 0)
                    RBS_CC_5_reportLine("908", 3)
                    RBS_CC_5_reportLine("909", 1)
                    props.request_type = "media"
                else if RBS_CC_5_reportLine("910", 2) and (videoSegment.segType = 1)
                    RBS_CC_5_reportLine("910", 3)
                    RBS_CC_5_reportLine("911", 1)
                    props.request_type = "audio"
                else if RBS_CC_5_reportLine("912", 2) and (videoSegment.segType = 2)
                    RBS_CC_5_reportLine("912", 3)
                    RBS_CC_5_reportLine("913", 1)
                    props.request_type = "video"
                else if RBS_CC_5_reportLine("914", 2) and (videoSegment.segType = 3)
                    RBS_CC_5_reportLine("914", 3)
                    RBS_CC_5_reportLine("915", 1)
                    props.request_type = "captions"
                end if
            end if
            if RBS_CC_5_reportLine("918", 2) and (videoSegment.segDuration <> invalid)
                RBS_CC_5_reportLine("918", 3)
                RBS_CC_5_reportLine("919", 1)
                props.request_media_duration = videoSegment.segDuration
            end if
            if RBS_CC_5_reportLine("921", 2) and (videoSegment.downloadDuration <> invalid)
                RBS_CC_5_reportLine("921", 3)
                RBS_CC_5_reportLine("922", 1)
                date = m._getDateTime()
                RBS_CC_5_reportLine("923", 1)
                now = 0# + date.AsSeconds() * 1000.0# + date.GetMilliseconds()
                RBS_CC_5_reportLine("924", 1)
                props.request_response_end = FormatJson(now)
                RBS_CC_5_reportLine("925", 1)
                resultMilliseconds = now - videoSegment.downloadDuration
                RBS_CC_5_reportLine("926", 1)
                props.request_start = FormatJson(resultMilliseconds)
            end if
            if RBS_CC_5_reportLine("928", 2) and (videoSegment.segUrl <> invalid)
                RBS_CC_5_reportLine("928", 3)
                RBS_CC_5_reportLine("929", 1)
                props.request_hostname = m._getHostname(videoSegment.segUrl)
                RBS_CC_5_reportLine("930", 1)
                props.request_url = videoSegment.segUrl
            end if
            if RBS_CC_5_reportLine("932", 2) and (videoSegment.status <> invalid)
                RBS_CC_5_reportLine("932", 3)
                if RBS_CC_5_reportLine("933", 2) and (videoSegment.status = 0)
                    RBS_CC_5_reportLine("933", 3)
                    if RBS_CC_5_reportLine("934", 2) and (videoSegment.segSize <> invalid)
                        RBS_CC_5_reportLine("934", 3)
                        RBS_CC_5_reportLine("935", 1)
                        props.request_bytes_loaded = videoSegment.segSize
                    end if
                    if RBS_CC_5_reportLine("937", 2) and (videoSegment.width <> invalid)
                        RBS_CC_5_reportLine("937", 3)
                        RBS_CC_5_reportLine("938", 1)
                        props.request_video_width = videoSegment.width
                    end if
                    if RBS_CC_5_reportLine("940", 2) and (videoSegment.height <> invalid)
                        RBS_CC_5_reportLine("940", 3)
                        RBS_CC_5_reportLine("941", 1)
                        props.request_video_height = videoSegment.height
                    end if
                    if RBS_CC_5_reportLine("943", 2) and (videoSegment.downloadDuration <> invalid and videoSegment.downloadDuration > 0 and videoSegment.segSize <> invalid and videoSegment.segSize > 0)
                        RBS_CC_5_reportLine("943", 3)
                        RBS_CC_5_reportLine("944", 1)
                        loadTime = videoSegment.downloadDuration / 1000
                        RBS_CC_5_reportLine("945", 1)
                        throughput = (videoSegment.segSize * 8) / loadTime ' in bits / sec
                        RBS_CC_5_reportLine("946", 1)
                        m._totalBytes = m._safeAdd(m._totalBytes, videoSegment.segSize)
                        RBS_CC_5_reportLine("947", 1)
                        m._totalLoadTime = m._safeAdd(m._totalLoadTime, loadTime)
                        if RBS_CC_5_reportLine("948", 2) and (m._viewMinRequestThroughput = invalid)
                            RBS_CC_5_reportLine("948", 3)
                            RBS_CC_5_reportLine("949", 1)
                            m._viewMinRequestThroughput = throughput
                        else
                            RBS_CC_5_reportLine("950", 3)
                            RBS_CC_5_reportLine("951", 1)
                            m._viewMinRequestThroughput = m._min(m._viewMinRequestThroughput, throughput)
                        end if
                        RBS_CC_5_reportLine("953", 1)
                        m._viewAverageRequestThroughput = (m._totalBytes * 8) / m._totalLoadTime
                        RBS_CC_5_reportLine("954", 1)
                        m._viewRequestCount = m._segmentRequestCount
                    end if
                    RBS_CC_5_reportLine("956", 1)
                    m._addEventToQueue(m._createEvent("requestcompleted", props))
                else
                    RBS_CC_5_reportLine("957", 3)
                    if RBS_CC_5_reportLine("958", 2) and (m._segmentRequestFailedCount = invalid) then
                        RBS_CC_5_reportLine("958", 3)
                        RBS_CC_5_reportLine("958", 1)
                        m._segmentRequestFailedCount = 0
                    end if
                    RBS_CC_5_reportLine("959", 1)
                    m._segmentRequestFailedCount++
                    RBS_CC_5_reportLine("960", 1)
                    props.view_request_failed_count = m._segmentRequestFailedCount
                    RBS_CC_5_reportLine("961", 1)
                    m._addEventToQueue(m._createEvent("requestfailed", props))
                end if
            end if
        end if
    end sub
    RBS_CC_5_reportLine("967", 1)
    prototype.videoDecoderStatsChangeHandler = sub(decoderStats as object)
        if RBS_CC_5_reportLine("968", 2) and (decoderStats <> invalid)
            RBS_CC_5_reportLine("968", 3)
            if RBS_CC_5_reportLine("969", 2) and (decoderStats.frameDropCount <> invalid)
                RBS_CC_5_reportLine("969", 3)
                RBS_CC_5_reportLine("970", 1)
                m.droppedFrames = decoderStats.frameDropCount
            end if
        end if
    end sub
    RBS_CC_5_reportLine("975", 1)
    prototype.configChangeHandler = sub(config as object)
        ' convert property_key to env_key
        if RBS_CC_5_reportLine("977", 2) and (config.property_key <> invalid and config.property_key <> "")
            RBS_CC_5_reportLine("977", 3)
            RBS_CC_5_reportLine("978", 1)
            print "[mux-analytics] warning: 'property_key' is deprecated. Please use 'env_key' instead."
            RBS_CC_5_reportLine("979", 1)
            config.env_key = config.property_key
            RBS_CC_5_reportLine("980", 1)
            config.Delete("property_key")
        end if
        if RBS_CC_5_reportLine("982", 2) and (config.beaconCollectionDomain <> invalid and config.beaconCollectionDomain <> "")
            RBS_CC_5_reportLine("982", 3)
            RBS_CC_5_reportLine("983", 1)
            m.beaconUrl = "https://" + config.beaconCollectionDomain
        else if RBS_CC_5_reportLine("984", 2) and (config.env_key <> invalid and config.env_key <> "")
            RBS_CC_5_reportLine("984", 3)
            RBS_CC_5_reportLine("985", 1)
            m.beaconUrl = m._createBeaconUrl(config.env_key)
        end if
        RBS_CC_5_reportLine("988", 1)
        m._configProperties = config
    end sub
    RBS_CC_5_reportLine("991", 1)
    prototype.useRenderStitchedStreamHandler = sub(useRenderStitchedStream as boolean)
        if RBS_CC_5_reportLine("992", 2) and (useRenderStitchedStream <> invalid)
            RBS_CC_5_reportLine("992", 3)
            RBS_CC_5_reportLine("993", 1)
            m._Flag_useRenderStitchedStream = useRenderStitchedStream
        end if
    end sub
    RBS_CC_5_reportLine("997", 1)
    prototype.useSSAIHandler = sub(useSSAI as boolean)
        if RBS_CC_5_reportLine("998", 2) and (useSSAI <> invalid)
            RBS_CC_5_reportLine("998", 3)
            RBS_CC_5_reportLine("999", 1)
            m._Flag_useSSAI = useSSAI
        end if
    end sub
    RBS_CC_5_reportLine("1003", 1)
    prototype.disableAutomaticErrorTrackingHandler = sub(disableAutomaticErrorTracking as boolean)
        if RBS_CC_5_reportLine("1004", 2) and (disableAutomaticErrorTracking <> invalid)
            RBS_CC_5_reportLine("1004", 3)
            RBS_CC_5_reportLine("1005", 1)
            m._Flag_automaticErrorTracking = (not disableAutomaticErrorTracking)
        end if
    end sub
    RBS_CC_5_reportLine("1009", 1)
    prototype.videoErrorHandler = sub(error as object)
        RBS_CC_5_reportLine("1010", 1)
        errorCode = "0"
        RBS_CC_5_reportLine("1011", 1)
        errorMessage = "Unknown"
        RBS_CC_5_reportLine("1012", 1)
        errorContext = "No additional information"
        RBS_CC_5_reportLine("1013", 1)
        errorSeverity = "fatal"
        RBS_CC_5_reportLine("1014", 1)
        isBusinessException = false
        if RBS_CC_5_reportLine("1015", 2) and (error <> invalid)
            RBS_CC_5_reportLine("1015", 3)
            if RBS_CC_5_reportLine("1016", 2) and (error.errorCode <> invalid)
                RBS_CC_5_reportLine("1016", 3)
                RBS_CC_5_reportLine("1017", 1)
                errorCode = error.errorCode
            end if
            if RBS_CC_5_reportLine("1019", 2) and (error.player_error_code <> invalid)
                RBS_CC_5_reportLine("1019", 3)
                RBS_CC_5_reportLine("1020", 1)
                errorCode = error.player_error_code
            end if
            if RBS_CC_5_reportLine("1023", 2) and (error.errorMsg <> invalid)
                RBS_CC_5_reportLine("1023", 3)
                RBS_CC_5_reportLine("1024", 1)
                errorMessage = error.errorMsg
            end if
            if RBS_CC_5_reportLine("1026", 2) and (error.errorMessage <> invalid)
                RBS_CC_5_reportLine("1026", 3)
                RBS_CC_5_reportLine("1027", 1)
                errorMessage = error.errorMessage
            end if
            if RBS_CC_5_reportLine("1029", 2) and (error.player_error_message <> invalid)
                RBS_CC_5_reportLine("1029", 3)
                RBS_CC_5_reportLine("1030", 1)
                errorMessage = error.player_error_message
            end if
            ' legacy support for a typo
            if RBS_CC_5_reportLine("1033", 2) and (error.player_error_messsage <> invalid)
                RBS_CC_5_reportLine("1033", 3)
                RBS_CC_5_reportLine("1034", 1)
                errorMessage = error.player_error_message
            end if
            if RBS_CC_5_reportLine("1037", 2) and (error.errorContext <> invalid)
                RBS_CC_5_reportLine("1037", 3)
                RBS_CC_5_reportLine("1038", 1)
                errorContext = error.errorContext
            end if
            if RBS_CC_5_reportLine("1040", 2) and (error.player_error_context <> invalid)
                RBS_CC_5_reportLine("1040", 3)
                RBS_CC_5_reportLine("1041", 1)
                errorContext = error.player_error_context
            end if
            if RBS_CC_5_reportLine("1044", 2) and (error.errorSeverity <> invalid)
                RBS_CC_5_reportLine("1044", 3)
                if RBS_CC_5_reportLine("1045", 2) and (error.errorSeverity = "warning")
                    RBS_CC_5_reportLine("1045", 3)
                    RBS_CC_5_reportLine("1046", 1)
                    errorSeverity = "warning"
                end if
            end if
            if RBS_CC_5_reportLine("1049", 2) and (error.player_error_severity <> invalid)
                RBS_CC_5_reportLine("1049", 3)
                if RBS_CC_5_reportLine("1050", 2) and (error.player_error_severity = "warning")
                    RBS_CC_5_reportLine("1050", 3)
                    RBS_CC_5_reportLine("1051", 1)
                    errorSeverity = "warning"
                end if
            end if
            if RBS_CC_5_reportLine("1055", 2) and (error.isBusinessException <> invalid)
                RBS_CC_5_reportLine("1055", 3)
                RBS_CC_5_reportLine("1056", 1)
                isBusinessException = error.isBusinessException
            end if
            if RBS_CC_5_reportLine("1058", 2) and (error.player_error_business_exception <> invalid)
                RBS_CC_5_reportLine("1058", 3)
                RBS_CC_5_reportLine("1059", 1)
                isBusinessException = error.player_error_business_exception
            end if
        end if
        RBS_CC_5_reportLine("1062", 1)
        m._addEventToQueue(m._createEvent("error", {
            player_error_code: errorCode
            player_error_message: errorMessage
            player_error_context: errorContext
            player_error_severity: errorSeverity
            player_error_business_exception: isBusinessException
        }))
    end sub
    RBS_CC_5_reportLine("1065", 1)
    prototype.disablePlayheadRebufferTrackingHandler = sub(disablePlayheadRebufferTracking as boolean)
        if RBS_CC_5_reportLine("1066", 2) and (disablePlayheadRebufferTracking <> invalid)
            RBS_CC_5_reportLine("1066", 3)
            RBS_CC_5_reportLine("1067", 1)
            m._Flag_automaticRebufferTracking = (not disablePlayheadRebufferTracking)
        end if
    end sub
    RBS_CC_5_reportLine("1071", 1)
    prototype.rebufferStartHandler = sub()
        RBS_CC_5_reportLine("1072", 1)
        m._addEventToQueue(m._createEvent("rebufferstart"))
    end sub
    RBS_CC_5_reportLine("1075", 1)
    prototype.rebufferEndHandler = sub()
        RBS_CC_5_reportLine("1076", 1)
        m._addEventToQueue(m._createEvent("rebufferend"))
    end sub
    RBS_CC_5_reportLine("1079", 1)
    prototype.playbackModeHandler = sub(playbackMode as object)
        RBS_CC_5_reportLine("1080", 1)
        props = {}
        if RBS_CC_5_reportLine("1082", 2) and (playbackMode.player_playback_mode = invalid)
            RBS_CC_5_reportLine("1082", 3)
            RBS_CC_5_reportLine("1083", 1)
            print "[mux-analytics] warning: playback_mode player_playback_mode property not set."
            RBS_CC_5_reportLine("1084", 1)
            return
        end if
        RBS_CC_5_reportLine("1086", 1)
        props.player_playback_mode = playbackMode.player_playback_mode
        ' Remember the playback mode for future events in the config
        if RBS_CC_5_reportLine("1088", 2) and (m._configProperties <> invalid)
            RBS_CC_5_reportLine("1088", 3)
            RBS_CC_5_reportLine("1089", 1)
            m._configProperties.player_playback_mode = playbackMode.player_playback_mode
        end if
        if RBS_CC_5_reportLine("1092", 2) and (playbackMode.player_playback_mode_data <> invalid)
            RBS_CC_5_reportLine("1092", 3)
            ' ParseJson returns invalid if provided string is not parse-able JSON
            RBS_CC_5_reportLine("1094", 1)
            parsedData = ParseJson(playbackMode.player_playback_mode_data)
            if RBS_CC_5_reportLine("1095", 2) and (parsedData = invalid)
                RBS_CC_5_reportLine("1095", 3)
                RBS_CC_5_reportLine("1096", 1)
                print "[mux-analytics] warning: player_playback_mode_data is not valid JSON"
                RBS_CC_5_reportLine("1097", 1)
                return
            end if
            RBS_CC_5_reportLine("1099", 1)
            props.player_playback_mode_data = playbackMode.player_playback_mode_data
        end if
        RBS_CC_5_reportLine("1102", 1)
        props.view_playing_time_ms_cumulative = m._cumulativePlayingTime
        RBS_CC_5_reportLine("1103", 1)
        props.ad_playing_time_ms_cumulative = m._totalAdWatchTime
        RBS_CC_5_reportLine("1105", 1)
        m._addEventToQueue(m._createEvent("playbackmodechange", props))
    end sub
    RBS_CC_5_reportLine("1108", 1)
    prototype.requestHandler = sub(message as object)
        ' Require type field as it becomes the event type (e property)
        if RBS_CC_5_reportLine("1110", 2) and (message.type = invalid)
            RBS_CC_5_reportLine("1110", 3)
            RBS_CC_5_reportLine("1111", 1)
            print "[mux-analytics] warning: request handler called without required 'type' field"
            RBS_CC_5_reportLine("1112", 1)
            return
        end if
        RBS_CC_5_reportLine("1115", 1)
        requestVariant = message.type
        ' Used for throughput and latency metrics
        RBS_CC_5_reportLine("1118", 1)
        requestStartNum = 0
        RBS_CC_5_reportLine("1119", 1)
        responseStartNum = invalid
        RBS_CC_5_reportLine("1120", 1)
        responseEndNum = 0
        RBS_CC_5_reportLine("1121", 1)
        bytesLoaded = invalid
        RBS_CC_5_reportLine("1123", 1)
        props = {}
        if RBS_CC_5_reportLine("1124", 2) and (message.request_start <> invalid)
            RBS_CC_5_reportLine("1124", 3)
            RBS_CC_5_reportLine("1125", 1)
            props.request_start = message.request_start
            RBS_CC_5_reportLine("1126", 1)
            msgType = Type(message.request_start)
            if RBS_CC_5_reportLine("1127", 2) and (msgType = "roString" or msgType = "String")
                RBS_CC_5_reportLine("1127", 3)
                ' String: set in props but don't use for calculations
                RBS_CC_5_reportLine("1129", 1)
                print "[mux-analytics] warning: request_start received as string, only numeric values are supported for metric calculations"
            else
                RBS_CC_5_reportLine("1130", 3)
                ' Number: use for calculations and convert to string for props
                RBS_CC_5_reportLine("1132", 1)
                requestStartNum = message.request_start
            end if
        end if
        if RBS_CC_5_reportLine("1135", 2) and (message.request_hostname <> invalid)
            RBS_CC_5_reportLine("1135", 3)
            RBS_CC_5_reportLine("1136", 1)
            props.request_hostname = message.request_hostname
        end if
        if RBS_CC_5_reportLine("1138", 2) and (message.request_type <> invalid)
            RBS_CC_5_reportLine("1138", 3)
            RBS_CC_5_reportLine("1139", 1)
            props.request_type = message.request_type
        end if
        if RBS_CC_5_reportLine("1141", 2) and (message.request_id <> invalid)
            RBS_CC_5_reportLine("1141", 3)
            RBS_CC_5_reportLine("1142", 1)
            props.request_id = message.request_id
        end if
        if RBS_CC_5_reportLine("1145", 2) and (requestVariant = "completed")
            RBS_CC_5_reportLine("1145", 3)
            if RBS_CC_5_reportLine("1146", 2) and (message.request_bytes_loaded <> invalid)
                RBS_CC_5_reportLine("1146", 3)
                RBS_CC_5_reportLine("1147", 1)
                props.request_bytes_loaded = message.request_bytes_loaded
                RBS_CC_5_reportLine("1148", 1)
                bytesLoaded = message.request_bytes_loaded
            end if
            if RBS_CC_5_reportLine("1150", 2) and (message.request_response_start <> invalid)
                RBS_CC_5_reportLine("1150", 3)
                RBS_CC_5_reportLine("1151", 1)
                props.request_response_start = message.request_response_start
                RBS_CC_5_reportLine("1152", 1)
                msgType = Type(message.request_response_start)
                if RBS_CC_5_reportLine("1153", 2) and (msgType = "roString" or msgType = "String")
                    RBS_CC_5_reportLine("1153", 3)
                    ' String: set in props but don't use for calculations
                    RBS_CC_5_reportLine("1155", 1)
                    print "[mux-analytics] warning: request_response_start received as string, only numeric values are supported for metric calculations"
                else
                    RBS_CC_5_reportLine("1156", 3)
                    ' Number: use for calculations and convert to string for props
                    RBS_CC_5_reportLine("1158", 1)
                    responseStartNum = message.request_response_start
                end if
            end if
            if RBS_CC_5_reportLine("1161", 2) and (message.request_response_end <> invalid)
                RBS_CC_5_reportLine("1161", 3)
                RBS_CC_5_reportLine("1162", 1)
                props.request_response_end = message.request_response_end
                RBS_CC_5_reportLine("1163", 1)
                msgType = Type(message.request_response_end)
                if RBS_CC_5_reportLine("1164", 2) and (msgType = "roString" or msgType = "String")
                    RBS_CC_5_reportLine("1164", 3)
                    ' String: set in props but don't use for calculations
                    RBS_CC_5_reportLine("1166", 1)
                    print "[mux-analytics] warning: request_response_end received as string, only numeric values are supported for metric calculations"
                else
                    RBS_CC_5_reportLine("1167", 3)
                    ' Number: use for calculations and convert to string for props
                    RBS_CC_5_reportLine("1169", 1)
                    responseEndNum = message.request_response_end
                end if
            end if
            if RBS_CC_5_reportLine("1172", 2) and (message.request_url <> invalid)
                RBS_CC_5_reportLine("1172", 3)
                RBS_CC_5_reportLine("1173", 1)
                props.request_url = message.request_url
            end if
            if RBS_CC_5_reportLine("1175", 2) and (message.request_labeled_bitrate <> invalid)
                RBS_CC_5_reportLine("1175", 3)
                RBS_CC_5_reportLine("1176", 1)
                props.request_labeled_bitrate = message.request_labeled_bitrate
            end if
            if RBS_CC_5_reportLine("1178", 2) and (message.request_response_headers <> invalid)
                RBS_CC_5_reportLine("1178", 3)
                RBS_CC_5_reportLine("1179", 1)
                props.request_response_headers = message.request_response_headers
            end if
            if RBS_CC_5_reportLine("1181", 2) and (message.request_media_duration <> invalid)
                RBS_CC_5_reportLine("1181", 3)
                RBS_CC_5_reportLine("1182", 1)
                props.request_media_duration = message.request_media_duration
            end if
            if RBS_CC_5_reportLine("1184", 2) and (message.request_video_width <> invalid)
                RBS_CC_5_reportLine("1184", 3)
                RBS_CC_5_reportLine("1185", 1)
                props.request_video_width = message.request_video_width
            end if
            if RBS_CC_5_reportLine("1187", 2) and (message.request_video_height <> invalid)
                RBS_CC_5_reportLine("1187", 3)
                RBS_CC_5_reportLine("1188", 1)
                props.request_video_height = message.request_video_height
            end if
            ' Calculate request_duration for api and encryption request types
            ' Limit api/encryption requestcompleted events per view to prevent abuse
            if RBS_CC_5_reportLine("1192", 2) and (props.request_type <> invalid and (props.request_type = "api" or props.request_type = "encryption"))
                RBS_CC_5_reportLine("1192", 3)
                if RBS_CC_5_reportLine("1193", 2) and (m._viewApiEncryptionRequestCount = invalid) then
                    RBS_CC_5_reportLine("1193", 3)
                    RBS_CC_5_reportLine("1193", 1)
                    m._viewApiEncryptionRequestCount = 0
                end if
                if RBS_CC_5_reportLine("1194", 2) and (m._viewApiEncryptionRequestCount >= m.MAX_API_ENCRYPTION_REQUESTS_PER_VIEW)
                    RBS_CC_5_reportLine("1194", 3)
                    ' Drop event if limit exceeded
                    RBS_CC_5_reportLine("1196", 1)
                    return
                end if
                RBS_CC_5_reportLine("1198", 1)
                m._viewApiEncryptionRequestCount++
                if RBS_CC_5_reportLine("1199", 2) and (props.request_start <> invalid and props.request_response_end <> invalid)
                    RBS_CC_5_reportLine("1199", 3)
                    RBS_CC_5_reportLine("1200", 1)
                    duration = responseEndNum - requestStartNum
                    RBS_CC_5_reportLine("1201", 1)
                    props.request_duration = duration
                end if
            end if
            RBS_CC_5_reportLine("1205", 1)
            latency = invalid
            RBS_CC_5_reportLine("1206", 1)
            loadTime = invalid
            if RBS_CC_5_reportLine("1208", 2) and (responseStartNum <> invalid)
                RBS_CC_5_reportLine("1208", 3)
                RBS_CC_5_reportLine("1209", 1)
                latency = responseStartNum - requestStartNum
                RBS_CC_5_reportLine("1210", 1)
                loadTime = responseEndNum - responseStartNum
            else
                RBS_CC_5_reportLine("1211", 3)
                RBS_CC_5_reportLine("1212", 1)
                loadTime = responseEndNum - requestStartNum
            end if
            if RBS_CC_5_reportLine("1215", 2) and (loadTime > 0 and bytesLoaded <> invalid and bytesLoaded > 0)
                RBS_CC_5_reportLine("1215", 3)
                RBS_CC_5_reportLine("1216", 1)
                throughput = (bytesLoaded / loadTime) * 8000 ' in bits/sec
                if RBS_CC_5_reportLine("1218", 2) and (m._requestCompletedCount = invalid)
                    RBS_CC_5_reportLine("1218", 3)
                    RBS_CC_5_reportLine("1219", 1)
                    m._requestCompletedCount = 0
                end if
                RBS_CC_5_reportLine("1222", 1)
                m._requestCompletedCount++
                RBS_CC_5_reportLine("1223", 1)
                m._totalBytes = m._safeAdd(m._totalBytes, bytesLoaded)
                RBS_CC_5_reportLine("1224", 1)
                m._totalLoadTime = m._safeAdd(m._totalLoadTime, loadTime)
                if RBS_CC_5_reportLine("1226", 2) and (m._viewMinRequestThroughput = invalid)
                    RBS_CC_5_reportLine("1226", 3)
                    RBS_CC_5_reportLine("1227", 1)
                    m._viewMinRequestThroughput = throughput
                else
                    RBS_CC_5_reportLine("1228", 3)
                    RBS_CC_5_reportLine("1229", 1)
                    m._viewMinRequestThroughput = m._min(m._viewMinRequestThroughput, throughput)
                end if
                RBS_CC_5_reportLine("1232", 1)
                m._viewAverageRequestThroughput = (m._totalBytes / m._totalLoadTime) * 8000
                ' if we have latency data, then let's add these metrics
                if RBS_CC_5_reportLine("1235", 2) and (latency <> invalid and latency > 0)
                    RBS_CC_5_reportLine("1235", 3)
                    RBS_CC_5_reportLine("1236", 1)
                    m._totalLatency = m._safeAdd(m._totalLatency, latency)
                    if RBS_CC_5_reportLine("1238", 2) and (m._viewMaxRequestLatency = invalid)
                        RBS_CC_5_reportLine("1238", 3)
                        RBS_CC_5_reportLine("1239", 1)
                        m._viewMaxRequestLatency = latency
                    else
                        RBS_CC_5_reportLine("1240", 3)
                        RBS_CC_5_reportLine("1241", 1)
                        m._viewMaxRequestLatency = m._max(m._viewMaxRequestLatency, latency)
                    end if
                    RBS_CC_5_reportLine("1244", 1)
                    m._viewAverageRequestLatency = m._totalLatency / m._requestCompletedCount
                end if
            end if
            RBS_CC_5_reportLine("1249", 1)
            m._addEventToQueue(m._createEvent("requestcompleted", props))
        else if RBS_CC_5_reportLine("1250", 2) and (requestVariant = "failed")
            RBS_CC_5_reportLine("1250", 3)
            if RBS_CC_5_reportLine("1251", 2) and (message.request_url <> invalid)
                RBS_CC_5_reportLine("1251", 3)
                RBS_CC_5_reportLine("1252", 1)
                props.request_url = message.request_url
            end if
            if RBS_CC_5_reportLine("1254", 2) and (message.request_error <> invalid)
                RBS_CC_5_reportLine("1254", 3)
                RBS_CC_5_reportLine("1255", 1)
                props.request_error = message.request_error
            end if
            if RBS_CC_5_reportLine("1257", 2) and (message.request_error_code <> invalid)
                RBS_CC_5_reportLine("1257", 3)
                RBS_CC_5_reportLine("1258", 1)
                props.request_error_code = message.request_error_code
            end if
            if RBS_CC_5_reportLine("1260", 2) and (message.request_error_text <> invalid)
                RBS_CC_5_reportLine("1260", 3)
                RBS_CC_5_reportLine("1261", 1)
                props.request_error_text = message.request_error_text
            end if
            RBS_CC_5_reportLine("1263", 1)
            m._addEventToQueue(m._createEvent("requestfailed", props))
        else if RBS_CC_5_reportLine("1264", 2) and (requestVariant = "canceled")
            RBS_CC_5_reportLine("1264", 3)
            RBS_CC_5_reportLine("1265", 1)
            m._addEventToQueue(m._createEvent("requestcanceled", props))
        end if
    end sub
    RBS_CC_5_reportLine("1269", 1)
    prototype.rafEventHandler = sub(rafEvent)
        RBS_CC_5_reportLine("1270", 1)
        data = rafEvent.getData()
        RBS_CC_5_reportLine("1271", 1)
        eventType = data.eventType
        RBS_CC_5_reportLine("1272", 1)
        obj = data.obj
        RBS_CC_5_reportLine("1273", 1)
        ctx = data.ctx
        ' Only pull the pieces of data we care about
        ' Previous instructions passed the full adIface in, which has a circular reference in some cases
        RBS_CC_5_reportLine("1277", 1)
        adMetadata = {}
        ' copy over the `mux` object so we can pull the values later
        RBS_CC_5_reportLine("1279", 1)
        adMetadata.mux = {}
        if RBS_CC_5_reportLine("1280", 2) and (ctx.mux <> invalid)
            RBS_CC_5_reportLine("1280", 3)
            RBS_CC_5_reportLine("1281", 1)
            adMetadata.mux = ctx.mux
        end if
        if RBS_CC_5_reportLine("1283", 2) and (obj <> invalid)
            RBS_CC_5_reportLine("1283", 3)
            if RBS_CC_5_reportLine("1284", 2) and (obj.adurl <> invalid)
                RBS_CC_5_reportLine("1284", 3)
                RBS_CC_5_reportLine("1285", 1)
                adMetadata.adTagUrl = obj.adurl
            end if
        end if
        RBS_CC_5_reportLine("1289", 1)
        m._advertProperties = {}
        ' Special case to handle if `renderStitchedStream` is used or not
        if RBS_CC_5_reportLine("1292", 2) and (m._Flag_useRenderStitchedStream = true)
            RBS_CC_5_reportLine("1292", 3)
            RBS_CC_5_reportLine("1293", 1)
            m._renderStitchedStreamRafEventHandler(eventType, ctx, adMetadata)
        else
            RBS_CC_5_reportLine("1294", 3)
            RBS_CC_5_reportLine("1295", 1)
            m._rafEventHandler(eventType, ctx, adMetadata)
        end if
    end sub
    RBS_CC_5_reportLine("1299", 1)
    prototype._rafEventhandler = sub(eventType, ctx, adMetadata)
        RBS_CC_5_reportLine("1300", 1)
        date = m._getDateTime()
        RBS_CC_5_reportLine("1301", 1)
        now = 0# + date.AsSeconds() * 1000.0# + date.GetMilliseconds()
        ' If we're handling ad events, we'll need these eventually, so guarantee they're initialized
        if RBS_CC_5_reportLine("1304", 2) and (m._adWatchTime = invalid)
            RBS_CC_5_reportLine("1304", 3)
            RBS_CC_5_reportLine("1305", 1)
            m._adWatchTime = 0
        end if
        if RBS_CC_5_reportLine("1307", 2) and (m._totalAdWatchTime = invalid)
            RBS_CC_5_reportLine("1307", 3)
            RBS_CC_5_reportLine("1308", 1)
            m._totalAdWatchTime = 0
        end if
        RBS_CC_5_reportLine("1311", 1)
        m._Flag_isPaused = (eventType = "Pause")
        if RBS_CC_5_reportLine("1312", 2) and (eventType = "PodStart")
            RBS_CC_5_reportLine("1312", 3)
            RBS_CC_5_reportLine("1313", 1)
            m._advertProperties = m._getAdvertProperties(adMetadata)
            RBS_CC_5_reportLine("1314", 1)
            m._addEventToQueue(m._createEvent("adbreakstart"))
            ' In the case that this is SSAI, we need to signal an adplay and adplaying event
            if RBS_CC_5_reportLine("1316", 2) and (m._Flag_useSSAI = true)
                RBS_CC_5_reportLine("1316", 3)
                RBS_CC_5_reportLine("1317", 1)
                m._lastAdResumeTime = now
                RBS_CC_5_reportLine("1318", 1)
                m._addEventToQueue(m._createEvent("adplay"))
                RBS_CC_5_reportLine("1319", 1)
                m._addEventToQueue(m._createEvent("adplaying"))
            else
                RBS_CC_5_reportLine("1320", 3)
                ' For CSAI, end the playback range, since CSAI ads have their own playhead
                RBS_CC_5_reportLine("1322", 1)
                m._endPlaybackRange(m._playerPlayheadTime)
            end if
        else if RBS_CC_5_reportLine("1324", 2) and (eventType = "PodComplete")
            RBS_CC_5_reportLine("1324", 3)
            RBS_CC_5_reportLine("1325", 1)
            m._addEventToQueue(m._createEvent("adbreakend"))
            RBS_CC_5_reportLine("1326", 1)
            m._Flag_FailedAdsErrorSet = false
            ' In the case that this is SSAI, we need to signal a play and playing event
            if RBS_CC_5_reportLine("1328", 2) and (m._Flag_useSSAI = true)
                RBS_CC_5_reportLine("1328", 3)
                RBS_CC_5_reportLine("1329", 1)
                m._Flag_isPaused = false
                RBS_CC_5_reportLine("1330", 1)
                m._triggerPlayEvent()
                RBS_CC_5_reportLine("1332", 1)
                m._addEventToQueue(m._createEvent("playing"))
            else
                RBS_CC_5_reportLine("1333", 3)
                ' for CSAI, we need to restart the playback range
                if RBS_CC_5_reportLine("1335", 2) and (m._Flag_isPaused <> false)
                    RBS_CC_5_reportLine("1335", 3)
                    RBS_CC_5_reportLine("1336", 1)
                    m._startPlaybackRange(m._playerPlayheadTime)
                end if
            end if
        else if RBS_CC_5_reportLine("1339", 2) and (eventType = "Impression")
            RBS_CC_5_reportLine("1339", 3)
            RBS_CC_5_reportLine("1340", 1)
            m._addEventToQueue(m._createEvent("adimpression"))
        else if RBS_CC_5_reportLine("1341", 2) and (eventType = "Pause")
            RBS_CC_5_reportLine("1341", 3)
            if RBS_CC_5_reportLine("1342", 2) and (m._lastAdResumeTime <> invalid)
                RBS_CC_5_reportLine("1342", 3)
                RBS_CC_5_reportLine("1343", 1)
                m._adWatchTime += m._max(0, now - m._lastAdResumeTime)
                RBS_CC_5_reportLine("1344", 1)
                m._lastAdResumeTime = invalid
            end if
            RBS_CC_5_reportLine("1346", 1)
            m._addEventToQueue(m._createEvent("adpause"))
        else if RBS_CC_5_reportLine("1347", 2) and (eventType = "Start")
            RBS_CC_5_reportLine("1347", 3)
            if RBS_CC_5_reportLine("1348", 2) and (m._viewTimeToFirstFrame = invalid)
                RBS_CC_5_reportLine("1348", 3)
                if RBS_CC_5_reportLine("1349", 2) and (m._viewStartTimestamp <> invalid and m._viewStartTimestamp <> 0)
                    RBS_CC_5_reportLine("1349", 3)
                    RBS_CC_5_reportLine("1350", 1)
                    date = m._getDateTime()
                    RBS_CC_5_reportLine("1351", 1)
                    now = 0# + date.AsSeconds() * 1000.0# + date.GetMilliseconds()
                    RBS_CC_5_reportLine("1352", 1)
                    m._viewTimeToFirstFrame = now - m._viewStartTimestamp
                end if
            end if
            ' mark us as having another ad being played
            if RBS_CC_5_reportLine("1356", 2) and (m._viewAdPlayedCount <> invalid)
                RBS_CC_5_reportLine("1356", 3)
                RBS_CC_5_reportLine("1357", 1)
                m._viewAdPlayedCount++
            end if
            if RBS_CC_5_reportLine("1359", 2) and (m._viewPrerollPlayedCount <> invalid)
                RBS_CC_5_reportLine("1359", 3)
                ' CHECK FOR PREROLL
                RBS_CC_5_reportLine("1361", 1)
                m._viewPrerollPlayedCount++
            end if
            RBS_CC_5_reportLine("1363", 1)
            m._advertProperties = m._getAdvertProperties(ctx)
            RBS_CC_5_reportLine("1364", 1)
            m._adWatchTime = 0
            RBS_CC_5_reportLine("1365", 1)
            m._lastAdResumeTime = now
            RBS_CC_5_reportLine("1367", 1)
            m._addEventToQueue(m._createEvent("adplay"))
            RBS_CC_5_reportLine("1368", 1)
            m._addEventToQueue(m._createEvent("adplaying"))
        else if RBS_CC_5_reportLine("1369", 2) and (eventType = "Resume")
            RBS_CC_5_reportLine("1369", 3)
            RBS_CC_5_reportLine("1370", 1)
            m._lastAdResumeTime = now
            RBS_CC_5_reportLine("1371", 1)
            m._advertProperties = m._getAdvertProperties(ctx)
            RBS_CC_5_reportLine("1373", 1)
            m._addEventToQueue(m._createEvent("adplay"))
            RBS_CC_5_reportLine("1374", 1)
            m._addEventToQueue(m._createEvent("adplaying"))
        else if RBS_CC_5_reportLine("1375", 2) and (eventType = "Complete")
            RBS_CC_5_reportLine("1375", 3)
            if RBS_CC_5_reportLine("1376", 2) and (m._lastAdResumeTime <> invalid)
                RBS_CC_5_reportLine("1376", 3)
                RBS_CC_5_reportLine("1377", 1)
                m._adWatchTime += m._max(0, now - m._lastAdResumeTime)
                RBS_CC_5_reportLine("1378", 1)
                m._lastAdResumeTime = invalid
            end if
            RBS_CC_5_reportLine("1381", 1)
            m._totalAdWatchTime += m._adWatchTime
            RBS_CC_5_reportLine("1382", 1)
            m._addEventToQueue(m._createEvent("adended"))
        else if RBS_CC_5_reportLine("1383", 2) and (eventType = "NoAdsError")
            RBS_CC_5_reportLine("1383", 3)
            if RBS_CC_5_reportLine("1384", 2) and (m._Flag_FailedAdsErrorSet <> true)
                RBS_CC_5_reportLine("1384", 3)
                ' For now, aderror events do not support codes and messages, but leaving
                ' this here for now for context in the future
                ' errorCode = ""
                ' errorMessage = ""
                ' if ctx <> Invalid
                '   if ctx.errcode <> Invalid
                '     errorCode = ctx.errcode
                '   end if
                '   if ctx.errmsg <> Invalid
                '     errorMessage = ctx.errmsg
                '   end if
                ' end if
                RBS_CC_5_reportLine("1397", 1)
                m._addEventToQueue(m._createEvent("aderror"))
                RBS_CC_5_reportLine("1398", 1)
                m._Flag_FailedAdsErrorSet = true
            end if
        else if RBS_CC_5_reportLine("1400", 2) and (eventType = "FirstQuartile")
            RBS_CC_5_reportLine("1400", 3)
            RBS_CC_5_reportLine("1401", 1)
            m._addEventToQueue(m._createEvent("adfirstquartile"))
        else if RBS_CC_5_reportLine("1402", 2) and (eventType = "Midpoint")
            RBS_CC_5_reportLine("1402", 3)
            RBS_CC_5_reportLine("1403", 1)
            m._addEventToQueue(m._createEvent("admidpoint"))
        else if RBS_CC_5_reportLine("1404", 2) and (eventType = "ThirdQuartile")
            RBS_CC_5_reportLine("1404", 3)
            RBS_CC_5_reportLine("1405", 1)
            m._addEventToQueue(m._createEvent("adthirdquartile"))
        else if RBS_CC_5_reportLine("1406", 2) and (eventType = "Skip")
            RBS_CC_5_reportLine("1406", 3)
            if RBS_CC_5_reportLine("1407", 2) and (m._lastAdResumeTime <> invalid)
                RBS_CC_5_reportLine("1407", 3)
                RBS_CC_5_reportLine("1408", 1)
                m._adWatchTime += m._max(0, now - m._lastAdResumeTime)
                RBS_CC_5_reportLine("1409", 1)
                m._lastAdResumeTime = invalid
            end if
            RBS_CC_5_reportLine("1411", 1)
            m._totalAdWatchTime += m._adWatchTime
            RBS_CC_5_reportLine("1412", 1)
            m._addEventToQueue(m._createEvent("adskipped"))
            RBS_CC_5_reportLine("1413", 1)
            m._addEventToQueue(m._createEvent("adended"))
        end if
    end sub
    RBS_CC_5_reportLine("1417", 1)
    prototype._renderStitchedStreamRafEventHandler = sub(eventType, ctx, adMetadata)
        RBS_CC_5_reportLine("1418", 1)
        date = m._getDateTime()
        RBS_CC_5_reportLine("1419", 1)
        now = 0# + date.AsSeconds() * 1000.0# + date.GetMilliseconds()
        ' If we're handling ad events, we'll need these eventually, so guarantee they're initialized
        if RBS_CC_5_reportLine("1422", 2) and (m._adWatchTime = invalid)
            RBS_CC_5_reportLine("1422", 3)
            RBS_CC_5_reportLine("1423", 1)
            m._adWatchTime = 0
        end if
        if RBS_CC_5_reportLine("1425", 2) and (m._totalAdWatchTime = invalid)
            RBS_CC_5_reportLine("1425", 3)
            RBS_CC_5_reportLine("1426", 1)
            m._totalAdWatchTime = 0
        end if
        if RBS_CC_5_reportLine("1429", 2) and (eventType = "AdStateChange")
            RBS_CC_5_reportLine("1429", 3)
            RBS_CC_5_reportLine("1430", 1)
            state = ctx.state
            RBS_CC_5_reportLine("1431", 1)
            m._advertProperties = m._getAdvertProperties(adMetadata)
            if RBS_CC_5_reportLine("1432", 2) and (state = "buffering")
                RBS_CC_5_reportLine("1432", 3)
                ' the buffering state is the first event we get in a new ad pod, so start
                ' our ad break here if we're not already in one
                if RBS_CC_5_reportLine("1435", 2) and (not m._Flag_rssInAdBreak)
                    RBS_CC_5_reportLine("1435", 3)
                    RBS_CC_5_reportLine("1436", 1)
                    m._Flag_rssInAdBreak = true
                    RBS_CC_5_reportLine("1438", 1)
                    m._addEventToQueue(m._createEvent("adbreakstart"))
                end if
                ' and always trigger adplay
                RBS_CC_5_reportLine("1442", 1)
                m._Flag_isPaused = false
                RBS_CC_5_reportLine("1444", 1)
                m._addEventToQueue(m._createEvent("adplay"))
            else if RBS_CC_5_reportLine("1445", 2) and (state = "playing")
                RBS_CC_5_reportLine("1445", 3)
                ' in the playing state, if we are resuming, we need adplay first
                if RBS_CC_5_reportLine("1447", 2) and (m._Flag_isPaused)
                    RBS_CC_5_reportLine("1447", 3)
                    RBS_CC_5_reportLine("1448", 1)
                    m._Flag_isPaused = false
                    RBS_CC_5_reportLine("1449", 1)
                    m._addEventToQueue(m._createEvent("adplay"))
                else
                    RBS_CC_5_reportLine("1450", 3)
                    ' starting fresh: reset watch time
                    RBS_CC_5_reportLine("1452", 1)
                    m._adWatchTime = 0
                end if
                ' and always emit adplaying
                RBS_CC_5_reportLine("1455", 1)
                m._lastAdResumeTime = now
                RBS_CC_5_reportLine("1456", 1)
                m._addEventToQueue(m._createEvent("adplaying"))
            else if RBS_CC_5_reportLine("1457", 2) and (state = "paused")
                RBS_CC_5_reportLine("1457", 3)
                if RBS_CC_5_reportLine("1458", 2) and (m._lastAdResumeTime <> invalid)
                    RBS_CC_5_reportLine("1458", 3)
                    RBS_CC_5_reportLine("1459", 1)
                    m._adWatchTime += m._max(0, now - m._lastAdResumeTime)
                    RBS_CC_5_reportLine("1460", 1)
                    m._lastAdResumeTime = invalid
                end if
                RBS_CC_5_reportLine("1462", 1)
                m._Flag_isPaused = true
                RBS_CC_5_reportLine("1463", 1)
                m._addEventToQueue(m._createEvent("adpause"))
            end if
        else if RBS_CC_5_reportLine("1465", 2) and (eventType = "PodStart")
            RBS_CC_5_reportLine("1465", 3)
            ' Need to handle PodStart for non-pre-rolls
            if RBS_CC_5_reportLine("1467", 2) and (not m._Flag_rssInAdBreak)
                RBS_CC_5_reportLine("1467", 3)
                RBS_CC_5_reportLine("1468", 1)
                m._Flag_rssInAdBreak = true
                RBS_CC_5_reportLine("1469", 1)
                m._adWatchTime = 0
                RBS_CC_5_reportLine("1470", 1)
                m._lastAdResumeTime = now
                if RBS_CC_5_reportLine("1471", 2) and (not m._Flag_isPaused)
                    RBS_CC_5_reportLine("1471", 3)
                    RBS_CC_5_reportLine("1472", 1)
                    m._Flag_isPaused = true
                    RBS_CC_5_reportLine("1473", 1)
                    m._addEventToQueue(m._createEvent("pause"))
                end if
                RBS_CC_5_reportLine("1476", 1)
                m._addEventToQueue(m._createEvent("adbreakstart"))
            end if
        else if RBS_CC_5_reportLine("1478", 2) and (eventType = "Complete")
            RBS_CC_5_reportLine("1478", 3)
            ' Complete signals an ad has finished playback
            RBS_CC_5_reportLine("1480", 1)
            m._Flag_rssAdEnded = true
            if RBS_CC_5_reportLine("1481", 2) and (m._lastAdResumeTime <> invalid)
                RBS_CC_5_reportLine("1481", 3)
                RBS_CC_5_reportLine("1482", 1)
                m._adWatchTime += m._max(0, now - m._lastAdResumeTime)
                RBS_CC_5_reportLine("1483", 1)
                m._lastAdResumeTime = invalid
            end if
            RBS_CC_5_reportLine("1486", 1)
            m._totalAdWatchTime += m._adWatchTime
            RBS_CC_5_reportLine("1487", 1)
            m._addEventToQueue(m._createEvent("adended"))
        else if RBS_CC_5_reportLine("1488", 2) and (eventType = "Impression")
            RBS_CC_5_reportLine("1488", 3)
            ' When an additional ad is played within an ad pod, we do not get
            ' the AdStateChange events or anything other than the Impression
            ' event to know that a new ad was played
            if RBS_CC_5_reportLine("1492", 2) and (m._Flag_rssAdEnded)
                RBS_CC_5_reportLine("1492", 3)
                RBS_CC_5_reportLine("1493", 1)
                m._Flag_rssAdEnded = false
                RBS_CC_5_reportLine("1494", 1)
                m._adWatchTime = 0
                RBS_CC_5_reportLine("1495", 1)
                m._lastAdResumeTime = now
                RBS_CC_5_reportLine("1497", 1)
                m._addEventToQueue(m._createEvent("adplay"))
                RBS_CC_5_reportLine("1498", 1)
                m._addEventToQueue(m._createEvent("adplaying"))
            end if
        else if RBS_CC_5_reportLine("1500", 2) and (eventType = "PodComplete")
            RBS_CC_5_reportLine("1500", 3)
            RBS_CC_5_reportLine("1501", 1)
            m._Flag_rssInAdBreak = false
            RBS_CC_5_reportLine("1502", 1)
            m._Flag_isPaused = true
            RBS_CC_5_reportLine("1504", 1)
            m._addEventToQueue(m._createEvent("adbreakend"))
        else if RBS_CC_5_reportLine("1505", 2) and (eventType = "ContentPosition")
            RBS_CC_5_reportLine("1505", 3)
            ' we have a special case here to track the start of content after an ad break
            if RBS_CC_5_reportLine("1507", 2) and (not m._Flag_rssInAdBreak)
                RBS_CC_5_reportLine("1507", 3)
                if RBS_CC_5_reportLine("1508", 2) and (m._Flag_isPaused)
                    RBS_CC_5_reportLine("1508", 3)
                    RBS_CC_5_reportLine("1509", 1)
                    m._Flag_isPaused = false
                    RBS_CC_5_reportLine("1510", 1)
                    m._triggerPlayEvent()
                    RBS_CC_5_reportLine("1512", 1)
                    m._startPlaybackRange(m._playerPlayheadTime)
                    RBS_CC_5_reportLine("1513", 1)
                    m._addEventToQueue(m._createEvent("playing"))
                end if
            end if
        else if RBS_CC_5_reportLine("1516", 2) and (eventType = "ContentStateChange")
            RBS_CC_5_reportLine("1516", 3)
            ' We really only care about this if we're _not_ in an ad break
            if RBS_CC_5_reportLine("1518", 2) and (not m._Flag_rssInAdBreak)
                RBS_CC_5_reportLine("1518", 3)
                RBS_CC_5_reportLine("1519", 1)
                state = ctx.state
                if RBS_CC_5_reportLine("1520", 2) and (state = "buffering")
                    RBS_CC_5_reportLine("1520", 3)
                    ' if m._Flag_isPaused
                    RBS_CC_5_reportLine("1522", 1)
                    m._Flag_isPaused = false
                    RBS_CC_5_reportLine("1523", 1)
                    m._triggerPlayEvent()
                    ' end if
                else if RBS_CC_5_reportLine("1525", 2) and (state = "playing")
                    RBS_CC_5_reportLine("1525", 3)
                    ' We get the playing event after buffering on initial startup, but
                    ' also again on unpausing (without the buffering event), so we need
                    ' to send play if we're currently paused
                    if RBS_CC_5_reportLine("1529", 2) and (m._Flag_isPaused)
                        RBS_CC_5_reportLine("1529", 3)
                        RBS_CC_5_reportLine("1530", 1)
                        m._Flag_isPaused = false
                        RBS_CC_5_reportLine("1531", 1)
                        m._triggerPlayEvent()
                    end if
                    RBS_CC_5_reportLine("1534", 1)
                    m._startPlaybackRange(m._playerPlayheadTime)
                    RBS_CC_5_reportLine("1535", 1)
                    m._addEventToQueue(m._createEvent("playing"))
                else if RBS_CC_5_reportLine("1536", 2) and (state = "paused")
                    RBS_CC_5_reportLine("1536", 3)
                    RBS_CC_5_reportLine("1537", 1)
                    m._Flag_isPaused = true
                    RBS_CC_5_reportLine("1538", 1)
                    m._addEventToQueue(m._createEvent("pause"))
                end if
            end if
        end if
    end sub
    RBS_CC_5_reportLine("1544", 1)
    prototype.pollingIntervalHandler = sub(pollingIntervalEvent)
        if RBS_CC_5_reportLine("1545", 2) and (m.video = invalid) then
            RBS_CC_5_reportLine("1545", 3)
            RBS_CC_5_reportLine("1545", 1)
            return
        end if
        if RBS_CC_5_reportLine("1546", 2) and (m._Flag_isPaused = true) then
            RBS_CC_5_reportLine("1546", 3)
            RBS_CC_5_reportLine("1546", 1)
            return
        end if
        ' Position is now handled by videoPositionChangeHandler to avoid rendezvous
        ' if m.video.position < m.MAX_VIDEO_POSITION_JUMP
        '   m._playerPlayheadTime = m.video.position
        ' end if
        RBS_CC_5_reportLine("1553", 1)
        m._setBufferingMetrics()
        RBS_CC_5_reportLine("1554", 1)
        m._updateContentPlaybackTime()
        RBS_CC_5_reportLine("1556", 1)
        m._updateTotalWatchTime()
        RBS_CC_5_reportLine("1557", 1)
        m._updateLastReportedPositionFlag()
    end sub
    ' ' //////////////////////////////////////////////////////////////
    ' ' INTERNAL METHODS
    ' ' //////////////////////////////////////////////////////////////
    RBS_CC_5_reportLine("1564", 1)
    prototype._updateLastReportedPositionFlag = sub()
        if RBS_CC_5_reportLine("1565", 2) and (m._playerPlayheadTime = m._Flag_lastReportedPosition) then
            RBS_CC_5_reportLine("1565", 3)
            RBS_CC_5_reportLine("1565", 1)
            return
        end if
        if RBS_CC_5_reportLine("1566", 2) and (m._playerPlayheadTime <> invalid)
            RBS_CC_5_reportLine("1566", 3)
            RBS_CC_5_reportLine("1567", 1)
            m._Flag_lastReportedPosition = m._playerPlayheadTime
        end if
    end sub
    RBS_CC_5_reportLine("1571", 1)
    prototype._updateContentPlaybackTime = sub()
        if RBS_CC_5_reportLine("1572", 2) and (m._playerPlayheadTime = invalid) then
            RBS_CC_5_reportLine("1572", 3)
            RBS_CC_5_reportLine("1572", 1)
            return
        end if
        if RBS_CC_5_reportLine("1573", 2) and (m._playerPlayheadTime <= m._Flag_lastReportedPosition) then
            RBS_CC_5_reportLine("1573", 3)
            RBS_CC_5_reportLine("1573", 1)
            return
        end if
        if RBS_CC_5_reportLine("1574", 2) and (m.video_state <> "playing") then
            RBS_CC_5_reportLine("1574", 3)
            RBS_CC_5_reportLine("1574", 1)
            return
        end if
        if RBS_CC_5_reportLine("1575", 2) and (m._contentPlaybackTime = invalid) then
            RBS_CC_5_reportLine("1575", 3)
            RBS_CC_5_reportLine("1575", 1)
            return
        end if
        RBS_CC_5_reportLine("1577", 1)
        timeDelta = m._playerPlayheadTime - m._Flag_lastReportedPosition
        ' Guard against suspiciously large jumps
        if RBS_CC_5_reportLine("1580", 2) and (timeDelta > 100) then
            RBS_CC_5_reportLine("1580", 3)
            RBS_CC_5_reportLine("1580", 1)
            return
        end if
        RBS_CC_5_reportLine("1582", 1)
        m._contentPlaybackTime = m._contentPlaybackTime + (timeDelta * 1000)
    end sub
    RBS_CC_5_reportLine("1585", 1)
    prototype._updateTotalWatchTime = sub()
        if RBS_CC_5_reportLine("1586", 2) and (m.video_state = "paused") then
            RBS_CC_5_reportLine("1586", 3)
            RBS_CC_5_reportLine("1586", 1)
            return
        end if
        if RBS_CC_5_reportLine("1587", 2) and (m._viewWatchTime = invalid) then
            RBS_CC_5_reportLine("1587", 3)
            RBS_CC_5_reportLine("1587", 1)
            return
        end if
        if RBS_CC_5_reportLine("1588", 2) and (m._viewStartTimestamp = invalid) then
            RBS_CC_5_reportLine("1588", 3)
            RBS_CC_5_reportLine("1588", 1)
            return
        end if
        if RBS_CC_5_reportLine("1589", 2) and (m._viewTimeToFirstFrame = invalid) then
            RBS_CC_5_reportLine("1589", 3)
            RBS_CC_5_reportLine("1589", 1)
            return
        end if
        if RBS_CC_5_reportLine("1590", 2) and (m._viewRebufferDuration = invalid) then
            RBS_CC_5_reportLine("1590", 3)
            RBS_CC_5_reportLine("1590", 1)
            return
        end if
        if RBS_CC_5_reportLine("1591", 2) and (m._contentPlaybackTime = invalid) then
            RBS_CC_5_reportLine("1591", 3)
            RBS_CC_5_reportLine("1591", 1)
            return
        end if
        RBS_CC_5_reportLine("1593", 1)
        m._viewWatchTime = m._viewTimeToFirstFrame + m._viewRebufferDuration + m._contentPlaybackTime
        RBS_CC_5_reportLine("1594", 1)
        m._cumulativePlayingTime = m._viewWatchTime + m._totalAdWatchTime
    end sub
    RBS_CC_5_reportLine("1597", 1)
    prototype._setBufferingMetrics = sub()
        if RBS_CC_5_reportLine("1598", 2) and (m.video_state <> "buffering") then
            RBS_CC_5_reportLine("1598", 3)
            RBS_CC_5_reportLine("1598", 1)
            return
        end if
        if RBS_CC_5_reportLine("1599", 2) and (m._Flag_atLeastOnePlayEventForContent <> true) then
            RBS_CC_5_reportLine("1599", 3)
            RBS_CC_5_reportLine("1599", 1)
            return
        end if
        if RBS_CC_5_reportLine("1600", 2) and (m._viewRebufferDuration = invalid) then
            RBS_CC_5_reportLine("1600", 3)
            RBS_CC_5_reportLine("1600", 1)
            return
        end if
        RBS_CC_5_reportLine("1602", 1)
        m._viewRebufferDuration = m._viewRebufferDuration + (m.pollTimer.duration * 1000)
        if RBS_CC_5_reportLine("1603", 2) and (m._viewWatchTime <> invalid and m._viewWatchTime > 0)
            RBS_CC_5_reportLine("1603", 3)
            RBS_CC_5_reportLine("1604", 1)
            m._viewRebufferPercentage = m._viewRebufferDuration / m._viewWatchTime
        end if
    end sub
    RBS_CC_5_reportLine("1608", 1)
    prototype._addEventToQueue = sub(_event as object)
        RBS_CC_5_reportLine("1609", 1)
        m._logEvent(_event)
        ' If the heartbeat is running restart it.
        if RBS_CC_5_reportLine("1611", 2) and (m._Flag_heartbeatTimerRunning)
            RBS_CC_5_reportLine("1611", 3)
            RBS_CC_5_reportLine("1612", 1)
            m.heartbeatTimer.control = "stop"
            RBS_CC_5_reportLine("1613", 1)
            m.heartbeatTimer.control = "start"
        end if
        ' Only queue up the event if we have not reached
        ' the max queue size
        if RBS_CC_5_reportLine("1618", 2) and (m._eventQueue.count() <= m.MAX_QUEUE_LENGTH)
            RBS_CC_5_reportLine("1618", 3)
            RBS_CC_5_reportLine("1619", 1)
            m._eventQueue.push(_event)
        end if
    end sub
    RBS_CC_5_reportLine("1623", 1)
    prototype.isQueueEmpty = function() as boolean
        RBS_CC_5_reportLine("1624", 1)
        return m._eventQueue.count() = 0
    end function
    RBS_CC_5_reportLine("1627", 1)
    prototype.LIGHT_THE_BEACONS = sub()
        ' If a request is already in progress, do nothing
        if RBS_CC_5_reportLine("1629", 2) and (m._Flag_beaconRequestInProgress) then
            RBS_CC_5_reportLine("1629", 3)
            RBS_CC_5_reportLine("1629", 1)
            return
        end if
        RBS_CC_5_reportLine("1631", 1)
        queueSize = m._eventQueue.count()
        if RBS_CC_5_reportLine("1632", 2) and (queueSize = 0) then
            RBS_CC_5_reportLine("1632", 3)
            RBS_CC_5_reportLine("1632", 1)
            return
        end if
        if RBS_CC_5_reportLine("1634", 2) and (queueSize >= m.MAX_BEACON_SIZE)
            RBS_CC_5_reportLine("1634", 3)
            RBS_CC_5_reportLine("1635", 1)
            beacon = []
            RBS_CC_5_reportLine("1636", 1): for i = 0 to m.MAX_BEACON_SIZE - 1 step 1
                RBS_CC_5_reportLine("1637", 1)
                beacon.push(m._eventQueue.shift())
            end for
        else
            RBS_CC_5_reportLine("1639", 3)
            RBS_CC_5_reportLine("1640", 1)
            beacon = []
            RBS_CC_5_reportLine("1641", 1)
            beacon.Append(m._eventQueue)
            RBS_CC_5_reportLine("1642", 1)
            m._eventQueue.Clear()
        end if
        RBS_CC_5_reportLine("1644", 1)
        m._sendBeacon(beacon)
    end sub
    RBS_CC_5_reportLine("1647", 1)
    prototype._sendBeacon = sub(beacon as object)
        RBS_CC_5_reportLine("1648", 1)
        m._beaconCount++
        if RBS_CC_5_reportLine("1649", 2) and (m.dryRun = true)
            RBS_CC_5_reportLine("1649", 3)
            RBS_CC_5_reportLine("1650", 1)
            m._logBeacon(beacon, "DRY-BEACON")
        else
            RBS_CC_5_reportLine("1651", 3)
            if RBS_CC_5_reportLine("1652", 2) and (beacon.count() > 0)
                RBS_CC_5_reportLine("1652", 3)
                RBS_CC_5_reportLine("1653", 1)
                m._logBeacon(beacon, "BEACON")
                RBS_CC_5_reportLine("1654", 1)
                m._minifiedBeacon = []
                RBS_CC_5_reportLine("1655", 1): for each b in beacon
                    RBS_CC_5_reportLine("1656", 1)
                    m._minifiedBeacon.push(m._minify(b))
                end for
                RBS_CC_5_reportLine("1658", 1)
                m._retryCountdown = m.HTTP_RETRIES
                RBS_CC_5_reportLine("1659", 1)
                m._Flag_beaconRequestInProgress = true
                RBS_CC_5_reportLine("1660", 1)
                m._makeRequest()
            end if
        end if
    end sub
    RBS_CC_5_reportLine("1665", 1)
    prototype._makeRequest = sub()
        RBS_CC_5_reportLine("1666", 1)
        m._beaconRetryDelay = invalid
        RBS_CC_5_reportLine("1667", 1)
        m._beaconAttemptTimespan = invalid
        RBS_CC_5_reportLine("1668", 1)
        m.connection.AsyncCancel()
        RBS_CC_5_reportLine("1669", 1)
        m.connection.SetUrl(m.beaconUrl)
        RBS_CC_5_reportLine("1670", 1)
        m.requestId = m.connection.GetIdentity()
        RBS_CC_5_reportLine("1671", 1)
        requestBody = {}
        RBS_CC_5_reportLine("1672", 1)
        requestBody.events = m._minifiedBeacon
        RBS_CC_5_reportLine("1673", 1)
        fBody = FormatJson(requestBody)
        RBS_CC_5_reportLine("1674", 1)
        m.connection.AsyncPostFromString(fBody)
    end sub
    RBS_CC_5_reportLine("1677", 1)
    prototype._handleHttpEvent = sub(event as object)
        if RBS_CC_5_reportLine("1678", 2) and (not m._Flag_beaconRequestInProgress)
            RBS_CC_5_reportLine("1678", 3)
            RBS_CC_5_reportLine("1679", 1)
            print "[mux-analytics] HTTP port event received when no request in progress"
            RBS_CC_5_reportLine("1680", 1)
            return
        end if
        if RBS_CC_5_reportLine("1683", 2) and (type(event) <> "roUrlEvent")
            RBS_CC_5_reportLine("1683", 3)
            RBS_CC_5_reportLine("1684", 1)
            print "[mux-analytics] Unknown HTTP port event"
            RBS_CC_5_reportLine("1685", 1)
            return
        end if
        ' Successful exit if a 2xx is returned
        RBS_CC_5_reportLine("1689", 1)
        statusCode = event.GetResponseCode()
        if RBS_CC_5_reportLine("1690", 2) and (statusCode >= 200 and statusCode < 300)
            RBS_CC_5_reportLine("1690", 3)
            RBS_CC_5_reportLine("1691", 1)
            m._Flag_beaconRequestInProgress = false
            RBS_CC_5_reportLine("1692", 1)
            return
        end if
        ' Otherwise clean it up and set our delay and timer if we're not done
        if RBS_CC_5_reportLine("1696", 2) and (m._retryCountdown <= 0)
            RBS_CC_5_reportLine("1696", 3)
            RBS_CC_5_reportLine("1697", 1)
            print "[mux-analytics] Retries exceeded for beacon, giving up"
            RBS_CC_5_reportLine("1698", 1)
            m._Flag_beaconRequestInProgress = false
            RBS_CC_5_reportLine("1699", 1)
            return
        end if
        RBS_CC_5_reportLine("1702", 1)
        base = m._min(m.HEARTBEAT_INTERVAL, 2 ^ (m.HTTP_RETRIES - m._retryCountdown) * 1000)
        RBS_CC_5_reportLine("1703", 1)
        m._beaconRetryDelay = Fix(base / 2 + Rnd(0) * base / 2)
        RBS_CC_5_reportLine("1704", 1)
        m._beaconAttemptTimespan = CreateObject("roTimespan")
        RBS_CC_5_reportLine("1705", 1)
        m._retryCountdown = m._retryCountdown - 1
    end sub
    RBS_CC_5_reportLine("1708", 1)
    prototype._retryBeacon = sub()
        ' If we have a retry, do it when ready
        if RBS_CC_5_reportLine("1710", 2) and (m._beaconRetryDelay = invalid or m._beaconAttemptTimespan = invalid) then
            RBS_CC_5_reportLine("1710", 3)
            RBS_CC_5_reportLine("1710", 1)
            return
        end if
        if RBS_CC_5_reportLine("1712", 2) and (m._beaconAttemptTimespan.TotalMilliseconds() >= m._beaconRetryDelay)
            RBS_CC_5_reportLine("1712", 3)
            RBS_CC_5_reportLine("1713", 1)
            m._makeRequest()
        end if
    end sub
    RBS_CC_5_reportLine("1717", 1)
    prototype._startView = sub(setByClient = false as boolean)
        if RBS_CC_5_reportLine("1718", 2) and (setByClient = true)
            RBS_CC_5_reportLine("1718", 3)
            RBS_CC_5_reportLine("1719", 1)
            m._clientOperatedStartAndEnd = true
        end if
        if RBS_CC_5_reportLine("1721", 2) and (m._clientOperatedStartAndEnd = true and setByClient = false) then
            RBS_CC_5_reportLine("1721", 3)
            RBS_CC_5_reportLine("1721", 1)
            return
        end if
        if RBS_CC_5_reportLine("1722", 2) and (m._inView = false)
            RBS_CC_5_reportLine("1722", 3)
            RBS_CC_5_reportLine("1723", 1)
            m.heartbeatTimer.control = "start"
            RBS_CC_5_reportLine("1724", 1)
            m._Flag_heartbeatTimerRunning = true
            RBS_CC_5_reportLine("1725", 1)
            m.pollTimer.control = "start"
            RBS_CC_5_reportLine("1726", 1)
            m._viewSequence = 0
            if RBS_CC_5_reportLine("1727", 2) and (m._playerViewCount <> invalid)
                RBS_CC_5_reportLine("1727", 3)
                RBS_CC_5_reportLine("1728", 1)
                m._playerViewCount++
            end if
            RBS_CC_5_reportLine("1730", 1)
            m._viewId = m._generateGUID()
            RBS_CC_5_reportLine("1731", 1)
            m._viewWatchTime = 0
            RBS_CC_5_reportLine("1732", 1)
            m._adWatchTime = 0
            RBS_CC_5_reportLine("1733", 1)
            m._totalAdWatchTime = 0
            RBS_CC_5_reportLine("1734", 1)
            m._cumulativePlayingTime = 0
            RBS_CC_5_reportLine("1735", 1)
            m._contentPlaybackTime = 0
            RBS_CC_5_reportLine("1736", 1)
            m._viewRebufferCount = 0
            RBS_CC_5_reportLine("1737", 1)
            m._viewRebufferDuration = 0
            RBS_CC_5_reportLine("1738", 1)
            m._viewSeekCount = 0
            RBS_CC_5_reportLine("1739", 1)
            m._viewSeekDuration = 0#
            RBS_CC_5_reportLine("1740", 1)
            m._viewAdPlayedCount = 0
            RBS_CC_5_reportLine("1741", 1)
            m._viewPrerollPlayedCount = 0
            RBS_CC_5_reportLine("1743", 1)
            m._lastSourceWidth = 0
            RBS_CC_5_reportLine("1744", 1)
            m._lastSourceHeight = 0
            RBS_CC_5_reportLine("1745", 1)
            m._totalBytes = 0
            RBS_CC_5_reportLine("1746", 1)
            m._totalLoadTime = 0
            RBS_CC_5_reportLine("1747", 1)
            m._segmentRequestCount = 0
            RBS_CC_5_reportLine("1748", 1)
            m._segmentRequestFailedCount = 0
            RBS_CC_5_reportLine("1749", 1)
            m._viewApiEncryptionRequestCount = 0
            RBS_CC_5_reportLine("1750", 1)
            m._requestCompletedCount = 0
            RBS_CC_5_reportLine("1751", 1)
            m._totalLatency = 0
            RBS_CC_5_reportLine("1753", 1)
            m._playbackRanges = []
            RBS_CC_5_reportLine("1754", 1)
            m._currentPlaybackRangeStart = invalid
            RBS_CC_5_reportLine("1756", 1)
            m._Flag_lastReportedPosition = 0
            RBS_CC_5_reportLine("1757", 1)
            m._Flag_atLeastOnePlayEventForContent = false
            RBS_CC_5_reportLine("1758", 1)
            m._Flag_isSeeking = false
            RBS_CC_5_reportLine("1759", 1)
            date = m._getDateTime()
            RBS_CC_5_reportLine("1760", 1)
            m._viewStartTimestamp = 0# + date.AsSeconds() * 1000.0# + date.GetMilliseconds()
            if RBS_CC_5_reportLine("1762", 2) and (m.video <> invalid)
                RBS_CC_5_reportLine("1762", 3)
                if RBS_CC_5_reportLine("1763", 2) and (m.video.content <> invalid)
                    RBS_CC_5_reportLine("1763", 3)
                    if RBS_CC_5_reportLine("1764", 2) and (m.video.contentIsPlaylist)
                        RBS_CC_5_reportLine("1764", 3)
                        RBS_CC_5_reportLine("1765", 1)
                        m._videoContentProperties = m._getVideoContentProperties(m.video.content.getChild(m.video.contentIndex))
                    else
                        RBS_CC_5_reportLine("1766", 3)
                        RBS_CC_5_reportLine("1767", 1)
                        m._videoContentProperties = m._getVideoContentProperties(m.video.content)
                    end if
                end if
                RBS_CC_5_reportLine("1770", 1)
                m._videoProperties = m._getVideoProperties(m.video)
            end if
            ' Send playbackmodechange event
            RBS_CC_5_reportLine("1774", 1)
            props = {}
            RBS_CC_5_reportLine("1775", 1)
            props.player_playback_mode = "standard"
            RBS_CC_5_reportLine("1776", 1)
            props.view_playing_time_ms_cumulative = m._cumulativePlayingTime
            RBS_CC_5_reportLine("1777", 1)
            props.ad_playing_time_ms_cumulative = m._totalAdWatchTime
            RBS_CC_5_reportLine("1778", 1)
            m._addEventToQueue(m._createEvent("playbackmodechange", props))
            ' Fire initial networkchange event
            RBS_CC_5_reportLine("1781", 1)
            initialConnectionType = _getConnectionType(m.deviceInfo)
            RBS_CC_5_reportLine("1782", 1)
            m._lastConnectionType = initialConnectionType
            RBS_CC_5_reportLine("1783", 1)
            m._fireNetworkChangeEvent(initialConnectionType)
            RBS_CC_5_reportLine("1785", 1)
            m._addEventToQueue(m._createEvent("viewstart"))
            RBS_CC_5_reportLine("1787", 1)
            m._inView = true
        end if
    end sub
    RBS_CC_5_reportLine("1791", 1)
    prototype._endView = sub(setByClient = false as boolean)
        if RBS_CC_5_reportLine("1792", 2) and (m._clientOperatedStartAndEnd = true and setByClient = false) then
            RBS_CC_5_reportLine("1792", 3)
            RBS_CC_5_reportLine("1792", 1)
            return
        end if
        if RBS_CC_5_reportLine("1793", 2) and (m._clientOperatedStartAndEnd = false and setByClient = true) then
            RBS_CC_5_reportLine("1793", 3)
            RBS_CC_5_reportLine("1793", 1)
            return
        end if
        if RBS_CC_5_reportLine("1794", 2) and (m._inView = true)
            RBS_CC_5_reportLine("1794", 3)
            RBS_CC_5_reportLine("1795", 1)
            m.heartbeatTimer.control = "stop"
            RBS_CC_5_reportLine("1796", 1)
            m._Flag_heartbeatTimerRunning = false
            RBS_CC_5_reportLine("1797", 1)
            m.pollTimer.control = "stop"
            RBS_CC_5_reportLine("1799", 1)
            m._endPlaybackRange(m._playerPlayheadTime)
            RBS_CC_5_reportLine("1800", 1)
            m._addEventToQueue(m._createEvent("viewend"))
            RBS_CC_5_reportLine("1801", 1)
            m._inView = false
            RBS_CC_5_reportLine("1802", 1)
            m._viewId = invalid
            RBS_CC_5_reportLine("1803", 1)
            m._viewStartTimestamp = invalid
            RBS_CC_5_reportLine("1804", 1)
            m._viewSequence = invalid
            RBS_CC_5_reportLine("1805", 1)
            m._playerPlayheadTime = invalid
            RBS_CC_5_reportLine("1806", 1)
            m._viewTimeToFirstFrame = invalid
            RBS_CC_5_reportLine("1807", 1)
            m._playerTimeToFirstFrame = invalid
            RBS_CC_5_reportLine("1808", 1)
            m._contentPlaybackTime = invalid
            RBS_CC_5_reportLine("1809", 1)
            m._viewWatchTime = invalid
            RBS_CC_5_reportLine("1810", 1)
            m._adWatchTime = invalid
            RBS_CC_5_reportLine("1811", 1)
            m._lastAdResumeTime = invalid
            RBS_CC_5_reportLine("1812", 1)
            m._totalAdWatchTime = invalid
            RBS_CC_5_reportLine("1813", 1)
            m._cumulativePlayingTime = invalid
            RBS_CC_5_reportLine("1814", 1)
            m._viewRebufferCount = invalid
            RBS_CC_5_reportLine("1815", 1)
            m._viewRebufferDuration = invalid
            RBS_CC_5_reportLine("1816", 1)
            m._viewRebufferFrequency! = invalid
            RBS_CC_5_reportLine("1817", 1)
            m._viewRebufferPercentage = invalid
            RBS_CC_5_reportLine("1818", 1)
            m._viewSeekCount = invalid
            RBS_CC_5_reportLine("1819", 1)
            m._viewSeekDuration = invalid
            RBS_CC_5_reportLine("1820", 1)
            m._viewAdPlayedCount = invalid
            RBS_CC_5_reportLine("1821", 1)
            m._viewPrerollPlayedCount = invalid
            RBS_CC_5_reportLine("1822", 1)
            m._videoSourceFormat = invalid
            RBS_CC_5_reportLine("1823", 1)
            m._videoSourceDuration = invalid
            RBS_CC_5_reportLine("1824", 1)
            m._videoCurrentCdn = invalid
            RBS_CC_5_reportLine("1825", 1)
            m.drmType = invalid
            RBS_CC_5_reportLine("1826", 1)
            m.droppedFrames = invalid
            RBS_CC_5_reportLine("1828", 1)
            m._lastSourceWidth = invalid
            RBS_CC_5_reportLine("1829", 1)
            m._lastSourceHeight = invalid
            RBS_CC_5_reportLine("1830", 1)
            m._lastPlayheadPosition = invalid
            RBS_CC_5_reportLine("1831", 1)
            m._lastVideoSegmentBitrate = invalid
            RBS_CC_5_reportLine("1832", 1)
            m._viewMaxUpscalePercentage = invalid
            RBS_CC_5_reportLine("1833", 1)
            m._viewMaxDownscalePercentage = invalid
            RBS_CC_5_reportLine("1834", 1)
            m._viewTotalUpscaling = invalid
            RBS_CC_5_reportLine("1835", 1)
            m._viewTotalDownscaling = invalid
            RBS_CC_5_reportLine("1836", 1)
            m._viewTotalContentPlaybackTime = invalid
            RBS_CC_5_reportLine("1837", 1)
            m._totalBytes = invalid
            RBS_CC_5_reportLine("1838", 1)
            m._totalLoadTime = invalid
            RBS_CC_5_reportLine("1839", 1)
            m._segmentRequestCount = invalid
            RBS_CC_5_reportLine("1840", 1)
            m._viewMinRequestThroughput = invalid
            RBS_CC_5_reportLine("1841", 1)
            m._viewAverageRequestThroughput = invalid
            RBS_CC_5_reportLine("1842", 1)
            m._viewRequestCount = invalid
            RBS_CC_5_reportLine("1843", 1)
            m._segmentRequestFailedCount = invalid
            RBS_CC_5_reportLine("1844", 1)
            m._lastConnectionType = invalid
            RBS_CC_5_reportLine("1845", 1)
            m._viewApiEncryptionRequestCount = invalid
            RBS_CC_5_reportLine("1846", 1)
            m._requestCompletedCount = invalid
            RBS_CC_5_reportLine("1847", 1)
            m._totalLatency = invalid
            RBS_CC_5_reportLine("1848", 1)
            m._viewMaxRequestLatency = invalid
            RBS_CC_5_reportLine("1849", 1)
            m._viewAverageRequestLatency = invalid
        end if
    end sub
    RBS_CC_5_reportLine("1853", 1)
    prototype._createEvent = function(eventType as string, eventProperties = {} as object) as object
        RBS_CC_5_reportLine("1854", 1)
        newEvent = {}
        if RBS_CC_5_reportLine("1856", 2) and (m._playerSequence <> invalid)
            RBS_CC_5_reportLine("1856", 3)
            RBS_CC_5_reportLine("1857", 1)
            m._playerSequence++
        end if
        if RBS_CC_5_reportLine("1860", 2) and (m._viewSequence <> invalid)
            RBS_CC_5_reportLine("1860", 3)
            RBS_CC_5_reportLine("1861", 1)
            m._viewSequence++
        end if
        ' session properties are set once per player session
        if RBS_CC_5_reportLine("1865", 2) and (m._sessionProperties <> invalid)
            RBS_CC_5_reportLine("1865", 3)
            RBS_CC_5_reportLine("1866", 1)
            newEvent.Append(m._sessionProperties)
        end if
        ' video content properties are checked once per view
        if RBS_CC_5_reportLine("1870", 2) and (m._videoContentProperties <> invalid)
            RBS_CC_5_reportLine("1870", 3)
            RBS_CC_5_reportLine("1871", 1)
            newEvent.Append(m._videoContentProperties)
        end if
        'actual video values overwrite video content values such as duration
        if RBS_CC_5_reportLine("1875", 2) and (m._videoProperties <> invalid)
            RBS_CC_5_reportLine("1875", 3)
            RBS_CC_5_reportLine("1876", 1)
            newEvent.Append(m._videoProperties)
        end if
        'advert properties are checked during ad events
        if RBS_CC_5_reportLine("1880", 2) and (m._advertProperties <> invalid)
            RBS_CC_5_reportLine("1880", 3)
            RBS_CC_5_reportLine("1881", 1)
            newEvent.Append(m._advertProperties)
        end if
        'dynamic properties are checked during every event
        RBS_CC_5_reportLine("1885", 1)
        dynamicProperties = m._getDynamicProperties()
        RBS_CC_5_reportLine("1886", 1)
        newEvent.Append(dynamicProperties)
        RBS_CC_5_reportLine("1887", 1)
        newEvent.Append(eventProperties)
        'customer can overwrite ALL properties should they wish'
        if RBS_CC_5_reportLine("1890", 2) and (m._configProperties <> invalid)
            RBS_CC_5_reportLine("1890", 3)
            RBS_CC_5_reportLine("1891", 1)
            newEvent.Append(m._configProperties)
        end if
        ' Warn if env_key is not set
        if RBS_CC_5_reportLine("1894", 2) and (newEvent.env_key = invalid or newEvent.env_key = "")
            RBS_CC_5_reportLine("1894", 3)
            if RBS_CC_5_reportLine("1895", 2) and (m._playerSequence <> invalid and m._playerSequence < 2)
                RBS_CC_5_reportLine("1895", 3)
                RBS_CC_5_reportLine("1896", 1)
                print "[mux-analytics] warning env_key not set."
            end if
        end if
        RBS_CC_5_reportLine("1900", 1)
        date = m._getDateTime()
        RBS_CC_5_reportLine("1901", 1)
        newEvent.viewer_time = FormatJson(0# + date.AsSeconds() * 1000.0# + date.GetMilliseconds())
        RBS_CC_5_reportLine("1903", 1)
        newEvent.event = eventType
        RBS_CC_5_reportLine("1904", 1)
        return newEvent
    end function
    ' called once per application session'
    RBS_CC_5_reportLine("1908", 1)
    prototype._getSessionProperties = function() as object
        RBS_CC_5_reportLine("1909", 1)
        props = {}
        RBS_CC_5_reportLine("1910", 1)
        deviceInfo = m._getDeviceInfo()
        RBS_CC_5_reportLine("1911", 1)
        appInfo = m._getAppInfo()
        RBS_CC_5_reportLine("1912", 1)
        firmwareVersion = _firmwareVersionNumber(deviceInfo)
        ' HARDCODED
        RBS_CC_5_reportLine("1915", 1)
        props.player_sequence_number = 1
        RBS_CC_5_reportLine("1916", 1)
        props.player_software_name = m.PLAYER_SOFTWARE_NAME
        RBS_CC_5_reportLine("1917", 1)
        props.player_software_version = firmwareVersion
        RBS_CC_5_reportLine("1918", 1)
        props.viewer_application_name = appInfo.GetTitle() ' let them override
        RBS_CC_5_reportLine("1919", 1)
        props.viewer_application_version = appInfo.GetVersion()
        RBS_CC_5_reportLine("1920", 1)
        props.viewer_device_name = deviceInfo.GetModelDisplayName()
        RBS_CC_5_reportLine("1921", 1)
        props.viewer_device_category = "tv"
        RBS_CC_5_reportLine("1922", 1)
        props.viewer_device_manufacturer = deviceInfo.GetModelDetails()["VendorName"]
        ' If GetModel() is invalid, try the specific model number
        RBS_CC_5_reportLine("1924", 1)
        seriesModel = deviceInfo.GetModel()
        if RBS_CC_5_reportLine("1925", 2) and (seriesModel = invalid)
            RBS_CC_5_reportLine("1925", 3)
            RBS_CC_5_reportLine("1926", 1)
            seriesModel = deviceInfo.GetModelDetails()["ModelNumber"]
        end if
        RBS_CC_5_reportLine("1928", 1)
        props.viewer_device_model = seriesModel
        RBS_CC_5_reportLine("1929", 1)
        props.viewer_os_family = "Roku OS"
        RBS_CC_5_reportLine("1930", 1)
        props.viewer_os_version = firmwareVersion
        RBS_CC_5_reportLine("1931", 1)
        connectionType = _getConnectionType(deviceInfo)
        if RBS_CC_5_reportLine("1932", 2) and (connectionType <> invalid)
            RBS_CC_5_reportLine("1932", 3)
            RBS_CC_5_reportLine("1933", 1)
            props.viewer_connection_type = connectionType
        end if
        RBS_CC_5_reportLine("1935", 1)
        props.mux_api_version = m.MUX_API_VERSION
        RBS_CC_5_reportLine("1936", 1)
        props.player_mux_plugin_name = m.MUX_SDK_NAME
        RBS_CC_5_reportLine("1937", 1)
        props.player_mux_plugin_version = m.MUX_SDK_VERSION
        RBS_CC_5_reportLine("1938", 1)
        props.player_language_code = deviceInfo.GetCurrentLocale()
        RBS_CC_5_reportLine("1939", 1)
        videoMode = deviceInfo.GetVideoMode()
        RBS_CC_5_reportLine("1940", 1)
        props.player_width = m._getVideoPlaybackMetric(videoMode, "width")
        RBS_CC_5_reportLine("1941", 1)
        props.player_height = m._getVideoPlaybackMetric(videoMode, "height")
        RBS_CC_5_reportLine("1942", 1)
        props.player_is_fullscreen = m.PLAYER_IS_FULLSCREEN
        RBS_CC_5_reportLine("1943", 1)
        props.beacon_domain = m._getDomain(m.beaconUrl)
        ' We are moving towards using GUID style instance IDs
        RBS_CC_5_reportLine("1946", 1)
        props.player_instance_id = m._generateGUID()
        ' DEVICE INFO
        if RBS_CC_5_reportLine("1948", 2) and (m._Flag_useRandomMuxViewerId)
            RBS_CC_5_reportLine("1948", 3)
            RBS_CC_5_reportLine("1949", 1)
            props.mux_viewer_id = m._generateGUID()
        else
            RBS_CC_5_reportLine("1950", 3)
            RBS_CC_5_reportLine("1951", 1)
            props.mux_viewer_id = deviceInfo.GetRIDA()
        end if
        RBS_CC_5_reportLine("1953", 1)
        return props
    end function
    ' called once per video'
    RBS_CC_5_reportLine("1957", 1)
    prototype._getVideoProperties = function(video as object) as object
        RBS_CC_5_reportLine("1958", 1)
        props = {}
        if RBS_CC_5_reportLine("1959", 2) and (video <> invalid)
            RBS_CC_5_reportLine("1959", 3)
            if RBS_CC_5_reportLine("1960", 2) and (video.duration <> invalid and video.duration > 0)
                RBS_CC_5_reportLine("1960", 3)
                RBS_CC_5_reportLine("1961", 1)
                m._videoSourceDuration = video.duration * 1000
            end if
            if RBS_CC_5_reportLine("1964", 2) and (video.videoFormat <> invalid and video.videoFormat <> "")
                RBS_CC_5_reportLine("1964", 3)
                RBS_CC_5_reportLine("1965", 1)
                m._videoSourceFormat = video.videoFormat
            end if
            if RBS_CC_5_reportLine("1968", 2) and (video.audioFormat <> invalid and video.audioFormat <> "")
                RBS_CC_5_reportLine("1968", 3)
                RBS_CC_5_reportLine("1969", 1)
                m._audioSourceFormat = video.audioFormat
            end if
        end if
        RBS_CC_5_reportLine("1973", 1)
        return props
    end function
    ' Set called per video content'
    RBS_CC_5_reportLine("1977", 1)
    prototype._getVideoContentProperties = function(incomingContent as object) as object
        RBS_CC_5_reportLine("1978", 1)
        props = {}
        if RBS_CC_5_reportLine("1979", 2) and (incomingContent <> invalid)
            RBS_CC_5_reportLine("1979", 3)
            RBS_CC_5_reportLine("1980", 1)
            content = incomingContent.GetFields()
            if RBS_CC_5_reportLine("1981", 2) and (content.title <> invalid and (type(content.title) = "String" or type(content.title) = "roString") and content.title <> "")
                RBS_CC_5_reportLine("1981", 3)
                RBS_CC_5_reportLine("1982", 1)
                props.video_title = content.title
            end if
            if RBS_CC_5_reportLine("1984", 2) and (content.TitleSeason <> invalid and (type(content.TitleSeason) = "String" or type(content.TitleSeason) = "roString") and content.TitleSeason <> "")
                RBS_CC_5_reportLine("1984", 3)
                RBS_CC_5_reportLine("1985", 1)
                props.video_series = content.TitleSeason
            end if
            if RBS_CC_5_reportLine("1987", 2) and (content.Director <> invalid and (type(content.Director) = "String" or type(content.Director) = "roString") and content.Director <> "")
                RBS_CC_5_reportLine("1987", 3)
                RBS_CC_5_reportLine("1988", 1)
                props.video_producer = content.Director
            end if
            if RBS_CC_5_reportLine("1990", 2) and (content.video_id <> invalid and (type(content.video_id) = "String" or type(content.video_id) = "roString") and content.video_id <> "")
                RBS_CC_5_reportLine("1990", 3)
                RBS_CC_5_reportLine("1991", 1)
                props.video_id = content.video_id
            end if
            if RBS_CC_5_reportLine("1993", 2) and (content.ContentType <> invalid)
                RBS_CC_5_reportLine("1993", 3)
                if RBS_CC_5_reportLine("1994", 2) and (type(content.ContentType) = "roInt")
                    RBS_CC_5_reportLine("1994", 3)
                    if RBS_CC_5_reportLine("1995", 2) and (content.ContentType = 1)
                        RBS_CC_5_reportLine("1995", 3)
                        RBS_CC_5_reportLine("1996", 1)
                        props.video_content_type = "movie"
                    else if RBS_CC_5_reportLine("1997", 2) and (content.ContentType = 2)
                        RBS_CC_5_reportLine("1997", 3)
                        RBS_CC_5_reportLine("1998", 1)
                        props.video_content_type = "series"
                    else if RBS_CC_5_reportLine("1999", 2) and (content.ContentType = 3)
                        RBS_CC_5_reportLine("1999", 3)
                        RBS_CC_5_reportLine("2000", 1)
                        props.video_content_type = "season"
                    else if RBS_CC_5_reportLine("2001", 2) and (content.ContentType = 4)
                        RBS_CC_5_reportLine("2001", 3)
                        RBS_CC_5_reportLine("2002", 1)
                        props.video_content_type = "episode"
                    else if RBS_CC_5_reportLine("2003", 2) and (content.ContentType = 5)
                        RBS_CC_5_reportLine("2003", 3)
                        RBS_CC_5_reportLine("2004", 1)
                        props.video_content_type = "audio"
                    end if
                else
                    RBS_CC_5_reportLine("2006", 3)
                    RBS_CC_5_reportLine("2007", 1)
                    props.video_content_type = content.ContentType
                end if
            end if
            if RBS_CC_5_reportLine("2011", 2) and (content.URL <> invalid and content.URL <> "")
                RBS_CC_5_reportLine("2011", 3)
                RBS_CC_5_reportLine("2012", 1)
                props.video_source_url = content.URL
                RBS_CC_5_reportLine("2013", 1)
                props.video_source_hostname = m._getHostname(content.URL)
                RBS_CC_5_reportLine("2014", 1)
                props.video_source_domain = m._getDomain(content.URL)
                if RBS_CC_5_reportLine("2015", 2) and (m._videoSourceFormat = invalid or m._videoSourceFormat = "")
                    RBS_CC_5_reportLine("2015", 3)
                    RBS_CC_5_reportLine("2016", 1)
                    m._videoSourceFormat = m._getVideoFormat(content.URL)
                end if
            end if
            if RBS_CC_5_reportLine("2020", 2) and (content.StreamFormat <> invalid and (type(content.StreamFormat) = "String" or type(content.StreamFormat) = "roString") and content.StreamFormat <> "(null)")
                RBS_CC_5_reportLine("2020", 3)
                RBS_CC_5_reportLine("2021", 1)
                props.video_source_mime_type = m._convertStreamFormat(content.StreamFormat)
            end if
            if RBS_CC_5_reportLine("2024", 2) and (content.Live <> invalid)
                RBS_CC_5_reportLine("2024", 3)
                if RBS_CC_5_reportLine("2025", 2) and (content.Live = true)
                    RBS_CC_5_reportLine("2025", 3)
                    RBS_CC_5_reportLine("2026", 1)
                    props.video_source_is_live = "true"
                else
                    RBS_CC_5_reportLine("2027", 3)
                    RBS_CC_5_reportLine("2028", 1)
                    props.video_source_is_live = "false"
                end if
            end if
            if RBS_CC_5_reportLine("2031", 2) and (content.Length <> invalid and content.Length > 0)
                RBS_CC_5_reportLine("2031", 3)
                RBS_CC_5_reportLine("2032", 1)
                m._videoSourceDuration = content.Length * 1000
            end if
        end if
        RBS_CC_5_reportLine("2036", 1)
        return props
    end function
    ' called once per advert session'
    RBS_CC_5_reportLine("2040", 1)
    prototype._getAdvertProperties = function(adData as object) as object
        RBS_CC_5_reportLine("2041", 1)
        props = {}
        if RBS_CC_5_reportLine("2042", 2) and (adData <> invalid)
            RBS_CC_5_reportLine("2042", 3)
            RBS_CC_5_reportLine("2043", 1)
            ad = adData.ad
            RBS_CC_5_reportLine("2044", 1)
            adIndex = adData.adIndex
            RBS_CC_5_reportLine("2045", 1)
            adTagUrl = adData.adTagUrl
            if RBS_CC_5_reportLine("2046", 2) and (ad <> invalid)
                RBS_CC_5_reportLine("2046", 3)
                if RBS_CC_5_reportLine("2047", 2) and (adIndex <> invalid and adIndex = 1)
                    RBS_CC_5_reportLine("2047", 3) 'preroll only'
                    if RBS_CC_5_reportLine("2048", 2) and (ad.streams <> invalid)
                        RBS_CC_5_reportLine("2048", 3)
                        if RBS_CC_5_reportLine("2049", 2) and (ad.streams.count() > 0)
                            RBS_CC_5_reportLine("2049", 3)
                            if RBS_CC_5_reportLine("2050", 2) and (ad.streams[0].url <> invalid)
                                RBS_CC_5_reportLine("2050", 3)
                                RBS_CC_5_reportLine("2051", 1)
                                adUrl = ad.streams[0].url
                                if RBS_CC_5_reportLine("2052", 2) and (adUrl <> invalid and adUrl <> "")
                                    RBS_CC_5_reportLine("2052", 3)
                                    RBS_CC_5_reportLine("2053", 1)
                                    props.view_preroll_ad_asset_hostname = m._getHostname(adUrl)
                                    RBS_CC_5_reportLine("2054", 1)
                                    props.view_preroll_ad_asset_domain = m._getDomain(adUrl)
                                end if
                            end if
                        end if
                    end if
                end if
            end if
            if RBS_CC_5_reportLine("2061", 2) and (adTagUrl <> invalid and adTagUrl <> "")
                RBS_CC_5_reportLine("2061", 3)
                RBS_CC_5_reportLine("2062", 1)
                props.view_preroll_ad_tag_hostname = m._getHostname(adTagUrl)
                RBS_CC_5_reportLine("2063", 1)
                props.view_preroll_ad_tag_domain = m._getDomain(adTagUrl)
            end if
            if RBS_CC_5_reportLine("2065", 2) and (adData.mux <> invalid)
                RBS_CC_5_reportLine("2065", 3)
                if RBS_CC_5_reportLine("2066", 2) and (adData.mux.ad_type <> invalid)
                    RBS_CC_5_reportLine("2066", 3)
                    RBS_CC_5_reportLine("2067", 1)
                    props.ad_type = adData.mux.ad_type
                end if
            end if
        end if
        RBS_CC_5_reportLine("2071", 1)
        return props
    end function
    ' called once per event
    ' Note - when a number that _should_ be an integer is copied over,
    ' we force it into that format to help FormatJson do its job correctly
    ' later. Also, timestamps need to be `FormatJson`d immediately to
    ' try to make sure those don't get into scientific notation
    RBS_CC_5_reportLine("2079", 1)
    prototype._getDynamicProperties = function() as object
        RBS_CC_5_reportLine("2080", 1)
        props = {}
        if RBS_CC_5_reportLine("2081", 2) and (m.video <> invalid)
            RBS_CC_5_reportLine("2081", 3)
            if RBS_CC_5_reportLine("2082", 2) and (m._Flag_isPaused = true)
                RBS_CC_5_reportLine("2082", 3)
                RBS_CC_5_reportLine("2083", 1)
                props.player_is_paused = "true"
            else
                RBS_CC_5_reportLine("2084", 3)
                RBS_CC_5_reportLine("2085", 1)
                props.player_is_paused = "false"
            end if
            if RBS_CC_5_reportLine("2087", 2) and (m._playerTimeToFirstFrame = invalid and m.video.timeToStartStreaming <> invalid and m.video.timeToStartStreaming <> 0)
                RBS_CC_5_reportLine("2087", 3)
                RBS_CC_5_reportLine("2088", 1)
                m._playerTimeToFirstFrame = Int(m.video.timeToStartStreaming * 1000)
                RBS_CC_5_reportLine("2089", 1)
                props.player_time_to_first_frame = m._playerTimeToFirstFrame
            end if
            if RBS_CC_5_reportLine("2091", 2) and (m._playerPlayheadTime <> invalid)
                RBS_CC_5_reportLine("2091", 3)
                RBS_CC_5_reportLine("2092", 1)
                props.player_playhead_time = Int(m._playerPlayheadTime * 1000)
            end if
        end if
        if RBS_CC_5_reportLine("2095", 2) and (m.drmType <> invalid)
            RBS_CC_5_reportLine("2095", 3)
            RBS_CC_5_reportLine("2096", 1)
            props.view_drm_type = m.drmType
        end if
        if RBS_CC_5_reportLine("2098", 2) and (m.droppedFrames <> invalid)
            RBS_CC_5_reportLine("2098", 3)
            RBS_CC_5_reportLine("2099", 1)
            props.view_dropped_frames_count = m.droppedFrames
        end if
        if RBS_CC_5_reportLine("2101", 2) and (m._playerSequence <> invalid and m._playerSequence <> 0)
            RBS_CC_5_reportLine("2101", 3)
            RBS_CC_5_reportLine("2102", 1)
            props.player_sequence_number = Int(m._playerSequence)
        end if
        if RBS_CC_5_reportLine("2104", 2) and (m._playerViewCount <> invalid and m._playerViewCount <> 0)
            RBS_CC_5_reportLine("2104", 3)
            RBS_CC_5_reportLine("2105", 1)
            props.player_view_count = Int(m._playerViewCount)
        end if
        if RBS_CC_5_reportLine("2107", 2) and (m._viewSequence <> invalid and m._viewSequence <> 0)
            RBS_CC_5_reportLine("2107", 3)
            RBS_CC_5_reportLine("2108", 1)
            props.view_sequence_number = Int(m._viewSequence)
        end if
        if RBS_CC_5_reportLine("2110", 2) and (m._viewID <> invalid and m._viewID <> "")
            RBS_CC_5_reportLine("2110", 3)
            RBS_CC_5_reportLine("2111", 1)
            props.view_id = m._viewID
        end if
        if RBS_CC_5_reportLine("2113", 2) and (m._startTimestamp <> invalid and m._startTimestamp <> 0)
            RBS_CC_5_reportLine("2113", 3)
            RBS_CC_5_reportLine("2114", 1)
            props.player_start = FormatJson(m._startTimestamp)
        end if
        if RBS_CC_5_reportLine("2116", 2) and (m._viewStartTimestamp <> invalid and m._viewStartTimestamp <> 0)
            RBS_CC_5_reportLine("2116", 3)
            RBS_CC_5_reportLine("2117", 1)
            props.view_start = FormatJson(m._viewStartTimestamp)
        end if
        if RBS_CC_5_reportLine("2119", 2) and (m._viewTimeToFirstFrame <> invalid and m._viewTimeToFirstFrame <> 0)
            RBS_CC_5_reportLine("2119", 3)
            RBS_CC_5_reportLine("2120", 1)
            props.view_time_to_first_frame = Int(m._viewTimeToFirstFrame)
        end if
        if RBS_CC_5_reportLine("2122", 2) and (m._contentPlaybackTime <> invalid and m._contentPlaybackTime <> 0)
            RBS_CC_5_reportLine("2122", 3)
            RBS_CC_5_reportLine("2123", 1)
            props.view_content_playback_time = Int(m._contentPlaybackTime)
            RBS_CC_5_reportLine("2124", 1)
            props.view_total_content_playback_time = Int(m._contentPlaybackTime)
        end if
        if RBS_CC_5_reportLine("2126", 2) and (m._viewWatchTime <> invalid and m._viewWatchTime <> 0)
            RBS_CC_5_reportLine("2126", 3)
            RBS_CC_5_reportLine("2127", 1)
            props.view_watch_time = Int(m._viewWatchTime)
        end if
        if RBS_CC_5_reportLine("2129", 2) and (m._viewRebufferCount <> invalid)
            RBS_CC_5_reportLine("2129", 3)
            RBS_CC_5_reportLine("2130", 1)
            props.view_rebuffer_count = Int(m._viewRebufferCount)
        end if
        if RBS_CC_5_reportLine("2132", 2) and (m._viewRebufferDuration <> invalid)
            RBS_CC_5_reportLine("2132", 3)
            RBS_CC_5_reportLine("2133", 1)
            props.view_rebuffer_duration = Int(m._viewRebufferDuration)
        end if
        if RBS_CC_5_reportLine("2135", 2) and (m._viewRebufferPercentage <> invalid)
            RBS_CC_5_reportLine("2135", 3)
            RBS_CC_5_reportLine("2136", 1)
            props.view_rebuffer_percentage = m._viewRebufferPercentage
        end if
        if RBS_CC_5_reportLine("2138", 2) and (m._viewRebufferFrequency! <> invalid)
            RBS_CC_5_reportLine("2138", 3)
            RBS_CC_5_reportLine("2139", 1)
            props.view_rebuffer_frequency = m._viewRebufferFrequency!
        end if
        if RBS_CC_5_reportLine("2141", 2) and (m._viewSeekCount <> invalid)
            RBS_CC_5_reportLine("2141", 3)
            RBS_CC_5_reportLine("2142", 1)
            props.view_seek_count = Int(m._viewSeekCount)
        end if
        if RBS_CC_5_reportLine("2144", 2) and (m._viewSeekDuration <> invalid)
            RBS_CC_5_reportLine("2144", 3)
            RBS_CC_5_reportLine("2145", 1)
            props.view_seek_duration = Int(m._viewSeekDuration)
        end if
        if RBS_CC_5_reportLine("2147", 2) and (m._viewAdPlayedCount <> invalid)
            RBS_CC_5_reportLine("2147", 3)
            RBS_CC_5_reportLine("2148", 1)
            props.view_ad_played_count = Int(m._viewAdPlayedCount)
        end if
        if RBS_CC_5_reportLine("2150", 2) and (m._viewPrerollPlayedCount <> invalid and m._viewPrerollPlayedCount > 0)
            RBS_CC_5_reportLine("2150", 3)
            RBS_CC_5_reportLine("2151", 1)
            props.view_preroll_played = "true"
        else
            RBS_CC_5_reportLine("2152", 3)
            RBS_CC_5_reportLine("2153", 1)
            props.view_preroll_played = "false"
        end if
        if RBS_CC_5_reportLine("2155", 2) and (m._videoSourceFormat <> invalid)
            RBS_CC_5_reportLine("2155", 3)
            RBS_CC_5_reportLine("2156", 1)
            props.video_source_format = m._videoSourceFormat
        end if
        if RBS_CC_5_reportLine("2158", 2) and (m._videoSourceDuration <> invalid)
            RBS_CC_5_reportLine("2158", 3)
            RBS_CC_5_reportLine("2159", 1)
            props.video_source_duration = Int(m._videoSourceDuration)
        end if
        if RBS_CC_5_reportLine("2161", 2) and (m._viewMaxUpscalePercentage <> invalid)
            RBS_CC_5_reportLine("2161", 3)
            RBS_CC_5_reportLine("2162", 1)
            props.view_max_upscale_percentage = m._viewMaxUpscalePercentage
        end if
        if RBS_CC_5_reportLine("2164", 2) and (m._viewMaxDownscalePercentage <> invalid)
            RBS_CC_5_reportLine("2164", 3)
            RBS_CC_5_reportLine("2165", 1)
            props.view_max_downscale_percentage = m._viewMaxDownscalePercentage
        end if
        if RBS_CC_5_reportLine("2167", 2) and (m._viewTotalContentPlaybackTime <> invalid)
            RBS_CC_5_reportLine("2167", 3)
            RBS_CC_5_reportLine("2168", 1)
            props.view_total_content_playback_time = m._viewTotalContentPlaybackTime
        end if
        if RBS_CC_5_reportLine("2170", 2) and (m._viewTotalUpscaling <> invalid)
            RBS_CC_5_reportLine("2170", 3)
            RBS_CC_5_reportLine("2171", 1)
            props.view_total_upscaling = m._viewTotalUpscaling
        end if
        if RBS_CC_5_reportLine("2173", 2) and (m._viewTotalDownscaling <> invalid)
            RBS_CC_5_reportLine("2173", 3)
            RBS_CC_5_reportLine("2174", 1)
            props.view_total_downscaling = m._viewTotalDownscaling
        end if
        if RBS_CC_5_reportLine("2176", 2) and (m._viewMinRequestThroughput <> invalid)
            RBS_CC_5_reportLine("2176", 3)
            RBS_CC_5_reportLine("2177", 1)
            props.view_min_request_throughput = FormatJson(m._viewMinRequestThroughput)
        end if
        if RBS_CC_5_reportLine("2179", 2) and (m._viewAverageRequestThroughput <> invalid)
            RBS_CC_5_reportLine("2179", 3)
            RBS_CC_5_reportLine("2180", 1)
            props.view_average_request_throughput = FormatJson(m._viewAverageRequestThroughput)
        end if
        if RBS_CC_5_reportLine("2182", 2) and (m._viewRequestCount <> invalid)
            RBS_CC_5_reportLine("2182", 3)
            RBS_CC_5_reportLine("2183", 1)
            props.view_request_count = m._viewRequestCount
        end if
        if RBS_CC_5_reportLine("2185", 2) and (m._viewMaxRequestLatency <> invalid)
            RBS_CC_5_reportLine("2185", 3)
            RBS_CC_5_reportLine("2186", 1)
            props.view_max_request_latency = Int(m._viewMaxRequestLatency)
        end if
        if RBS_CC_5_reportLine("2188", 2) and (m._viewAverageRequestLatency <> invalid)
            RBS_CC_5_reportLine("2188", 3)
            RBS_CC_5_reportLine("2189", 1)
            props.view_average_request_latency = Int(m._viewAverageRequestLatency)
        end if
        if RBS_CC_5_reportLine("2191", 2) and (m._cumulativePlayingTime <> invalid and m._cumulativePlayingTime > 0)
            RBS_CC_5_reportLine("2191", 3)
            RBS_CC_5_reportLine("2192", 1)
            props.view_playing_time_ms_cumulative = m._cumulativePlayingTime
        end if
        if RBS_CC_5_reportLine("2194", 2) and (m._totalAdWatchTime <> invalid and m._totalAdWatchTime > 0)
            RBS_CC_5_reportLine("2194", 3)
            RBS_CC_5_reportLine("2195", 1)
            props.ad_playing_time_ms_cumulative = m._totalAdWatchTime
        end if
        if RBS_CC_5_reportLine("2197", 2) and (m._playbackRanges <> invalid and m._playbackRanges.count() > 0)
            RBS_CC_5_reportLine("2197", 3)
            RBS_CC_5_reportLine("2198", 1)
            props.video_playback_range = m._stringifiedPlaybackRanges(m._playbackRanges)
        end if
        if RBS_CC_5_reportLine("2200", 2) and (m._configProperties <> invalid and m._configProperties.player_init_time <> invalid)
            RBS_CC_5_reportLine("2200", 3)
            RBS_CC_5_reportLine("2201", 1)
            playerInitTime = invalid
            if RBS_CC_5_reportLine("2202", 2) and (Type(m._configProperties.player_init_time) = "roString")
                RBS_CC_5_reportLine("2202", 3)
                RBS_CC_5_reportLine("2203", 1)
                playerInitTime = Val(m._configProperties.player_init_time)
            else if RBS_CC_5_reportLine("2204", 2) and (Type(m._configProperties.player_init_time) = "roFloat")
                RBS_CC_5_reportLine("2204", 3)
                RBS_CC_5_reportLine("2205", 1)
                playerInitTime = m._configProperties.player_init_time
            end if
            if RBS_CC_5_reportLine("2208", 2) and (playerInitTime <> invalid)
                RBS_CC_5_reportLine("2208", 3)
                if RBS_CC_5_reportLine("2209", 2) and (playerInitTime > 0)
                    RBS_CC_5_reportLine("2209", 3)
                    RBS_CC_5_reportLine("2210", 1)
                    props.player_startup_time = Int(m._startTimestamp - playerInitTime)
                    if RBS_CC_5_reportLine("2211", 2) and (m._viewTimeToFirstFrame <> invalid and m._viewTimeToFirstFrame <> 0)
                        RBS_CC_5_reportLine("2211", 3)
                        RBS_CC_5_reportLine("2212", 1)
                        props.view_aggregate_startup_time = Int(m._viewTimeToFirstFrame + (m._startTimestamp - playerInitTime))
                    end if
                end if
            end if
        end if
        RBS_CC_5_reportLine("2218", 1)
        return props
    end function
    RBS_CC_5_reportLine("2221", 1)
    prototype._getDomain = function(url as string) as string
        RBS_CC_5_reportLine("2222", 1)
        domain = ""
        RBS_CC_5_reportLine("2223", 1)
        strippedUrl = url.Split("//")
        if RBS_CC_5_reportLine("2224", 2) and (strippedUrl.count() = 1)
            RBS_CC_5_reportLine("2224", 3)
            RBS_CC_5_reportLine("2225", 1)
            url = strippedUrl[0]
        else if RBS_CC_5_reportLine("2226", 2) and (strippedUrl.count() > 1)
            RBS_CC_5_reportLine("2226", 3)
            if RBS_CC_5_reportLine("2227", 2) and (strippedUrl[0].len() > 7)
                RBS_CC_5_reportLine("2227", 3)
                RBS_CC_5_reportLine("2228", 1)
                url = strippedUrl[0]
            else
                RBS_CC_5_reportLine("2229", 3)
                RBS_CC_5_reportLine("2230", 1)
                url = strippedUrl[1]
            end if
        end if
        RBS_CC_5_reportLine("2233", 1)
        splitRegex = CreateObject("roRegex", "[\/|\?|\#]", "")
        RBS_CC_5_reportLine("2234", 1)
        strippedUrl = splitRegex.Split(url)
        if RBS_CC_5_reportLine("2235", 2) and (strippedUrl.count() > 0)
            RBS_CC_5_reportLine("2235", 3)
            RBS_CC_5_reportLine("2236", 1)
            url = strippedUrl[0]
        end if
        RBS_CC_5_reportLine("2238", 1)
        domainRegex = CreateObject("roRegex", "([a-z0-9\-]+)\.([a-z0-9\-]+|[a-z0-9\-]{2}\.[a-z0-9\-]+)$", "i")
        RBS_CC_5_reportLine("2239", 1)
        matchResults = domainRegex.Match(url)
        if RBS_CC_5_reportLine("2240", 2) and (matchResults.count() > 0)
            RBS_CC_5_reportLine("2240", 3)
            RBS_CC_5_reportLine("2241", 1)
            domain = matchResults[0]
        end if
        RBS_CC_5_reportLine("2243", 1)
        return domain
    end function
    RBS_CC_5_reportLine("2246", 1)
    prototype._getHostname = function(url as string) as string
        RBS_CC_5_reportLine("2247", 1)
        host = ""
        RBS_CC_5_reportLine("2248", 1)
        hostRegex = CreateObject("roRegex", "([a-z0-9\-]+)(\.)([a-z0-9\-\.]+)", "i")
        RBS_CC_5_reportLine("2249", 1)
        matchResults = hostRegex.Match(url)
        if RBS_CC_5_reportLine("2250", 2) and (matchResults.count() > 0)
            RBS_CC_5_reportLine("2250", 3)
            RBS_CC_5_reportLine("2251", 1)
            host = matchResults[0]
        end if
        RBS_CC_5_reportLine("2253", 1)
        return host
    end function
    RBS_CC_5_reportLine("2256", 1)
    prototype._getHostnameAndPath = function(src as string) as string
        RBS_CC_5_reportLine("2257", 1)
        hostAndPath = src
        RBS_CC_5_reportLine("2258", 1)
        hostAndPathRegEx = CreateObject("roRegex", "^https?://", "")
        RBS_CC_5_reportLine("2259", 1)
        parts = hostAndPathRegEx.split(src)
        if RBS_CC_5_reportLine("2260", 2) and (parts <> invalid and parts.count() > 0)
            RBS_CC_5_reportLine("2260", 3)
            if RBS_CC_5_reportLine("2261", 2) and (parts.count() > 1)
                RBS_CC_5_reportLine("2261", 3)
                RBS_CC_5_reportLine("2262", 1)
                parts.shift()
            end if
            if RBS_CC_5_reportLine("2264", 2) and (parts.count() > 1)
                RBS_CC_5_reportLine("2264", 3)
                RBS_CC_5_reportLine("2265", 1)
                hostAndPath = parts.join()
            else
                RBS_CC_5_reportLine("2266", 3)
                RBS_CC_5_reportLine("2267", 1)
                hostAndPath = parts[0]
            end if
            RBS_CC_5_reportLine("2269", 1)
            hostAndPathRegEx = CreateObject("roRegex", "\?|#", "")
            RBS_CC_5_reportLine("2270", 1)
            parts = hostAndPathRegEx.split(hostAndPath)
            if RBS_CC_5_reportLine("2271", 2) and (parts.count() > 1)
                RBS_CC_5_reportLine("2271", 3)
                RBS_CC_5_reportLine("2272", 1)
                hostAndPath = parts[0]
            end if
        end if
        RBS_CC_5_reportLine("2275", 1)
        return hostAndPath
    end function
    RBS_CC_5_reportLine("2278", 1)
    prototype._convertStreamFormat = function(format as string) as string
        if RBS_CC_5_reportLine("2279", 2) and (format = "mp4")
            RBS_CC_5_reportLine("2279", 3)
            RBS_CC_5_reportLine("2280", 1)
            return "video/mp4"
        else if RBS_CC_5_reportLine("2281", 2) and (format = "wma")
            RBS_CC_5_reportLine("2281", 3)
            RBS_CC_5_reportLine("2282", 1)
            return "video/x-ms-wma"
        else if RBS_CC_5_reportLine("2283", 2) and (format = "mp3")
            RBS_CC_5_reportLine("2283", 3)
            RBS_CC_5_reportLine("2284", 1)
            return "audio/mpeg"
        else if RBS_CC_5_reportLine("2285", 2) and (format = "hls")
            RBS_CC_5_reportLine("2285", 3)
            RBS_CC_5_reportLine("2286", 1)
            return "application/x-mpegurl"
        else if RBS_CC_5_reportLine("2287", 2) and (format = "ism")
            RBS_CC_5_reportLine("2287", 3)
            RBS_CC_5_reportLine("2288", 1)
            return "application/vnd.ms-sstr+xml"
        else if RBS_CC_5_reportLine("2289", 2) and (format = "dash")
            RBS_CC_5_reportLine("2289", 3)
            RBS_CC_5_reportLine("2290", 1)
            return "application/dash+xml"
        else if RBS_CC_5_reportLine("2291", 2) and (format = "mkv")
            RBS_CC_5_reportLine("2291", 3)
            RBS_CC_5_reportLine("2292", 1)
            return "video/x-matroska"
        else if RBS_CC_5_reportLine("2293", 2) and (format = "mka")
            RBS_CC_5_reportLine("2293", 3)
            RBS_CC_5_reportLine("2294", 1)
            return "audio/x-matroska"
        else if RBS_CC_5_reportLine("2295", 2) and (format = "mks")
            RBS_CC_5_reportLine("2295", 3)
            RBS_CC_5_reportLine("2296", 1)
            return "video/x-matroska"
        else if RBS_CC_5_reportLine("2297", 2) and (format = "wmv")
            RBS_CC_5_reportLine("2297", 3)
            RBS_CC_5_reportLine("2298", 1)
            return "video/x-ms-wmv"
        else
            RBS_CC_5_reportLine("2299", 3)
            RBS_CC_5_reportLine("2300", 1)
            return format
        end if
    end function
    RBS_CC_5_reportLine("2304", 1)
    prototype._getVideoFormat = function(url as string) as string
        RBS_CC_5_reportLine("2305", 1)
        formatRegex = CreateObject("roRegex", "\*?\.([^\.]*?)(\?|\/$|$|#).*", "i")
        if RBS_CC_5_reportLine("2306", 2) and (formatRegex <> invalid)
            RBS_CC_5_reportLine("2306", 3)
            RBS_CC_5_reportLine("2307", 1)
            extension = formatRegex.Match(url)
            if RBS_CC_5_reportLine("2308", 2) and (extension <> invalid and extension.count() > 1)
                RBS_CC_5_reportLine("2308", 3)
                RBS_CC_5_reportLine("2309", 1)
                return extension[1]
            end if
        end if
        RBS_CC_5_reportLine("2313", 1)
        return "unknown"
    end function
    ' return format: Array of strings in the format "startTime:endTime" in milliseconds
    RBS_CC_5_reportLine("2317", 1)
    prototype._stringifiedPlaybackRanges = function(ranges as object) as object
        if RBS_CC_5_reportLine("2318", 2) and (ranges = invalid or ranges.count() = 0)
            RBS_CC_5_reportLine("2318", 3)
            RBS_CC_5_reportLine("2319", 1)
            return invalid
        end if
        ' Expects an array of objects with start and end properties
        RBS_CC_5_reportLine("2323", 1)
        result = []
        RBS_CC_5_reportLine("2324", 1): for each range in ranges
            if RBS_CC_5_reportLine("2325", 2) and (range.start <> invalid and range.end <> invalid)
                RBS_CC_5_reportLine("2325", 3)
                RBS_CC_5_reportLine("2326", 1)
                startMs = m._floatSecsToMillis(range.start)
                RBS_CC_5_reportLine("2327", 1)
                endMs = m._floatSecsToMillis(range.end)
                RBS_CC_5_reportLine("2328", 1)
                rangeStr = startMs.ToStr() + ":" + endMs.ToStr()
                RBS_CC_5_reportLine("2329", 1)
                result.push(rangeStr)
            end if
        end for
        RBS_CC_5_reportLine("2332", 1)
        return result
    end function
    RBS_CC_5_reportLine("2335", 1)
    prototype._startPlaybackRange = sub(startPlayheadTimeSec)
        if RBS_CC_5_reportLine("2336", 2) and (startPlayheadTimeSec = invalid)
            RBS_CC_5_reportLine("2336", 3)
            RBS_CC_5_reportLine("2337", 1)
            print "[mux-analytics] Warning: Attempted to start playback range with invalid start time"
            RBS_CC_5_reportLine("2338", 1)
            return
        end if
        ' only start a new playback range if one is not already open.
        if RBS_CC_5_reportLine("2342", 2) and (m._currentPlaybackRangeStart = invalid)
            RBS_CC_5_reportLine("2342", 3)
            RBS_CC_5_reportLine("2343", 1)
            m._currentPlaybackRangeStart = startPlayheadTimeSec
        else
            RBS_CC_5_reportLine("2344", 3)
            RBS_CC_5_reportLine("2345", 1)
            print "[mux-analytics] ignoring startPlaybackRange at " + Str(startPlayheadTimeSec) + ". range already open at " + Str(m._currentPlaybackRangeStart)
        end if
    end sub
    RBS_CC_5_reportLine("2349", 1)
    prototype._endPlaybackRange = sub(endingPlayheadTimeSec)
        if RBS_CC_5_reportLine("2350", 2) and (m._currentPlaybackRangeStart <> invalid and endingPlayheadTimeSec <> invalid)
            RBS_CC_5_reportLine("2350", 3)
            RBS_CC_5_reportLine("2351", 1)
            range = m._createPlaybackRange(m._currentPlaybackRangeStart, endingPlayheadTimeSec)
            if RBS_CC_5_reportLine("2352", 2) and (range <> invalid)
                RBS_CC_5_reportLine("2352", 3)
                RBS_CC_5_reportLine("2353", 1)
                m._playbackRanges.push(range)
            end if
            RBS_CC_5_reportLine("2356", 1)
            m._currentPlaybackRangeStart = invalid
        else
            RBS_CC_5_reportLine("2357", 3)
            RBS_CC_5_reportLine("2358", 1)
            print "[mux-analytics] Warning: Attempted to end playback range with invalid start or end time"
        end if
    end sub
    RBS_CC_5_reportLine("2362", 1)
    prototype._createPlaybackRange = function(startSec as float, endSec as float) as object
        if RBS_CC_5_reportLine("2363", 2) and (startSec = invalid or endSec = invalid or startSec >= endSec)
            RBS_CC_5_reportLine("2363", 3)
            RBS_CC_5_reportLine("2364", 1)
            print "Invalid start or end time for playback range"
            RBS_CC_5_reportLine("2365", 1)
            return invalid
        end if
        RBS_CC_5_reportLine("2368", 1)
        range = {
            start: startSec
            end: endSec
        }
        RBS_CC_5_reportLine("2373", 1)
        return range
    end function
    RBS_CC_5_reportLine("2376", 1)
    prototype._setCookieData = sub(data as object)
        RBS_CC_5_reportLine("2377", 1)
        cookie = _createRegistry()
        RBS_CC_5_reportLine("2378", 1)
        cookie.Write("UserRegistrationToken", data)
        RBS_CC_5_reportLine("2379", 1)
        cookie.Flush()
    end sub
    RBS_CC_5_reportLine("2382", 1)
    prototype._getCookieData = function() as dynamic
        RBS_CC_5_reportLine("2383", 1)
        cookie = _createRegistry()
        if RBS_CC_5_reportLine("2384", 2) and (cookie.Exists("UserRegistrationToken"))
            RBS_CC_5_reportLine("2384", 3)
            RBS_CC_5_reportLine("2385", 1)
            return cookie.Read("UserRegistrationToken")
        end if
        RBS_CC_5_reportLine("2387", 1)
        return invalid
    end function
    RBS_CC_5_reportLine("2390", 1)
    prototype._minify = function(src as object) as object
        RBS_CC_5_reportLine("2391", 1)
        result = {}
        RBS_CC_5_reportLine("2393", 1): for each key in src
            if RBS_CC_5_reportLine("2394", 2) and (key = "_")
                RBS_CC_5_reportLine("2394", 3)
                RBS_CC_5_reportLine("2395", 1)
                result["__"] = src[key]
            else
                RBS_CC_5_reportLine("2396", 3)
                RBS_CC_5_reportLine("2397", 1)
                keyParts = key.split("_")
                RBS_CC_5_reportLine("2398", 1)
                newKey = ""
                RBS_CC_5_reportLine("2399", 1)
                s = keyParts.count()
                if RBS_CC_5_reportLine("2401", 2) and (s > 0)
                    RBS_CC_5_reportLine("2401", 3)
                    RBS_CC_5_reportLine("2402", 1)
                    firstPart = keyParts[0]
                    if RBS_CC_5_reportLine("2403", 2) and (m._firstWords[firstPart] <> invalid)
                        RBS_CC_5_reportLine("2403", 3)
                        RBS_CC_5_reportLine("2404", 1)
                        newKey = m._firstWords[firstPart]
                    else if RBS_CC_5_reportLine("2405", 2) and (firstPart <> "")
                        RBS_CC_5_reportLine("2405", 3)
                        RBS_CC_5_reportLine("2406", 1)
                        newKey = "_" + firstPart + "_"
                    end if
                end if
                RBS_CC_5_reportLine("2410", 1): for i = 1 to s - 1 step 1
                    RBS_CC_5_reportLine("2411", 1)
                    nextPart = keyParts[i]
                    if RBS_CC_5_reportLine("2413", 2) and (nextPart <> "")
                        RBS_CC_5_reportLine("2413", 3)
                        if RBS_CC_5_reportLine("2414", 2) and (m._subsequentWords[nextPart] <> invalid)
                            RBS_CC_5_reportLine("2414", 3)
                            RBS_CC_5_reportLine("2415", 1)
                            newKey = newKey + m._subsequentWords[nextPart]
                        else if RBS_CC_5_reportLine("2416", 2) and (nextPart.len() > 0 and nextPart.toInt() > 0 and nextPart.toInt() = Int(nextPart.toInt()))
                            RBS_CC_5_reportLine("2416", 3)
                            ' Make sure the value is an integer, not decimal
                            RBS_CC_5_reportLine("2418", 1)
                            newKey = newKey + nextPart
                        else
                            RBS_CC_5_reportLine("2419", 3)
                            RBS_CC_5_reportLine("2420", 1)
                            newKey = newKey + "_" + nextPart + "_"
                        end if
                    end if
                end for
                RBS_CC_5_reportLine("2425", 1)
                result[newKey] = src[key]
            end if
        end for
        RBS_CC_5_reportLine("2429", 1)
        return result
    end function
    RBS_CC_5_reportLine("2432", 1)
    prototype._createBeaconUrl = function(key as string, domain = "litix.io" as string) as string
        if RBS_CC_5_reportLine("2433", 2) and (m.manifestBaseUrl <> invalid and m.manifestBaseUrl <> "")
            RBS_CC_5_reportLine("2433", 3)
            RBS_CC_5_reportLine("2434", 1)
            return m.manifestBaseUrl
        end if
        RBS_CC_5_reportLine("2436", 1)
        keyRegex = CreateObject("roRegex", "^[a-z0-9]+$", "i")
        RBS_CC_5_reportLine("2437", 1)
        result = "https://"
        RBS_CC_5_reportLine("2438", 1)
        subdomain = "img"
        if RBS_CC_5_reportLine("2439", 2) and (keyRegex <> invalid)
            RBS_CC_5_reportLine("2439", 3)
            RBS_CC_5_reportLine("2440", 1)
            keyValid = keyRegex.isMatch(key)
            if RBS_CC_5_reportLine("2441", 2) and (keyValid = true)
                RBS_CC_5_reportLine("2441", 3)
                RBS_CC_5_reportLine("2442", 1)
                subdomain = key
            end if
        end if
        RBS_CC_5_reportLine("2445", 1)
        result = result + subdomain
        RBS_CC_5_reportLine("2446", 1)
        result = result + "." + domain
        RBS_CC_5_reportLine("2448", 1)
        return result
    end function
    RBS_CC_5_reportLine("2451", 1)
    prototype._generateShortID = function() as string
        RBS_CC_5_reportLine("2452", 1)
        randomNumber = Rnd(0) * 2176782336
        RBS_CC_5_reportLine("2453", 1)
        randomNumber = randomNumber << 2
        RBS_CC_5_reportLine("2454", 1)
        shortID = Right(StrI(randomNumber, 36), 6)
        RBS_CC_5_reportLine("2455", 1)
        return shortID
    end function
    RBS_CC_5_reportLine("2458", 1)
    prototype._getVideoPlaybackMetric = function(videoMode as string, metricType as string) as string
        RBS_CC_5_reportLine("2459", 1)
        result = ""
        RBS_CC_5_reportLine("2460", 1)
        metrics = {
            "480i": {
                width: "720"
                height: "480"
                aspect: "4:3"
                refresh: "60 Hz"
                depth: "8 Bit"
            }
            "480p": {
                width: "720"
                height: "480"
                aspect: "4:3"
                refresh: "60 Hz"
                depth: "8 Bit"
            }
            "576i25": {
                width: "720"
                height: "576"
                aspect: "4:3"
                refresh: "25 Hz"
                depth: "8 Bit"
            }
            "576p50": {
                width: "720"
                height: "576"
                aspect: "4:3"
                refresh: "50 Hz"
                depth: "8 Bit"
            }
            "576p60": {
                width: "720"
                height: "576"
                aspect: "4:3"
                refresh: "60 Hz"
                depth: "8 Bit"
            }
            "720p50": {
                width: "1280"
                height: "720 "
                aspect: "16:9"
                refresh: "50 Hz"
                depth: "8 Bit"
            }
            "720p": {
                width: "1280"
                height: "720 "
                aspect: "16:9"
                refresh: "60 Hz"
                depth: "8 Bit"
            }
            "1080i50": {
                width: "1920"
                height: "1080"
                aspect: "16:9"
                refresh: "50 Hz"
                depth: "8 Bit"
            }
            "1080i": {
                width: "1920"
                height: "1080"
                aspect: "16:9"
                refresh: "60 Hz"
                depth: "8 Bit"
            }
            "1080p24": {
                width: "1920"
                height: "1080"
                aspect: "16:9"
                refresh: "24 Hz"
                depth: "8 Bit"
            }
            "1080p25": {
                width: "1920"
                height: "1080"
                aspect: "16:9"
                refresh: "25 Hz"
                depth: "8 Bit"
            }
            "1080p30": {
                width: "1920"
                height: "1080"
                aspect: "16:9"
                refresh: "30 Hz"
                depth: "8 Bit"
            }
            "1080p50": {
                width: "1920"
                height: "1080"
                aspect: "16:9"
                refresh: "50 Hz"
                depth: "8 Bit"
            }
            "1080p": {
                width: "1920"
                height: "1080"
                aspect: "16:9"
                refresh: "60 Hz"
                depth: "8 Bit"
            }
            "2160p25": {
                width: "3840"
                height: "2160"
                aspect: "16:9"
                refresh: "25 Hz"
                depth: "8 Bit"
            }
            "2160p24": {
                width: "3840"
                height: "2160"
                aspect: "16:9"
                refresh: "24 Hz"
                depth: "8 Bit"
            }
            "2160p30": {
                width: "3840"
                height: "2160"
                aspect: "16:9"
                refresh: "30 Hz"
                depth: "8 Bit"
            }
            "2160p50": {
                width: "3840"
                height: "2160"
                aspect: "16:9"
                refresh: "50 Hz"
                depth: "8 Bit"
            }
            "2160p60": {
                width: "3840"
                height: "2160"
                aspect: "16:9"
                refresh: "60 Hz"
                depth: "8 Bit"
            }
            "2160p24b10": {
                width: "3840"
                height: "2160"
                aspect: "16:9"
                refresh: "24 Hz"
                depth: "10 Bit"
            }
            "2160p25b10": {
                width: "3840"
                height: "2160"
                aspect: "16:9"
                refresh: "25 Hz"
                depth: "10 Bit"
            }
            "2160p50b10": {
                width: "3840"
                height: "2160"
                aspect: "16:9"
                refresh: "50 Hz"
                depth: "10 Bit"
            }
            "2160p30b10": {
                width: "3840"
                height: "2160"
                aspect: "16:9"
                refresh: "30 Hz"
                depth: "10 Bit"
            }
            "2160p60b10": {
                width: "3840"
                height: "2160"
                aspect: "16:9"
                refresh: "60 Hz"
                depth: "10 Bit"
            }
            "4320p60": {
                width: "7680"
                height: "4320"
                aspect: "16:9"
                refresh: "60 Hz"
                depth: "12 Bit"
            }
            "4320p60b10": {
                width: "7680"
                height: "4320"
                aspect: "16:9"
                refresh: "60 Hz"
                depth: "12 Bit"
            }
        }
        if RBS_CC_5_reportLine("2488", 2) and (metrics[videoMode] <> invalid)
            RBS_CC_5_reportLine("2488", 3)
            RBS_CC_5_reportLine("2489", 1)
            modeMetrics = metrics[videoMode]
            if RBS_CC_5_reportLine("2490", 2) and (modeMetrics[metricType] <> invalid)
                RBS_CC_5_reportLine("2490", 3)
                RBS_CC_5_reportLine("2491", 1)
                result = modeMetrics[metricType]
            end if
        end if
        RBS_CC_5_reportLine("2494", 1)
        return result
    end function
    RBS_CC_5_reportLine("2497", 1)
    prototype._generateGUID = function() as string
        RBS_CC_5_reportLine("2498", 1)
        pattern = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
        RBS_CC_5_reportLine("2499", 1)
        randomizeX = function() as string
            RBS_CC_5_reportLine("2500", 1)
            return StrI(Rnd(0) * 16, 16)
        end function
        RBS_CC_5_reportLine("2502", 1)
        randomizeY = function() as string
            RBS_CC_5_reportLine("2503", 1)
            randomNumber = Rnd(0) * 16
            RBS_CC_5_reportLine("2504", 1)
            randomNumber = randomNumber + 3
            if RBS_CC_5_reportLine("2505", 2) and (randomNumber >= 16)
                RBS_CC_5_reportLine("2505", 3)
                RBS_CC_5_reportLine("2506", 1)
                randomNumber = 8
            end if
            RBS_CC_5_reportLine("2508", 1)
            return StrI(randomNumber, 16)
        end function
        RBS_CC_5_reportLine("2510", 1)
        patternArray = pattern.split("")
        RBS_CC_5_reportLine("2511", 1)
        viewId = ""
        RBS_CC_5_reportLine("2512", 1): for each char in patternArray
            if RBS_CC_5_reportLine("2513", 2) and (char = "x")
                RBS_CC_5_reportLine("2513", 3)
                RBS_CC_5_reportLine("2514", 1)
                viewId = viewId + randomizeX()
            else if RBS_CC_5_reportLine("2515", 2) and (char = "y")
                RBS_CC_5_reportLine("2515", 3)
                RBS_CC_5_reportLine("2516", 1)
                viewId = viewId + randomizeY()
            else
                RBS_CC_5_reportLine("2517", 3)
                RBS_CC_5_reportLine("2518", 1)
                viewId = viewId + char
            end if
        end for
        RBS_CC_5_reportLine("2521", 1)
        return viewId
    end function
    RBS_CC_5_reportLine("2524", 1)
    prototype._logBeacon = sub(eventArray as object, title = "BEACON" as string)
        if RBS_CC_5_reportLine("2525", 2) and (m.debugBeacons <> "full" and m.debugBeacons <> "partial") then
            RBS_CC_5_reportLine("2525", 3)
            RBS_CC_5_reportLine("2525", 1)
            return
        end if
        RBS_CC_5_reportLine("2526", 1)
        fullEvent = (m.debugBeacons = "full")
        RBS_CC_5_reportLine("2527", 1)
        tot = m.loggingPrefix + title + " (" + eventArray.count().toStr() + ") [ "
        RBS_CC_5_reportLine("2528", 1): for each evt in eventArray
            if RBS_CC_5_reportLine("2529", 2) and (fullEvent = false)
                RBS_CC_5_reportLine("2529", 3)
                if RBS_CC_5_reportLine("2530", 2) and (evt <> invalid)
                    RBS_CC_5_reportLine("2530", 3)
                    RBS_CC_5_reportLine("2531", 1)
                    tot = tot + " " + evt.event
                end if
            else
                RBS_CC_5_reportLine("2533", 3)
                RBS_CC_5_reportLine("2534", 1)
                tot = tot + "{"
                RBS_CC_5_reportLine("2535", 1): for each prop in evt
                    RBS_CC_5_reportLine("2536", 1)
                    tot = tot + prop + ":" + m._safeDebugStr(evt[prop]) + ", "
                end for
                RBS_CC_5_reportLine("2538", 1)
                tot = Left(tot, len(tot) - 2)
                RBS_CC_5_reportLine("2539", 1)
                tot = tot + "} "
            end if
        end for
        RBS_CC_5_reportLine("2542", 1)
        tot = tot + " ]"
        RBS_CC_5_reportLine("2543", 1)
        print tot
    end sub
    RBS_CC_5_reportLine("2546", 1)
    prototype._logEvent = sub(event = {} as object, subtype = "" as string, title = "EVENT" as string)
        if RBS_CC_5_reportLine("2547", 2) and (m.debugEvents = "none") then
            RBS_CC_5_reportLine("2547", 3)
            RBS_CC_5_reportLine("2547", 1)
            return
        end if
        RBS_CC_5_reportLine("2548", 1)
        tot = m.loggingPrefix + title + " " + event.event
        if RBS_CC_5_reportLine("2549", 2) and (m.debugEvents = "full")
            RBS_CC_5_reportLine("2549", 3)
            RBS_CC_5_reportLine("2550", 1)
            tot = tot + "{"
            RBS_CC_5_reportLine("2551", 1): for each prop in event
                if RBS_CC_5_reportLine("2552", 2) and (event[prop] <> invalid)
                    RBS_CC_5_reportLine("2552", 3)
                    RBS_CC_5_reportLine("2553", 1)
                    tot = tot + prop + ":" + m._safeDebugStr(event[prop]) + ", "
                end if
            end for
            RBS_CC_5_reportLine("2556", 1)
            tot = Left(tot, len(tot) - 2)
            RBS_CC_5_reportLine("2557", 1)
            tot = tot + "} "
        end if
        RBS_CC_5_reportLine("2559", 1)
        print tot
    end sub
    RBS_CC_5_reportLine("2562", 1)
    prototype._getDeviceInfo = function() as object
        RBS_CC_5_reportLine("2563", 1)
        return _createDeviceInfo()
    end function
    RBS_CC_5_reportLine("2566", 1)
    prototype._getAppInfo = function() as object
        RBS_CC_5_reportLine("2567", 1)
        return _createAppInfo()
    end function
    RBS_CC_5_reportLine("2570", 1)
    prototype._getDateTime = function() as object
        RBS_CC_5_reportLine("2571", 1)
        return CreateObject("roDateTime")
    end function
    RBS_CC_5_reportLine("2574", 1)
    prototype._firstWords = {
        "property": "a"
        "env": "a" ' account
        "beacon": "b"
        "custom": "c"
        "ad": "d"
        "event": "e"
        "experiment": "f" ' nothing better to use...
        "internal": "i"
        "mux": "m"
        "response": "n"
        "player": "p"
        "request": "q"
        "retry": "r" ' placeholder for beacons adding retry counts
        "session": "s"
        "timestamp": "t"
        "viewer": "u" ' user
        "video": "v"
        "page": "w" ' web page
        "view": "x"
        "sub": "y" ' cause nowhere else to fit it
    }
    RBS_CC_5_reportLine("2597", 1)
    prototype._subsequentWords = {
        "ad": "ad"
        "affiliate": "af"
        "aggregate": "ag"
        "api": "ap"
        "application": "al"
        "audio": "ao"
        "architecture": "ar"
        "asset": "as"
        "autoplay": "au"
        "average": "av"
        "bitrate": "bi"
        "brand": "bn"
        "break": "br"
        "browser": "bw"
        "bytes": "by"
        "business": "bz"
        "cached": "ca"
        "cancel": "cb"
        "codec": "cc"
        "code": "cd"
        "category": "cg"
        "changed": "ch"
        "client": "ci"
        "clicked": "ck"
        "canceled": "cl"
        "config": "cn"
        "count": "co"
        "counter": "ce"
        "complete": "cp"
        "creator": "cq"
        "creative": "cr"
        "captions": "cs"
        "content": "ct"
        "current": "cu"
        "connection": "cx"
        "context": "cz"
        "cumulative": "cv"
        "downscaling": "dg"
        "domain": "dm"
        "cdn": "dn"
        "downscale": "do"
        "drm": "dr"
        "dropped": "dp"
        "duration": "du"
        "device": "dv"
        "dynamic": "dy"
        "enabled": "eb"
        "encoding": "ec"
        "edge": "ed"
        "end": "en"
        "engine": "eg"
        "embed": "em"
        "error": "er"
        "experiments": "ep"
        "errorcode": "es"
        "errortext": "et"
        "event": "ee"
        "events": "ev"
        "expires": "ex"
        "exception": "ez"
        "failed": "fa"
        "first": "fi"
        "family": "fm"
        "format": "ft"
        "fps": "fp"
        "frequency": "fq"
        "frame": "fr"
        "fullscreen": "fs"
        "has": "ha"
        "holdback": "hb"
        "headers": "he"
        "host": "ho"
        "hostname": "hn"
        "height": "ht"
        "id": "id"
        "init": "ii"
        "instance": "in"
        "ip": "ip"
        "is": "is"
        "key": "ke"
        "language": "la"
        "labeled": "lb"
        "level": "le"
        "live": "li"
        "loaded": "ld"
        "load": "lo"
        "lists": "ls"
        "latency": "lt"
        "max": "ma"
        "media": "md"
        "message": "me"
        "manifest": "mf"
        "mime": "mi"
        "midroll": "ml"
        "min": "mm"
        "manufacturer": "mn"
        "mode": "mp"
        "model": "mo"
        "mux": "mx"
        "ms": "ms"
        "newest": "ne"
        "name": "nm"
        "number": "no"
        "on": "on"
        "origin": "or"
        "os": "os"
        "paused": "pa"
        "playback": "pb"
        "producer": "pd"
        "percentage": "pe"
        "played": "pf"
        "previous": "pv"
        "program": "pg"
        "playhead": "ph"
        "plugin": "pi"
        "preroll": "pl"
        "playing": "pn"
        "poster": "po"
        "pip": "pp"
        "preload": "pr"
        "position": "ps"
        "part": "pt"
        "property": "py"
        "pop": "px"
        "plan": "pz"
        "rate": "ra"
        "requested": "rd"
        "rebuffer": "re"
        "rendition": "rf"
        "range": "rg"
        "remote": "rm"
        "ratio": "ro"
        "response": "rp"
        "request": "rq"
        "requests": "rs"
        "sample": "sa"
        "skipped": "sd"
        "session": "se"
        "shift": "sh"
        "seek": "sk"
        "stream": "sm"
        "source": "so"
        "sequence": "sq"
        "series": "sr"
        "status": "ss"
        "start": "st"
        "startup": "su"
        "server": "sv"
        "software": "sw"
        "severity": "sy"
        "tag": "ta"
        "tech": "tc"
        "text": "te"
        "target": "tg"
        "throughput": "th"
        "time": "ti"
        "total": "tl"
        "to": "to"
        "title": "tt"
        "type": "ty"
        "upscaling": "ug"
        "universal": "un"
        "upscale": "up"
        "url": "ur"
        "user": "us"
        "variant": "va"
        "viewed": "vd"
        "video": "vi"
        "version": "ve"
        "view": "vw"
        "viewer": "vr"
        "width": "wd"
        "watch": "wa"
        "waiting": "wt"
    }
    ' ' //////////////////////////////////////////////////////////////
    ' ' UTILS METHODS
    ' ' //////////////////////////////////////////////////////////////
    RBS_CC_5_reportLine("2778", 1)
    prototype._floatSecsToMillis = function(secs as float) as integer
        if RBS_CC_5_reportLine("2779", 2) and (secs = invalid)
            RBS_CC_5_reportLine("2779", 3)
            RBS_CC_5_reportLine("2780", 1)
            return invalid
        else
            RBS_CC_5_reportLine("2781", 3)
            RBS_CC_5_reportLine("2782", 1)
            return Int(secs * 1000)
        end if
    end function
    RBS_CC_5_reportLine("2786", 1)
    prototype._min = function(a, b) as object
        if RBS_CC_5_reportLine("2787", 2) and (a = invalid) then
            RBS_CC_5_reportLine("2787", 3)
            RBS_CC_5_reportLine("2787", 1)
            a = 0
        end if
        if RBS_CC_5_reportLine("2788", 2) and (b = invalid) then
            RBS_CC_5_reportLine("2788", 3)
            RBS_CC_5_reportLine("2788", 1)
            b = 0
        end if
        if RBS_CC_5_reportLine("2790", 2) and (a < b)
            RBS_CC_5_reportLine("2790", 3)
            RBS_CC_5_reportLine("2791", 1)
            return a
        else
            RBS_CC_5_reportLine("2792", 3)
            RBS_CC_5_reportLine("2793", 1)
            return b
        end if
    end function
    RBS_CC_5_reportLine("2797", 1)
    prototype._max = function(a, b) as object
        if RBS_CC_5_reportLine("2798", 2) and (a = invalid) then
            RBS_CC_5_reportLine("2798", 3)
            RBS_CC_5_reportLine("2798", 1)
            a = 0
        end if
        if RBS_CC_5_reportLine("2799", 2) and (b = invalid) then
            RBS_CC_5_reportLine("2799", 3)
            RBS_CC_5_reportLine("2799", 1)
            b = 0
        end if
        if RBS_CC_5_reportLine("2801", 2) and (a < b)
            RBS_CC_5_reportLine("2801", 3)
            RBS_CC_5_reportLine("2802", 1)
            return b
        else
            RBS_CC_5_reportLine("2803", 3)
            RBS_CC_5_reportLine("2804", 1)
            return a
        end if
    end function
    RBS_CC_5_reportLine("2808", 1)
    prototype._safeDebugStr = function(value as dynamic) as string
        if RBS_CC_5_reportLine("2809", 2) and (value = invalid)
            RBS_CC_5_reportLine("2809", 3)
            RBS_CC_5_reportLine("2810", 1)
            return "Invalid"
        else if RBS_CC_5_reportLine("2811", 2) and (GetInterface(value, "ifArray") <> invalid)
            RBS_CC_5_reportLine("2811", 3)
            ' you can only Join() arrays of strings, so stringify each item before joining
            RBS_CC_5_reportLine("2813", 1)
            stringifiedValues = []
            RBS_CC_5_reportLine("2814", 1): for each item in value
                RBS_CC_5_reportLine("2815", 1)
                stringifiedValues.push(m._safeDebugStr(item))
            end for
            RBS_CC_5_reportLine("2817", 1)
            return "Array[" + stringifiedValues.join(",") + "]"
        else if RBS_CC_5_reportLine("2818", 2) and (GetInterface(value, "ifAssociativeArray") <> invalid)
            RBS_CC_5_reportLine("2818", 3)
            RBS_CC_5_reportLine("2819", 1)
            return "Object" + FormatJson(value)
        else
            RBS_CC_5_reportLine("2820", 3)
            RBS_CC_5_reportLine("2821", 1)
            return value.toStr()
        end if
    end function
    RBS_CC_5_reportLine("2825", 1)
    prototype._safeAdd = function(var, addValue) as object
        if RBS_CC_5_reportLine("2826", 2) and (var = invalid)
            RBS_CC_5_reportLine("2826", 3)
            RBS_CC_5_reportLine("2827", 1)
            return addValue
        else
            RBS_CC_5_reportLine("2828", 3)
            RBS_CC_5_reportLine("2829", 1)
            return var + addValue
        end if
    end function
    RBS_CC_5_reportLine("2833", 1)
    return prototype
end function

function RBS_CC_5_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "5"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "5"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./MuxTask.brs.map