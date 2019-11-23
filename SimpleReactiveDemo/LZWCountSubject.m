//
//  LZWCountSubject.m
//  SimpleReactiveDemo
//
//  Created by luozhiwei on 2019/11/23.
//  Copyright © 2019 Lizhi. All rights reserved.
//

#import "LZWCountSubject.h"

@interface LZWCountSubject ()

@property (nonatomic, assign) NSUInteger count;

@property (nonatomic, strong) NSMutableArray *blockArray;

@end

@implementation LZWCountSubject


- (LZWCountSubject *)sendNext:(NSUInteger)count {
    self.count = count;
    if (self.blockArray.count > 0) {
        for (SubscribeNextActionBlock block in self.blockArray) {
            block(self.count);
        }
    }
    return self;
}

- (LZWCountSubject *)subscribeNext:(SubscribeNextActionBlock)block {
    [self.blockArray addObject:block];
    return self;
}

- (NSMutableArray *)blockArray
{
    if (_blockArray == nil) {
        _blockArray = [NSMutableArray array];
    }
    return _blockArray;
}

@end
