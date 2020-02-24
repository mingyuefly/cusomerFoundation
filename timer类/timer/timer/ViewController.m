//
//  ViewController.m
//  timer
//
//  Created by Gguomingyue on 2019/11/15.
//  Copyright © 2019 Gmingyue. All rights reserved.
//

#import "ViewController.h"
#import "AViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(100, 100, 100, 30);
        [btn setTitle:@"APage" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.view addSubview:button];
}

-(void)buttonAction
{
    AViewController *avc = [[AViewController alloc] init];
    [self.navigationController pushViewController:avc animated:YES];
}

@end
