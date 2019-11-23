//
//  LZWBuyPanelModel.m
//  SimpleReactiveDemo
//
//  Created by luozhiwei on 2019/11/22.
//  Copyright © 2019 Lizhi. All rights reserved.
//

#import "LZWBuyPanelModel.h"

@implementation LZWBuyPanelModel

- (instancetype)initWithCoin:(int)coin price:(int)price count:(int)count
{
    if (self = [super init]) {
        self.coin = coin;
        self.price = price;
        self.count = count;
    }
    return self;
}

#pragma mark - getters

- (LZWCountSubject *)countSubject
{
    if (_countSubject == nil) {
        _countSubject = [[LZWCountSubject alloc] init];
    }
    return _countSubject;
}

@end
