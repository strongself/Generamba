//
//  Presenter.m
//  GenerambaTestProject
//
//  Created by Egor Tolstoy on  31/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "RDSLoginPresenter.h"

#import "RDSLoginViewInput.h"
#import "RDSLoginInteractorInput.h"
#import "RDSLoginRouterInput.h"

@implementation RDSLoginPresenter

#pragma mark - Методы RDSLoginModuleInput

- (void)configureCurrentModule {
    [self.view setupInitialState];
}

#pragma mark - Методы RDSLoginInteractorOutput

#pragma mark - Методы RDSLoginViewOutput

@end