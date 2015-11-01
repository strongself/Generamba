//
//  RamblerTyphoonAssemblyTestUtilities.m
//  Pods
//
//  Created by Egor Tolstoy on 29/07/15.
//
//

#import "RamblerTyphoonAssemblyTestUtilities.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation RamblerTyphoonAssemblyTestUtilities

+ (NSDictionary *) propertiesForHierarchyOfClass:(Class)objectClass {
    NSMutableDictionary * properties = [NSMutableDictionary dictionary];
    [self propertiesForHierarchyOfClass:objectClass
                           onDictionary:properties];
    return [NSDictionary dictionaryWithDictionary:properties];
}

+ (NSDictionary *) propertiesOfClass:(Class)objectClass {
    NSMutableDictionary *properties = [NSMutableDictionary dictionary];
    return [self propertiesForSubclass:objectClass
                          onDictionary:properties];
}

+ (NSMutableDictionary *)propertiesForHierarchyOfClass:(Class)class
                                          onDictionary:(NSMutableDictionary *)properties {
    if (class == [NSObject class]) {
        return properties;
    }
    
    // Получаем свойтва текущего класса
    [self propertiesForSubclass:class onDictionary:properties];
    
    // Получаем свойтва родительского класса
    return [self propertiesForHierarchyOfClass:[class superclass] onDictionary:properties];
}

+ (NSMutableDictionary *) propertiesForSubclass:(Class)class
                                   onDictionary:(NSMutableDictionary *)properties {
    unsigned int outCount, i;
    objc_property_t *objcProperties = class_copyPropertyList(class, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = objcProperties[i];
        const char *propName = property_getName(property);
        if(propName) {
            const char *propType = getPropertyType(property);
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [NSString stringWithUTF8String:propType];
            [properties setObject:propertyType forKey:propertyName];
        }
    }
    free(objcProperties);
    
    return properties;
}

static const char *getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // Примитивные типы
            return "";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // Тип id
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            NSString *name;
            if (attribute[2] == '?') {
                // Блоки
                name = [[NSString alloc] initWithBytes:attribute + 2 length:1 encoding:NSASCIIStringEncoding];
            } else {
                // Другие классы
                name = [[NSString alloc] initWithBytes:attribute + 3 length:strlen(attribute) - 4 encoding:NSASCIIStringEncoding];
            }
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
    }
    return "";
}

@end