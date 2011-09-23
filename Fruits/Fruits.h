//
//  Fruits.h
//  Fruits
//
//  Created by Sitdhibhong Laokok on 9/19/54 BE.
//  Copyright (c) 2554 Apps Tree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Fruits : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * pricePerKilogram;
@property (nonatomic, retain) NSString * fruitNote;

@end
