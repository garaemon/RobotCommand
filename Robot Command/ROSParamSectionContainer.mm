//
//  ROSParamSectionContainer.m
//  Robot Command
//
//  Created by Ryohei Ueda on 2015/12/24.
//  Copyright © 2015年 Ryohei Ueda. All rights reserved.
//

#import "ROSParamSectionContainer.h"

@implementation ROSParamSectionContainer

- (ROSParamSectionContainer*)initWithNameField:(std::string) name {
    self = [super init];
    self.commands = [NSMutableArray array];
    self.name = name;
    return self;
}

- (void)addContainer:(ROSParamCommandContainer*)container {
    [self.commands addObject:container];
}

- (NSInteger)commandsCount {
    return [self.commands count];
}

- (ROSParamCommandContainer*) commandAtIndex:(NSInteger) index {
    return (ROSParamCommandContainer*)[self.commands objectAtIndex:index];
}

@end
