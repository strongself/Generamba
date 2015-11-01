//
//  AuthorizationViewControllerTests.m
//  GenerambaSandbox
//
//  Created by Egor Tolstoy on 01/11/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "AuthorizationViewController.h"

#import "AuthorizationViewOutput.h"

@interface AuthorizationViewControllerTests : XCTestCase

@property (strong, nonatomic) AuthorizationViewController *controller;

@property (strong, nonatomic) id mockOutput;

@end

@implementation AuthorizationViewControllerTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.controller = [[AuthorizationViewController alloc] init];

    self.mockOutput = OCMProtocolMock(@protocol(AuthorizationViewOutput));

    self.controller.output = self.mockOutput;
}

- (void)tearDown {
    self.controller = nil;

    self.mockOutput = nil;

    [super tearDown];
}

#pragma mark - Тестирование жизненного цикла

#pragma mark - Тестирование методов интерфейса

#pragma mark - Тестирование методов AuthorizationViewInput

@end