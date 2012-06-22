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
    id uc;
}

- (void)setUp
{
    [super setUp];
    cod = [UniversalCoding new];
}

- (void)tearDown
{
   // [uc verify];
    
    [cod release];
    [super tearDown];
}

- (void)testGetProperty
{
    STAssertThrows([cod getPropertys:nil],@"should throw exceprion!!!");
    STAssertNoThrow([cod getPropertys:[NSString new]],@"should not throw exception!!!");
}

-(void)testNSCoding
{
    uc = [OCMockObject mockForClass:[UniversalCoding class]];
  //  [[uc expect] encodeWithCoder:[[NSCoder alloc]init]];
    
}

@end
