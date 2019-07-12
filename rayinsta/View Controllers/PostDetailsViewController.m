//
//  PostDetailsViewController.m
//  rayinsta
//
//  Created by rhaypapenfuzz on 7/10/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "PostDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "DateTools.h"

@interface PostDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *detailedImage;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

@end

@implementation PostDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PFFileObject *userImage  = self.instaPost.image;
    
    //setting image
    NSString *imageURL = userImage.url;
    NSURL *URL = [NSURL URLWithString:imageURL];
    [self.detailedImage setImageWithURL:URL];
    
    
    NSDate *now = [NSDate date];
    NSDate *date = self.instaPost.createdAt;
    NSString *postedTimeDifference;
    long months = [now monthsFrom:date];
    long days = [now daysFrom:date];
    long hours = [now hoursFrom:date];
    long minutes = [now minutesFrom:date];
    long seconds = [now secondsFrom:date];
    
   if (months == 0){
       
        if (days != 0){
            postedTimeDifference = [[NSString stringWithFormat:@"%lu", days] stringByAppendingString:@" day ago"];
        }
        else if (hours != 0){
            postedTimeDifference = [[NSString stringWithFormat:@"%lu", hours] stringByAppendingString:@" hours ago"];
        }
        else if (minutes != 0){
            postedTimeDifference = [[NSString stringWithFormat:@"%lu", minutes] stringByAppendingString:@" mins ago"];
        }
        else if (seconds != 0){
            postedTimeDifference = [[NSString stringWithFormat:@"%lu", seconds] stringByAppendingString:@" seconds ago"];
        }
        self.timestampLabel.text = postedTimeDifference;
    }
    
    self.captionLabel.text = self.instaPost.caption;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
