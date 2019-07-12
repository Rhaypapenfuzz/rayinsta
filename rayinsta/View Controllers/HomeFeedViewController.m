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
#import "PostDetailsViewController.h"
#import "AppDelegate.h"
#import "Post.h"
#import "InstaCell.h"
#import "UIImageView+AFNetworking.h"

@interface HomeFeedViewController () <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *instaView;
- (IBAction)LogoutButtonAction:(id)sender;
@property (nonatomic, strong) NSMutableArray *InstaPostsArray;
@property(nonatomic, strong) UIRefreshControl *refreshControl;
@property (assign, nonatomic) BOOL isMoreDataLoading;
//@property (nonatomic, strong) NSArray<Post*> *InstaPosts;

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
    [query includeKey:@"author"];
    [query orderByDescending:@"createdAt"];
    query.limit = 4;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.InstaPostsArray = posts; //[NSMutableArray arrayWithArray:posts];
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

    cell.authorNameLabel.text = post.author.username;
    cell.likesCountLabel.text = [NSString stringWithFormat:@"%@%s", post.likeCount, " likes"];
    
    //add tap gesture on label programatically

    return cell;
    
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.InstaPostsArray.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"detailsViewSegue"]){
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.instaView indexPathForCell:tappedCell];
        PostDetailsViewController *detailsViewController = [segue destinationViewController];
        Post *post = self.InstaPostsArray[indexPath.row];
        detailsViewController.instaPost = post;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(!self.isMoreDataLoading){
        // Calculate the position of one screen length before the bottom of the results
        int scrollViewContentHeight = self.instaView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.instaView.bounds.size.height;
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.instaView.isDragging) {
            self.isMoreDataLoading = true;
            [self loadMoreData];
        }
    }
}

-(void)loadMoreData{
    
    // ... Create (myRequest) ...
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query includeKey:@"author"];
    [query orderByDescending:@"createdAt"];
    query.limit = 4;
    
    Post *post = self.InstaPostsArray[self.InstaPostsArray.count - 1];
    NSDate *dateOfMyLastPost = post.createdAt;
    
    [query whereKey:@"createdAt" lessThan: dateOfMyLastPost];
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if ([posts count] != 0) {
            // do something with the array of object returned by the call
            self.InstaPostsArray = [self.InstaPostsArray arrayByAddingObjectsFromArray:posts];
           
            //self.InstaPostsArray = [NSMutableArray arrayWithArray:posts];

            // Update flag
            self.isMoreDataLoading = false;
            [self.instaView reloadData]; //reloads tableView
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];


}


@end
