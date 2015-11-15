//
//  AuthorizationViewController.m
//  GenerambaSandbox
//
//  Created by Egor Tolstoy on 15/11/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "AuthorizationViewController.h"

#import "AuthorizationViewOutput.h"

@implementation AuthorizationViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы AuthorizationViewInput

- (void)setupInitialState {
	// В этом методе происходит настройка параметров view, зависящих от ее жизненого цикла (создание элементов, анимации и пр.)
}

@end