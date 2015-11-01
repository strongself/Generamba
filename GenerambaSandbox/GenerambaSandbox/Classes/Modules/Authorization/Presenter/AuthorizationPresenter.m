//
//  AuthorizationPresenter.m
//  GenerambaSandbox
//
//  Created by Egor Tolstoy on 01/11/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "AuthorizationPresenter.h"

#import "AuthorizationViewInput.h"
#import "AuthorizationInteractorInput.h"
#import "AuthorizationRouterInput.h"

@implementation AuthorizationPresenter

#pragma mark - Методы AuthorizationModuleInput

- (void)configureCurrentModule {
    [self.view setupInitialState];
}

#pragma mark - Методы AuthorizationInteractorOutput

#pragma mark - Методы AuthorizationViewOutput

@end