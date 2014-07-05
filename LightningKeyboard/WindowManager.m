//
//  WindowManager.m
//  LightningKeyboard
//
//  Created by 森川慎太郎 on 2014/07/05.
//  Copyright (c) 2014年 Shintaro Morikawa. All rights reserved.
//

#import "WindowManager.h"
#import "MainViewController.h"

@interface WindowManager () {
    NSWindowController *mainWindowController;
    MainViewController *mainViewController;
}

@end

@implementation WindowManager

- (NSWindow *)createWindowWithContentView:(NSView *)view {
    NSRect frame = NSMakeRect(0, 0, view.frame.size.width, view.frame.size.height+22);
    NSUInteger styleMask = (NSTitledWindowMask
                            | NSClosableWindowMask
                            | NSMiniaturizableWindowMask
                            /*| NSResizableWindowMask*/);
    NSRect rect = [NSWindow contentRectForFrameRect:frame styleMask:styleMask];
    NSWindow *window = [[NSWindow alloc] initWithContentRect:rect
                                                   styleMask:styleMask
                                                     backing:NSBackingStoreBuffered
                                                       defer:false];
    [window center];
    [window setContentView:view];
    return window;
}

- (void)openMainWindow {
    mainViewController = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
    NSWindow *window = [self createWindowWithContentView:mainViewController.view];
    mainWindowController = [[NSWindowController alloc] initWithWindow:window];
    [mainWindowController showWindow:self];
    [NSApp activateIgnoringOtherApps:YES];
}

@end
