//
//  ViewController.m
//  rayinsta
//
//  Created by rhaypapenfuzz on 7/8/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//
#import "LoginViewController.h"
#import "Parse/Parse.h"

static NSString *const signUpSegueIdentifier = @"signUpSegue";
static NSString *const loginSegueIdentifier = @"loginSegue";
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;


- (IBAction)signUpButtonAction:(id)sender;
- (IBAction)loginButtonAction:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)loginUser {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            [self performSegueWithIdentifier: loginSegueIdentifier sender:nil]; //performs segue to login if user is valid
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
        }
    }];
}

- (IBAction)signUpButtonAction:(id)sender {
    [self performSegueWithIdentifier: signUpSegueIdentifier sender:nil];
}

- (IBAction)loginButtonAction:(id)sender {
        [self loginUser]; //calls the parse login authentication method to verify user
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString: signUpSegueIdentifier]){
        
    }
    
}
- (IBAction)tapOutsideTextFieldAction:(id)sender {
     [self.view endEditing:YES];
}

@end
