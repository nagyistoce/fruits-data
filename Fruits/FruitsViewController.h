//
//  FruitsViewController.h
//  Fruits
//  
//  Fruits Data
//  Copyright (C) 2011  Sitdhibong Laokok
//  
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//  
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//  
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
#import <UIKit/UIKit.h>

#import "FruitInformDelegate.h"

@interface FruitsViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, FruitInformDelegate>

@property (nonatomic, retain) NSFetchedResultsController *fruitsFetchedResultController;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)objectContext;

@end
