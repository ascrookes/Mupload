//
//  ASCImagePickerCell.h
//  Mupload
//
//  Created by Amadou Crookes on 8/21/12.
//  Copyright (c) 2012 Amadou Crookes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASCImageCellThumbnail.h"

@interface ASCImagePickerCell : UITableViewCell

@property (strong, nonatomic) IBOutlet ASCImageCellThumbnail *image0;
@property (strong, nonatomic) IBOutlet ASCImageCellThumbnail *image1;
@property (strong, nonatomic) IBOutlet ASCImageCellThumbnail *image2;
@property (strong, nonatomic) IBOutlet ASCImageCellThumbnail *image3;


- (void)setupCellWithImages:(NSArray*)images;


@end
