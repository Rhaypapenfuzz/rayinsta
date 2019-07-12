//
//  profileViewCollectionCell.h
//  rayinsta
//
//  Created by rhaypapenfuzz on 7/11/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *pastImage;
@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
