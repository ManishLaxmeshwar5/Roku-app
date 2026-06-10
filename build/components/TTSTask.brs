sub runTTS()
    RBS_CC_7_reportLine("1", 1)
    m.port = createObject("roMessagePort")
    RBS_CC_7_reportLine("2", 1)
    m.tts = createObject("roTextToSpeech")
    RBS_CC_7_reportLine("3", 1)
    m.deviceInfo = CreateObject("roDeviceInfo")
    ' m.tts  = createObject("roAudioGuide") 
    if RBS_CC_7_reportLine("6", 2) and (not m.tts.IsEnabled())
        RBS_CC_7_reportLine("6", 3)
        RBS_CC_7_reportLine("7", 1)
        m.top.ttsState = "disabled"
        RBS_CC_7_reportLine("8", 1)
        return
    end if
    RBS_CC_7_reportLine("11", 1)
    m.tts.SetMessagePort(m.port)
    RBS_CC_7_reportLine("12", 1)
    m.top.observeFieldScoped("text", m.port)
    RBS_CC_7_reportLine("13", 1)
    m.top.observeFieldScoped("control", m.port)
    RBS_CC_7_reportLine("14", 1)
    m.top.ttsState = "idle"
    RBS_CC_7_reportLine("16", 1): while true
        RBS_CC_7_reportLine("17", 1)
        msg = wait(0, m.port)
        if RBS_CC_7_reportLine("19", 2) and (type(msg) = "roSGNodeEvent")
            RBS_CC_7_reportLine("19", 3)
            RBS_CC_7_reportLine("20", 1)
            field = msg.getField()
            if RBS_CC_7_reportLine("21", 2) and (field = "text")
                RBS_CC_7_reportLine("21", 3)
                RBS_CC_7_reportLine("22", 1)
                text = m.top.text
                if RBS_CC_7_reportLine("23", 2) and (text <> invalid and text <> "")
                    RBS_CC_7_reportLine("23", 3)
                    RBS_CC_7_reportLine("24", 1)
                    m.tts.Flush()
                    RBS_CC_7_reportLine("25", 1)
                    m.top.speechid = m.tts.Say(text)
                    RBS_CC_7_reportLine("26", 1)
                    m.top.ttsState = "playing"
                end if
            else if RBS_CC_7_reportLine("28", 2) and (field = "control")
                RBS_CC_7_reportLine("28", 3)
                RBS_CC_7_reportLine("29", 1)
                m.tts.Flush()
                RBS_CC_7_reportLine("30", 1)
                m.top.ttsState = "idle"
            end if
        else if RBS_CC_7_reportLine("33", 2) and (type(msg) = "roTextToSpeechEvent")
            RBS_CC_7_reportLine("33", 3)
            RBS_CC_7_reportLine("34", 1)
            index = msg.GetIndex()
            if RBS_CC_7_reportLine("35", 2) and (index = 0)
                RBS_CC_7_reportLine("35", 3)
                RBS_CC_7_reportLine("36", 1)
                m.top.ttsState = "playing"
            else if RBS_CC_7_reportLine("37", 2) and (index = 1)
                RBS_CC_7_reportLine("37", 3)
                RBS_CC_7_reportLine("38", 1)
                m.top.ttsState = "idle"
            else if RBS_CC_7_reportLine("39", 2) and (index = 2)
                RBS_CC_7_reportLine("39", 3)
                RBS_CC_7_reportLine("40", 1)
                m.top.ttsState = "playing"
            else if RBS_CC_7_reportLine("41", 2) and (index = 3)
                RBS_CC_7_reportLine("41", 3)
                RBS_CC_7_reportLine("42", 1)
                m.top.ttsState = "stopped"
            end if
        end if
    end while
end sub

function RBS_CC_7_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "7"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "7"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./TTSTask.brs.map