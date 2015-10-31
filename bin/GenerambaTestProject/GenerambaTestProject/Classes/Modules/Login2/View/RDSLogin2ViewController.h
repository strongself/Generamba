//
//  RDSLogin2ViewController.h
//  GenerambaTestProject
//
//  Created by Egor Tolstoy on 31/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RDSLogin2ViewInput.h"

@protocol RDSLogin2ViewOutput;

@interface RDSLogin2ViewController : UIViewController <RDSLogin2ViewInput>

@property (strong, nonatomic) id<RDSLogin2ViewOutput> output;

@end