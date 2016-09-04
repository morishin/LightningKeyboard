//
//  AppDelegate.m
//  LightningKeyboard
//
//  Copyright (c) 2014 Shintaro Morikawa. All rights reserved.
//

#import "AppDelegate.h"
#import "LightController.h"

@interface AppDelegate () {
    LightController *lightController;
    NSStatusItem *statusItem;
}

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSDictionary *options = @{(__bridge id)kAXTrustedCheckOptionPrompt: @YES};
    BOOL accessibilityEnabled = AXIsProcessTrustedWithOptions((__bridge CFDictionaryRef)options);
    if (!accessibilityEnabled) {
        NSAlert *alert = [NSAlert alertWithMessageText:@"Add LightningKeyboard.app to the list in Accessibility preference pane. (Drag&Drop this app on the list)" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"(System Preferences > Security & Privacy > Privacy > Accessibility)\n\nAnd you need to reboot this app."];
        if ([alert runModal] == NSAlertDefaultReturn) {
            [NSApp terminate:nil];
        }
    }
    
    lightController = [LightController new];
    [self setupStatusItem];
}

- (void)setupStatusItem {
    NSMenu *statusMenu = [NSMenu new];
    NSStatusBar *systemStatusBar = [NSStatusBar systemStatusBar];
    statusItem = [systemStatusBar statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setHighlightMode:YES];
    [statusItem setImage:[NSImage imageNamed:@"MenuIcon"]];
    [statusItem setMenu:statusMenu];
    [statusMenu addItemWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@""];
}

@end
