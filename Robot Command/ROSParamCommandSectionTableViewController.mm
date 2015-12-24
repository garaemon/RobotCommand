//
//  ROSParamCommandSectionTableViewController.m
//  Robot Command
//
//  Created by Ryohei Ueda on 2015/12/24.
//  Copyright © 2015年 Ryohei Ueda. All rights reserved.
//

#import "ROSParamCommandSectionTableViewController.h"
#import "ROSParamSectionContainer.h"

@implementation ROSParamCommandSectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // initialize self.sections
    // load parameter
    self.sections = [NSMutableArray array];
    self.dummy = [NSMutableArray array];
    ros::NodeHandle nh;
    @try {
        if (nh.hasParam("rosparam_commands")) {
            XmlRpc::XmlRpcValue v;
            nh.param("rosparam_commands", v, v);
            if (v.getType() == XmlRpc::XmlRpcValue::TypeArray) {
                ROS_INFO("rosparam_commands is array");
                for (size_t section_i = 0; section_i < v.size(); section_i++) {
                    // each section should be a dictionary
                    XmlRpc::XmlRpcValue vv = v[section_i];
                    if (vv.getType() == XmlRpc::XmlRpcValue::TypeStruct) {
                        ROS_INFO("section %zu is struct", section_i);
                        ROS_INFO(" -- %s", vv.toXml().c_str());
                        if (!vv.hasMember("name")) {
                            @throw [NSException exceptionWithName:@"rosparam read error"
                                                           reason:@"section does not have name field"
                                                         userInfo:nil];
                        }
                        else if (!vv.hasMember("commands")) {
                            @throw [NSException exceptionWithName:@"rosparam read error"
                                                           reason:@"section does not have commands field"
                                                         userInfo:nil];
                        }
                        else {
                            ROSParamSectionContainer* section = [[ROSParamSectionContainer alloc]
                                                                    initWithNameField:vv["name"]];
                            ROS_INFO("foo");
                            [self.sections addObject:section];
                            [self.dummy addObject:@"foo"];
                            ROS_INFO("bar %lu", [self.sections count]);
                            ROS_INFO("bar2 %lu", [self.dummy count]);
                            XmlRpc::XmlRpcValue vvv = vv["commands"];

                            if (vvv.getType() != XmlRpc::XmlRpcValue::TypeArray) {
                                @throw [NSException exceptionWithName:@"rosparam read error"
                                                               reason:@"commands section is not array"
                                                             userInfo:nil];
                            }
                            else {
                                for (size_t command_i = 0; command_i < vvv.size(); command_i++) {
                                    XmlRpc::XmlRpcValue vvvv = vvv[command_i];
                                    if (vvvv.getType() != XmlRpc::XmlRpcValue::TypeStruct) {
                                        @throw [NSException exceptionWithName:@"rosparam read errro"
                                                                       reason:@"commands section is not array of dictionery" userInfo:nil];
                                    }
                                    else if (!vvvv.hasMember("name")) {
                                        @throw [NSException exceptionWithName:@"rosparam read error"
                                                                       reason:@"command section does not have name field" userInfo:nil];
                                    }
                                    else if (!vvvv.hasMember("srv")) {
                                        @throw [NSException exceptionWithName:@"rosparam read error"
                                                                       reason:@"command section does not have srv field" userInfo:nil];
                                    }
                                    else {
                                        ROS_INFO("command %s -- %s", ((std::string)vvvv["name"]).c_str(), ((std::string)vvvv["srv"]).c_str());
                                        ROSParamCommandContainer* command = [[ROSParamCommandContainer alloc] initWithName:vvvv["name"]
                                                                                service:vvvv["srv"]];
                                        [section addContainer:command];
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        else {
            @throw [NSException exceptionWithName:@"rosparam read error"
                                           reason:@"cannot find /rosparam_commands parameter"
                                         userInfo:nil];
        }
        ROS_INFO("sections: %lu", [self.sections count]);
    }
    @catch (NSException* exception) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:exception.name
                              message:exception.reason
                              delegate:self
                              cancelButtonTitle:@"OK！" otherButtonTitles:nil];
        [alert show];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    ROS_INFO("%d", [self.sections count]);
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sections count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    ROS_INFO("indexPath.row: %d", indexPath.row);
    if (indexPath.row < [self.sections count]) {
        std::string name = ((ROSParamSectionContainer*)[self.sections objectAtIndex:indexPath.row]).name;
        cell.textLabel.text = [[NSString alloc] initWithUTF8String:name.c_str()];
    }
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"selectRow"]) {
        ROSparamCommandTableViewController* ctrl = [segue destinationViewController];    // <- 1
        ctrl.section_container = [self.sections objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}

// Callback function when cell is selected
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   [self performSegueWithIdentifier:@"selectRow" sender:self];
}



@end
