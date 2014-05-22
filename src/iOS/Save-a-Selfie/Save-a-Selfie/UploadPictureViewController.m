//
//  UploadPictureViewController.m
//  Save-a-Selfie
//
//  Created by Nadja Deininger on 12/05/14.
//  Copyright (c) 2014 Code for All Ireland. All rights reserved.
//

#import "UploadPictureViewController.h"

@interface UploadPictureViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *selectButton;

@end

@implementation UploadPictureViewController

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
    self.picker = [[UIImagePickerController alloc] init];
    _picker.delegate = self;
    
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
- (IBAction)handleSelectClick:(id)sender {
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"Select image source" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take photo", @"Choose from existing", nil];
    as.tag = 1;
    [as showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    [self useCamera];
                    break;
                case 1:
                    [self useCameraRoll];
                    break;
            }
            break;
        }
        default:
            break;
    }
}

// todo: if no camera is available, don't even show the button, but this works for now
- (IBAction)useCamera {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [_picker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:_picker animated:YES completion:nil];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Camera could not be found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)useCameraRoll {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [_picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:_picker animated:YES completion:nil];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Photo library could not be found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    
    [self.picker dismissViewControllerAnimated:NO completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *imageToSave;
    if([info objectForKey:UIImagePickerControllerEditedImage]) {
        imageToSave = info[UIImagePickerControllerEditedImage];
    }
    else if([info objectForKey:UIImagePickerControllerOriginalImage]) {
        imageToSave = info[UIImagePickerControllerOriginalImage];
    }
    else {UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Selected image could not be found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    [_imageView setImage:imageToSave];
    [self.picker dismissViewControllerAnimated:YES completion:nil];
    
}

@end
