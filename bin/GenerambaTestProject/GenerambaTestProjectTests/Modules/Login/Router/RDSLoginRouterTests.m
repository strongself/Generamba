//
//  RouterTests.m
//  GenerambaTestProject
//
//  Created by Egor Tolstoy on  31/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "RDSLoginRouter.h"

@interface RDSLoginRouterTests : XCTestCase

@property (strong, nonatomic) RDSLoginRouter *router;

@end

@implementation RDSLoginRouterTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.router = [[RDSLoginRouter alloc] init];
}

- (void)tearDown {
    self.router = nil;

    [super tearDown];
}

@end