//
//  RDSLogin2Presenter.m
//  GenerambaTestProject
//
//  Created by Egor Tolstoy on 31/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "RDSLogin2Presenter.h"

#import "RDSLogin2ViewInput.h"
#import "RDSLogin2InteractorInput.h"
#import "RDSLogin2RouterInput.h"

@implementation RDSLogin2Presenter

#pragma mark - Методы RDSLogin2ModuleInput

- (void)configureCurrentModule {
    [self.view setupInitialState];
}

#pragma mark - Методы RDSLogin2InteractorOutput

#pragma mark - Методы RDSLogin2ViewOutput

@end