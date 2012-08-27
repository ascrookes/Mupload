//
//  ASCImageManager.m
//  Mupload
//
//  Created by Amadou Crookes on 8/21/12.
//  Copyright (c) 2012 Amadou Crookes. All rights reserved.
//

#import "ASCImageManager.h"

@implementation ASCImageManager

@synthesize assetsLibrary = _assetsLibrary;
@synthesize assets = _assets;
@synthesize selectedAssets = _selectedAssets;
@synthesize delegate;



+ (ASCImageManager*)ImageManagerWithPhotoLibrary
{
    NSLog(@"CREATING MANAGER");
    ASCImageManager* accessor = [[ASCImageManager alloc] init];
    [accessor getAssetsFromPhotoLibrary];
    return accessor;
}


- (void)getAssetsFromPhotoLibrary
{
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if(group != nil) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if(result != nil) {
                    [self.assets addObject:result];
                }
            }];
        }
        [self.delegate enumeratedAGroup];
        
    } failureBlock:^(NSError *error) {
    }];
}

- (UIImage*)getImageAtIndex:(NSInteger)index
{
    CGImageRef imageRef = [[self.assets objectAtIndex:index] thumbnail];
    return [UIImage imageWithCGImage:imageRef];
}

- (int)count
{
    return [self.assets count];
}

- (NSArray*)getImages:(NSInteger)numImages fromIndex:(NSInteger)index
{
    NSMutableArray* images = [NSMutableArray arrayWithCapacity:4];
    int end = index + 4;
    if(end >= [self count]) {
        end = [self count] - 1;
    }
    for(int i = index; i < end; i++)
    {
        [images addObject:[self getImageAtIndex:i]];
    }
    return images;
}

- (NSArray*)getAssets:(NSInteger)numImages fromIndex:(NSInteger)index
{
    NSMutableArray* assets = [NSMutableArray arrayWithCapacity:numImages];
    int end = index + numImages;
    if(end >= [self count]) {
        end = [self count] - 1;
    }
    for(int i = index; i < end; i++)
    {
        [assets addObject:[self.assets objectAtIndex:i]];
    }
    
    return assets;
}

- (NSArray*)getSelected:(NSInteger)numSelected fromIndex:(NSInteger)index
{
    NSMutableArray* selected = [NSMutableArray arrayWithCapacity:numSelected];
    int end = index + numSelected;
    if(end >= [self count]) {
        end = [self count] - 1;
    }
    for(int i = index; i < end; i++)
    {
        [selected addObject:[self.selectedAssets objectAtIndex:i]];
    }

    return selected;
}






- (void)selectedAssetAtIndex:(NSInteger)index
{
    // Since BOOL cannot be in an arrry it gets wrapped as an NSNumer
    NSNumber* selectedWrapper = [self.selectedAssets objectAtIndex:index];
    BOOL selected = [selectedWrapper boolValue];
    // Since BOOL is binary just flip it when it gets selected
    [self.selectedAssets replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:!selected]];
}

- (NSArray*)getSelectedAssets
{
    NSMutableArray* selected = [NSMutableArray array];
    for(int i = 0; i < [self.selectedAssets count]; i++)
    {
        if([[self.selectedAssets objectAtIndex:i] boolValue]) {
            [selected addObject:[self.assets objectAtIndex:i]];
        }
    }
    return selected;
}

- (void)clearSelected
{
    self.selectedAssets = nil;
}

//*********************************************************
//*********************************************************
#pragma mark - Server Stuff
//*********************************************************
//*********************************************************

- (void)uploadAssetsImagesToServer:(NSArray*)assets
{
    dispatch_queue_t queue = dispatch_queue_create("image uplaod from asset", nil);
    dispatch_async(queue, ^{
        for(ALAsset* asset in assets)
        {
            [self uploadImageToServer:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]]];
        }

    });
    dispatch_release(queue);
}

- (void)uploadImageToServer:(UIImage*)image
{
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://ascrookes.webfactional.com/api"]];
    [request setDelegate:self];
    [request setPostFormat:ASIMultipartFormDataPostFormat];
    [request setRequestMethod:@"POST"];
    // want the images to have different names so naming them the hexadecimal address of their UIImages 
    [request setData:UIImageJPEGRepresentation(image, 1.0f) withFileName:[NSString stringWithFormat:@"%p.jpg", image] andContentType:@"image/jpeg" forKey:@"image"];
    [request setPostValue:[[FBSession activeSession] accessToken] forKey:@"fbAccessToken"];
    
    [request startAsynchronous];
}


- (void)requestStarted:(ASIHTTPRequest *)request
{
    NSLog(@"Started");
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"Finished");
    NSLog(@"\nStatus Msg: [%@]\nResponse: [%@]",[request responseStatusMessage], [request responseString]);
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"Failed With Code: %i", [request responseStatusCode]);
    NSLog(@"Failed With Message: %@", [request responseStatusMessage]);
    NSLog(@"Failed With Response: %@", [request responseString]);
}


//*********************************************************
//*********************************************************
#pragma mark - Setters & Getters
//*********************************************************
//*********************************************************


- (ALAssetsLibrary*)assetsLibrary
{
    if(!_assetsLibrary) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return _assetsLibrary;
}

- (NSMutableArray*)assets
{
    if(!_assets) {
        _assets = [NSMutableArray array];
    }
    return _assets;
}

// If this object does not exist yet create it and fill it with NO
- (NSMutableArray*)selectedAssets
{
    if(!_selectedAssets) {
        int numAssets = [self.assets count];
        _selectedAssets = [NSMutableArray arrayWithCapacity:numAssets];
        for(int i = 0; i < numAssets; i++)
        {
            [_selectedAssets addObject:[NSNumber numberWithBool:NO]];
        }
    }

    return _selectedAssets;
}



@end
