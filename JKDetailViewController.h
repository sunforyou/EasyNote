//
//  JKDetailViewController.h
//  JKNotes
//
//  Created by 宋旭 on 16/4/20.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKDetailViewController : UIViewController<UITextViewDelegate>

/**
 *  接收被选中的cell传入的数据模型
 */
@property (strong, nonatomic) id detailItem;

/**
 *  是否为新建Note
 */
@property (assign, nonatomic) BOOL isNewNote;

@end
