//
//  LightController.m
//  LightningKeyboard
//
//  Copyright (c) 2014 Shintaro Morikawa. All rights reserved.
//

#import "LightController.h"
#import "lmucontroller.h"

@interface LightController () {
    KeyMonitor *keyMonitor;
    float currentBrightness;
    int flickerCount;
    NSTimer *dimTimer;
    NSTimer *flickerTimer;
}

@end

@implementation LightController

- (instancetype)init {
    self = [super init];
    if (self) {
        keyMonitor = [[KeyMonitor alloc] init];
        keyMonitor.delegate = self;
    }
    return self;
}

// KeyMonitorDelegate method
- (void)keyDown:(unsigned short)keyCode {
    if (dimTimer != nil) {
        [dimTimer invalidate];
    }
    if (flickerTimer != nil) {
        [flickerTimer invalidate];
    }
    
    if (keyCode == 36) {
        // Return key
        flickerCount = 0;
        currentBrightness = 1.0;
        flickerTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(flicker) userInfo:nil repeats:YES];
        [flickerTimer fire];
    } else {
        currentBrightness = 1.0;
        setKeyboardBrightness(currentBrightness);
        
        dimTimer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(dim) userInfo:nil repeats:YES];
        [dimTimer fire];
    }
}

- (void)dim {
    currentBrightness -= 0.1;
    
    if (currentBrightness < 0.0) {
        currentBrightness = 0.0;
        [dimTimer invalidate];
    }
    
    setKeyboardBrightness(currentBrightness);
}

- (void)flicker {
    flickerCount += 1;
    
    if (flickerCount >= 10) {
        currentBrightness -= 0.3;
        if (currentBrightness < 0.0) {
            currentBrightness = 0.0;
            [flickerTimer invalidate];
        }
        setKeyboardBrightness(currentBrightness);
    } else {
        setKeyboardBrightness(flickerCount%2);
    }
}

@end
