//
//  RDSLogin2Assembly_Testable.h
//  GenerambaTestProject
//
//  Created by Egor Tolstoy on 31/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "RDSLogin2Assembly.h"

@class RDSLogin2ViewController;
@class RDSLogin2Interactor;
@class RDSLogin2Presenter;
@class RDSLogin2Router;

@interface RDSLogin2Assembly()

- (RDSLogin2ViewController *)viewLogin2Module;
- (RDSLogin2Presenter *)presenterLogin2Module;
- (RDSLogin2Interactor *)interactorLogin2Module;
- (RDSLogin2Router *)routerLogin2Module;

@end