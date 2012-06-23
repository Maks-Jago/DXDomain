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
    id coderMock;
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
