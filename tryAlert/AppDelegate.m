//
//  AppDelegate.m
//  tryAlert
//
//  Created by Li Richard on 13-7-18.
//  Copyright (c) 2013年 lirichard. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize window;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    count = 0;
}

-(IBAction)pressBtnTryNSRunAlertPanel:(id)sender
{
    [NSThread detachNewThreadSelector: @selector(tryRunLoop:) toTarget:self withObject:[NSNumber numberWithInt:TryPanelMode]];
}

-(IBAction)pressBtnTryNSAlert:(id)sender
{
    [NSThread detachNewThreadSelector: @selector(tryRunLoop:) toTarget:self withObject:[NSNumber numberWithInt:TryMethodMode]];
}

-(void)showAlert:(id) anObject
{
    if (![anObject respondsToSelector:@selector(intValue)])
        return ;
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    NSString *str = [[NSString alloc] initWithFormat:@"Just testing : %d",count++];
    //NSInteger buttonStatus = NSAlertErrorReturn;
    
    switch ([anObject intValue]) {
        case TryPanelMode:
            NSRunAlertPanel(@"Warning:",str, @"YES", nil, nil);
            break;
        case TryMethodMode:
            [[NSAlert alertWithMessageText:@"Warning" defaultButton:@"YES" alternateButton:nil otherButton:nil informativeTextWithFormat:@"%@",str] runModal];
        default:
            break;
    }
    
    
    [pool drain];
    
    [str release];
    
    return ;
   
}

-(void)tryRunLoop:(id) anObject
{
    if (![anObject respondsToSelector:@selector(intValue)])
        return ;
    
    //NSArray *array = [NSArray arrayWithObjects:@"NSDefaultRunLoopMode",nil];
    while(1)
        [self performSelectorOnMainThread:@selector(showAlert:) withObject:anObject waitUntilDone:YES];//modes:array];
    
    return;
}

@end
