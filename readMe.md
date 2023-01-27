# A17 Time Zones Screen Saver

v2.0.1

Displays <a href="https://time.area17.com/" target="blank">time.area17.com</a> within a macOS screen saver. Passes controllable parameters to control the display of clock type, clock format, temperature units and display of temperature and weather; more info on these parameters in the [time repository](https://github.com/area17/time).

Download the screen saver here: [A17TimeZones.saver.zip](https://time.area17.com/downloads/A17TimeZones.saver.zip)

## Installing

I'm not a certified developer and so installing the screen saver might not be as simple as double-clicking it. Instead you may have to right click/control click and select "open" and then select "open" on the prompt.

## Issues/Contributing/Discussion

If you find a bug in A17TimeZones-ScreenSaver, please add it to [the issue tracker](https://github.com/area17/A17TimeZones-ScreenSaver/issues) or fork it, fix it and submit a pull request for it (👍).

As this was built by a FE developer its likely to be a bit rough around the edges, any pointers would be appreciated.

## Support

Tested in macOS version:

* 12.6 macOS Monterey

*Should* work in 10.13 High Sierra and newer...

## Version 2

Updates the screen saver to use `WKWebView` and to no longer use any deprecated methods. Shout out to this [commit](https://github.com/brockgr/websaver/commit/3a80fc4daee2f9efc82cf57d223963af12dd5970) by [brockgr](https://github.com/brockgr).

### v2.0.1

* removes credit for Dark Sky as [time.area17.com](https://time.area17.com/) no uses [Visual Crossing](https://www.visualcrossing.com/) and the credit for this is going to be visible in the screen saver rather than the preferences panel.
* updates build target to 10.13 High Sierra and up
* builds to working directory, build gitignored

## Author

* [Mike Byrne](https://github.com/13twelve) - [@13twelve](https://twitter.com/13twelve)
