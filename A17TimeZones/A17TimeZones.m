//
//  A17TimeZones.m
//

#import "A17TimeZones.h"
#import <WebKit/WebKit.h>

@implementation A17TimeZones

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];

    if (self) {
        webView = [[WebView alloc] initWithFrame:[self bounds] frameName:nil groupName:nil];

        [webView setMainFrameURL:[NSString stringWithFormat:@"file://%@/www/index.html", [[NSBundle bundleForClass:[self class]] resourcePath]]];

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
