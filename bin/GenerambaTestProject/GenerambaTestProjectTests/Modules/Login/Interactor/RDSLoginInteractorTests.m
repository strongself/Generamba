//
//  InteractorTests.m
//  GenerambaTestProject
//
//  Created by Egor Tolstoy on  31/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "RDSLoginInteractor.h"

#import "RDSLoginInteractorOutput.h"

@interface RDSLoginInteractorTests : XCTestCase

@property (strong, nonatomic) RDSLoginInteractor *interactor;

@property (strong, nonatomic) id mockOutput;

@end

@implementation RDSLoginInteractorTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.interactor = [[RDSLoginInteractor alloc] init];

    self.mockOutput = OCMProtocolMock(@protocol(RDSLoginInteractorOutput));

    self.interactor.output = self.mockOutput;
}

- (void)tearDown {
    self.interactor = nil;

    self.mockOutput = nil;

    [super tearDown];
}

#pragma mark - Тестирование методов RDSLoginInteractorInput

@end