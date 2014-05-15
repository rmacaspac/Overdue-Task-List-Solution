//
//  RMEditTaskViewController.h
//  Overdue Task List Solution
//
//  Created by Ryan Macaspac on 5/14/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMTask.h"

@protocol RMEditTaskViewControllerDelegate <NSObject>

-(void)didSaveTask;

@end


@interface RMEditTaskViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) id <RMEditTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) RMTask *task;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender;
@end
