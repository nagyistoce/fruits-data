//
//  FruitsAppDelegate.h
//  Fruits
//
//  Created by Sitdhibhong Laokok on 9/19/54 BE.
//  Copyright 2554 Apps Tree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FruitsAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
