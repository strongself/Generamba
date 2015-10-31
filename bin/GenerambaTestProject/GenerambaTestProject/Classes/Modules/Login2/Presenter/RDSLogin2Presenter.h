//
//  RDSLogin2Presenter.h
//  GenerambaTestProject
//
//  Created by Egor Tolstoy on 31/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "RDSLogin2ViewOutput.h"
#import "RDSLogin2InteractorOutput.h"
#import "RDSLogin2ModuleInput.h"

@protocol RDSLogin2ViewInput;
@protocol RDSLogin2InteractorInput;
@protocol RDSLogin2RouterInput;

@interface RDSLogin2Presenter : NSObject <RDSLogin2ModuleInput, RDSLogin2ViewOutput, RDSLogin2InteractorOutput>

@property (nonatomic, weak) id<RDSLogin2ViewInput> view;
@property (nonatomic, strong) id<RDSLogin2InteractorInput> interactor;
@property (nonatomic, strong) id<RDSLogin2RouterInput> router;

@end