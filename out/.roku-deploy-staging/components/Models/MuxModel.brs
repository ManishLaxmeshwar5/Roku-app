function MuxModel() as Object

    model = {}

    model.startTracking = function(videoNode as Object,content as Object) as Object

        mux = CreateObject("roSGNode","MuxTask")

        mux.video = videoNode

        mux.config = {
            env_key: "gclsk122j8oqocr7cacau07vm"
            player_name: "Custom Roku Player"
            player_version: "1.0"
            video_title: content.title
            video_id: content.url
            video_stream_type: "on-demand"
        }

        mux.control = "RUN"

        mux.view = "start"

        return mux

    end function


    return model

end function