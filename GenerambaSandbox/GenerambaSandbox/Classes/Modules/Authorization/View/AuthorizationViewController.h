//
//  AuthorizationViewController.h
//  GenerambaSandbox
//
//  Created by Egor Tolstoy on 01/11/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AuthorizationViewInput.h"

@protocol AuthorizationViewOutput;

@interface AuthorizationViewController : UIViewController <AuthorizationViewInput>

@property (strong, nonatomic) id<AuthorizationViewOutput> output;

@end