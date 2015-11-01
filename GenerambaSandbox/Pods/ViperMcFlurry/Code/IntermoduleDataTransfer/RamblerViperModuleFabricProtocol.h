//
//  RamblerViperModuleFabricProtocol.h
//  ViperMcFlurry
//
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RamblerViperModuleTransitionHandlerProtocol;

@protocol RamblerViperModuleFabricProtocol <NSObject>

- (__nullable id<RamblerViperModuleTransitionHandlerProtocol>)instantiateModuleTransitionHandler;

@end
