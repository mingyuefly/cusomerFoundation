//
//  ViewController.m
//  sqlite
//
//  Created by mingyue on 16/5/29.
//  Copyright © 2016年 G. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>

@interface ViewController ()

- (IBAction)insert:(id)sender;
- (IBAction)delete:(id)sender;
- (IBAction)update:(id)sender;
- (IBAction)select:(id)sender;

@property (nonatomic, assign) sqlite3 *db;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //db是数据库句柄,就是数据库的象征，要对数据库进行增删改查，就得操作这个实例
    //sqlite3 *db;
    
    //获得数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                     
    NSString *fileName = [doc stringByAppendingPathComponent:@"students.sqlite"];
    NSLog(@"%@",fileName);
    //将OC字符串转换为C语言的字符串
    const char *cfileName = [fileName UTF8String];
    
    //1.打开数据库文件（如果数据库文件不存在，那么该函数会自动创建数据库文件）
    int result = sqlite3_open(cfileName, &_db);
    if (result == SQLITE_OK) {
        NSLog(@"成功打开数据库");
        //2.创建表
        const char *sql = "CREATE TABLE t_students (id integer PRIMARY KEY AUTOINCREMENT,name text NOT NULL,age integer NOT NULL);";
        char *errmsg = NULL;
        result = sqlite3_exec(self.db, sql, NULL, NULL, &errmsg);
        if (result == SQLITE_OK) {
            NSLog(@"创表成功");
        } else {
            printf("创表失败---%s---%s---%d",errmsg, __FILE__, __LINE__);
        }
    } else {
        NSLog(@"打开数据库失败");
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)insert:(id)sender {
    
    for (int i = 0; i < 20; i++) {
        //1.拼接SQL语句
        NSString *name = [NSString stringWithFormat:@"文晓--%d",arc4random_uniform(100)];
        int age = arc4random_uniform(20) + 10;
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO t_students (name, age) VALUES ('%@',%d);",name,age];
        
        //2.执行SQL语句
        char *errmsg = NULL;
        sqlite3_exec(self.db, sql.UTF8String, NULL, NULL, &errmsg);
        if (errmsg) {
            NSLog(@"插入数据失败--%s",errmsg);
        } else {
            NSLog(@"插入数据成功");
        }
    }
    
    
}

- (IBAction)delete:(id)sender {
    
}

- (IBAction)update:(id)sender {
    
}

- (IBAction)select:(id)sender {
    
    const char *sql = "SELECT id,name,age FROM t_students WHERE age<20;";
    sqlite3_stmt *stmt = NULL;
    
    //进行查询前的准备工作
    if (sqlite3_prepare_v2(self.db, sql, -1, &stmt, NULL) == SQLITE_OK) {
        NSLog(@"查询语句没有问题");
        
        //每调用一次sqlite3_step函数，stmt就会指向下一条记录
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //取出数据
            //(1)取出第0列字段的值（int类型的值）
            int ID = sqlite3_column_int(stmt, 0);
            //(2)取出第一列字段的值(text类型的值)
            const unsigned char *name = sqlite3_column_text(stmt, 1);
            //(3)取出第2列字段的值（int类型的值）
            int age = sqlite3_column_int(stmt, 2);
            NSLog(@"%d %s %d",ID, name, age);
            printf("%d %s %d\n",ID, name, age);
        }
    } else {
        NSLog(@"查询语句有问题");
    }
    
}
@end
