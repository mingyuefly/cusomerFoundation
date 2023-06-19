//
//  ViewController.m
//  method
//
//  Created by gmy on 2023/6/19.
//

#import "ViewController.h"
#import "MessageViewController.h"
#import "MethodViewController.h"


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = [@[@"message", @"method"] mutableCopy];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.text = self.dataSource[indexPath.row];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = self.dataSource[indexPath.row];
    if ([str isEqualToString:@"message"]) {
        MessageViewController *mvc = [[MessageViewController alloc] init];
        [self.navigationController pushViewController:mvc animated:YES];
    } else if ([str isEqualToString:@"method"]) {
        MethodViewController *mvc = [[MethodViewController alloc] init];
        [self.navigationController pushViewController:mvc animated:YES];
    } else {
        
    }
}

#pragma mark - properties
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [@[] mutableCopy];
    }
    return _dataSource;
}


@end
