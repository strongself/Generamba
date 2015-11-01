//
//  RamblerViperModuleInput.h
//  ViperMcFlurry
//
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RamblerViperModuleOutput;

@protocol RamblerViperModuleInput <NSObject>

@optional
- (void)setModuleOutput:(id<RamblerViperModuleOutput>)moduleOutput;

@end
