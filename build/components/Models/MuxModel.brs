function MuxModel() as Object
    RBS_CC_3_reportLine("2", 1)
    model = {}
    RBS_CC_3_reportLine("4", 1)
    model.startTracking = function(videoNode as Object, content as Object) as Object
        RBS_CC_3_reportLine("6", 1)
        mux = CreateObject("roSGNode", "MuxTask")
        RBS_CC_3_reportLine("8", 1)
        mux.video = videoNode
        RBS_CC_3_reportLine("10", 1)
        mux.config = {
            env_key: "gclsk122j8oqocr7cacau07vm"
            player_name: "Custom Roku Player"
            player_version: "1.0"
            video_title: content.title
            video_id: content.url
            video_stream_type: "on-demand"
        }
        RBS_CC_3_reportLine("19", 1)
        mux.control = "RUN"
        RBS_CC_3_reportLine("21", 1)
        mux.view = "start"
        RBS_CC_3_reportLine("23", 1)
        return mux
    end function
    RBS_CC_3_reportLine("28", 1)
    return model
end function

function RBS_CC_3_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "3"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "3"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./MuxModel.brs.map