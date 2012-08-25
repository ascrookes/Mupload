//
//  ASCImagePickerCell.h
//  Mupload
//
//  Created by Amadou Crookes on 8/21/12.
//  Copyright (c) 2012 Amadou Crookes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASCImageCellThumbnail.h"

@class ASCImagePickerCell;

@protocol ASCImagePickerCellDelegate <NSObject>

- (void)selectedCell:(ASCImagePickerCell*)cell withImageAtIndex:(NSInteger)index;

@end

@interface ASCImagePickerCell : UITableViewCell

@property (strong, nonatomic) IBOutlet ASCImageCellThumbnail *image0;
@property (strong, nonatomic) IBOutlet ASCImageCellThumbnail *image1;
@property (strong, nonatomic) IBOutlet ASCImageCellThumbnail *image2;
@property (strong, nonatomic) IBOutlet ASCImageCellThumbnail *image3;
@property (strong, nonatomic) id <ASCImagePickerCellDelegate> delegate;


- (void)setupCellWithImages:(NSArray*)images;
- (void)reselectImages:(NSArray*)selected;


@end
