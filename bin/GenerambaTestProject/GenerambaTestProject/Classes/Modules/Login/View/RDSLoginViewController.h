//
//  ViewController.h
//  GenerambaTestProject
//
//  Created by Egor Tolstoy on  31/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RDSLoginViewInput.h"

@protocol RDSLoginViewOutput;

@interface RDSLoginViewController : UIViewController <RDSLoginViewInput>

@property (strong, nonatomic) id<RDSLoginViewOutput> output;

@end