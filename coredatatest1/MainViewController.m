//
//  MainViewController.m
//  coredatatest1
//
//  Created by Danny Lin on 13/1/30.
//  Copyright (c) 2013年 Danny Lin. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //- (void)insertData:(NSString*)symbol purchasePrice:(float)purchasePrice unitsPurchased:(int)unitsPurchased date:(NSString*)date
#pragma mark -- 新增五筆資料    
    //新增五筆實驗資料
	[self insertData:@"ALU" purchasePrice:14.23 unitsPurchased:100 dates:@"01-12-2012"];
	[self insertData:@"GOOG" purchasePrice:600.77 unitsPurchased:20 dates:@"01-09-2012"];
	[self insertData:@"NT" purchasePrice:20.23 unitsPurchased:140 dates:@"02-05-2012"];
	[self insertData:@"MSFT試" purchasePrice:30.23 unitsPurchased:5 dates:@"01-03-2012"];
	[self insertData:@"中文測試！" purchasePrice:30.13 unitsPurchased:3 dates:@"01-03-2012"];
    //取得資料庫內的總筆數來確定五筆資料是否都有新增
    NSLog(@"Total: %lu",(unsigned long)[[self.fetchedResultsController fetchedObjects] count] );
#pragma mark -- 條件式搜尋
    //條件式搜尋
    /*
    NSFetchRequest *bfetchRequest = [self.fetchedResultsController fetchRequest];
    NSPredicate *pred=[NSPredicate predicateWithFormat:@"symbol LIKE '*T*'"];
    [bfetchRequest setPredicate:pred];
    NSError *error;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:bfetchRequest error:&error];
    NSLog(@"Total GET: %lu",(unsigned long)[fetchedObjects count] );
    NSLog(@"-----\n%@\n--------",fetchedObjects);
    */
#pragma mark -- 更新資料    
    //更新資料
    /*
    [[fetchedObjects objectAtIndex:0] setValue:@"danny" forKeyPath:@"symbol"];
    [self.managedObjectContext save:&error];
    NSLog(@"--更新資料開始---\n%@\n--更新資料完成---",fetchedObjects);
     */
#pragma mark -- 刪除  
    //刪除
    /*
    NSLog(@"--資料刪除之前---\n%@\n--資料刪除之前---",fetchedObjects);    
    
    [self.managedObjectContext deleteObject:[fetchedObjects objectAtIndex:0]];
    [self.managedObjectContext save:&error];
    //
    NSArray *fetchedObjects1 = [self.managedObjectContext executeFetchRequest:bfetchRequest error:&error];
    NSLog(@"Total GET: %lu",(unsigned long)[fetchedObjects1 count] );
    NSLog(@"--資料刪除之後---\n%@\n--資料刪除之後---",fetchedObjects1);
     */

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}


#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Entity" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"purchase_date" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}
//
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{

}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:

            break;
            
        case NSFetchedResultsChangeDelete:

            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{

    
    switch(type) {
        case NSFetchedResultsChangeInsert:

            break;
            
        case NSFetchedResultsChangeDelete:

            break;
            
        case NSFetchedResultsChangeUpdate:

            break;
            
        case NSFetchedResultsChangeMove:

            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{

}

- (void)insertData:(NSString*)symbol purchasePrice:(float)purchasePrice unitsPurchased:(int)unitsPurchased dates:(NSString*)dates
{
    //insertData(pDb, "ALU",  14.23, 100, "03-17-2012");
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    //NSDate *date = [dateFormatter dateFromString:dates];
    
    [newManagedObject setValue:[dateFormatter dateFromString:dates] forKey:@"purchase_date"];
    [newManagedObject setValue:[NSNumber numberWithFloat:purchasePrice] forKey:@"purchasePrice"];
    [newManagedObject setValue:symbol forKey:@"symbol"];
    [newManagedObject setValue:[NSNumber numberWithInt:unitsPurchased] forKey:@"unitsPurchased"];
    //NSLog(@"%@",[dateFormatter dateFromString:dates]);
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

@end
