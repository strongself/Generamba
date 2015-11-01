//
//  RamblerTyphoonAssemblyTests.h
//  Pods
//
//  Created by Egor Tolstoy on 29/07/15.
//
//

#import <XCTest/XCTest.h>

#define RamblerSelector(x) NSStringFromSelector(@selector(x))

/**
 @author Andrey Rezanov
 
 Класс-прородитель для ассембли тестов
 */
@interface RamblerTyphoonAssemblyTests : XCTestCase

/**
 @author Irina Dyagileva
 
 Метод для тестирования создаваемого Assembly объекта
 
 @param targetDependency Создаваемая зависимость
 @param targetClass      Класс, на соответствие которому мы хотим проверить зависимость
 */
- (void)verifyTargetDependency:(id)targetDependency
                     withClass:(Class)targetClass;

/**
 @author Irina Dyagileva
 
 Метод для тестирования создаваемого Assembly объекта, а также проверки его зависимостей
 
 @param targetDependency Создаваемая зависимость
 @param targetClass      Класс, на соответствие которому мы хотим проверить зависимость
 @param dependencies     NSArray c названиями зависимостей
 */
- (void)verifyTargetDependency:(id)targetObject
                     withClass:(Class)targetClass
                  dependencies:(NSArray *)dependencies;

@end