sub runTTS()
    m.port = createObject("roMessagePort")
    m.tts  = createObject("roTextToSpeech")
    m.deviceInfo = CreateObject("roDeviceInfo")
    ' m.tts  = createObject("roAudioGuide") 

    if not m.tts.IsEnabled()
        m.top.ttsState = "disabled"
        return
    end if

    m.tts.SetMessagePort(m.port)
    m.top.observeFieldScoped("text",    m.port)
    m.top.observeFieldScoped("control", m.port)
    m.top.ttsState = "idle"

    while true
        msg = wait(0, m.port)

        if type(msg) = "roSGNodeEvent"
            field = msg.getField()
            if field = "text"
                text = m.top.text
                if text <> invalid and text <> ""
                    m.tts.Flush()
                    m.top.speechid = m.tts.Say(text)
                    m.top.ttsState = "playing"
                end if
            else if field = "control"
                m.tts.Flush()
                m.top.ttsState = "idle"
            end if

        else if type(msg) = "roTextToSpeechEvent"
            index = msg.GetIndex()
            if index = 0
                m.top.ttsState = "playing"
            else if index = 1
                m.top.ttsState = "idle"
            else if index = 2
                m.top.ttsState = "playing"
            else if index = 3
                m.top.ttsState = "stopped"
            end if

        end if
    end while
end sub
