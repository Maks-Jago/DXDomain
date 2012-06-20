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
        type = [self parseType:type];
        [propertyDictionary setValue: type forKey:propertyName];
    }    
    return propertyDictionary;
}

- (NSDictionary*)getIvars:(id) object
{
    NSParameterAssert(object);
    NSMutableDictionary *ivarDictionary = [NSMutableDictionary dictionary];
    uint outCount = 0;
    Ivar * ivars = class_copyIvarList([object class],&outCount); 
    for (int i=0; i<outCount; i++) 
    {
        NSString *ivarName = [[[NSString alloc] initWithUTF8String:ivar_getName(ivars[i])] autorelease];
        NSString *ivarType = [[[NSString alloc] initWithUTF8String:ivar_getTypeEncoding(ivars[i])] autorelease]; 
        [ivarDictionary setValue:[self parseType:ivarType] forKey:ivarName];
    }
    return ivarDictionary;
}

- (NSString*)parseType:(NSString*) type
{
    char simbolToSwitch = [type UTF8String][1];
    if (simbolToSwitch == '\0' || simbolToSwitch == '\"') 
    {
        simbolToSwitch = [type UTF8String][0];
    }
    switch (simbolToSwitch) 
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
            return @"float";
        case 'l':
            return @"long";
        case 's':                        
            return @"short";
        case 'c':
            return @"char";
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
                    case 'c':
                        return @"char*";
                    case 'f':
                        return @"float*";
                    case 'l':
                        return @"long*";
                    case 's':                        
                        return @"short*";
                    case 'I':
                        return @"unsigned*";
                }
            }
            break;
    }
    return nil;
}

@end
