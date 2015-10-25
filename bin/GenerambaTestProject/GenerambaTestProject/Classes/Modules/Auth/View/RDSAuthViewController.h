//
//  RDSAuthViewController.h
//  
//
//  Created by Egor Tolstoy on  25/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "RDSAuthViewInput.h"

@protocol RDSAuthViewOutput;

@interface RDSAuthViewController : UIViewController <RDSAuthViewInput>

@property (strong, nonatomic) id<RDSAuthViewOutput> output;

@end