//
//  InitailViewController.h
//  Robot Command
//
//  Created by Ryohei Ueda on 2015/12/24.
//  Copyright © 2015年 Ryohei Ueda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameController/GameController.h>

@interface InitailViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>		
@property (nonatomic, strong) GCController *controller;
@property (nonatomic) BOOL use_controller;

// controller callbacks
- (void)gamepadCallback:(GCExtendedGamepad *)gamepad
                element:(GCControllerElement*)element;
@end
