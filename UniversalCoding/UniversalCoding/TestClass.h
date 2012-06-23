//
//  TestClass.h
//  UniversalCoding
//
//  Created by Maks on 19.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestClass : NSObject
{
    NSInteger integer;
    double db;
    NSArray *someArray;
    char someSymbol;
}
@property (nonatomic,strong) NSString* string;
@property (nonatomic,assign) NSInteger num;
@property (nonatomic,assign) double _doubleName;

@end
