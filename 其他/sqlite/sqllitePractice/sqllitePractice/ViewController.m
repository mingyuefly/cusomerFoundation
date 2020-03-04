//
//  ViewController.m
//  sqllitePractice
//
//  Created by mingyue on 16/5/29.
//  Copyright © 2016年 G. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>

@interface ViewController ()

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *lineTextFields;
@property (nonatomic, assign) sqlite3 *database;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (sqlite3_open([[self dataFilePath] UTF8String], &_database) != SQLITE_OK) {
        sqlite3_close(_database);
        NSAssert(0, @"Failed to open database");
    }
    
    NSString *createSQL = @"CREATE TABLE IF NOT EXISTS FIELDS "
    "(ROM INTEGER PRIMARY KEY, FIELD_DATA TEXT)";
    char *errorMsg;
    if (sqlite3_exec(self.database, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(self.database);
        NSAssert(0, @"Error creating table:%s",errorMsg);
    }
    NSString *query = @"SELECT ROW, FIELD_DATA FROM FIELDS ORDER BY NOW";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(self.database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int row = sqlite3_column_int(statement, 0);
            char *rowData = (char *)sqlite3_column_text(statement, 1);
            NSString *fieldValue = [[NSString alloc]initWithUTF8String:rowData];
            UITextField *field = self.lineTextFields[row];
            field.text = fieldValue;
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(self.database);
    
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActiveAction:) name:UIApplicationWillResignActiveNotification object:app];
    
}

#pragma mark - Actions 

-(void)applicationWillResignActiveAction:(NSNotification *)notification {
    
    if (sqlite3_open([[self dataFilePath] UTF8String], &_database) != SQLITE_OK) {
        sqlite3_close(self.database);
        NSAssert(0, @"Failed to open database");
    }
    for (int i = 0; i < 4; i++) {
        UITextField *field = self.lineTextFields[i];
        char *update = "INSERT OR REPLACE INTO FIELDS (ROW, FIELD_DATA) "
        "VALUES (?,?);";
        char *errorMsg = NULL;
        sqlite3_stmt *stmt = NULL;
        if (sqlite3_prepare_v2(self.database, update, -1, &stmt, nil) == SQLITE_OK) {
            sqlite3_bind_int(stmt, 1, i);
            sqlite3_bind_text(stmt, 2, [field.text UTF8String], -1, NULL);
        }
        if (sqlite3_step(stmt) != SQLITE_DONE) {
            NSAssert(0, @"Error updating table: %s",errorMsg);
        }
        sqlite3_finalize(stmt);
    }
    sqlite3_close(self.database);
}


#pragma mark - private methods

-(NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirctory = [paths objectAtIndex:0];
    NSLog(@"%@",[documentsDirctory stringByAppendingPathComponent:@"data.sqlite"]);
    return [documentsDirctory stringByAppendingPathComponent:@"data.sqlite"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
