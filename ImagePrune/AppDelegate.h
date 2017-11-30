//
//  AppDelegate.h
//  ImagePrune
//
//  Created by 红喇叭 on 2017/11/29.
//  Copyright © 2017年 红喇叭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

