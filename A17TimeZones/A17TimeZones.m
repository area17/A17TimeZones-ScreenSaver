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

        // guessing timezone to set default temperature unit
        NSTimeZone *timeZone = [NSTimeZone localTimeZone];
        NSString *tzName = [timeZone name];
        NSError *error = NULL;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"Adak|Anchorage|Boise|Chicago|Denver|Detroit|Indiana|Juneau|Kentucky|Los_Angeles|Menominee|Metlakatla|New_York|Nome|North_Dakota|Phoenix|Sitka|Yakutat|Honolulu" options:NSRegularExpressionCaseInsensitive error:&error];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:tzName options:0 range:NSMakeRange(0, [tzName length])];

        defaults = [ScreenSaverDefaults defaultsForModuleWithName:ModuleName];
        [defaults registerDefaults:@{@"ClockType": @"Analogue",
                                     @"DigitalFormat": ((numberOfMatches > 0) ? @"12 hour" : @"24 hour"),
                                     @"Weather": @"YES",
                                     @"TemperatureUnits": ((numberOfMatches > 0) ? @"Fahrenheit" : @"Celsius"),
                                     @"Animated": @"NO"}];

        // set up url to add in a param of the static page
        NSString * url = @"https://time.area17.com/?screensaver=true";
        
        // the various params we can set
        NSString * paramClockType = @"&clocktype=";
        NSString * paramDigitalFormat = @"&digitalformat=";
        NSString * paramWeather = @"&showcurrentweather=";
        NSString * paramTemperatureUnits = @"&temperatureunit=";
        NSString * paramAnimated = @"&animtedicons=";
        
        // the values we want to pass through
        NSString * valueClockType = [[defaults objectForKey:@"ClockType"] lowercaseString];
        NSString * valueDigitalFormat = [[defaults objectForKey:@"DigitalFormat"] lowercaseString];
        NSString * valueWeather = (([defaults boolForKey:@"Weather"]) ? @"true" : @"false");
        NSString * valueTemperatureUnits = [[defaults objectForKey:@"TemperatureUnits"] lowercaseString];
        NSString * valueAnimated = (([defaults boolForKey:@"Animated"]) ? @"true" : @"false");
        
        // convert space to %20 else NSURL becomes invalid somehow
        valueDigitalFormat = [valueDigitalFormat stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
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
        
        // make web view and request url
        webView = [[WKWebView alloc] initWithFrame:[self bounds]];
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        
        [self addSubview:webView];
    }

    return self;
}

- (BOOL)hasConfigureSheet
{
    return YES;
}

- (NSWindow*)configureSheet
{
    if (!configSheet)
    {
        if ( ! [[NSBundle bundleForClass:[self class]] loadNibNamed:@"ConfigureSheet" owner:self  topLevelObjects:nil] )
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
