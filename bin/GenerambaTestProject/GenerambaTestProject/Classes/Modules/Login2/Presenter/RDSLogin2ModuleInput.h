//
//  RDSLogin2ModuleInput.h
//  GenerambaTestProject
//
//  Created by Egor Tolstoy on 31/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RDSLogin2ModuleInput <NSObject>

/**
 @author Egor Tolstoy

 Метод инициирует стартовую конфигурацию текущего модуля
 */
- (void)configureCurrentModule;

@end