//
//  ComposeViewController.m
//  rayinsta
//
//  Created by rhaypapenfuzz on 7/9/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "ComposeViewController.h"
#import "Post.h"
#import "HomeFeedViewController.h"

@interface ComposeViewController () < UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong, nonatomic) UIImage *resizedPhoto;
- (IBAction)cancelButtonAction:(id)sender;
- (IBAction)shareButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *captionText;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageToPost;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)imageTapAction:(id)sender {
    //Instantiating a UIImagePickerController
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
}

// implementing the imagePickerController delegate method
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    // Do something with the images (based on your use case)
    self.resizedPhoto = [self resizeImage:editedImage withSize:CGSizeMake(350, 350)]; //resizing and storing image
    self.selectedImageToPost.image = editedImage; //set selected image in uiview to edited image
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */





//resize image function
- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelButtonAction:(id)sender {
     [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)shareButtonAction:(id)sender{
    [Post postUserImage: self.resizedPhoto withCaption: self.captionText.text withCompletion:nil];
    
    //[self.instaView reloadData]; //reload tableView with new post
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
