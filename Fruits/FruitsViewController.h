//
//  FruitsViewController.h
//  Fruits
//
//  Created by Sitdhibhong Laokok on 9/19/54 BE.
//  Copyright 2554 Apps Tree. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FruitInformDelegate.h"

@interface FruitsViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, FruitInformDelegate>

@property (nonatomic, retain) NSFetchedResultsController *fruitsFetchedResultController;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)objectContext;

@end
