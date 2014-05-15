//
//  RMDetailTaskViewController.h
//  Overdue Task List Solution
//
//  Created by Ryan Macaspac on 5/14/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMTask.h"
#import "RMEditTaskViewController.h"

@protocol RMDetailTaskViewControllerDelegate <NSObject>

-(void)saveTask;

@end


@interface RMDetailTaskViewController : UIViewController <RMEditTaskViewControllerDelegate>

@property (strong, nonatomic) RMTask *task;
@property (weak, nonatomic) id <RMDetailTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;

- (IBAction)editBarButtonItemPressed:(UIBarButtonItem *)sender;
@end
