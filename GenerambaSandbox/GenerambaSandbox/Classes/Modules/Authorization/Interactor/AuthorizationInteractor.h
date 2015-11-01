//
//  AuthorizationInteractor.h
//  GenerambaSandbox
//
//  Created by Egor Tolstoy on 01/11/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "AuthorizationInteractorInput.h"

@protocol AuthorizationInteractorOutput;

@interface AuthorizationInteractor : NSObject <AuthorizationInteractorInput>

@property (nonatomic, weak) id<AuthorizationInteractorOutput> output;

@end