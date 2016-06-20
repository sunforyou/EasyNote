//
//  JKMasterViewController.h
//  JKNotes
//
//  Created by 宋旭 on 16/4/20.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKModelManager.h"
#import "JKNoteModel.h"
#import "JKNote.h"
#import "JKDetailViewController.h"
#import "JKNoteManagedObject+CoreDataProperties.h"

@interface JKMasterViewController : UITableViewController

/**
 *  详情视图实例
 */
@property (strong, nonatomic) JKDetailViewController *detailVC;

/**
 *  数据缓存
 */
@property (strong, nonatomic) NSMutableArray *listData;

@end
