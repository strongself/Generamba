//
//  AssemblyTests.m
//  GenerambaTestProject
//
//  Created by Egor Tolstoy on  31/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <RamblerMcFlurry/Testing.h>
#import <Typhoon/Typhoon.h>

#import "RDSLoginAssembly.h"
#import "RDSLoginAssembly_Testable.h"

#import "RDSLoginViewController.h"
#import "RDSLoginPresenter.h"
#import "RDSLoginInteractor.h"
#import "RDSLoginRouter.h"

@interface RDSLoginAssemblyTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) RDSLoginAssembly *assembly;

@end

@implementation RDSLoginAssemblyTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.assembly = [[RDSLoginAssembly alloc] init];
    [self.assembly activate];
}

- (void)tearDown {
    self.assembly = nil;

    [super tearDown];
}

#pragma mark - Тестирование создания элементов модуля

- (void)testThatAssemblyCreatesViewController {
    // given
    Class targetClass = [RDSLoginViewController class];
    NSArray *dependencies = @[
                              RamblerSelector(output)
                              ];
    // when
    id result = [self.assembly viewLoginModule];

    // then
    [self verifyTargetDependency:result
                       withClass:targetClass
                    dependencies:dependencies];
}

- (void)testThatAssemblyCreatesPresenter {
    // given
    Class targetClass = [RDSLoginPresenter class];
    NSArray *dependencies = @[
                              RamblerSelector(interactor),
                              RamblerSelector(view),
                              RamblerSelector(router)
                              ];
    // when
    RDSLoginPresenter *result = [self.assembly presenterLoginModule];

    // then
    [self verifyTargetDependency:result
                           withClass:targetClass
                        dependencies:dependencies];
}

- (void)testThatAssemblyCreatesInteractor {
    // given
    Class targetClass = [RDSLoginInteractor class];
    NSArray *dependencies = @[
                              RamblerSelector(output)
                              ];
    // when
    id result = [self.assembly interactorLoginModule];

    // then
    [self verifyTargetDependency:result
                       withClass:targetClass
                    dependencies:dependencies];
}

- (void)testThatAssemblyCreatesRouter {
    // given
    Class targetClass = [RDSLoginRouter class];
    NSArray *dependencies = @[
                              RamblerSelector(transitionHandler)
                              ];
    // when
    id result = [self.assembly routerLoginModule];

    // then
    [self verifyTargetDependency:result
                           withClass:targetClass
                        dependencies:dependencies];
}

@end