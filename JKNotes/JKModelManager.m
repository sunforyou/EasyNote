//
//  JKModelManager.m
//  JKNotes
//
//  Created by 宋旭 on 16/4/20.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "JKModelManager.h"

@implementation JKModelManager

- (NSMutableArray*)createNote:(JKNote *)model {
    JKNoteModel *noteModel = [JKNoteModel sharedManager];
    [noteModel create:model];
    
    return [noteModel findAll];
}

- (NSMutableArray*)remove:(JKNote *)model {
    JKNoteModel *noteModel = [JKNoteModel sharedManager];
    [noteModel remove:model];
    
    return [noteModel findAll];
}

- (NSMutableArray *)modify:(JKNote *)model {
    JKNoteModel *noteModel = [JKNoteModel sharedManager];
    [noteModel modify:model];
    
    return [noteModel findAll];
}

- (NSMutableArray*)findAll {
    JKNoteModel *noteModel = [JKNoteModel sharedManager];
    return [noteModel findAll];
}

@end
