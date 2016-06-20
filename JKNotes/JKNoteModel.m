//
//  JKNoteModel.m
//  JKNotes
//
//  Created by 宋旭 on 16/4/20.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "JKNoteModel.h"

@implementation JKNoteModel

static JKNoteModel *sharedManager = nil;

- (NSManagedObjectContext *)noteManagedObjectContext {
    if (!_noteManagedObjectContext) {
      _noteManagedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    return _noteManagedObjectContext;
}

+ (JKNoteModel *)sharedManager {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
        [sharedManager noteManagedObjectContext];
    });
    return sharedManager;
}

#pragma mark Core Data Operation Methods

- (void)create:(JKNote *)model {
    
    NSManagedObjectContext *cxt = [self noteManagedObjectContext];
    
    JKNoteManagedObject *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note"
                                                              inManagedObjectContext:cxt];
    [note setValue:model.content forKey:@"content"];
    [note setValue:model.timeStamp forKey:@"timeStamp"];
    note.content = model.content;
    note.timeStamp = model.timeStamp;
    
    NSError *savingError = nil;
    if ([cxt save:&savingError]){
        NSLog(@"添加数据成功");
    } else {
        NSLog(@"添加数据失败");
    }
}

- (void)remove:(JKNote *)model {
    
    NSManagedObjectContext *cxt = [self noteManagedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Note"
                                                         inManagedObjectContext:cxt];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    //通过Note的属性--时间戳从CoreDate中抓取对应Note
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"timeStamp =  %@", model.timeStamp];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    if ([listData count] > 0) {
        JKNoteManagedObject *note = [listData lastObject];
        [cxt deleteObject:note];
        
        NSError *savingError = nil;
        if ([cxt save:&savingError]){
            NSLog(@"删除数据成功");
        } else {
            NSLog(@"删除数据失败");
        }
    }
}

- (void)modify:(JKNote *)model {
    NSManagedObjectContext *cxt = [self noteManagedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Note"
                                                         inManagedObjectContext:cxt];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"timeStamp = %@", model.timeStamp];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    if ([listData count] > 0) {
        JKNoteManagedObject *note = [listData lastObject];
        note.content = model.content;
        note.timeStamp = [[NSDate alloc] init];
        
        NSError *savingError = nil;
        if ([cxt save:&savingError]){
            NSLog(@"修改数据成功");
        } else {
            NSLog(@"修改数据失败");
        }
    }
}

- (NSMutableArray*)findAll {
    NSManagedObjectContext *cxt = [self noteManagedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Note"
                                                         inManagedObjectContext:cxt];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp"
                                                                   ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    
    NSMutableArray *resListData = [[NSMutableArray alloc] init];
    
    for (JKNoteManagedObject *model in listData) {
        JKNote *note = [[JKNote alloc] init];
        note.timeStamp = model.timeStamp;
        note.content = model.content;
        [resListData addObject:note];
    }
    
    return resListData;
}

@end
