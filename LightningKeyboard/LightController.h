//
//  LightController.h
//  LightningKeyboard
//
//  Copyright (c) 2014 Shintaro Morikawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyMonitor.h"

@interface LightController : NSObject <KeyMonitorDelegate>

- (void)keyDown:(unsigned short)keyCode;

@end
