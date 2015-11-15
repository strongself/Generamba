//
//  AuthorizationViewController.h
//  GenerambaSandbox
//
//  Created by Egor Tolstoy on 15/11/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AuthorizationViewInput.h"

@protocol AuthorizationViewOutput;

@interface AuthorizationViewController : UIViewController <AuthorizationViewInput>

@property (nonatomic, strong) id<AuthorizationViewOutput> output;

@end