//
//  AuthorizationInteractorTests.m
//  GenerambaSandbox
//
//  Created by Egor Tolstoy on 01/11/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "AuthorizationInteractor.h"

#import "AuthorizationInteractorOutput.h"

@interface AuthorizationInteractorTests : XCTestCase

@property (strong, nonatomic) AuthorizationInteractor *interactor;

@property (strong, nonatomic) id mockOutput;

@end

@implementation AuthorizationInteractorTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.interactor = [[AuthorizationInteractor alloc] init];

    self.mockOutput = OCMProtocolMock(@protocol(AuthorizationInteractorOutput));

    self.interactor.output = self.mockOutput;
}

- (void)tearDown {
    self.interactor = nil;

    self.mockOutput = nil;

    [super tearDown];
}

#pragma mark - Тестирование методов AuthorizationInteractorInput

@end