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
    id coderMock;
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
    TestClass *testObject = [TestClass new];
    
    dict = [cod getPropertys:[TestClass new]];//[cod getPropertys:testObject];
    NSInteger countAfter = [dict count];
    
    NSArray *allKeys = [dict allKeys];
    NSArray *allValues = [dict allValues];
    
    for(int i=0;i<[allKeys count];i++)
    {
//        STAssertEqualObjects([allKeys objectAtIndex:i], [testObject ]<#a1, a2...#>)
    }
    
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

-(void)testInitWithCoder
{
    coderMock = [OCMockObject mockForClass:[NSCoder class]];
    [[[coderMock stub]andReturn:[[NSNumber alloc]initWithInt:10]] decodeIntegerForKey:@""];
    [[[coderMock stub]andReturn:[[NSNumber alloc]initWithDouble:10.1]] decodeDoubleForKey:@""];
    [[[coderMock stub]andReturn:[[NSNumber alloc]initWithFloat:10.2]] decodeFloatForKey:@""];
    [[[coderMock stub]andReturn:[[NSNumber alloc]initWithBool:YES]] decodeBoolForKey:@""];
    [[[coderMock stub]andReturn:[[NSString alloc]initWithFormat:@"qwerty"]] decodeObjectForKey:@""];
    
    [cod initWithCoder:coderMock];
    NSLog(@"%a",cod);
    
}

/*error: testInitWithCoder (UniversalCodingTests) failed: +[OCMConstraint any]: unrecognized selector sent to class 0x67a0788
*/

@end
