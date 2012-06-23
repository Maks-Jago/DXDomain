//
//  TestClass.h
//  UniversalCoding
//
//  Created by Maks on 19.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UniversalCoding.h"

@interface TestClass :UniversalCoding

@property (nonatomic,strong) NSString* str;
@property (nonatomic,assign) NSInteger integer;
@property (nonatomic,assign) int a;
@property (nonatomic,assign) double b;
@property (nonatomic,assign) float c;
@property (nonatomic,assign) BOOL d;

@end
