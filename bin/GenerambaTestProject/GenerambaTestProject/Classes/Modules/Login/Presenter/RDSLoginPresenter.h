//
//  Presenter.h
//  GenerambaTestProject
//
//  Created by Egor Tolstoy on  31/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "RDSLoginViewOutput.h"
#import "RDSLoginInteractorOutput.h"
#import "RDSLoginModuleInput.h"

@protocol RDSLoginViewInput;
@protocol RDSLoginInteractorInput;
@protocol RDSLoginRouterInput;

@interface RDSLoginPresenter : NSObject <RDSLoginModuleInput, RDSLoginViewOutput, RDSLoginInteractorOutput>

@property (nonatomic, weak) id<RDSLoginViewInput> view;
@property (nonatomic, strong) id<RDSLoginInteractorInput> interactor;
@property (nonatomic, strong) id<RDSLoginRouterInput> router;

@end