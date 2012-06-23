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
  //  UniversalCoding *cod;
    id coderMock;
    
    TestClass* tc;
}

- (void)setUp
{
    [super setUp];
//    cod = [UniversalCoding new];
}

- (void)tearDown
{
   // [uc verify];
    
  //  [cod release];
    [super tearDown];
}
/*
- (void)testGetProperty
{
    STAssertThrows([cod getPropertys:nil],@"should throw exceprion!!!");
    STAssertNoThrow([cod getPropertys:[NSString new]],@"should not throw exception!!!");
}*/

-(void)testInitWithCoder
{
    coderMock = [OCMockObject mockForClass:[NSCoder class]];
    [[[coderMock stub] andReturnValue:[[NSNumber alloc] initWithInt:10]] decodeIntegerForKey:@"integer"];
    [[[coderMock stub] andReturnValue:[[NSNumber alloc] initWithDouble:10.1]] decodeDoubleForKey:@"b"];
    [[[coderMock stub] andReturnValue:[[NSNumber alloc] initWithFloat:10.2]] decodeFloatForKey:@"c"];
   // [[[coderMock stub] andReturnValue:[[NSNumber alloc] initWithBool:YES]] decodeBoolForKey:@"d"];
    [[[coderMock stub] andReturn:[[NSString alloc] initWithFormat:@"qwerty"]] decodeObjectForKey:@"str"];
    tc = [[TestClass alloc ] initWithCoder:coderMock];
    
    STAssertTrue(tc.a == 10,@"Int doesn't work!");
    STAssertTrue(tc.b == 10.1,@"Double doesn't work");
    STAssertTrue(tc.c == 10.2,@"Float doesn't work");
  //  STAssertTrue(tc.d == YES,@"Bool doesn't work");
    STAssertTrue([tc.str isEqualToString:@"qwerty"],@"NSString doesn't work");
}

@end
