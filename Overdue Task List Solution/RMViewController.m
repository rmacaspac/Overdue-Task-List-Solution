//
//  RMViewController.m
//  Overdue Task List Solution
//
//  Created by Ryan Macaspac on 5/14/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMViewController.h"

@interface RMViewController ()

@end

@implementation RMViewController

#pragma mark - Lazy Instantiation

- (NSMutableArray *)taskObjects;
    {
        if (!_taskObjects) {
            _taskObjects = [[NSMutableArray alloc] init];
        }
        return _taskObjects;
    }

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Accessing NSUserDefaults
    NSArray *taskObjectsArray = [[NSUserDefaults standardUserDefaults] objectForKey:TASK_OBJECTS_KEY];
    for (NSDictionary *dictionary in taskObjectsArray) {
        RMTask *taskObjects = [self taskObjectsFromDictionary:dictionary];
        [self.taskObjects addObject:taskObjects];
    }
    
    // Setting Data Source and Delegate to Self
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Data Source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    RMTask *task = [self.taskObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = task.title;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *formattedDate = [formatter stringFromDate:task.date];
    cell.detailTextLabel.text = formattedDate;
    
    // Checking if date is past users date
    if (task.completion == YES) cell.backgroundColor = [UIColor greenColor];
    else if ([self isDateGreaterThanDate:[NSDate date] and:task.date]) cell.backgroundColor = [UIColor redColor];
    else cell.backgroundColor = [UIColor yellowColor];

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.taskObjects count];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toDetailTaskViewController" sender:indexPath];
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMTask *task = [self.taskObjects objectAtIndex:indexPath.row];
    
    [self updateCompletionOfTasks:task forIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.taskObjects removeObjectAtIndex:indexPath.row];
    
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] objectForKey:TASK_OBJECTS_KEY] mutableCopy];
    
    [taskObjectsAsPropertyLists removeObjectAtIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECTS_KEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [self.tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSLog(@"%@", self.taskObjects);
    
    RMTask *movedTaskObjects = self.taskObjects[sourceIndexPath.row];
    
    [self.taskObjects removeObjectAtIndex:sourceIndexPath.row];
    
    [self.taskObjects insertObject:movedTaskObjects atIndex:destinationIndexPath.row];
    
    [[NSUserDefaults standardUserDefaults] setObject:[self savedTaskObjectsAsPropertyLists:self.taskObjects] forKey:TASK_OBJECTS_KEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[RMAddTaskViewController class]]) {
        RMAddTaskViewController *addTaskVC = segue.destinationViewController;
        addTaskVC.delegate = self;
    } else if ([segue.destinationViewController isKindOfClass:[RMDetailTaskViewController class]]) {
        RMDetailTaskViewController *detailTaskVC = segue.destinationViewController;
        NSIndexPath *path = sender;
        RMTask *taskObject = [self.taskObjects objectAtIndex:path.row];
        detailTaskVC.task = taskObject;
        detailTaskVC.delegate = self;
    }
}

- (IBAction)reorderBarButtonItemPressed:(UIBarButtonItem *)sender
{
    if ([self.tableView isEditing]) {
    [self.tableView setEditing:NO animated:YES];
    [sender setTitle:@"Reorder"];
    } else {
    [self.tableView setEditing:YES animated:YES];
    [sender setTitle:@"Done"];
    }
}

- (IBAction)addTaskBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"toAddTaskViewControllerSegue" sender:sender];
}

#pragma mark - RMAddTaskViewController Delegate

- (void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didAddTask:(RMTask *)task
{
    // Adding task objects to taskObjects array
    [self.taskObjects addObject:task];
    
    // Persisting task objects to NSUserDefaults
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey: TASK_OBJECTS_KEY] mutableCopy];
    
    if (!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    
    [taskObjectsAsPropertyLists addObject:[self taskObjectsAsPropertyLists:task]];
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECTS_KEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
     
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableView reloadData];

}

#pragma mark - RMDetailTaskViewController Delegate

- (void)saveTask
{
    [self savedTaskObjectsAsPropertyLists:self.taskObjects];
    
    [self.tableView reloadData];
}

#pragma mark - Helper Methods

- (NSDictionary *)taskObjectsAsPropertyLists:(RMTask *)taskObject
{
    NSDictionary *dictionary = @{TASK_TITLE : taskObject.title, TASK_DESCRIPTION : taskObject.description , TASK_DATE : taskObject.date, TASK_COMPLETION : @(taskObject.completion)};
    return dictionary;
}

- (RMTask *)taskObjectsFromDictionary:(NSDictionary *)taskObjectsAsPropertyLists
{
    RMTask *taskObjects = [[RMTask alloc] initWithData:taskObjectsAsPropertyLists];
    
    return taskObjects;
}

- (BOOL)isDateGreaterThanDate:(NSDate *)date and:(NSDate *)toDate
{
    int timeInterval = [date timeIntervalSince1970];
    int toTimeInterval = [toDate timeIntervalSince1970];
    
    if (timeInterval > toTimeInterval) {
        return YES;
    } else {
        return NO;
    }
}

- (void)updateCompletionOfTasks:(RMTask *)task forIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] objectForKey:TASK_OBJECTS_KEY] mutableCopy];
    
    if (!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    
    [taskObjectsAsPropertyLists removeObjectAtIndex:indexPath.row];
    
    if (task.completion == YES) task.completion = NO;
    
    else task.completion = YES;
    
    [taskObjectsAsPropertyLists insertObject:[self taskObjectsAsPropertyLists:task] atIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECTS_KEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];
}

- (NSMutableArray *)savedTaskObjectsAsPropertyLists:(NSMutableArray *)newTaskObjectsAsPropertyLists
{
    NSMutableArray *reorderedTaskList = [[NSMutableArray alloc] init];
  
    for (RMTask *task in newTaskObjectsAsPropertyLists) [reorderedTaskList addObject:[self taskObjectsAsPropertyLists:task]];
    
    return reorderedTaskList;
}


@end
