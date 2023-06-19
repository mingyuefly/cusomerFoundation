//
//  MessageViewController.m
//  method
//
//  Created by gmy on 2023/6/19.
//

#import "MessageViewController.h"
#import <objc/runtime.h>
#import "Person.h"
#import "Animal.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    class_addMethod([self class], @selector(foo), (IMP)fooFunc, "v@:");
    
    [self performSelector:@selector(foo)];
    
    [self performSelector:@selector(foo:) withObject:nil];
    
    [self performSelector:@selector(foo1)];
    
    [self performSelector:@selector(foo2)];
    
    //    [self foo:nil];
}

//-(void)foo {
//    NSLog(@"foo");
//}

//- (void)foo:(NSString *)str {
//    NSLog(@"foo");
//}

// 动态方法解析
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(foo:)) {//如果是执行foo函数，就动态解析，指定新的IMP
        class_addMethod([self class], sel, (IMP)fooMethod, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

// 备用接受者
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(foo1)) {
        return [[Person alloc] init];//返回Person对象，让Person对象接收这个消息
    }
    return [super forwardingTargetForSelector:aSelector];
}

// 完整消息转发
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector) isEqualToString:@"foo2"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];//签名，进入forwardInvocation
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = anInvocation.selector;
    Animal *p = [Animal new];
    if([p respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:p];
    } else {
        [self doesNotRecognizeSelector:sel];
    }
    
}

void fooFunc(id obj, SEL _cmd) {
    NSLog(@"foo");//新的foo函数
}

void fooMethod(id obj, SEL _cmd) {
    NSLog(@"Doing foo");//新的foo函数
}





@end
