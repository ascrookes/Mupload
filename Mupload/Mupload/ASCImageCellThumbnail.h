//
//  ASCImageCellThumbnail.h
//  Mupload
//
//  Created by Amadou Crookes on 8/21/12.
//  Copyright (c) 2012 Amadou Crookes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface ASCImageCellThumbnail : UIButton

@property (nonatomic) BOOL selected;
@property (nonatomic, strong) NSData* originalImageData;


- (void)showSelected;
- (void)resetThumbnail;


@end
