//
//  ASCImageCellThumbnail.m
//  Mupload
//
//  Created by Amadou Crookes on 8/21/12.
//  Copyright (c) 2012 Amadou Crookes. All rights reserved.
//

#import "ASCImageCellThumbnail.h"

@implementation ASCImageCellThumbnail

@synthesize selected;
@synthesize originalImageData;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selected = NO;
        self.originalImageData = nil;
    }
    return self;
}


- (void)showSelected
{
    if(self.selected) {
        self.selected = NO;
        [self setImage:[UIImage imageWithData:self.originalImageData] forState:UIControlStateNormal];
    } else {
        self.selected = YES;
        self.originalImageData = UIImagePNGRepresentation(self.imageView.image);
        [self addOverlay];
    }
}

- (void)resetThumbnail
{
    self.originalImageData = nil;
    self.selected = NO;
}

- (void)addOverlay
{
    CGRect frame = CGRectMake(0, 0, 70, 70);
    UIImage* image = self.imageView.image;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(70, 70), NO, 0.0);
    [image drawInRect:frame];
    [[UIImage imageNamed:@"picker.png"] drawInRect:frame];
    [self setImage:UIGraphicsGetImageFromCurrentImageContext() forState:UIControlStateNormal];
    UIGraphicsEndImageContext();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


@end
