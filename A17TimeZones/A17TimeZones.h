//
//  A17TimeZones.h
//

#import <ScreenSaver/ScreenSaver.h>
#import <WebKit/WebKit.h>

@interface A17TimeZones : ScreenSaverView
{
    IBOutlet id configSheet;
    
    IBOutlet NSPopUpButton *clockType;
    IBOutlet NSPopUpButton *digitalFormat;
    IBOutlet NSPopUpButton *temperatureUnits;
    IBOutlet NSButtonCell *temperature;
    IBOutlet NSButtonCell *weather;

    ScreenSaverDefaults *defaults;
    
    WebView *webView;
}

@end
