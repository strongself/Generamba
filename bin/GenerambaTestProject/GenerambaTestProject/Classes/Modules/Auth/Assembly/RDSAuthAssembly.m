//
//  RDSAuthAssembly.m
//  
//
//  Created by Egor Tolstoy on  25/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "RDSAuthAssembly.h"

#import "RDSAuthViewController.h"
#import "RDSAuthInteractor.h"
#import "RDSAuthPresenter.h"
#import "RDSAuthRouter.h"

#import <ViperMcFlurry/ViperMcFlurry.h>

@implementation RDSAuthAssembly

- (RDSAuthViewController *)viewAuthModule {
    return [TyphoonDefinition withClass:[RDSAuthViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterAuthModule]];
                              [definition injectProperty:@selector(moduleInput)
                                                    with:[self presenterAuthModule]];
                          }];
}

- (RDSAuthPresenter *)presenterAuthModule {
    return [TyphoonDefinition withClass:[RDSAuthPresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(view)
                                                    with:[self viewAuthModule]];
                              [definition injectProperty:@selector(interactor)
                                                    with:[self interactorAuthModule]];
                              [definition injectProperty:@selector(router)
                                                    with:[self routerAuthModule]];
                          }];
}

- (RDSAuthInteractor *)interactorAuthModule {
    return [TyphoonDefinition withClass:[RDSAuthInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterAuthModule]];
                          }];
}

- (RDSAuthRouter *)routerAuthModule {
    return [TyphoonDefinition withClass:[RDSAuthRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(transitionHandler)
                                                    with:[self viewAuthModule]];
                          }];
}

@end