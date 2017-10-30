//
//  A17TimeZones.m
//

#import "A17TimeZones.h"
#import <WebKit/WebKit.h>
#define ModuleName @"com.github.area17.A17TimeZones"

@implementation A17TimeZones

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];

    if (self) {
        
        defaults = [ScreenSaverDefaults defaultsForModuleWithName:ModuleName];
        [defaults registerDefaults:@{@"ClockType": @"Analogue",
                                     @"DigitalFormat": @"24 hour",
                                     @"Weather": @"YES",
                                     @"TemperatureUnits": @"Celsius",
                                     @"Animated": @"NO"}];
        
        // set up url to add in a param of the static page
        // url is urlencoded, with % swapped for @ because xcode cries about % in strings
        NSString * static_url = @"file://%@/www/index.html?url=";
        //NSString * base_url = @"http@3A@2F@2Fa17_timezones.localip@2F@3Fscreensaver@3Dtrue";
        NSString * base_url = @"https@3A@2F@2Ftime.area17.com@2F@3Fscreensaver@3Dtrue";
        NSString * url = [static_url stringByAppendingString:base_url];
        // the various params we can set
        NSString * paramClockType = @"@26clocktype@3D";
        NSString * paramDigitalFormat = @"@26digitalformat@3D";
        NSString * paramWeather = @"@26showcurrentweather@3D";
        NSString * paramTemperatureUnits = @"@26temperatureunit@3D";
        NSString * paramAnimated = @"@26animtedicons@3D";
        // the values we want to pass through
        NSString * valueClockType = [[defaults objectForKey:@"ClockType"] lowercaseString];
        NSString * valueDigitalFormat = [[defaults objectForKey:@"DigitalFormat"] lowercaseString];
        NSString * valueWeather = (([defaults boolForKey:@"Weather"]) ? @"true" : @"false");
        NSString * valueTemperatureUnits = [[defaults objectForKey:@"TemperatureUnits"] lowercaseString];
        NSString * valueAnimated = (([defaults boolForKey:@"Animated"]) ? @"true" : @"false");
        // joining the params to their values
        paramClockType = [paramClockType stringByAppendingString:valueClockType];
        paramDigitalFormat = [paramDigitalFormat stringByAppendingString:valueDigitalFormat];
        paramWeather = [paramWeather stringByAppendingString:valueWeather];
        paramTemperatureUnits = [paramTemperatureUnits stringByAppendingString:valueTemperatureUnits];
        paramAnimated = [paramAnimated stringByAppendingString:valueAnimated];
        // joining the params to the urls
        url = [url stringByAppendingString:paramClockType];
        url = [url stringByAppendingString:paramDigitalFormat];
        url = [url stringByAppendingString:paramWeather];
        url = [url stringByAppendingString:paramTemperatureUnits];
        url = [url stringByAppendingString:paramAnimated];
        
        webView = [[WebView alloc] initWithFrame:[self bounds] frameName:nil groupName:nil];
        
        [webView setMainFrameURL:[NSString stringWithFormat:url, [[NSBundle bundleForClass:[self class]] resourcePath]]];

        [self addSubview:webView];
    }

    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    return;
}

- (BOOL)hasConfigureSheet
{
    return YES;
}

- (NSWindow*)configureSheet
{
    if (!configSheet)
    {
        if (![NSBundle loadNibNamed:@"ConfigureSheet" owner:self])
        //if (![[NSBundle mainBundle] loadNibNamed:@"ConfigureSheet" owner:self topLevelObjects:nil])
        {
            NSLog( @"Failed to load configure sheet." );
            NSBeep();
        }
    }
    
    
    // apply defaults
    [clockType selectItemWithTitle: [defaults objectForKey:@"ClockType"]];
    [digitalFormat selectItemWithTitle: [defaults objectForKey:@"DigitalFormat"]];
    [temperatureUnits selectItemWithTitle: [defaults objectForKey:@"TemperatureUnits"]];
    
    if ([defaults boolForKey:@"Weather"]){
        [weather setState:NSOnState];
    } else {
        [weather setState:NSOffState];
    }
    
    if ([defaults boolForKey:@"Animated"]){
        [animated setState:NSOnState];
    } else {
        [animated setState:NSOffState];
    }
    
    return configSheet;
}


// IBActions

- (IBAction) okClick:(id)sender
{
    [defaults setValue:[clockType titleOfSelectedItem] forKey:@"ClockType"];
    [defaults setValue:[digitalFormat titleOfSelectedItem] forKey:@"DigitalFormat"];
    [defaults setValue:[temperatureUnits titleOfSelectedItem] forKey:@"TemperatureUnits"];
    [defaults setBool:[weather state] forKey:@"Weather"];
    [defaults setBool:[animated state] forKey:@"Animated"];
    [defaults synchronize];
    
    [[NSApplication sharedApplication] endSheet:configSheet];
}

@end
