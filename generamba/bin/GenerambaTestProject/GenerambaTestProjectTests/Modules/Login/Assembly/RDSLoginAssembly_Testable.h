//
//  Assembly_Testable.h
//  GenerambaTestProject
//
//  Created by Egor Tolstoy on  31/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "RDSLoginAssembly.h"

@class RDSLoginViewController;
@class RDSLoginInteractor;
@class RDSLoginPresenter;
@class RDSLoginRouter;

@interface RDSLoginAssembly()

- (RDSLoginViewController *)viewLoginModule;
- (RDSLoginPresenter *)presenterLoginModule;
- (RDSLoginInteractor *)interactorLoginModule;
- (RDSLoginRouter *)routerLoginModule;

@end