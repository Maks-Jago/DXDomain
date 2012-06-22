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
        
    NSDictionary *dict = [NSDictionary dictionary];
    NSInteger countBefore = [dict count];
    dict = [cod getPropertys:[TestClass new]];
    NSInteger countAfter = [dict count];
    
    STAssertFalse(countBefore == countAfter,@"should be different!!!");    
    dict = [cod getIvars:[TestClass new]];
    countAfter = [dict count];
  
    STAssertFalse(countBefore == countAfter,@"should be different!!!");
    dict = [cod getIvars:[NSString new]];
    countAfter = [dict count];
    
    STAssertTrue(countBefore == countAfter,@"should be equal!!!");
    
    dict = [cod getPropertys:[NSString new]];
    countAfter = [dict count];
    
    STAssertTrue(countAfter == countBefore,@"should be equal!!!");
        
}

@end
