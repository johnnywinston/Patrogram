//
//  MTCameraViewController.m
//  PhotoFX
//
//  Created by Patreon Pro on 7/18/14.
//  Copyright (c) 2014 Johnny Winston. All rights reserved.
//

#import "MTCameraViewController.h"
#import "GPUImage.h"
//#import "GPUImageOutput.h"
//#import "GPUImagePicture.h"

@interface MTCameraViewController () <UIActionSheetDelegate> {
    GPUImageStillCamera *stillCamera;
    GPUImageFilter *filter;
}

@end

@implementation MTCameraViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add Filter Button to Interface
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(applyImageFilter:)];
    self.navigationItem.rightBarButtonItem = filterButton;
    
    // Setup initial camera filter
    filter = [[GPUImageFilter alloc] init];
    GPUImageView *filterView = (GPUImageView *)self.view;
    [filter addTarget:filterView];
    
    // Create custom GPUImage camera
    stillCamera = [[GPUImageStillCamera alloc] init];
    stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    [stillCamera addTarget:filter];
    
    // Begin showing video camera stream
    [stillCamera startCameraCapture];
    
    
    
}

- (IBAction)applyImageFilter:(id)sender
{
    UIActionSheet *filterActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Filter"
                                                                   delegate:self
                                                          cancelButtonTitle:@"Cancel"
                                                     destructiveButtonTitle:nil
                                                          otherButtonTitles:@"Grayscale", @"Sepia", @"Sketch", @"Pixellate", @"Color Invert", @"Toon", @"Pinch Distort", @"None", nil];
    
    [filterActionSheet showFromBarButtonItem:sender animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // Bail if the cancel button was tapped
    if(actionSheet.cancelButtonIndex == buttonIndex)
    {
        return;
    }
    
    GPUImageFilter *selectedFilter;
    
    [stillCamera removeAllTargets];
    [filter removeAllTargets];
    
    
    switch (buttonIndex) {
        case 0:
            selectedFilter = [[GPUImageGrayscaleFilter alloc] init];
            break;
        case 1:
            selectedFilter = [[GPUImageSepiaFilter alloc] init];
            break;
        case 2:
            selectedFilter = [[GPUImageSketchFilter alloc] init];
            break;
        case 3:
            selectedFilter = [[GPUImagePixellateFilter alloc] init];
            break;
        case 4:
            selectedFilter = [[GPUImageColorInvertFilter alloc] init];
            break;
        case 5:
            selectedFilter = [[GPUImageToonFilter alloc] init];
            break;
        case 6:
            selectedFilter = [[GPUImagePinchDistortionFilter alloc] init];
            break;
        case 7:
            selectedFilter = [[GPUImageFilter alloc] init];
            break;
        default:
            break;
    }
    
    filter = selectedFilter;
    GPUImageView *filterView = (GPUImageView *)self.view;
    [filter addTarget:filterView];
    [stillCamera addTarget:filter];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
