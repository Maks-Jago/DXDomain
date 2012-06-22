//
//  UniversalCodingTests.m
//  UniversalCodingTests
//
//  Created by Maks on 19.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UniversalCodingTests.h"
#import "UniversalCoding.h"
#import "TestClass.h"

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
    
    STAssertNil([[cod getPropertys:[NSString new]] count],@"should be equal nill!!!");
    STAssertNotNil([cod getPropertys:[TestClass new]],@"should'nt be equal nill!!!");
    
    STAssertNil([[cod getIvars:[NSString new]] count],@"should be equal nill!!!");
    STAssertNotNil([cod getIvars:[TestClass new]],@"should'nt be equal nill!!!");
}

@end
