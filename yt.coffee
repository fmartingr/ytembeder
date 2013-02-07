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
    __construct: ->
        @options =
            width: 640
            height: 480
            videoId: ''
            playerVars:
                autohide: 2
                #autoplay: 0
                #cc_load_policy: 1
                #color: 0
                #controls: 1
                #disablekb: 0
                enablejsapi: 0
                #end: null
                #fs: 1
                #iv_load_policy: 1
                #list: null
                #listType: null
                #loop: 0
                #modestbranding: 0
                #origin: null
                #playerapiid: null
                #playlist: null
                #rel: 1
                #showinfo: 0
                #start: 0
                #theme: 'dark'
            events:
                onReady: ->
                onStateChange: ->
        @element = 'ytvideo'
        @embedMode = null
        @debug = false
        @player = null # YT Player object
        @api = null # TODO

    ##
    #   INTERNALS
    ##
    log: (message, type='log') ->
        if window.console and window.console.log and @debug
            console.log "[%s] YTEmbeder: %s", type, message

    haveVideoTag: ->
        !!document.createElement('video').canPlayType

    haveFlash: ->
        # Thanks to http://bit.ly/SjTiSa
        hasFlash = false
        try
            flashObject = new ActiveXObject 'ShockwaveFlash.ShockwaveFlash'
            hasFlash = true if flashObject
        catch e
            hasFlash = true if navigator.mimeTypes["application/x-shockwave-flash"] isnt undefined
        hasFlash

    embedScript: ->
        if window._ytapiready is undefined
            tag = document.createElement 'script'
            tag.src = "https://www.youtube.com/player_api"
            firstScriptTag = document.getElementsByTagName('script')[0]
            firstScriptTag.parentNode.insertBefore tag, firstScriptTag
            window._ytapiready = false
            window.onYouTubePlayerAPIReady = =>
                window._ytapiready = true
                @log 'API ready'

    embedVideo: ->
        @player = new YT.Player @element, @options

    getEmbedMode: ->
        @embedMode = 'html5' if @haveVideoTag()
        @embedMode = 'flash' if @embedMode is null and @haveFlash()
        @

    start: ->
        @getEmbedMode()
        if @embedMode isnt null
            @embedScript()
        else
            @log 'Browser do not support flash or html5!', 'error'
        @

    init: (options) ->
        type = typeof(options)
        if type is "object"
            # Full options object
            @options = options
        else if type is "string"
            # String, so only video ID
            @options.videoId = options
        @__construct()
        @start()

    ##
    #   HELPERS
    ##
    lazy: (id, width, height, modestUI=true) ->
        @setVideo id
        @setSize width, height
        if modestUI
            @setControls false
            @setInfo false
            @setAutoplay true
            @setModestBranding true
        @

    setVideo: (id) ->
        @options.videoId = id
        @

    setModestBranding: (bool) ->
        @options.playerVars.modestbranding = Number bool

    setSize: (width, height) ->
        @options.width = parseInt width
        @options.height = parseInt height
        @

    setControls: (bool) ->
        @options.playerVars.controls = Number bool
        @

    setInfo: (bool) ->
        @options.playerVars.showinfo = Number bool
        @

    setAutoplay: (bool) ->
        @options.playerVars.autoplay = Number bool
        @

    allowFullscreen: (bool) ->
        @options.playerVars.fs = Number bool
        @

    embed: (element) ->
        if not window._ytapiready
            setTimeout =>
                @embed element
            , 200    
        else
            @element = element
            @embedVideo()
        @

window.YT = YT
