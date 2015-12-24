//
//  ROSParamCommandSectionTableViewController.h
//  Robot Command
//
//  Created by Ryohei Ueda on 2015/12/24.
//  Copyright © 2015年 Ryohei Ueda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <ros/ros.h>
#import "ROSParamCommandTableViewController.h"

@interface ROSParamCommandSectionTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>	
@property (nonatomic) NSMutableArray* sections;
@property (nonatomic) NSMutableArray* dummy;

@end
