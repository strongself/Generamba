//
//  AuthorizationRouterTests.m
//  GenerambaSandbox
//
//  Created by Egor Tolstoy on 01/11/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "AuthorizationRouter.h"

@interface AuthorizationRouterTests : XCTestCase

@property (strong, nonatomic) AuthorizationRouter *router;

@end

@implementation AuthorizationRouterTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.router = [[AuthorizationRouter alloc] init];
}

- (void)tearDown {
    self.router = nil;

    [super tearDown];
}

@end