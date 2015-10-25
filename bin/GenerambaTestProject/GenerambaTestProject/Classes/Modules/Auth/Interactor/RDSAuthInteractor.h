//
//  RDSAuthInteractor.h
//  
//
//  Created by Egor Tolstoy on  25/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "RDSAuthInteractorInput.h"

@protocol RDSAuthInteractorOutput;

@interface RDSAuthInteractor : NSObject <RDSAuthInteractorInput>

@property (nonatomic, weak) id<RDSAuthInteractorOutput> output;

@end