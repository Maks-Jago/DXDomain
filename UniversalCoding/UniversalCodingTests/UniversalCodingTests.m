//
//  UniversalCodingTests.m
//  UniversalCodingTests
//
//  Created by Maks on 19.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UniversalCodingTests.h"
#import "UniversalCoding.h"

@implementation UniversalCodingTests
{
    UniversalCoding *cod;
}

- (void)setUp
{
    [super setUp];
    cod = [UniversalCoding new];
}

- (void)tearDown
{
    [cod release];
    [super tearDown];
}

- (void)testGetPropertyAndIvar
{
    STAssertThrows([cod getPropertys:nil],@"should throw exceprion!!!");
    STAssertNoThrow([cod getPropertys:[NSString new]],@"should not throw exception!!!");
    
    STAssertThrows([cod getIvars:nil],@"should throw exceprion!!!");
    STAssertNoThrow([cod getIvars:[NSString new]],@"should not throw exception!!!");
}


@end
