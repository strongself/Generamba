//
//  RamblerViperOpenModulePromise.h
//  ViperMcFlurry
//
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RamblerViperModuleOutput;
@protocol RamblerViperModuleInput;

typedef void(^PostLinkActionBlock)();

/**
 This module is used to link modules one to another. ModuleInput is typically presenter of module.
 Block can be used to return module output.
 */
typedef id<RamblerViperModuleOutput>(^RamblerViperModuleLinkBlock)(id<RamblerViperModuleInput> moduleInput);

/**
 Promise used to configure module input.
 */
@interface RamblerViperOpenModulePromise : NSObject

@property (nonatomic,strong) id<RamblerViperModuleInput> moduleInput;
@property (nonatomic,strong) PostLinkActionBlock postLinkActionBlock;

- (void)thenChainUsingBlock:(RamblerViperModuleLinkBlock)linkBlock;

@end
