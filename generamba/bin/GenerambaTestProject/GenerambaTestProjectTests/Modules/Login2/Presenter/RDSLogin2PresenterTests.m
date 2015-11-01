//
//  RDSLogin2PresenterTests.m
//  GenerambaTestProject
//
//  Created by Egor Tolstoy on 31/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "RDSLogin2Presenter.h"

#import "RDSLogin2ViewInput.h"
#import "RDSLogin2InteractorInput.h"
#import "RDSLogin2RouterInput.h"

@interface RDSLogin2PresenterTests : XCTestCase

@property (strong, nonatomic) RDSLogin2Presenter *presenter;

@property (strong, nonatomic) id mockInteractor;
@property (strong, nonatomic) id mockRouter;
@property (strong, nonatomic) id mockView;

@end

@implementation RDSLogin2PresenterTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.presenter = [[RDSLogin2Presenter alloc] init];

    self.mockInteractor = OCMProtocolMock(@protocol(RDSLogin2InteractorInput));
    self.mockRouter = OCMProtocolMock(@protocol(RDSLogin2RouterInput));
    self.mockView = OCMProtocolMock(@protocol(RDSLogin2ViewInput));

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

#pragma mark - Тестирование методов RDSLogin2ModuleInput

- (void)testThatPresenterConfiguresModule {
    // given


    // when
    [self.presenter configureCurrentModule];

    // then
    OCMVerify([self.mockView setupInitialState]);
}

#pragma mark - Тестирование методов RDSLogin2ViewOutput

#pragma mark - Тестирование методов RDSLogin2InteractorOutput

@end