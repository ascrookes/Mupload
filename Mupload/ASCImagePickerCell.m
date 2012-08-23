//
//  ASCImagePickerCell.m
//  Mupload
//
//  Created by Amadou Crookes on 8/21/12.
//  Copyright (c) 2012 Amadou Crookes. All rights reserved.
//

#import "ASCImagePickerCell.h"

@implementation ASCImagePickerCell

@synthesize image0 = _image0;
@synthesize image1 = _image1;
@synthesize image2 = _image2;
@synthesize image3 = _image3;


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
        [self.image0 setImage:[images objectAtIndex:0] forState:UIControlStateNormal];
    } else {
        [self.image0 setImage:nil forState:UIControlStateNormal];
    }
    if(count > 1) {
        [self.image1 setImage:[images objectAtIndex:1] forState:UIControlStateNormal];
    } else {
        [self.image1 setImage:nil forState:UIControlStateNormal];
    }
    if(count > 2) {
        [self.image2 setImage:[images objectAtIndex:2] forState:UIControlStateNormal];
    } else {
        [self.image2 setImage:nil forState:UIControlStateNormal];
    }
    if([images count] > 3) {
        [self.image3 setImage:[images objectAtIndex:3] forState:UIControlStateNormal];
    } else {
        [self.image3 setImage:nil forState:UIControlStateNormal];
    }
}


- (IBAction)clickedImage:(UIButton*)sender
{
    if([sender isEqual:self.image0]) {
        NSLog(@"IMAGE 0");
        [self.image0 showSelected];
    } else if([sender isEqual:self.image1]) {
        NSLog(@"IMAGE 1");
        [self.image1 showSelected];
    } else if([sender isEqual:self.image2]) {
        NSLog(@"IMAGE 2");
        [self.image2 showSelected];
    } else if([sender isEqual:self.image3]) {
        NSLog(@"IMAGE 3");
        [self.image3 showSelected];
    }
}


- (ASCImageCellThumbnail*)image0
{
    if(!_image0) {
        _image0 = [[ASCImageCellThumbnail alloc] initWithFrame:CGRectMake(8, 4, 70, 70)];
        [self.contentView addSubview:_image0];
        [_image0 addTarget:self action:@selector(clickedImage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _image0;
}

- (ASCImageCellThumbnail*)image1
{
    if(!_image1) {
        _image1 = [[ASCImageCellThumbnail alloc] initWithFrame:CGRectMake(86, 4, 70, 70)];
        [self.contentView addSubview:_image1];
        [_image1 addTarget:self action:@selector(clickedImage:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _image1;
}

- (ASCImageCellThumbnail*)image2
{
    if(!_image2) {
        _image2 = [[ASCImageCellThumbnail alloc] initWithFrame:CGRectMake(164, 4, 70, 70)];
        [self.contentView addSubview:_image2];
        [_image2 addTarget:self action:@selector(clickedImage:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _image2;
}

- (ASCImageCellThumbnail*)image3
{
    if(!_image3) {
        _image3 = [[ASCImageCellThumbnail alloc] initWithFrame:CGRectMake(242, 4, 70, 70)];
        [self.contentView addSubview:_image3];
        [_image3 addTarget:self action:@selector(clickedImage:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _image3;
}










@end
