//
//  RDSLogin2InteractorTests.m
//  GenerambaTestProject
//
//  Created by Egor Tolstoy on 31/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "RDSLogin2Interactor.h"

#import "RDSLogin2InteractorOutput.h"

@interface RDSLogin2InteractorTests : XCTestCase

@property (strong, nonatomic) RDSLogin2Interactor *interactor;

@property (strong, nonatomic) id mockOutput;

@end

@implementation RDSLogin2InteractorTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.interactor = [[RDSLogin2Interactor alloc] init];

    self.mockOutput = OCMProtocolMock(@protocol(RDSLogin2InteractorOutput));

    self.interactor.output = self.mockOutput;
}

- (void)tearDown {
    self.interactor = nil;

    self.mockOutput = nil;

    [super tearDown];
}

#pragma mark - Тестирование методов RDSLogin2InteractorInput

@end