//
//  KeyMonitor.m
//  LightningKeyboard
//
//  Copyright (c) 2014 Shintaro Morikawa. All rights reserved.
//

#import "KeyMonitor.h"

@interface KeyMonitor () {
    NSEvent *eventMonitor;
}
@end

@implementation KeyMonitor

- (id)init {
    self = [super init];
    if (self) {
        eventMonitor = [NSEvent addGlobalMonitorForEventsMatchingMask:NSKeyDownMask
                                                              handler:^(NSEvent *event) {
                              if (self.delegate != nil && [self.delegate respondsToSelector:@selector(keyDown:)]) {
                                  [self.delegate keyDown:event.keyCode];
                              }
                          }];
    }
    return self;
}

@end
