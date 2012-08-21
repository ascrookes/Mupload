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
        NSLog(@"enumerating");
        if(group != nil) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                [self.assets addObject:result];
                NSLog(@"ADDED ASSET");
            }];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"Assets library enumeration failure error: %@", error);
    }];
}

- (UIImage*)getImageAtIndex:(NSInteger)index
{
    CGImageRef imageRef = [[[self.assets objectAtIndex:index] defaultRepresentation] fullResolutionImage];
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
