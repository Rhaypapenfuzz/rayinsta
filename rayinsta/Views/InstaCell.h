//
//  InstaCell.h
//  rayinsta
//
//  Created by rhaypapenfuzz on 7/9/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InstaCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *allCommentsButton;
@property (weak, nonatomic) IBOutlet UIButton *likesButton;


/*
 userID
 @property (nonatomic, strong) NSString *postID;
 PFUser author ;
 PFUser *author;
*/

@end

NS_ASSUME_NONNULL_END
