###
# YouTube Embeder
# Author:       Felipe "Pyron" Martín (@fmartingr)
# Notes:        See README
###

YT = (_options) ->
    # Creates new instance or initializates itself
    if not (@ instanceof YT)
        new YT _options
    else
        @init _options

YT.prototype = 
    options:
        width: 640
        height: 480
        videoId: ''
    playerVars:
        autohide: 0
        autoplay: 0
        cc_load_policy: 0
        color: 0
        controls: 0
        disablekb: 0
        enablejsapi: 0
        end: 0
        fs: 0
        iv_load_policy: 0
        list: 0
        listType: 0
        loop: 0
        modestbranding: 0
        origin: 0
        playerapiid: 0
        playlist: 0
        rel: 0
        showinfo: 0
        start: 0
        theme: 0
    events:
        onReady: ->
        onStateChange: ->
    element: 'ytvideo'
    embedMode: null
    api: null # TODO

    haveVideoTag: ->
        !!document.createElement('video').canPlayType

    haveFlash: ->
        # Thanks to http://bit.ly/SjTiSa
        hasFlash = false
        try
            flashObject = new ActiveXObject 'ShockwaveFlash.ShockwaveFlash'
            hasFlash = true if flashObject
        catch e
            hasFlash = true if navigator.mimeTypes["application/x-shockwave-flash"] != undefined
        hasFlash

    embedScript: ->
        tag = document.createElement 'script'
        tag.src = "https://www.youtube.com/player_api"
        firstScriptTag = document.getElementsByTagName('script')[0]
        firstScriptTag.parentNode.insertBefore tag, firstScriptTag

    createCallback: ->
        window.player = null
        window.onYouTubePlayerAPIReady = =>
            window.player = new YT.Player @element, @options

    getEmbedMode: ->
        @embedMode = 'html5' if @haveVideoTag()
        @embedMode = 'flash' if @embedMode is null and @haveFlash()

    start: ->
        @getEmbedMode()
        if @embedMode isnt null
            @embedScript()
            @createCallback()
        else
            console.error 'Browser do not support flash or html5!'
        @

    init: (options) ->
        type = typeof(options)
        if type is "object"
            # Full options object
            @options = options
        else if type is "string"
            # String, so only video ID
            @options.videoId = options
        else
            console.error 'YTEmbeder: No options provided!'
        @start()


window.YT = YT
