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



+ (ASCImageManager*)ImageAccessorWithPhotoLibrary
{
    ASCImageManager* accessor = [[ASCImageManager alloc] init];
    [accessor getAssetsFromPhotoLibrary];
    return accessor;
}


- (void)getAssetsFromPhotoLibrary
{
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        if(group != nil) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                [self.assets addObject:result];
            }];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"Assets library enumeration error: %@", error);
    }];
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
}



@end
