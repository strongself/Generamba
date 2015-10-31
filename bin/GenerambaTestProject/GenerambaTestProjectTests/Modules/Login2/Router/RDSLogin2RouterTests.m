//
//  RDSLogin2RouterTests.m
//  GenerambaTestProject
//
//  Created by Egor Tolstoy on 31/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "RDSLogin2Router.h"

@interface RDSLogin2RouterTests : XCTestCase

@property (strong, nonatomic) RDSLogin2Router *router;

@end

@implementation RDSLogin2RouterTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.router = [[RDSLogin2Router alloc] init];
}

- (void)tearDown {
    self.router = nil;

    [super tearDown];
}

@end