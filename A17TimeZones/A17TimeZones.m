//
//  A17TimeZones.m
//

#import "A17TimeZones.h"
#import <WebKit/WebKit.h>


@implementation A17TimeZones

NSString * static_url = @"file://%@/www/index.html?url=";
NSString * base_url = @"http@3A@2F@2Fa17_timezones.localip@2F@3Fscreensaver@3Dtrue";

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];

    if (self) {
        webView = [[WebView alloc] initWithFrame:[self bounds] frameName:nil groupName:nil];

        [webView setMainFrameURL:[NSString stringWithFormat:[static_url stringByAppendingString:base_url], [[NSBundle bundleForClass:[self class]] resourcePath]]];

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
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
