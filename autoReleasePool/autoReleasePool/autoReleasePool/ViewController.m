//
//  ViewController.m
//  autoReleasePool
//
//  Created by gmy on 2023/6/19.
//

#import "ViewController.h"
#import "AutoObject.h"

@interface ViewController ()

@property (nonatomic, strong) NSThread *thread;

@end

@implementation ViewController

__strong NSString *str = @"abc";

__weak id reference = nil;

//__strong id reference = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *str = [NSString stringWithFormat:@"aaa"];
            // str 是一个 autorelease 对象，设置一个 weak 的引用来观察它。
    
    AutoObject *a = [[AutoObject alloc] init];
    a.autoString = @"autoString";
    
    reference = a;
    NSLog(@"%@   str = %@", NSStringFromSelector(_cmd), [reference valueForKey:@"autoString"]);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 30);
    btn.center = self.view.center;
    [btn setTitle:@"autoReleasePool" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadAction) object:nil];
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@   str = %@", NSStringFromSelector(_cmd), [reference valueForKey:@"autoString"]);
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@   str = %@", NSStringFromSelector(_cmd), [reference valueForKey:@"autoString"]);
    str = @"abcdefg";
}

-(void)btnAction {
    NSLog(@"%@   str = %@", NSStringFromSelector(_cmd), [reference valueForKey:@"autoString"]);
    AutoObject *b = [[AutoObject alloc] init];
    b.autoString = @"b";
    for (int i = 0; i < 10000; i++) {
        @autoreleasepool {
            AutoObject *a = [[AutoObject alloc] init];
            a.autoString = @"a";
        }
        NSLog(@"a destroy");
    }
    NSLog(@"b destroy");
//    [self.thread start];
}

-(void)threadAction {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    AutoObject *c = [[AutoObject alloc] init];
    c.autoString = @"c";
    
//    [self.thread cancel];
}

@end
