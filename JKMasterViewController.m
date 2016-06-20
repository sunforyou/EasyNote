//
//  JKMasterViewController.m
//  JKNotes
//
//  Created by 宋旭 on 16/4/20.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "JKMasterViewController.h"

@interface JKMasterViewController ()

@end

@implementation JKMasterViewController

- (NSMutableArray *)listData {
    if (!_listData) {
        JKModelManager *manager = [[JKModelManager alloc] init];
        _listData = [manager findAll];
    }
    return _listData;
}

- (JKDetailViewController *)detailVC {
    if (!_detailVC) {
        _detailVC = (JKDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    }
    return _detailVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //监控CoreData数据模型的变化
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadView:)
                                                 name:@"reloadViewNotification"
                                               object:nil];
}

/**
 *  用最新数据重载页面
 *
 *  @param notification: reloadViewNotification
 */
-(void)reloadView:(NSNotification*)notification {
    NSMutableArray *resList = [notification object];
    self.listData = resList;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                            forIndexPath:indexPath];
    
    JKNote *note = self.listData[indexPath.row];
    
    //截取第一行内容显示在列表上
    if (note.content) {
        NSArray *firstRow = [note.content componentsSeparatedByString:@"\n"];
        NSUInteger length = [firstRow[0] length] < 15 ? [firstRow[0] length] : 15;
        cell.textLabel.text = [firstRow[0] substringWithRange:NSMakeRange(0, length)];
    }
    cell.detailTextLabel.text = [note.timeStamp description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        JKNote *note = [self.listData objectAtIndex:[indexPath row]];
        JKModelManager *manager = [[JKModelManager alloc] init];
        self.listData = [manager remove:note];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

#pragma mark - Navigation prepareForSegue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        JKNote *note = self.listData[indexPath.row];
        [[segue destinationViewController] setDetailItem:note];
        [[segue destinationViewController] setIsNewNote:NO];
    } else if ([[segue identifier] isEqualToString:@"Add"]) {
        [[segue destinationViewController] setIsNewNote:YES];
    }
}


@end
