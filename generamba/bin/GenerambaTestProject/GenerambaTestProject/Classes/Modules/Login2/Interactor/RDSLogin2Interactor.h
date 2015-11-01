//
//  RDSLogin2Interactor.h
//  GenerambaTestProject
//
//  Created by Egor Tolstoy on 31/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "RDSLogin2InteractorInput.h"

@protocol RDSLogin2InteractorOutput;

@interface RDSLogin2Interactor : NSObject <RDSLogin2InteractorInput>

@property (nonatomic, weak) id<RDSLogin2InteractorOutput> output;

@end