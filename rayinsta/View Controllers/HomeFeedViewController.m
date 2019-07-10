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

@end

@implementation HomeFeedViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self constructQuery];
    self.instaView.delegate = self;
    self.instaView.dataSource = self;
    self.instaView.rowHeight = 600;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init]; //Initializing a UIRefreshControl
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.instaView insertSubview:refreshControl atIndex:0]; //Insert the refresh control into the list
    /*
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            self.InstaPostsArray = [NSMutableArray arrayWithArray:posts];
        }
        else {
            // handle error
        }
        [self.instaView reloadData];
    }];
     */
    
    //self.homeFeedView.dataSource = self; //view controller becomes its own dataSource
    //self.homeFeedView.delegate = self;  //view controller becomes its own delegate
    //self.homeFeedView.rowHeight = 180;
    
    // Get timeline
   /*
    {//make an API request
        if (tweets) {
            //stored the tweet data and display it
            self.feed = (NSMutableArray *) feeds;
            [self.homeFeedView reloadData]; //reload tableView
            NSLog(@"😎😎😎 Successfully loaded home feed");
        } else {
            NSLog(@"😫😫😫 Error getting home feed: %@", error.localizedDescription);
        }
        
    }];*/
   
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
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.instaView reloadData];
    }];
}
// Makes a network request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    
    // Create NSURL and NSURLRequest
//
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
//    delegate:nil
//    delegateQueue:[NSOperationQueue mainQueue]];
//    session.configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
//
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
//     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//
//      // ... Use the new data to update the data source ...
//
//     // Reload the tableView now that there is new data
//     [self.InstaView reloadData];
//
//    // Tell the refreshControl to stop spinning
//    [refreshControl endRefreshing];
// 
//    }];
//
//    [task resume];
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
    
    // NSLog(@"%@", message);
    cell.captionLabel.text = post.caption;
    
    //NSLog(@"%@", cell.captionLabel.text);
    
    /*@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;
     @property (weak, nonatomic) IBOutlet UILabel *likesCountLabel;
     @property (weak, nonatomic) IBOutlet UILabel *captionLabel;
     @property (weak, nonatomic) IBOutlet UIImageView *image;
     @property (weak, nonatomic) IBOutlet UIButton *commentButton;
     @property (weak, nonatomic) IBOutlet UIButton *allCommentsButton;
     @property (weak, nonatomic) IBOutlet UIButton *likesButton;*/
    return cell;
    
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.InstaPostsArray.count;
}



@end
