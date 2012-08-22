//
//  ASCImagePickerCell.m
//  Mupload
//
//  Created by Amadou Crookes on 8/21/12.
//  Copyright (c) 2012 Amadou Crookes. All rights reserved.
//

#import "ASCImagePickerCell.h"

@implementation ASCImagePickerCell
@synthesize image0;
@synthesize image1;
@synthesize image2;
@synthesize image3;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// images should be of length 4, unless it is the last row
// clearing if the image is not there for table reuseable cell reasons
- (void)setupCellWithImages:(NSArray*)images
{
    int count = [images count];
    if(count > 0) {
        self.image0.image = [images objectAtIndex:0];
        //NSLog(@"0 SET");
    } else {
        self.image0.image = nil;
    }
    if(count > 1) {
        self.image1.image = [images objectAtIndex:1];
        //NSLog(@"1 SET");
    } else {
        self.image1.image = nil;
    }
    if(count > 2) {
        self.image2.image = [images objectAtIndex:2];
        //NSLog(@"2 SET");
    } else {
        self.image2.image = nil;
    }
    if([images count] > 3) {
        self.image3.image = [images objectAtIndex:3];
        //NSLog(@"3 SET");
    } else {
        self.image3.image = nil;
    }
}


@end
