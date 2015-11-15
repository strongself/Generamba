//
//  AuthorizationPresenter.m
//  GenerambaSandbox
//
//  Created by Egor Tolstoy on 15/11/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "AuthorizationPresenter.h"

#import "AuthorizationViewInput.h"
#import "AuthorizationInteractorInput.h"
#import "AuthorizationRouterInput.h"

@implementation AuthorizationPresenter

#pragma mark - Методы AuthorizationModuleInput

- (void)configureModule {
    // Стартовая конфигурация модуля, не привязанная к состоянию view
}

#pragma mark - Методы AuthorizationViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы AuthorizationInteractorOutput

@end