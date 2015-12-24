//
//  InitailViewController.m
//  Robot Command
//
//  Created by Ryohei Ueda on 2015/12/24.
//  Copyright © 2015年 Ryohei Ueda. All rights reserved.
//

#import "InitailViewController.h"
#import <ros/ros.h>

@implementation InitailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    ROS_INFO("viewDidLoad");
    // check controller
    if ([[GCController controllers] count] > 0) {
        self.use_controller = TRUE;
        self.controller = [GCController controllers][0];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"controller"
                              message:@"found"
                              delegate:self
                              cancelButtonTitle:@"OK！" otherButtonTitles:nil];
        [alert show];
            __weak typeof(self) weakself = self;
            self.controller.extendedGamepad.valueChangedHandler =  ^(GCExtendedGamepad *gamepad, GCControllerElement *element) {
                [weakself gamepadCallback:gamepad element:element];
            };
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;	// 0 -> 1 に変更
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;	// 0 -> 10 に変更
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"ROS Param Commands";
    }
    return cell;
}

// Callback function when cell is selected
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"ROS Param Commands" sender:self];
    }
}

- (void)gamepadCallback:(GCExtendedGamepad *)gamepad
                element:(GCControllerElement*)element {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"controller"
                          message:@"value changed"
                          delegate:self
                          cancelButtonTitle:@"OK！" otherButtonTitles:nil];
    [alert show];
}


@end
