//
//  RDSAuthPresenter.h
//  
//
//  Created by Egor Tolstoy on  25/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "RDSAuthViewOutput.h"
#import "RDSAuthInteractorOutput.h"

@protocol RDSAuthViewInput;
@protocol RDSAuthInteractorInput;
@protocol RDSAuthRouterInput;

@interface RDSAuthPresenter : NSObject <RDSAuthModuleInput, RDSAuthViewOutput, RDSAuthInteractorOutput>

@property (nonatomic, weak) id<RDSAuthViewInput> view;
@property (nonatomic, strong) id<RDSAuthInteractorInput> interactor;
@property (nonatomic, strong) id<RDSAuthRouterInput> router;

@end