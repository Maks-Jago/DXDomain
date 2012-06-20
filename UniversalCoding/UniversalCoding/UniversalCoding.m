//
//  UniversalCoding.m
//  UniversalCoding
//
//  Created by Maks on 19.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UniversalCoding.h"

@interface UniversalCoding ()

- (NSString*)parseType:(NSString*) type;

@end

@implementation UniversalCoding

- (NSDictionary*)getPropertys:(id) object
{
    NSParameterAssert(object);
    NSMutableDictionary *propertyDictionary = [NSMutableDictionary dictionary];
    uint outCount = 0;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    for (int i=0; i<outCount; i++) 
    {
        NSString* propertyName = [[[NSString alloc] initWithUTF8String:property_getName(properties[i])] autorelease];        
        NSString* atribute = [[[NSString alloc] initWithUTF8String:property_getAttributes(properties[i])] autorelease];
        NSArray *array = [atribute componentsSeparatedByString:@","];
        NSString *type = [array objectAtIndex:0];
//        NSLog(@"\n\n%@\n\n",atribute);
//        NSLog(@"\n%@\n\n",type);
        type = [self parseType:type];
//        NSLog(@"\n%@\n\n",type);
        [propertyDictionary setValue: type forKey:propertyName];
    }    
    return propertyDictionary;
}

- (NSString*)parseType:(NSString*) type
{
    switch ([type UTF8String][1]) 
    {
        case '@':
            {
                NSArray *components = [type componentsSeparatedByString:@"\""];
                return [components objectAtIndex:1];
            }
            break;
        case 'i':
            return @"int";
        case 'f':
            return @"gloat";
        case 'l':
            return @"long";
        case 's':
            return @"short";
        case 'I':
            return @"unsigned";
        case '^':
            {
                switch ([type UTF8String][2]) 
                {
                    case 'i':
                        return @"int*";
                    case 'v':
                        return @"void*";

                }
            }
            break;
    }
}

@end
