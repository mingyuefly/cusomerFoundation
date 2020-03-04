//
//  main.m
//  string
//
//  Created by Gguomingyue on 2019/3/22.
//  Copyright © 2019 Gmingyue. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *string = @"abc";
        const char *stringChar = [string cStringUsingEncoding:NSUTF8StringEncoding];
        printf("stringChar = %s\n", stringChar);
        
        
//        NSArray *stringArray = [string componentsSeparatedByString:@""];
//        for (NSString *str in stringArray) {
//            NSLog(@"%@",str);
//        }
    }
    return 0;
}
