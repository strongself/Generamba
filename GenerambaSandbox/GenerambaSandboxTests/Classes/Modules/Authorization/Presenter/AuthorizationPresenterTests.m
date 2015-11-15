//
//  AuthorizationPresenterTests.m
//  GenerambaSandbox
//
//  Created by Egor Tolstoy on 15/11/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "AuthorizationPresenter.h"

#import "AuthorizationViewInput.h"
#import "AuthorizationInteractorInput.h"
#import "AuthorizationRouterInput.h"

@interface AuthorizationPresenterTests : XCTestCase

@property (strong, nonatomic) AuthorizationPresenter *presenter;

@property (strong, nonatomic) id mockInteractor;
@property (strong, nonatomic) id mockRouter;
@property (strong, nonatomic) id mockView;

@end

@implementation AuthorizationPresenterTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.presenter = [[AuthorizationPresenter alloc] init];

    self.mockInteractor = OCMProtocolMock(@protocol(AuthorizationInteractorInput));
    self.mockRouter = OCMProtocolMock(@protocol(AuthorizationRouterInput));
    self.mockView = OCMProtocolMock(@protocol(AuthorizationViewInput));

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

#pragma mark - Тестирование методов AuthorizationModuleInput

#pragma mark - Тестирование методов AuthorizationViewOutput

- (void)testThatPresenterHandlesViewReadyEvent {
    // given


    // when
    [self.presenter didTriggerViewReadyEvent];

    // then
    OCMVerify([self.mockView setupInitialState]);
}

#pragma mark - Тестирование методов AuthorizationInteractorOutput

@end