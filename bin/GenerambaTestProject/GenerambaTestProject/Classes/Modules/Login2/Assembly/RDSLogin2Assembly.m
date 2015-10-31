//
//  RDSLogin2Assembly.m
//  GenerambaTestProject
//
//  Created by Egor Tolstoy on 31/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "RDSLogin2Assembly.h"

#import "RDSLogin2ViewController.h"
#import "RDSLogin2Interactor.h"
#import "RDSLogin2Presenter.h"
#import "RDSLogin2Router.h"

#import <ViperMcFlurry/ViperMcFlurry.h>

@implementation RDSLogin2Assembly

- (RDSLogin2ViewController *)viewLogin2Module {
    return [TyphoonDefinition withClass:[RDSLogin2ViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterLogin2Module]];
                              [definition injectProperty:@selector(moduleInput)
                                                    with:[self presenterLogin2Module]];
                          }];
}

- (RDSLogin2Presenter *)presenterLogin2Module {
    return [TyphoonDefinition withClass:[RDSLogin2Presenter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(view)
                                                    with:[self viewLogin2Module]];
                              [definition injectProperty:@selector(interactor)
                                                    with:[self interactorLogin2Module]];
                              [definition injectProperty:@selector(router)
                                                    with:[self routerLogin2Module]];
                          }];
}

- (RDSLogin2Interactor *)interactorLogin2Module {
    return [TyphoonDefinition withClass:[RDSLogin2Interactor class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterLogin2Module]];
                          }];
}

- (RDSLogin2Router *)routerLogin2Module {
    return [TyphoonDefinition withClass:[RDSLogin2Router class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(transitionHandler)
                                                    with:[self viewLogin2Module]];
                          }];
}

@end