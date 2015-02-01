/**
 * Copyright (c) 2010-2013 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiLightModule.h"
#import "TiUtils.h"
#import <AVFoundation/AVFoundation.h>

@implementation TiLightModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"37ff229c-2c1b-4ee4-8eb8-8c09bbe24a24";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"ti.light";
}

#pragma mark Lifecycle

-(void)startup
{
	// you *must* call the superclass
	[super startup];
	
}

-(void)shutdown:(id)sender
{
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

-(NSNumber*)isSupported:(id)unused
{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass == nil)
    {
        return NUMBOOL(NO);
    }
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    return NUMBOOL(([device hasTorch] && [device hasFlash]));

}
-(NSNumber*)isOn:(id)unused
{
    BOOL onFlag = NO;
    
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass == nil)
    {
        return NUMBOOL(onFlag);
    }
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch] && [device hasFlash]){
        
        [device lockForConfiguration:nil];
        if (device.torchMode != AVCaptureTorchModeOff)
        {
            onFlag = YES;
        }
        [device unlockForConfiguration];
    }
    
    return NUMBOOL(onFlag);
    
}

-(void)turnOn:(id)unused
{
    [self toggleState:YES];
}

-(void)turnOff:(id)unused
{
    [self toggleState:NO];
}

-(void)toggleState:(BOOL)turnStatusOn
{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if ((device.torchMode == AVCaptureTorchModeOff) && turnStatusOn)
            {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
            }
            else
            {
                if(!turnStatusOn)
                {
                    [device setTorchMode:AVCaptureTorchModeOff];
                    [device setFlashMode:AVCaptureFlashModeOff];
                }
            }
            [device unlockForConfiguration];
        }
    }
}

-(void)toggle:(id)unused
{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (device.torchMode == AVCaptureTorchModeOff)
            {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
            }
            else
            {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}

@end
