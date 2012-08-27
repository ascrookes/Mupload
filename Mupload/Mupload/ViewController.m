//
//  ViewController.m
//  Mupload
//
//  Created by Amadou Crookes on 8/21/12.
//  Copyright (c) 2012 Amadou Crookes. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


- (IBAction)showPicker:(id)sender
{
    // Dont allow the picker if they are not logged to fb yet
    ASCImagePicker* picker = [self.storyboard instantiateViewControllerWithIdentifier:@"Image Picker View Controller"];
    [self presentModalViewController:picker animated:YES];
}

- (IBAction)loginToFB:(id)sender
{
    NSArray* permissions  = [NSArray arrayWithObject:@"publish_stream"];
    [FBSession openActiveSessionWithPermissions:permissions allowLoginUI:YES
                              completionHandler:^(FBSession *session,
                                                  FBSessionState status,
                                                  NSError *error) {
                                  NSLog(@"ACCESS TOKEN: %@",[[FBSession activeSession] accessToken]);
                                  NSLog(@"PERMISSIONS:  %@", [[FBSession activeSession] permissions]);
                              }];
}

@end
