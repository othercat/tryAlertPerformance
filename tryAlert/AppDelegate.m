//
//  AppDelegate.m
//  tryAlert
//
//  Created by Li Richard on 13-7-18.
//  Copyright (c) 2013年 lirichard. All rights reserved.
//

#import "AppDelegate.h"

NSString *threadDidFinishedNotification = @"threadDidFinishedNotification";
NSString *startNotification             = @"startNotification";

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
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(testEnd:)
                                                 name:threadDidFinishedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tryRunLoopNotification:)
                                                 name:startNotification
                                               object:nil];
}

- (void) testEnd:(NSNotification *)notification
{

    [NSApp abortModal];
    
    if ([[notification object] isEqual:@"tryRunLoop"])
        [NSThread detachNewThreadSelector: @selector(tryRunLoop:) toTarget:self withObject:(id)[[notification userInfo] objectForKey:@"TryMode"]];
    else
        [[NSNotificationCenter defaultCenter] postNotificationName:startNotification object:self userInfo:[notification userInfo]];
    
}

-(IBAction)pressBtnTryNSRunAlertPanel:(id)sender
{
    [NSThread detachNewThreadSelector: @selector(tryRunLoop:) toTarget:self withObject:[NSNumber numberWithInt:TryPanelMode]];
}

-(IBAction)pressBtnTryNSAlert:(id)sender
{
    [NSThread detachNewThreadSelector: @selector(tryRunLoop:) toTarget:self withObject:[NSNumber numberWithInt:TryMethodMode]];
}

-(IBAction)pressBtnTryNSAlertNotification:(id)sender
{
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [NSNumber numberWithInt:TryMethodMode],@"TryMode", nil];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:startNotification object:nil userInfo:dict];
    [dict release];
}

-(void)showAlert:(id) anObject
{
    //if (![anObject respondsToSelector:@selector(intValue)])
      //  return ;
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSString *str = [[NSString alloc] initWithFormat:@"Just testing : %d",count++];
    //NSInteger buttonStatus = NSAlertErrorReturn;
    
    switch ([anObject intValue]) {
        case TryPanelMode:{
            
            NSRunAlertPanel(@"Warning:",str, @"YES", nil, nil);
            
        }
            break;
        case TryMethodMode:
            [[NSAlert alertWithMessageText:@"Warning" defaultButton:@"YES" alternateButton:nil otherButton:nil informativeTextWithFormat:@"%@",str] runModal];
        default:
            break;
    }
    
    [str release];
    
    [NSApp stopModal];
    
    [pool drain];

    
    return ;
   
}

-(void)tryRunLoop:(id) anObject
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    [self performSelectorOnMainThread:@selector(showAlert:) withObject:anObject waitUntilDone:YES];//modes:array];

    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          anObject,@"TryMode", nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:threadDidFinishedNotification object:@"tryRunLoop" userInfo:dict];
    
    [dict release];
     
    [pool drain];

    return;
}

-(void)tryRunLoopNotification:(NSNotification *)notification
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    [self performSelectorOnMainThread:@selector(showAlert:) withObject:[[notification userInfo] objectForKey:@"TryMode"] waitUntilDone:YES];//modes:array];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:threadDidFinishedNotification object:@"tryRunLoopNotification" userInfo:[notification userInfo]];
    
    [pool drain];
    
    return;
}


@end
