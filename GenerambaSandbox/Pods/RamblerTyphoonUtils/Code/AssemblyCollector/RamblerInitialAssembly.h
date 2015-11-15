//
//  RamblerInitialAssembly.h
//  RamblerTyphoonUtils
//
//  Created by Egor Tolstoy on 12/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This protocol should be implemented by all of the TyphoonAssemblies, which require automated activation on application startup.
 It is used as an alternative to Info.plist integration.
 */
@protocol RamblerInitialAssembly <NSObject>

@end
