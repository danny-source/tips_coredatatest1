//
//  MainViewController.h
//  coredatatest1
//
//  Created by Danny Lin on 13/1/30.
//  Copyright (c) 2013年 Danny Lin. All rights reserved.
//

#import "FlipsideViewController.h"

#import <CoreData/CoreData.h>

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate,NSFetchedResultsControllerDelegate>{
    NSFetchedResultsController* _fetchedResultsController;

}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
