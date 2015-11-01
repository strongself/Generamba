//
//  RamblerTyphoonAssemblyTestUtilities.h
//  Pods
//
//  Created by Egor Tolstoy on 29/07/15.
//
//

#import <Foundation/Foundation.h>

/**
 @author Irina Dyagileva
 
 Хелпер для тестирования создаваемых зависимостей Assembly
 */
@interface RamblerTyphoonAssemblyTestUtilities : NSObject

/**
 @author Irina Dyagileva
 
 Возвращает все свойства заданного класса, включая свойства родительских классов
 
 @param object Class
 
 @return NSDictionary
 */
+ (NSDictionary *) propertiesForHierarchyOfClass:(Class)objectClass;

/**
 @author Irina Dyagileva
 
 Возвращает все свойства заданного класса, не включая свойства родительских классов
 
 @param object Class
 
 @return NSDictionary
 */
+ (NSDictionary *) propertiesOfClass:(Class)objectClass;

@end
