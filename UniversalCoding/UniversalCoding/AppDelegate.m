//
//  AppDelegate.m
//  UniversalCoding
//
//  Created by Maks on 19.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "UniversalCoding.h"
#import "TestClass.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
 /*   UniversalCoding *cod = [UniversalCoding new];
    
    NSDictionary *propertyDict = [cod getPropertys:[TestClass new]];
    NSArray *keys = [propertyDict allKeys];
    NSArray *values = [propertyDict allValues];
    
    int i;    
    
    NSLog(@"\n\n------------------PROPERTYS----------------------\n\n");
    
    for (i=0; i<[propertyDict count]; i++) 
    {
        NSLog(@"\n\n key = %@, value = %@ \n\n",[keys objectAtIndex:i],[values objectAtIndex:i]);
    }

    NSDictionary *ivarsDictionary = [cod getIvars:[TestClass new]];
    keys = [ivarsDictionary allKeys];
    values = [ivarsDictionary allValues];
    
    NSLog(@"\n\n------------------IVARS----------------------\n\n");
    
    for (i=0; i<[ivarsDictionary count]; i++) 
    {
        NSLog(@"\n\n key = %@, value = %@ \n\n",[keys objectAtIndex:i],[values objectAtIndex:i]);
    }

    [cod release];*/
    return YES;
}

@end
