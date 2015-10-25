//
//  RDSAuthRouter.h
//  
//
//  Created by Egor Tolstoy on  25/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "RDSAuthRouterInput.h"

@protocol RamblerViperModuleTransitionHandlerProtocol;

@interface RDSAuthRouter : NSObject <RDSAuthRouterInput>

@property (nonatomic, weak) id<RamblerViperModuleTransitionHandlerProtocol> transitionHandler;

@end