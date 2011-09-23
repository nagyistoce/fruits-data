//
//  AddNewFruitInformationViewController.m
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

#import "AddNewFruitInformationViewController.h"

@interface AddNewFruitInformationViewController ()
- (void)didWhenDoneButtonPressed;
- (void)didWhenCancelButtonPressed;
@end

@implementation AddNewFruitInformationViewController

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    
    self.title = @"Add New Fruit";
    
    name = [[UITextField alloc] initWithFrame:CGRectMake(15, (44 - 25) / 2, 320 - 15 * 2, 25)];
    name.placeholder = @"Fruit Name";
    name.textAlignment = UITextAlignmentCenter;
    name.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin);
    name.tag = 'name';
    
    pricePerKilogram = [[UITextField alloc] initWithFrame:CGRectMake(15, (44 - 25) / 2, 320 - 15 * 2, 25)];
    pricePerKilogram.placeholder = @"Price per Kilogram";
    pricePerKilogram.textAlignment = UITextAlignmentCenter;
    pricePerKilogram.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin);
    pricePerKilogram.tag = 'pric';
    
    fruitNote = [[UITextView alloc] initWithFrame:CGRectMake(15, (44 - 25) / 2, 320 - 15 * 2, 25)];
    fruitNote.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin);
    fruitNote.tag = 'note';
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(didWhenCancelButtonPressed)];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(didWhenDoneButtonPressed)];
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.rightBarButtonItem = doneButton;
    
    // I don't need it anymore
    [cancelButton release];
    [doneButton release];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"] autorelease];
    }
    
    switch (indexPath.row) {
        case 0:
            [cell addSubview:name];
            break;
            
        case 1:
            [cell addSubview:pricePerKilogram];
            break;
            
        case 2:
            [cell addSubview:fruitNote];
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row == 2 ? 150 : 44 ;
}

- (void)didWhenDoneButtonPressed
{
    if ([delegate respondsToSelector:@selector(saveFruitWithName:fruitNote:andPricePerKilogram:)]) {
        [delegate saveFruitWithName:name.text fruitNote:fruitNote.text andPricePerKilogram:[pricePerKilogram.text floatValue]];
    }
    
    [self didWhenCancelButtonPressed];
}

- (void)didWhenCancelButtonPressed
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)dealloc
{
    [name release];
    [pricePerKilogram release];
    [fruitNote release];
    [self.delegate release];
    
    [super dealloc];
}

@end
