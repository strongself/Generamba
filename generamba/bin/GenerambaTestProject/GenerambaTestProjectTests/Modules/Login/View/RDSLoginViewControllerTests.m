//
//  ViewControllerTests.m
//  GenerambaTestProject
//
//  Created by Egor Tolstoy on  31/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "RDSLoginViewController.h"

#import "RDSLoginViewOutput.h"

@interface RDSLoginViewControllerTests : XCTestCase

@property (strong, nonatomic) RDSLoginViewController *controller;

@property (strong, nonatomic) id mockOutput;

@end

@implementation RDSLoginViewControllerTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.controller = [[RDSLoginViewController alloc] init];

    self.mockOutput = OCMProtocolMock(@protocol(RDSLoginViewOutput));

    self.controller.output = self.mockOutput;
}

- (void)tearDown {
    self.controller = nil;

    self.mockOutput = nil;

    [super tearDown];
}

#pragma mark - Тестирование жизненного цикла

#pragma mark - Тестирование методов интерфейса

#pragma mark - Тестирование методов RDSLoginViewInput

@end