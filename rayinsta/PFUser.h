//
//  user.h
//  rayinsta
//
//  Created by rhaypapenfuzz on 7/8/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PFUser : NSObject
// MARK: Properties
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
//...
// Add any additional properties here

// TODO: Create initializer
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END



