//
//  JKNoteManagedObject+CoreDataProperties.h
//  JKNotes
//
//  Created by 宋旭 on 16/4/20.
//  Copyright © 2016年 sky. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "JKNoteManagedObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface JKNoteManagedObject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *content;
@property (nullable, nonatomic, retain) NSDate *timeStamp;

@end

NS_ASSUME_NONNULL_END
