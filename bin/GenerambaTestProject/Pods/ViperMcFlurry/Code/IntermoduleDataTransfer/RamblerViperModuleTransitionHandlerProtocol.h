//
//  RamblerViperModuleTransitionHandlerProtocol.h
//  ViperMcFlurry
//
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RamblerViperOpenModulePromise;
@protocol RamblerViperModuleInput;
@class RamblerViperModuleFabric;
@protocol RamblerViperModuleTransitionHandlerProtocol;

typedef void (^ModuleTransitionBlock)(id<RamblerViperModuleTransitionHandlerProtocol> sourceModuleTransitionHandler,
                                      id<RamblerViperModuleTransitionHandlerProtocol> destinationModuleTransitionHandler);

/**
 Protocol defines interface for intermodule transition
 */
@protocol RamblerViperModuleTransitionHandlerProtocol <NSObject>

@optional

// Module input object
@property (nonatomic, strong) id<RamblerViperModuleInput> moduleInput;

// Method opens module using segue
- (RamblerViperOpenModulePromise*)openModuleUsingSegue:(NSString*)segueIdentifier;
// Method opens module using module fabric
- (RamblerViperOpenModulePromise*)openModuleUsingFabric:(RamblerViperModuleFabric*)moduleFabric withTransitionBlock:(ModuleTransitionBlock)transitionBlock;
// Method removes/closes module
- (void)closeCurrentModule;

@end
