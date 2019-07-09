//
//  SignUpViewController.m
//  rayinsta
//
//  Created by rhaypapenfuzz on 7/8/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "SignUpViewController.h"
#import "Parse/Parse.h"

static NSString *const registerBackToLoginSegueIdentifier = @"registerBackToLoginSegue";

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)cancelButtonAction:(id)sender;
- (IBAction)registerButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (IBAction)registerButtonAction:(id)sender {
    
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.email = self.emailField.text;
    newUser.password = self.passwordField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
             [self performSegueWithIdentifier: registerBackToLoginSegueIdentifier sender:nil];
        }
    }];
}

@end
