//
//  ROSParamSectionContainer.h
//  Robot Command
//
//  Created by Ryohei Ueda on 2015/12/24.
//  Copyright © 2015年 Ryohei Ueda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ros/ros.h>
#import "ROSParamCommandContainer.h"

@interface ROSParamSectionContainer : NSObject
@property (nonatomic) NSMutableArray* commands;
@property (nonatomic) std::string name;

- (ROSParamSectionContainer*)initWithNameField:(std::string) name;
- (void)addContainer:(ROSParamCommandContainer*)container;
- (NSInteger)commandsCount;
- (ROSParamCommandContainer*) commandAtIndex:(NSInteger) index;

@end
