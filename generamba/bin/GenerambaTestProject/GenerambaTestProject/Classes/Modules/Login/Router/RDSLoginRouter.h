//
//  Router.h
//  GenerambaTestProject
//
//  Created by Egor Tolstoy on  31/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "RDSLoginRouterInput.h"

@protocol RamblerViperModuleTransitionHandlerProtocol;

@interface RDSLoginRouter : NSObject <RDSLoginRouterInput>

@property (nonatomic, weak) id<RamblerViperModuleTransitionHandlerProtocol> transitionHandler;

@end