//
//  MYObject.m
//  setTutorial
//
//  Created by mingyue on 2020/10/16.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "MYObject.h"

@implementation MYObject

-(BOOL)isEqual:(id)object
{
    MYObject *obj = (MYObject *)object;
    if (self.number == obj.number && self.size == obj.size) {
        return YES;
    }
    return NO;
}

-(NSUInteger)hash
{
    return self.number;
}

@end
