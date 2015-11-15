//
//  RamblerTyphoonAssemblyTestUtilities.h
//  RamblerTyphoonUtils
//
//  Created by Egor Tolstoy on 12/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Egor Tolstoy
 
 This class provides a number of useful methods for testing objects, created with a TyphoonAssembly
 */
@interface RamblerTyphoonAssemblyTestUtilities : NSObject

/**
 Returns all of the target class properties, including base classes properties.
 
 @param objectClass The target class
 
 @return NSDictionary
 */
+ (NSDictionary *)propertiesForHierarchyOfClass:(Class)objectClass;

/**
 Returns all of the target class properties, not-including base classes properties.
 
 @param objectClass The target class
 
 @return NSDictionary
 */
+ (NSDictionary *)propertiesOfClass:(Class)objectClass;

@end
