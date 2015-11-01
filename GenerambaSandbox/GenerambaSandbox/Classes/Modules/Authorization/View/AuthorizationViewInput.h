//
//  AuthorizationViewInput.h
//  GenerambaSandbox
//
//  Created by Egor Tolstoy on 01/11/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AuthorizationViewInput <NSObject>

/**
 @author Egor Tolstoy

 Метод настраивает начальный стейт экрана
 */
- (void)setupInitialState;

@end