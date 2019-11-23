//
//  LZWBuyPanelModel.h
//  SimpleReactiveDemo
//
//  Created by luozhiwei on 2019/11/22.
//  Copyright © 2019 Lizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZWCountSubject.h"

NS_ASSUME_NONNULL_BEGIN

@interface LZWBuyPanelModel : NSObject

@property (nonatomic, assign) int coin;     // 当前用户金币数量

@property (nonatomic, assign) int count;    // 购买数量
@property (nonatomic, assign) int price;    // 商品价格

@property (nonatomic, strong) LZWCountSubject *countSubject;

- (instancetype)initWithCoin:(int)coin price:(int)price count:(int)count;

@end

NS_ASSUME_NONNULL_END
