//
//  FruitInformDelegate.h
//  Fruits
//
//  Created by Sitdhibhong Laokok on 9/19/54 BE.
//  Copyright 2554 Apps Tree. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FruitInformDelegate <NSObject>

@optional
- (void)saveFruitWithName:(NSString *)name fruitNote:(NSString *)fruitNote andPricePerKilogram:(float)price;

@end
