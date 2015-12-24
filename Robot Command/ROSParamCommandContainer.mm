//
//  ROSParamCommandContainer.m
//  Robot Command
//
//  Created by Ryohei Ueda on 2015/12/24.
//  Copyright © 2015年 Ryohei Ueda. All rights reserved.
//

#import "ROSParamCommandContainer.h"
#import <std_srvs/Empty.h>

@implementation ROSParamCommandContainer

- (ROSParamCommandContainer*)initWithName:(std::string) name
                                  service:(std::string) service {
    self = [super init];
    self.name = name;
    self.service_name = service;
    return self;
}

// call the service
- (bool)call {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Confirm"
                          message:[NSString stringWithFormat:@"Are you sure to %s?", self.name.c_str()]
                          delegate:self
                          cancelButtonTitle:@"NO" otherButtonTitles:@"Go for it", nil];
    [alert show];
    return true;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        ROS_WARN("cancelled");
    }
    else {
        std_srvs::Empty req;
        ros::NodeHandle nh;
        ros::ServiceClient client = nh.serviceClient<std_srvs::Empty>(self.service_name);
        client.call(req);
    }
}


@end
