
//
//  RamblerViperModuleFactory.m
//  ViperMcFlurry
//
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import "RamblerViperModuleFactory.h"

@interface RamblerViperModuleFactory ()

@property (nonatomic,strong) UIStoryboard *storyboard;
@property (nonatomic,strong) NSString* restorationId;

@end

@implementation RamblerViperModuleFactory

- (instancetype)initWithStoryboard:(UIStoryboard*)storyboard andRestorationId:(NSString*)restorationId {
    self = [super init];
    if (self) {
        self.storyboard = storyboard;
        self.restorationId = restorationId;
    }
    return self;
}

#pragma mark - RDSModuleFactoryProtocol

- (__nullable id<RamblerViperModuleTransitionHandlerProtocol>)instantiateModuleTransitionHandler {
    id<RamblerViperModuleTransitionHandlerProtocol> destinationViewController = [self.storyboard instantiateViewControllerWithIdentifier:self.restorationId];
    return destinationViewController;
}

@end
