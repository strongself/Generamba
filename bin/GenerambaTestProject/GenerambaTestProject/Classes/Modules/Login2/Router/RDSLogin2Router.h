//
//  RDSLogin2Router.h
//  GenerambaTestProject
//
//  Created by Egor Tolstoy on 31/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "RDSLogin2RouterInput.h"

@protocol RamblerViperModuleTransitionHandlerProtocol;

@interface RDSLogin2Router : NSObject <RDSLogin2RouterInput>

@property (nonatomic, weak) id<RamblerViperModuleTransitionHandlerProtocol> transitionHandler;

@end