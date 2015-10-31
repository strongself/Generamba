//
//  Assembly.m
//  GenerambaTestProject
//
//  Created by Egor Tolstoy on  31/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "RDSLoginAssembly.h"

#import "RDSLoginViewController.h"
#import "RDSLoginInteractor.h"
#import "RDSLoginPresenter.h"
#import "RDSLoginRouter.h"

#import <ViperMcFlurry/ViperMcFlurry.h>

@implementation RDSLoginAssembly

- (RDSLoginViewController *)viewLoginModule {
    return [TyphoonDefinition withClass:[RDSLoginViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterLoginModule]];
                              [definition injectProperty:@selector(moduleInput)
                                                    with:[self presenterLoginModule]];
                          }];
}

- (RDSLoginPresenter *)presenterLoginModule {
    return [TyphoonDefinition withClass:[RDSLoginPresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(view)
                                                    with:[self viewLoginModule]];
                              [definition injectProperty:@selector(interactor)
                                                    with:[self interactorLoginModule]];
                              [definition injectProperty:@selector(router)
                                                    with:[self routerLoginModule]];
                          }];
}

- (RDSLoginInteractor *)interactorLoginModule {
    return [TyphoonDefinition withClass:[RDSLoginInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterLoginModule]];
                          }];
}

- (RDSLoginRouter *)routerLoginModule {
    return [TyphoonDefinition withClass:[RDSLoginRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(transitionHandler)
                                                    with:[self viewLoginModule]];
                          }];
}

@end