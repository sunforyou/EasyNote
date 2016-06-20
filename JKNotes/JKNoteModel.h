//
//  JKNoteModel.h
//  JKNotes
//
//  Created by 宋旭 on 16/4/20.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "JKNoteManagedObject+CoreDataProperties.h"
#import "JKNote.h"
#import "AppDelegate.h"

@interface JKNoteModel : NSObject

@property (strong, nonatomic) NSManagedObjectContext *noteManagedObjectContext;

@property (strong, nonatomic) JKNoteManagedObject *noteManagedObject;

/**
 *  生成模型单例
 *
 *  @return 模型实例
 */
+ (JKNoteModel *)sharedManager;

/**
 *  增加Note
 *
 *  @param model: JKNote
 */
- (void)create:(JKNote *)model;

/**
 *  删除Note
 *
 *  @param model: JKNote
 */
- (void)remove:(JKNote *)model;

/**
 *  修改Note
 *
 *  @param model: JKNote
 */
- (void)modify:(JKNote *)model;

/**
 *  查询Note
 *
 *  @return 返回当前所有模型
 */
- (NSMutableArray*)findAll;

@end
