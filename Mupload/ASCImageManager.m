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
        //NSLog(@"enumerating");
        if(group != nil) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if(result != nil) {
                    [self.assets addObject:result];
                    //NSLog(@"Adding");
                }
            }];
        }
        [self.delegate enumeratedAGroup];
        
    } failureBlock:^(NSError *error) {
        //NSLog(@"Assets library enumeration failure error: %@", error);
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
    //NSLog(@"MANAGER COUNT: %i", [images count]);
    return images;
}

- (NSArray*)getAssets:(NSInteger)numImages fromIndex:(NSInteger)index
{
    NSMutableArray* assets = [NSMutableArray arrayWithCapacity:4];
    int end = index + 4;
    if(end >= [self count]) {
        end = [self count] - 1;
    }
    for(int i = index; i < end; i++)
    {
        [assets addObject:[self.assets objectAtIndex:i]];
    }
    
    return assets;
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



@end
