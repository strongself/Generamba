//
//  AuthorizationPresenter.h
//  GenerambaSandbox
//
//  Created by Egor Tolstoy on 15/11/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "AuthorizationViewOutput.h"
#import "AuthorizationInteractorOutput.h"
#import "AuthorizationModuleInput.h"

@protocol AuthorizationViewInput;
@protocol AuthorizationInteractorInput;
@protocol AuthorizationRouterInput;

@interface AuthorizationPresenter : NSObject <AuthorizationModuleInput, AuthorizationViewOutput, AuthorizationInteractorOutput>

@property (nonatomic, weak) id<AuthorizationViewInput> view;
@property (nonatomic, strong) id<AuthorizationInteractorInput> interactor;
@property (nonatomic, strong) id<AuthorizationRouterInput> router;

@end