//
//  ROSparamCommandTableViewController.m
//  Robot Command
//
//  Created by Ryohei Ueda on 2015/12/24.
//  Copyright © 2015年 Ryohei Ueda. All rights reserved.
//

#import "ROSparamCommandTableViewController.h"

@implementation ROSparamCommandTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.section_container commandsCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    ROS_INFO("indexPath.row: %d", indexPath.row);
    if (indexPath.row < [self.section_container commandsCount]) {
        std::string name = ((ROSParamSectionContainer*)[self.section_container commandAtIndex:indexPath.row]).name;
        cell.textLabel.text = [[NSString alloc] initWithUTF8String:name.c_str()];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < [self.section_container commandsCount]) {
        ROSParamCommandContainer* command = [self.section_container commandAtIndex:indexPath.row];
        [command call];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}


@end
