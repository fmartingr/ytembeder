###
# YouTube Embeder
# Author:       Felipe "Pyron" Martín (@fmartingr)
# Notes:        See README
###

OptionsException = ->
    @name = "OptionsError"
    @message = "No options provided!"

YT = (_options) ->
    # Creates new instance or initializates itself
    if not (@ instanceof YT)
        new YT(_options)
    else
        @init(_options)

YT.prototype = 
    log: (string) ->
        if @options.log?
          console.log string

    haveVideoTag: ->
        !!document.createElement('video').canPlayType

    haveFlash: ->
        # Thanks to http://bit.ly/SjTiSa
        hasFlash = false
        try
            flashObject = new ActiveXObject 'ShockwaveFlash.ShockwaveFlash'
            hasFlash = true if flashObject
            console.log 'till here!'
        catch e
            console.log 'here!'
            hasFlash = true if navigator.mimeTypes["application/x-shockwave-flash"] != undefined
        hasFlash

    debug: ->
        console.log "Have Flash:", @haveFlash()
        console.log "Have <video>:", @haveVideoTag()

    init: (options) ->
        type = typeof(options)
        console.log options
        if type is "object"
            console.log 'object'
        else if type is "string"
            console.log 'string'
        else
            console.error 'YTEmbeder: No options provided!'

window.YT = YT
