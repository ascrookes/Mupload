//
//  ASCImagePicker.h
//  Mupload
//
//  Created by Amadou Crookes on 8/21/12.
//  Copyright (c) 2012 Amadou Crookes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASCImageManager.h"
#import "ASCImagePickerCell.h"

@interface ASCImagePicker : UIViewController <UITableViewDataSource, UITableViewDelegate, ASCImageManagerDelegate>

@property (nonatomic,weak) IBOutlet UITableView* table;
@property (nonatomic,strong) ASCImageManager* imageManager;

- (void)enumeratedAGroup;


@end