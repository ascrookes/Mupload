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
        cell = [[ASCImagePickerCell alloc] initWithFrame:CGRectMake(0, 0, 320, 78)];
    }
    [cell setupCellWithImages:[self.imageManager getImages:4 fromIndex:indexPath.row*4]];
    [cell reselectImages:[self.imageManager getSelected:4 fromIndex:indexPath.row*4]];
    cell.delegate = self;

    return cell;
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


- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

// called by manager as delegate call
// since it enumerates in a loop it says everytime another group is finished
- (void)enumeratedAGroup
{
    [self.table reloadData];
}


// called by cell when an image is selected
// pass that information to the manager and toggle selected things
- (void)selectedCell:(ASCImagePickerCell *)cell withImageAtIndex:(NSInteger)index
{
    NSIndexPath* cellIndexPath = [self.table indexPathForCell:cell];
    int imageIndex = (cellIndexPath.row * 4) + index;
    [self.imageManager selectedAssetAtIndex:imageIndex];
}


- (IBAction)upload:(id)sender
{
    NSArray* assets = [self.imageManager getSelectedAssets];
    NSLog(@"SELECTED ASSETS COUNT: %i",[assets count]);
    // Show activity indicator
    // Offload the data to a server
    // Send them to selected social networks
    
    //[self.imageManager clearSelected];
    //[self.table reloadData];
    UIImage* image;
    NSURL* url2 = [NSURL URLWithString:@"http://ascrookes.webfactional.com/api"];
    NSURL* url = [NSURL URLWithString:@"http://www.eecs.tufts.edu/~acrook01/files/joey.json"];
    if([assets count] > 0) {
        image = [UIImage imageWithCGImage:[[assets lastObject] thumbnail]];
    } else {
        return;
    }

/*
    ASIFormDataRequest* formRequest = [ASIFormDataRequest requestWithURL:url2];
    //[formRequest setPostFormat:ASIMultipartFormDataPostFormat];
    formRequest.delegate = self;
    [formRequest setData:UIImageJPEGRepresentation(image, 1.0f) withFileName:@"yolotiger.jpg" andContentType:@"image/jpeg" forKey:@"image"];
    [formRequest setPostValue:@"Dougle" forKey:@"name"];
    [formRequest setRequestMethod:@"POST"];
    [formRequest startAsynchronous];
 */
    [self.imageManager uploadImageToServer:image];
}


- (void)requestStarted:(ASIHTTPRequest *)request
{
    //NSLog(@"started");
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"finished: [%@]\n[%i]\n[%@]", [request responseString], [request responseStatusCode], [request responseString]);
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"failed: [%@]\n[%i]", [request responseStatusMessage], [request responseStatusCode]);
}


- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data
{
    NSLog(@"got data: [%@]\n[%i]", [request responseStatusMessage], [request responseStatusCode]);
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
