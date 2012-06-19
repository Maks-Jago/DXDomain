//
//  UniversalCoding.m
//  UniversalCoding
//
//  Created by Maks on 19.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UniversalCoding.h"

@implementation UniversalCoding

- (NSArray*)getPropertys:(id) object
{
    NSParameterAssert(object);
    NSMutableArray* propertyArray = [NSMutableArray array];
    uint outCount = 0;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    for (int i=0; i<outCount; i++) 
    {
        NSString* propertyName = [[[NSString alloc] initWithUTF8String:property_getName(properties[i])] autorelease];
        [propertyArray addObject:(id)propertyName];
    }
    return [[NSArray alloc] initWithArray:propertyArray];
}

@end
