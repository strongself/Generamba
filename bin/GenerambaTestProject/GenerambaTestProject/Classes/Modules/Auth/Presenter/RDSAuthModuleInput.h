//
//  RDSAuthModuleInput.h
//  
//
//  Created by Egor Tolstoy on  25/10/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RDSAuthModuleInput <NSObject>

/**
 @author Egor Tolstoy

 Метод инициирует стартовую конфигурацию текущего модуля
 */
- (void)configureCurrentModule;

@end