//
//  KeyMonitor.h
//  LightningKeyboard
//
//  Copyright (c) 2014 Shintaro Morikawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KeyMonitorDelegate <NSObject>
@required
- (void)keyDown:(unsigned short)keyCode;
@end

@interface KeyMonitor : NSObject

@property (nonatomic, weak) id<KeyMonitorDelegate> delegate;

@end
