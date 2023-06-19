//
//  MethodViewController.m
//  method
//
//  Created by gmy on 2023/6/19.
//

#import "MethodViewController.h"
#import <objc/runtime.h>

@interface MethodViewController ()

@end

@implementation MethodViewController

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 保证是原子操作，就算是在不同的线程中只会被执行一次
        Class class = [self class];
        SEL originalSelector = @selector(viewDidLoad);
        SEL swizzledSelector = @selector(jkviewDidLoad);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        //judge the method named  swizzledMethod is already existed.
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        // if swizzledMethod is already existed.
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    [self jkviewDidLoad];
}

- (void)jkviewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
//    [self viewDidLoad]; // 死循环，调用的是
}




@end
