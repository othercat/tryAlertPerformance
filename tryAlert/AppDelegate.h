//
//  AppDelegate.h
//  tryAlert
//
//  Created by Li Richard on 13-7-18.
//  Copyright (c) 2013年 lirichard. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum {
    TryPanelMode    =   1,
    TryMethodMode
} TryMode;


@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet NSWindow *window;
    IBOutlet NSButton *btnTryNSRunAlertPanel;
    IBOutlet NSButton *btnTryNSAlert;
    int count;
}

@property (assign) IBOutlet NSWindow *window;

-(IBAction)pressBtnTryNSRunAlertPanel:(id)sender;
-(IBAction)pressBtnTryNSAlert:(id)sender;

-(void)tryRunLoop:(id) anObject;
-(void)showAlert:(id) anObject;

@end
