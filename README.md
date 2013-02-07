ytembeder
=========

A easy tool to embed your youtube videos with the [embed api](https://developers.google.com/youtube/js_api_reference).

## Flash or HTML5?
Both. The Script checks for flash or html5 **before** loading the youtube API. If none present, nothing is loaded and the developer can show some message to the user. The Flash/HTML5 choice is made by the youtube API.

## JQuery, Zepto?
None. This is a standalone library.

## How to embed a video
After compiling the coffeescript into javascript, include the ytembeder.js into your code.  
```
<script type="text/javascript" src="ytembeder.js"></script>
```

Wrap your code when the content is loaded:
```
<div id="ytvideo"></div>

<script type="text/javascript">
window.onload = function() { ... } # On load
window.addEventListener('DOMContentLoaded', function() { ... }) # DOM
$(function(){ ... }) # jQuery/Zepto
</script>
```
## Methods

```
var player = YT();
// Set the video ID
player.setVideo('eh7lp9umG2I');

// Set video width/height
player.setSize(1280, 720);

// Activate modest branding
player.setModestBranding(true);

// Show/Hide controls
player.setControls(false);

// Show/Hide top info bar
player.setInfo(false);

// Activate/Deactivate autoplay
player.setAutoplay(true);

// Enable/Disable fullscreen
player.allowFullscreen(false);

// or use object oriented notation!
player.setVideo('eh7lp9umG2I').setSize(320, 240).setAutoplay(true);
```

After settings the properties:
```
player.embed('ytvideo')
```

You can also use the `.lazy()` function for easy embedding:
```
var player = YT().lazy('eh7lp9umG2I', 320, 240).embed('ytvideo')
// .lazy(id, width, height, modestUI)
// Modest UI will hide controls and info and
// also activate autplay and modest branding.
```

## Thanks to
- [Drewid](http://stackoverflow.com/users/402440/drewid) from Stackoverflow for [his function to check if flash is installed](http://stackoverflow.com/a/3336320).
