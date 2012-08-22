//
//  ASCImagePicker.m
//  Mupload
//
//  Created by Amadou Crookes on 8/21/12.
//  Copyright (c) 2012 Amadou Crookes. All rights reserved.
//

#import "ASCImagePicker.h"

@interface ASCImagePicker ()

@end

@implementation ASCImagePicker

@synthesize table = _table;
@synthesize imageManager = _imageManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSLog(@"COUNT: %i",[self.imageManager count]);
    self.table.separatorColor = self.table.backgroundColor;
    [self.table reloadData];
    
}

- (void)viewDidUnload
{
    [self setTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"iPhone Image Picker Cell";
    ASCImagePickerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[ASCImagePickerCell alloc] init];
    }
    
    [cell setupCellWithImages:[self.imageManager getImages:4 fromIndex:indexPath.row*4]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rows = [self.imageManager count]/4;
    if([self.imageManager count]%4 != 0) {
        rows++;
    }
    return rows;
}

// called by manager as delegate call
// since it enumerates in a loop it says everytime another group is finished
- (void)enumeratedAGroup
{
    [self.table reloadData];
}



- (ASCImageManager*)imageManager
{
    if(!_imageManager) {
        _imageManager = [ASCImageManager ImageManagerWithPhotoLibrary];
        _imageManager.delegate = self;
    }
    return _imageManager;
}

@end
