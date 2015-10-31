//
//  RamblerViperOpenModulePromise.m
//  ViperMcFlurry
//
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import "RamblerViperOpenModulePromise.h"
#import "RamblerViperModuleInput.h"

@interface RamblerViperOpenModulePromise()

@property (nonatomic,strong) __nullable RamblerViperModuleLinkBlock linkBlock;
@property (nonatomic,assign) BOOL linkBlockWasSet;
@property (nonatomic,assign) BOOL moduleInputWasSet;

@end

@implementation RamblerViperOpenModulePromise

- (void)setModuleInput:(id<RamblerViperModuleInput> __nullable)moduleInput {
    _moduleInput = moduleInput;
    self.moduleInputWasSet = YES;
    [self tryPerformLink];
}

- (void)thenChainUsingBlock:(__nullable RamblerViperModuleLinkBlock)linkBlock {
    self.linkBlock = linkBlock;
    self.linkBlockWasSet = YES;
    [self tryPerformLink];
}

- (void)tryPerformLink {
    if (self.linkBlockWasSet && self.moduleInputWasSet) {
        [self performLink];
    }
}

- (void)performLink {
    if (self.linkBlock != nil) {
        id<RamblerViperModuleOutput> moduleOutput = self.linkBlock(self.moduleInput);
        if ([self.moduleInput respondsToSelector:@selector(setModuleOutput:)]) {
            [self.moduleInput setModuleOutput:moduleOutput];
        }
        if (self.postLinkActionBlock) {
            self.postLinkActionBlock();
        }
    }
}

@end
