//
//  RDSAuthPresenter.m
//  
//
//  Created by Egor Tolstoy on  25/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "RDSAuthPresenter.h"

#import "RDSAuthViewInput.h"
#import "RDSAuthInteractorInput.h"
#import "RDSAuthRouterInput.h"

@implementation RDSAuthPresenter

#pragma mark - Методы RDSAuthModuleInput

- (void)configureCurrentModule {
    [self.view setupInitialState];
}

#pragma mark - Методы RDSAuthInteractorOutput

#pragma mark - Методы RDSAuthViewOutput

@end