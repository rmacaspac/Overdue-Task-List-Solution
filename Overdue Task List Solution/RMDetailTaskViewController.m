//
//  RMDetailTaskViewController.m
//  Overdue Task List Solution
//
//  Created by Ryan Macaspac on 5/14/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMDetailTaskViewController.h"

@interface RMDetailTaskViewController ()

@end

@implementation RMDetailTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.titleLabel.text = self.task.title;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [formatter stringFromDate:self.task.date];
    
    self.dateLabel.text = date;
    self.detailLabel.text = self.task.description;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[RMEditTaskViewController class]]) {
        RMEditTaskViewController *editTaskVC = segue.destinationViewController;
        editTaskVC.delegate = self;
        RMTask *taskObject = self.task;
        editTaskVC.task = taskObject;
    }
}


- (IBAction)editBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"toEditTaskViewControllerSegue" sender:sender];
}

#pragma mark - RMEditTaskViewController Delegate

- (void)didSaveTask
{
    self.titleLabel.text = self.task.title;
    self.detailLabel.text = self.task.description;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [formatter stringFromDate:self.task.date];
    
    self.dateLabel.text = date;
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.delegate saveTask];
}
@end
