//
//  RMEditTaskViewController.m
//  Overdue Task List Solution
//
//  Created by Ryan Macaspac on 5/14/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMEditTaskViewController.h"

@interface RMEditTaskViewController ()

@end

@implementation RMEditTaskViewController

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
    self.textField.text = self.task.title;
    self.textView.text = self.task.description;
    self.datePicker.date = self.task.date;
    
    self.textView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self returnNewTaskObject];
    [self.delegate didSaveTask];
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.textView resignFirstResponder];
        return NO;
    } else return YES; 
}

#pragma mark - Helper Methods

- (void)returnNewTaskObject
{
    self.task.title = self.textField.text;
    self.task.description = self.textView.text;
    self.task.date = self.datePicker.date;
}
@end
