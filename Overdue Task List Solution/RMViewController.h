//
//  RMViewController.h
//  Overdue Task List Solution
//
//  Created by Ryan Macaspac on 5/14/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMAddTaskViewController.h"
#import "RMTask.h"
#import "RMDetailTaskViewController.h"

@interface RMViewController : UIViewController <RMAddTaskViewControllerDelegate, RMDetailTaskViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *taskObjects;

- (IBAction)reorderBarButtonItemPressed:(UIBarButtonItem *)sender;
- (IBAction)addTaskBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
