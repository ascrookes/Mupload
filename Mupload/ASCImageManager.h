//
//  ASCImageManager.h
//  Mupload
//
//  Created by Amadou Crookes on 8/21/12.
//  Copyright (c) 2012 Amadou Crookes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ASCImageManager : NSObject

@property (nonatomic,strong) ALAssetsLibrary* assetsLibrary;
@property (nonatomic,strong) NSMutableArray*  assets;


@end


