//
//  AuthorizationAssembly.m
//  GenerambaSandbox
//
//  Created by Egor Tolstoy on 01/11/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "AuthorizationAssembly.h"

#import "AuthorizationViewController.h"
#import "AuthorizationInteractor.h"
#import "AuthorizationPresenter.h"
#import "AuthorizationRouter.h"

#import <ViperMcFlurry/ViperMcFlurry.h>

@implementation AuthorizationAssembly

- (AuthorizationViewController *)viewAuthorizationModule {
    return [TyphoonDefinition withClass:[AuthorizationViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterAuthorizationModule]];
                              [definition injectProperty:@selector(moduleInput)
                                                    with:[self presenterAuthorizationModule]];
                          }];
}

- (AuthorizationPresenter *)presenterAuthorizationModule {
    return [TyphoonDefinition withClass:[AuthorizationPresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(view)
                                                    with:[self viewAuthorizationModule]];
                              [definition injectProperty:@selector(interactor)
                                                    with:[self interactorAuthorizationModule]];
                              [definition injectProperty:@selector(router)
                                                    with:[self routerAuthorizationModule]];
                          }];
}

- (AuthorizationInteractor *)interactorAuthorizationModule {
    return [TyphoonDefinition withClass:[AuthorizationInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterAuthorizationModule]];
                          }];
}

- (AuthorizationRouter *)routerAuthorizationModule {
    return [TyphoonDefinition withClass:[AuthorizationRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(transitionHandler)
                                                    with:[self viewAuthorizationModule]];
                          }];
}

@end