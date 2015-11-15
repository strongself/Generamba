//
//  AuthorizationRouter.h
//  GenerambaSandbox
//
//  Created by Egor Tolstoy on 15/11/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "AuthorizationRouterInput.h"

@protocol RamblerViperModuleTransitionHandlerProtocol;

@interface AuthorizationRouter : NSObject <AuthorizationRouterInput>

@property (nonatomic, weak) id<RamblerViperModuleTransitionHandlerProtocol> transitionHandler;

@end