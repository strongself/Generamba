//
//  AuthorizationModuleInput.h
//  GenerambaSandbox
//
//  Created by Egor Tolstoy on 01/11/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AuthorizationModuleInput <NSObject>

/**
 @author Egor Tolstoy

 Метод инициирует стартовую конфигурацию текущего модуля
 */
- (void)configureCurrentModule;

@end