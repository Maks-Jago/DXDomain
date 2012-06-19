//
//  UniversalCoding.m
//  UniversalCoding
//
//  Created by Maks on 19.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UniversalCoding.h"

@implementation UniversalCoding

- (NSMutableArray*)getProperty:(id) object
{
    NSMutableArray* property = [NSMutableArray array];
    unsigned int *outCount = 0;
    objc_property_t *tt = class_copyPropertyList(object, outCount);

}

@end
