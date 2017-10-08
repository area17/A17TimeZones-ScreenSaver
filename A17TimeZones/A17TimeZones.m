//
//  A17TimeZones.m
//

#import "A17TimeZones.h"
#import <WebKit/WebKit.h>
#define ModuleName @"com.github.area17.A17TimeZones"

@implementation A17TimeZones

NSString * static_url = @"file://%@/www/index.html?url=";
NSString * base_url = @"http@3A@2F@2Fa17_timezones.localip@2F@3Fscreensaver@3Dtrue";

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];

    if (self) {
        
        defaults = [ScreenSaverDefaults defaultsForModuleWithName:ModuleName];
        [defaults registerDefaults:@{@"ClockType": @"Digital", @"DigitalFormat": @"12 hour", @"Temperature": @"YES", @"TemperatureUnits": @"Metric", @"Weather": @"NO"}];
        
        webView = [[WebView alloc] initWithFrame:[self bounds] frameName:nil groupName:nil];
        
        NSString * url = [static_url stringByAppendingString:base_url];
        NSString * paramClockType = @"@26clocktype@3D";
        NSString * paramDigitalFormat = @"@26digitalformat@3D";
        NSString * paramTemperature = @"@26temperature@3D";
        NSString * paramTemperatureUnits = @"@26temperatureunits@3D";
        NSString * paramWeather = @"@26weather@3D";
        
        NSString * valueClockType = [[defaults objectForKey:@"ClockType"] lowercaseString];
        NSString * valueDigitalFormat = [[defaults objectForKey:@"DigitalFormat"] lowercaseString];
        NSString * valueTemperature = [[defaults objectForKey:@"Temperature"] lowercaseString];
        NSString * valueTemperatureUnits = [[defaults objectForKey:@"TemperatureUnit"] lowercaseString];
        NSString * valueWeather = [[defaults objectForKey:@"Weather"] lowercaseString];
        
        paramClockType = [paramClockType stringByAppendingString:valueClockType];
        paramDigitalFormat = [paramDigitalFormat stringByAppendingString:valueDigitalFormat];
        paramTemperature = [paramTemperature stringByAppendingString:valueTemperature];
        paramTemperatureUnits = [paramTemperatureUnits stringByAppendingString:valueTemperatureUnits];
        paramWeather = [paramWeather stringByAppendingString:valueWeather];
        
        url = [url stringByAppendingString:paramClockType];
        url = [url stringByAppendingString:paramDigitalFormat];
        url = [url stringByAppendingString:paramTemperature];
        url = [url stringByAppendingString:paramTemperatureUnits];
        url = [url stringByAppendingString:paramWeather];
        
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
        //if (![NSBundle loadNibNamed:@"ConfigureSheet" owner:self])
        if (![[NSBundle mainBundle] loadNibNamed:@"ConfigureSheet" owner:self topLevelObjects:nil])
        {
            NSLog( @"Failed to load configure sheet." );
            NSBeep();
        }
    }
    
    return configSheet;
}


// IBActions

- (IBAction) okClick:(id)sender
{
    [defaults setValue:[clockType titleOfSelectedItem] forKey:@"ClockType"];
    [defaults setValue:[digitalFormat titleOfSelectedItem] forKey:@"DigitalFormat"];
    [defaults synchronize];
    
    [[NSApplication sharedApplication] endSheet:configSheet];
}

@end
