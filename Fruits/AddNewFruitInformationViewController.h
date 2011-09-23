//
//  AddNewFruitInformationViewController.h
//  Fruits
//
//  Created by Sitdhibhong Laokok on 9/19/54 BE.
//  Copyright 2554 Apps Tree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FruitInformDelegate.h"

@interface AddNewFruitInformationViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
    UITextField *name;
    UITextField *pricePerKilogram;
    UITextView *fruitNote;
}

@property (nonatomic, retain) id<FruitInformDelegate> delegate;

@end
