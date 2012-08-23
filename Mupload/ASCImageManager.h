//
//  ASCImageManager.h
//  Mupload
//
//  Created by Amadou Crookes on 8/21/12.
//  Copyright (c) 2012 Amadou Crookes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@protocol ASCImageManagerDelegate <NSObject>

- (void)enumeratedAGroup;

@end


@interface ASCImageManager : NSObject

@property (nonatomic,strong) ALAssetsLibrary* assetsLibrary;
@property (nonatomic,strong) NSMutableArray*  assets;
@property (nonatomic,strong) id <ASCImageManagerDelegate> delegate;

+ (ASCImageManager*)ImageManagerWithPhotoLibrary;
- (void)getAssetsFromPhotoLibrary;
- (UIImage*)getImageAtIndex:(NSInteger)index;
- (int)count;
- (NSArray*)getImages:(NSInteger)numImages fromIndex:(NSInteger)index;
- (NSArray*)getAssets:(NSInteger)numImages fromIndex:(NSInteger)index;


@end


