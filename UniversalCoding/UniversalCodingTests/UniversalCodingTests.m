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
    id coderMock;
    TestClass* tc;
    UniversalCoding *cod;
}

- (void)setUp
{
    [super setUp];
    cod = [UniversalCoding new];
}

- (void)tearDown
{
    [super tearDown];
    [cod release];
}


- (void)testGetPropertyAndIvar
{
    STAssertThrows([cod getPropertys:nil],@"should throw exceprion!!!");
    STAssertNoThrow([cod getPropertys:[NSString new]],@"should not throw exception!!!");
    
    STAssertThrows([cod getIvars:nil],@"should throw exceprion!!!");
    STAssertNoThrow([cod getIvars:[NSString new]],@"should not throw exception!!!");
}

- (void)testGetIvar
{    
    STAssertThrows([cod getIvars:nil],@"should throw exceprion!!!");
    STAssertNoThrow([cod getIvars:[NSString new]],@"should not throw exception!!!");
    
    STAssertTrue([[cod getIvars:[TestClass new]] count] > 0, @"should be equal 0!!!");
       
    STAssertTrue([[cod getIvars:[NSString new]] count] == 0, @"should be > 0!!!");    
    
    TestClass *testClass = [[TestClass new] autorelease];
    NSDictionary *dict = [cod getIvars:testClass];
    NSArray *keys = [dict allKeys]; 
    
    STAssertNoThrow([testClass valueForKey:[keys objectAtIndex:0]], @"object testClass dont have ivar - %@", [keys objectAtIndex:0]);        
    STAssertNoThrow([testClass valueForKey:[keys objectAtIndex:1]], @"object testClass dont have ivar - %@", [keys objectAtIndex:1]);        
    STAssertNoThrow([testClass valueForKey:[keys objectAtIndex:2]], @"object testClass dont have ivar - %@", [keys objectAtIndex:2]);
    STAssertNoThrow([testClass valueForKey:[keys objectAtIndex:3]], @"object testClass dont have ivar - %@", [keys objectAtIndex:3]);
    STAssertNoThrow([testClass valueForKey:[keys objectAtIndex:4]], @"object testClass dont have ivar - %@", [keys objectAtIndex:4]);        
}

- (void) testGetProperty
{
    STAssertThrows([cod getPropertys:nil],@"should throw exceprion!!!");
    STAssertNoThrow([cod getPropertys:[NSString new]],@"should not throw exception!!!");
    
    STAssertTrue([[cod getPropertys:[TestClass new]] count] > 0, @"should be equal 0!!!");    
    
    STAssertTrue([[cod getPropertys:[NSString new]] count] == 0, @"should be > 0!!!");
    
    TestClass *testClass = [[TestClass new] autorelease];
    NSDictionary *dict = [cod getPropertys:testClass];
    NSArray *keys = [dict allKeys];        
    
    STAssertNoThrow([testClass valueForKey:[keys objectAtIndex:0]], @"object testClass dont have property - %@", [keys objectAtIndex:0]);
    STAssertNoThrow([testClass valueForKey:[keys objectAtIndex:1]], @"object testClass dont have property - %@", [keys objectAtIndex:1]);
    STAssertNoThrow([testClass valueForKey:[keys objectAtIndex:2]], @"object testClass dont have property - %@", [keys objectAtIndex:2]);
}


-(void)testInitWithCoder
{
    coderMock = [OCMockObject mockForClass:[NSCoder class]];
    [[[coderMock stub] andReturn:[NSNumber numberWithInt:10]] decodeObjectForKey:@"integer"];
    [[[coderMock stub] andReturn:[NSNumber numberWithInt:11]] decodeObjectForKey:@"a"];
    [[[coderMock stub] andReturn:[NSNumber numberWithDouble:10.1]] decodeObjectForKey:@"b"];
    [[[coderMock stub] andReturn:[NSNumber numberWithFloat:10.2]] decodeObjectForKey:@"c"];
    [[[coderMock stub] andReturn:[NSNumber numberWithBool:YES]] decodeObjectForKey:@"d"];
    [[[coderMock stub] andReturn:[NSString stringWithFormat:@"qwerty"]] decodeObjectForKey:@"str"];
    tc = [[TestClass alloc ] initWithCoder:coderMock];
    
    STAssertTrue(tc.integer == 10,@"Integer doesn't work!");
    STAssertTrue(tc.a == 11,@"Int doesn't work!");
    STAssertEqualsWithAccuracy(tc.b, 10.1, 0.1, @"Double doesn't work");
    STAssertEqualsWithAccuracy(tc.c, 10.2f, 0.001, @"Float doesn't work");
    STAssertTrue(tc.d == YES,@"Bool doesn't work");
    STAssertTrue([tc.str isEqualToString:@"qwerty"],@"NSString doesn't work");
}

-(void)testEncodeWithCoder
{
    tc = [TestClass new];
    tc.integer = 15;
    tc.a = 16;
    tc.b = 16.1;
    tc.c = 16.2;
    tc.d = NO;
    tc.str = @"somethng";   
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tc];
    TestClass *result = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    STAssertTrue(tc.integer == result.integer,@"Integer diff");
    STAssertTrue(tc.a == result.a,@"Int diff");
    STAssertEqualsWithAccuracy(tc.b, result.b, 0.1, @"Double diff");
    STAssertEqualsWithAccuracy(tc.c, result.c, 0.1, @"Float diff");
    STAssertTrue(tc.d == result.d,@"BOOL diff");
    STAssertTrue([tc.str isEqualToString:result.str],@"Strings diff");
    
}

@end
