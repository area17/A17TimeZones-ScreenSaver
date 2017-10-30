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
    IBOutlet NSButtonCell *weather;
    IBOutlet NSButtonCell *animated;

    ScreenSaverDefaults *defaults;
    
    WebView *webView;
}

@end
