//
//  main.m
//  setTutorial
//
//  Created by mingyue on 2020/10/16.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYObject.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        MYObject *obj1 = [[MYObject alloc] init];
        obj1.name = @"obj1";
        obj1.number = 10;
        obj1.size = 9;
        
        MYObject *obj2 = [[MYObject alloc] init];
        obj2.name = @"obj2";
        obj2.number = 10;
        //obj2.size = 3;
        obj2.size = 9;
        
        MYObject *obj3 = obj1;
        
        if ([obj1 isEqual:obj2]) {
            NSLog(@"equal");
        } else {
            NSLog(@"not equal");
        }
        
        NSMutableSet *set = [NSMutableSet setWithObject:obj1];
        if ([set containsObject:obj2]) {
            NSLog(@"contain");
        } else {
            NSLog(@"not contain");
        }
        
        if (obj1.hash == obj2.hash) {
            NSLog(@"==");
        } else {
            NSLog(@"!=");
        }
        
        [set addObject:obj2];
        NSLog(@"%lu", (unsigned long)set.count);
    }
    return 0;
}
