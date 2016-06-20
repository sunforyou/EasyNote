//
//  JKModelManager.h
//  JKNotes
//
//  Created by 宋旭 on 16/4/20.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKNoteManagedObject+CoreDataProperties.h"
#import "JKNoteModel.h"

@interface JKModelManager : NSObject

/**
 *  插入Note
 *
 *  @param model: JKNote
 *
 *  @return 改动后的数据库
 */
- (NSMutableArray *)createNote:(JKNote *)model;

/**
 *  删除Note
 *
 *  @param model: JKNote
 *
 *  @return 改动后的数据库
 */
- (NSMutableArray *)remove:(JKNote *)model;

/**
 *  修改Note
 *
 *  @param model: JKNote
 *
 *  @return 改动后的数据库
 */
- (NSMutableArray *)modify:(JKNote *)model;

/**
 *  查询当前数据
 *
 *  @return 当前数据
 */
- (NSMutableArray *)findAll;

@end
