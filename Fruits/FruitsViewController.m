//
//  FruitsViewController.m
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

#import "FruitsViewController.h"
#import "AddNewFruitInformationViewController.h"
#import "Fruits.h"

@interface FruitsViewController ()
- (void)addNewFruitToList;
@end

@implementation FruitsViewController

@synthesize managedObjectContext;
@synthesize fruitsFetchedResultController = _fruitsFetchedResultController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)objectContext
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.managedObjectContext = objectContext;
    }
    
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    
    self.title = @"Fruits";
    
    self.navigationController.toolbarHidden = NO;
    
    // Create button for add a new fruit
    // put it to the toolbar bar, then release it.
    // target for this class and action point to -addNewFruitToList method
    UIBarButtonItem *addNewFruit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
                                                                                 target:self 
                                                                                 action:@selector(addNewFruitToList)];
    
    self.toolbarItems = [NSArray arrayWithObject:addNewFruit];
    
    [addNewFruit release];
    
    // fetch data from core data
    // It required to send memory address of error object to controller.
    // By this way, you should not do try...catch for error handler.
    NSError *error = nil;
    [self.fruitsFetchedResultController performFetch:&error];
    if (error != nil) {
        NSLog(@"Error while fetching fruits: %@", [error localizedDescription]);
    }
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)addNewFruitToList
{
    // Create new controller for add fruit, and set delegate of the new view controller to this class (self)
    AddNewFruitInformationViewController *newFruit = [[AddNewFruitInformationViewController alloc] initWithStyle:UITableViewStyleGrouped];
    newFruit.delegate = self;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:newFruit];
    
    [self presentModalViewController:navController animated:YES];
    
    [newFruit release];
    [navController release];
}

- (void)dealloc
{
    // Clean up memory
    [self setManagedObjectContext:nil];
    [_fruitsFetchedResultController release];
    [self setFruitsFetchedResultController:nil];
    
    [super dealloc];
}

// Accessory method for fruitsFetchedresultcontroller (getter)
- (NSFetchedResultsController *)fruitsFetchedResultController
{
    // everytime, I have to check _fruitsFetchedResultController empty or not.
    if (_fruitsFetchedResultController == nil) {
        // If it right (_fruitesFetchedResultController empty)
        // I will start with create fetch request object for send to NSFetchedResultsController for fetch data
        //
        // In NSFetchRequest 
        // There are 3 things required
        // 1. entity
        // 2. condition for sort data [sortDescriptors]
        // 3. predicate, nil is default if you want it all [predicate]
        NSFetchRequest *fruitRequest = [[NSFetchRequest alloc] init];
        fruitRequest.entity = [NSEntityDescription entityForName:@"Fruits" 
                                          inManagedObjectContext:self.managedObjectContext];
        
        NSSortDescriptor *sortByPrice = [[NSSortDescriptor alloc] initWithKey:@"pricePerKilogram" 
                                                                    ascending:NO];
        NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"name" 
                                                                   ascending:YES];
        
        fruitRequest.sortDescriptors = [NSArray arrayWithObjects:sortByPrice, sortByName, nil];
        
        fruitRequest.predicate = nil;
        
        NSFetchedResultsController *fetchResults = [[NSFetchedResultsController alloc] initWithFetchRequest:fruitRequest 
                                                                                       managedObjectContext:self.managedObjectContext 
                                                                                         sectionNameKeyPath:nil 
                                                                                                  cacheName:@"Fruit"];
        
        fetchResults.delegate = self;
        
        self.fruitsFetchedResultController = fetchResults;
        
        [fetchResults release];
        [fruitRequest release];
        [sortByName release];
        [sortByPrice release];
    }
    
    return _fruitsFetchedResultController;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self.fruitsFetchedResultController sections] lastObject] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"] autorelease];
    }
    
    Fruits *fruit = [self.fruitsFetchedResultController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ = %.2f", fruit.name, [fruit.pricePerKilogram floatValue]];
    cell.detailTextLabel.text = fruit.fruitNote;
    
    return cell;
}

#pragma mark - FruitInformDelegate
- (void)saveFruitWithName:(NSString *)name fruitNote:(NSString *)fruitNote andPricePerKilogram:(float)price
{
    Fruits *fruit = [[Fruits alloc] initWithEntity:[NSEntityDescription 
                                                    entityForName:@"Fruits" 
                                                    inManagedObjectContext:self.managedObjectContext] 
                    insertIntoManagedObjectContext:self.managedObjectContext];
    
    fruit.name = name;
    fruit.pricePerKilogram = [NSNumber numberWithFloat:price];
    fruit.fruitNote = fruitNote;
    
    NSError *error = nil;
    [self.managedObjectContext save:&error];
    if (error != nil) {
        NSLog(@"Error while saving fruit: %@", [error localizedDescription]);
    }
    
}

#pragma mark - NSFetchedResultsControllerDelegate
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView cellForRowAtIndexPath:indexPath].selected = NO;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fruits *editFruit = [self.fruitsFetchedResultController objectAtIndexPath:indexPath];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.managedObjectContext deleteObject:editFruit];
    }
    
    NSError *error = nil;
    [self.managedObjectContext save:&error];
    if (error != nil) {
        NSLog(@"Error while editing fruit: %@", [error localizedDescription]);
    }
}

@end