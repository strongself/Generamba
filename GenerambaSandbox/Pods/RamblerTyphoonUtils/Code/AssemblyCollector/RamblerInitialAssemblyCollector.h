//
//  RamblerInitialAssemblyCollector.h
//  RamblerTyphoonUtils
//
//  Created by Egor Tolstoy on 12/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This class traverses all of the application classes in the runtime and detects InitialAssemblies.
 */
@interface RamblerInitialAssemblyCollector : NSObject

/**
This method returns an array of TyphoonAssemly classes which requires activation on startup.

@return NSArray of TyphoonAssembly classes
*/
- (NSArray *)collectInitialAssemblyClasses;

@end
