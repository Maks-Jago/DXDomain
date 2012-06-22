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


// ---- NSCoding ----

- (void) encodeWithCoder:(NSCoder*)encoder 
{
    //  [encoder encodeObject:someArray forKey:@"someArray"];
    //  [encoder encodeInteger:someInteger forKey:@"someInteger"];
    //  [encoder encodeBool:someBool forKey:@"someBool"];
    
    NSDictionary* ivars = [self getIvars:self];
    NSArray* keys = [ivars allKeys];
    NSArray* values = [ivars allValues];
    for(int i=0;i<[keys count];i++)
    {
        //value - тип, key - имя
        if([[values objectAtIndex:i]isEqualToString:@"int"])
        {
            [encoder encodeInteger:(NSInteger)[self valueForKey:[keys objectAtIndex:i]] forKey:[keys objectAtIndex:i]];
        }
        else if ([[values objectAtIndex:i]isEqualToString:@"double"]) 
        {
            [encoder encodeDouble:[(NSNumber*)[self valueForKey:[keys objectAtIndex:i]] doubleValue] forKey:[keys objectAtIndex:i]];
        }
        else if ([[values objectAtIndex:i]isEqualToString:@"float"]) 
        {
            [encoder encodeFloat:[(NSNumber*)[self valueForKey:[keys objectAtIndex:i]] floatValue] forKey:[keys objectAtIndex:i]];
        }
        else if ([[values objectAtIndex:i]isEqualToString:@"bool"]) 
        {
           if([self valueForKey:[keys objectAtIndex:i]] == YES)
           {
               BOOL b = YES;
               [encoder encodeBool:b forKey:[keys objectAtIndex:i]];
           }
        }
        else // This is object
        {
            [encoder encodeObject:[self valueForKey:[keys objectAtIndex:i]] forKey:[keys objectAtIndex:i]];
        }
    }
}

- (id) initWithCoder:(NSCoder*)decoder 
{
    if (self = [super init]) 
    {
        NSDictionary* ivars = [self getIvars:self];
        NSArray* keys = [ivars allKeys];
        NSArray* values = [ivars allValues];
        for(int i=0;i<[keys count];i++)
        {
            //value - тип, key - имя
            if([[values objectAtIndex:i]isEqualToString:@"int"])
            {
                [self setValue:[[NSNumber alloc] initWithInt:[decoder decodeIntegerForKey:[keys objectAtIndex:i]]] forKey:[keys objectAtIndex:i]];
            }
            else if ([[values objectAtIndex:i]isEqualToString:@"double"]) 
            {
                    [self setValue:[[NSNumber alloc] initWithDouble:[decoder decodeDoubleForKey:[keys objectAtIndex:i]]] forKey:[keys objectAtIndex:i]];
            }
            else if ([[values objectAtIndex:i]isEqualToString:@"float"]) 
            {
                [self setValue:[[NSNumber alloc] initWithFloat:[decoder decodeFloatForKey: [keys objectAtIndex:i]]] forKey:[keys objectAtIndex:i]];
            }
            else if ([[values objectAtIndex:i]isEqualToString:@"bool"]) 
            {
                BOOL rez = [decoder decodeBoolForKey:[keys objectAtIndex:i]];
                if(rez == YES)
                {
                    [self setValue:[[NSNumber alloc] initWithInt:1] forKey:[keys objectAtIndex:i]];
                }
                else 
                {
                    [self setValue:[[NSNumber alloc] initWithInt:0] forKey:[keys objectAtIndex:i]];
                }
                
            }
            else //this is OBJECT
            {
                [self setValue:[decoder decodeObjectForKey:[keys objectAtIndex:i]] forKey:[keys objectAtIndex:i]];
            }
        }
        
    }
    return self;
}


@end
