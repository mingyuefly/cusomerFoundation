//
//  AViewController.m
//  timer
//
//  Created by Gguomingyue on 2019/11/15.
//  Copyright © 2019 Gmingyue. All rights reserved.
//

#import "AViewController.h"
#import <objc/runtime.h>

@interface MYProxy : NSProxy

@property (nonatomic, weak) id target;

@end

@implementation MYProxy

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end

@interface AViewController ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) id target;
@property (nonatomic, strong) MYProxy *proxy;

@end

@implementation AViewController

void timerAct(id objct, SEL selector) {
    NSLog(@"%@  %@", NSStringFromClass([objct class]), NSStringFromSelector(selector));
    NSLog(@"timerAct fire ....");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass([self class]);
    
    //self.target = [NSObject new];
    //class_addMethod([self.target class], @selector(timerAction:), (IMP)timerAct, "v@:");
    
    self.proxy = [MYProxy alloc];
    self.proxy.target = self;
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self.proxy selector:@selector(timerAction:) userInfo:nil repeats:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    if (self.timer) {
//        [self.timer invalidate];
//        self.timer = nil;
//    }
}

-(void)timerAction:(NSTimer *)sender
{
    self.index++;
    NSLog(@"index = %ld", self.index);
}

-(void)dealloc
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

@end
