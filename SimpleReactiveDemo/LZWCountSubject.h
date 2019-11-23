//
//  LZWCountSubject.h
//  SimpleReactiveDemo
//
//  Created by luozhiwei on 2019/11/23.
//  Copyright © 2019 Lizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LZWCountSubject;

NS_ASSUME_NONNULL_BEGIN

typedef void(^SubscribeNextActionBlock)(NSUInteger count);

@interface LZWCountSubject : NSObject

- (LZWCountSubject *)sendNext:(NSUInteger)count;
- (LZWCountSubject *)subscribeNext:(SubscribeNextActionBlock)block;

@end

NS_ASSUME_NONNULL_END
