//
//  AuthorizationAssembly_Testable.h
//  GenerambaSandbox
//
//  Created by Egor Tolstoy on 01/11/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "AuthorizationAssembly.h"

@class AuthorizationViewController;
@class AuthorizationInteractor;
@class AuthorizationPresenter;
@class AuthorizationRouter;

@interface AuthorizationAssembly()

- (AuthorizationViewController *)viewAuthorizationModule;
- (AuthorizationPresenter *)presenterAuthorizationModule;
- (AuthorizationInteractor *)interactorAuthorizationModule;
- (AuthorizationRouter *)routerAuthorizationModule;

@end