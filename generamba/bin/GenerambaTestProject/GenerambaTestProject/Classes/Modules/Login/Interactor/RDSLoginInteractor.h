//
//  Interactor.h
//  GenerambaTestProject
//
//  Created by Egor Tolstoy on  31/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "RDSLoginInteractorInput.h"

@protocol RDSLoginInteractorOutput;

@interface RDSLoginInteractor : NSObject <RDSLoginInteractorInput>

@property (nonatomic, weak) id<RDSLoginInteractorOutput> output;

@end