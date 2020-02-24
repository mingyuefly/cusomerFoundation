//
//  Person.m
//  exception
//
//  Created by Gguomingyue on 2019/10/11.
//  Copyright © 2019 Gmingyue. All rights reserved.
//

#import "Person.h"
#import "MyException.h"

@implementation Person

-(void)setAge:(NSInteger)age
{
    if (age > 127 || age < 0) {
        @throw [[MyException alloc] initWithName:@"抛异常" reason:@"人的年龄在0到127之间" userInfo:nil];
    }
    _age = age;
}

@end
