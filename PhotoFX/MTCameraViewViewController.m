//
//  MTCameraViewViewController.m
//  PhotoFX
//
//  Created by Patreon Pro on 7/18/14.
//  Copyright (c) 2014 Johnny Winston. All rights reserved.
//

#import "MTCameraViewViewController.h"
#import "GPUImage.h"


@interface MTCameraViewViewController () <UIActionSheetDelegate> {

GPUImageStillCamera *stillCamera;
GPUImageFilter *filter;
    
}

@end

@implementation MTCameraViewViewController

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
    
    // Setup initial camera filter
    filter = [[GPUImageFilter alloc] init];
//    [filter prepareForImageCapture];
    GPUImageView *filterView = (GPUImageView *)self.view;
    [filter addTarget:filterView];
    
    // Create custom GPUImage camera
    stillCamera = [[GPUImageStillCamera alloc] init];
    stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    [stillCamera addTarget:filter];
    
    // Begin showing video camera stream
    [stillCamera startCameraCapture];
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
