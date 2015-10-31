//
//  RDSLogin2ViewControllerTests.m
//  GenerambaTestProject
//
//  Created by Egor Tolstoy on 31/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "RDSLogin2ViewController.h"

#import "RDSLogin2ViewOutput.h"

@interface RDSLogin2ViewControllerTests : XCTestCase

@property (strong, nonatomic) RDSLogin2ViewController *controller;

@property (strong, nonatomic) id mockOutput;

@end

@implementation RDSLogin2ViewControllerTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.controller = [[RDSLogin2ViewController alloc] init];

    self.mockOutput = OCMProtocolMock(@protocol(RDSLogin2ViewOutput));

    self.controller.output = self.mockOutput;
}

- (void)tearDown {
    self.controller = nil;

    self.mockOutput = nil;

    [super tearDown];
}

#pragma mark - Тестирование жизненного цикла

#pragma mark - Тестирование методов интерфейса

#pragma mark - Тестирование методов RDSLogin2ViewInput

@end