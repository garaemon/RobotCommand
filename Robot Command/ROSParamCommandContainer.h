//
//  ROSParamCommandContainer.h
//  Robot Command
//
//  Created by Ryohei Ueda on 2015/12/24.
//  Copyright © 2015年 Ryohei Ueda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ros/ros.h>
#import <UIKit/UIKit.h>

@interface ROSParamCommandContainer : NSObject <UIAlertViewDelegate>
@property (nonatomic) std::string name;
@property (nonatomic) std::string service_name;


- (ROSParamCommandContainer*)initWithName:(std::string) name
                                  service:(std::string) service;
- (bool)call;

@end
