//
//  PresenterTests.m
//  GenerambaTestProject
//
//  Created by Egor Tolstoy on  31/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "RDSLoginPresenter.h"

#import "RDSLoginViewInput.h"
#import "RDSLoginInteractorInput.h"
#import "RDSLoginRouterInput.h"

@interface RDSLoginPresenterTests : XCTestCase

@property (strong, nonatomic) RDSLoginPresenter *presenter;

@property (strong, nonatomic) id mockInteractor;
@property (strong, nonatomic) id mockRouter;
@property (strong, nonatomic) id mockView;

@end

@implementation RDSLoginPresenterTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.presenter = [[RDSLoginPresenter alloc] init];

    self.mockInteractor = OCMProtocolMock(@protocol(RDSLoginInteractorInput));
    self.mockRouter = OCMProtocolMock(@protocol(RDSLoginRouterInput));
    self.mockView = OCMProtocolMock(@protocol(RDSLoginViewInput));

    self.presenter.interactor = self.mockInteractor;
    self.presenter.router = self.mockRouter;
    self.presenter.view = self.mockView;
}

- (void)tearDown {
    self.presenter = nil;

    self.mockView = nil;
    self.mockRouter = nil;
    self.mockInteractor = nil;

    [super tearDown];
}

#pragma mark - Тестирование методов RDSLoginModuleInput

- (void)testThatPresenterConfiguresModule {
    // given


    // when
    [self.presenter configureCurrentModule];

    // then
    OCMVerify([self.mockView setupInitialState]);
}

#pragma mark - Тестирование методов RDSLoginViewOutput

#pragma mark - Тестирование методов RDSLoginInteractorOutput

@end