//
//  Post.h
//  rayinsta
//
//  Created by rhaypapenfuzz on 7/9/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <Parse/Parse.h>
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface Post : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFFileObject *image;

@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) NSNumber *commentCount;

@property (nonatomic) BOOL favorited; // To configure the favorite button

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;



@end

NS_ASSUME_NONNULL_END


