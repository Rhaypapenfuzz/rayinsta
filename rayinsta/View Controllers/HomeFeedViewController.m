//
//  HomeFeedViewController.m
//  rayinsta
//
//  Created by rhaypapenfuzz on 7/8/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "HomeFeedViewController.h"
#import "Parse/Parse.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "Post.h"
#import "InstaCell.h"
#import "UIImageView+AFNetworking.h"

@interface HomeFeedViewController () <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet UITableView *instaView;
- (IBAction)LogoutButtonAction:(id)sender;
@property (nonatomic, strong) NSMutableArray *InstaPostsArray;
@property(nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation HomeFeedViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self constructQuery];
    self.instaView.delegate = self;
    self.instaView.dataSource = self;
    self.instaView.rowHeight = 570;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];  //Initializing a UIRefreshControl
    [refreshControl addTarget:self action:@selector(constructQuery) forControlEvents:UIControlEventValueChanged];
    [self.instaView insertSubview:refreshControl atIndex:0];  //Insert the refresh control into the list
    
}

- (void) constructQuery{
    
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
             self.InstaPostsArray = [NSMutableArray arrayWithArray:posts];
            [self.instaView reloadData]; //reloads tableView
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}

- (IBAction)LogoutButtonAction:(id)sender {
    
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    InstaCell *cell = [self.instaView dequeueReusableCellWithIdentifier:@"InstaCell" forIndexPath:indexPath];
    
    Post *post  = self.InstaPostsArray[indexPath.row];
    
    
    PFFileObject *userImage  = post.image;
    NSString *imageURL = userImage.url;
    NSURL *URL = [NSURL URLWithString:imageURL];
    [cell.postImage setImageWithURL:URL];
    
    
    cell.captionLabel.text = post.caption;
    //cell.authorNameLabel.text = [NSString stringWithFormat:@"%@", post.author.username];
    cell.likesCountLabel.text = [NSString stringWithFormat:@"%@%s", post.likeCount, " likes"];

    //NSString *date = post.createdAt;
    //cell.dateLabel.text = date;
    // NSLog(@"%@", message);

    return cell;
    
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.InstaPostsArray.count;
}



@end
