//
//  RMAddTaskViewController.h
//  Overdue Task List Solution
//
//  Created by Ryan Macaspac on 5/14/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMTask.h"

@protocol RMAddTaskViewControllerDelegate <NSObject>

- (void)didCancel;
- (void)didAddTask:(RMTask *)task;

@end


@interface RMAddTaskViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) id <RMAddTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)addTaskButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;

@end
