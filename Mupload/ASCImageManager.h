//
//  ASCImageManager.h
//  Mupload
//
//  Created by Amadou Crookes on 8/21/12.
//  Copyright (c) 2012 Amadou Crookes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"

@protocol ASCImageManagerDelegate <NSObject>

- (void)enumeratedAGroup;

@end


@interface ASCImageManager : NSObject <ASIHTTPRequestDelegate>

@property (nonatomic,strong) ALAssetsLibrary* assetsLibrary;
@property (nonatomic,strong) NSMutableArray*  assets;
@property (nonatomic,strong) NSMutableArray*  selectedAssets;
@property (nonatomic,strong) id <ASCImageManagerDelegate> delegate;

+ (ASCImageManager*)ImageManagerWithPhotoLibrary;
- (void)getAssetsFromPhotoLibrary;
- (UIImage*)getImageAtIndex:(NSInteger)index;
- (int)count;
- (NSArray*)getImages:(NSInteger)numImages fromIndex:(NSInteger)index;
- (NSArray*)getAssets:(NSInteger)numImages fromIndex:(NSInteger)index;
- (NSArray*)getSelected:(NSInteger)numSelected fromIndex:(NSInteger)index;
- (void)selectedAssetAtIndex:(NSInteger)index;
- (NSArray*)getSelectedAssets;
- (void)clearSelected;
- (void)uploadImageToServer:(UIImage*)image;





@end


