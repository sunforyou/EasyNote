//
//  JKDetailViewController.m
//  JKNotes
//
//  Created by 宋旭 on 16/4/20.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "JKDetailViewController.h"
#import "JKModelManager.h"

@interface JKDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextView *contentView;

@end

@implementation JKDetailViewController

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        [self configureView];
    }
}

- (void)setIsNewNote:(BOOL)isNewNote {
    if (_isNewNote != isNewNote ) {
        _isNewNote = isNewNote;
    }
}

/**
 *  显示有内容的界面
 */
- (void)configureView {
    if (self.detailItem) {
        JKNote *note = self.detailItem;
        self.contentView.text = note.content;
    }
}

/**
 *  回到主界面
 *
 *  @param sender Done
 */
- (IBAction)backButtonClicked:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  保存
 *
 *  @param sender Save
 */
- (IBAction)saveButtonClicked:(UIBarButtonItem *)sender {
    
    JKModelManager *manager = [[JKModelManager alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    if (self.isNewNote) {
        JKNote *note = [[JKNote alloc] init];
        note.timeStamp = [[NSDate alloc] init];
        note.content = self.contentView.text;
        array = [manager createNote:note];
    } else {
        JKNote *note = self.detailItem;
        note.content = self.contentView.text;
        array = [manager modify:note];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification"
                                                        object:array
                                                      userInfo:nil];
    
    [self.contentView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  删除
 *
 *  @param sender Trash
 */
- (IBAction)deleteButtonClicked:(UIBarButtonItem *)sender {
    JKModelManager *manager = [[JKModelManager alloc] init];
    JKNote *note = self.detailItem;
    NSMutableArray *array = [manager remove:note];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification"
                                                        object:array
                                                      userInfo:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  换行时隐藏键盘
 *
 *  @return BOOL
 */
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}

@end
