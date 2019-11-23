//
//  ViewController.m
//  SimpleReactiveDemo
//
//  Created by luozhiwei on 2019/11/22.
//  Copyright © 2019 Lizhi. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "LZWBuyPanelModel.h"

@interface ViewController ()

@property (nonatomic, strong) LZWBuyPanelModel *buyPanelModel;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UIButton *minusBtn;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *coinLabel;
@property (nonatomic, strong) UIButton *actionBtn;

@end

@implementation ViewController

#pragma mark - init

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.addBtn];
    [self.view addSubview:self.numLabel];
    [self.view addSubview:self.minusBtn];
    [self.view addSubview:self.priceLabel];
    [self.view addSubview:self.coinLabel];
    [self.view addSubview:self.actionBtn];
    [self addLayoutConstrains];
    [self updateUI];
    
    [self.buyPanelModel.countSubject subscribeNext:^(NSUInteger count) {
        self.numLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)count];
    }];
    
    [self.buyPanelModel.countSubject subscribeNext:^(NSUInteger count) {
        if (count > 0) {
            self.priceLabel.text = [NSString stringWithFormat:@"价格：%lu", self.buyPanelModel.price * count];
        }
    }];
    
    [self.buyPanelModel.countSubject subscribeNext:^(NSUInteger count) {
        NSUInteger totalPrices = self.buyPanelModel.price * count;
        BOOL canBuy = self.buyPanelModel.coin >= totalPrices;
        [self.actionBtn setTitle:canBuy? @"购买" : @"充值" forState:UIControlStateNormal];
        [self.actionBtn setTitleColor:canBuy? UIColor.blackColor : UIColor.redColor forState:UIControlStateNormal];
    }];
}

#pragma mark - update view

- (void)updateUI
{
    self.numLabel.text = [NSString stringWithFormat:@"%d", self.buyPanelModel.count];
    self.priceLabel.text = [NSString stringWithFormat:@"价格：%d", self.buyPanelModel.price];
    self.coinLabel.text = [NSString stringWithFormat:@"帐号余额:%d", self.buyPanelModel.coin];
}

- (void)addLayoutConstrains
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.addBtn.mas_top);
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(20);
    }];
    
    [self.minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(16);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.minusBtn);
        make.left.mas_equalTo(self.minusBtn.mas_right);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numLabel);
        make.left.mas_equalTo(self.numLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];

    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.minusBtn.mas_bottom);
        make.left.mas_equalTo(self.minusBtn);
        make.right.mas_equalTo(self.addBtn.mas_right);
        make.height.mas_equalTo(50);
    }];

    [self.coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceLabel.mas_bottom);
        make.left.and.right.mas_equalTo(self.priceLabel);
        make.height.mas_equalTo(50);
    }];

    [self.actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coinLabel.mas_bottom);
        make.left.and.right.mas_equalTo(self.coinLabel);
        make.height.mas_equalTo(50);
    }];
}

#pragma - event actoin

- (void)addAction
{
    self.buyPanelModel.count++;
    [self.buyPanelModel.countSubject sendNext:self.buyPanelModel.count];
}

- (void)minusAction
{
    self.buyPanelModel.count--;
    if (self.buyPanelModel.count < 0) {
        self.buyPanelModel.count = 0;
    }
    [self.buyPanelModel.countSubject sendNext:self.buyPanelModel.count];
}

#pragma mark - getters

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"购买数量:";
    }
    return _titleLabel;
}

- (UIButton *)addBtn
{
    if (_addBtn == nil) {
        _addBtn = [[UIButton alloc] init];
        [_addBtn setTitle:@"+" forState:UIControlStateNormal];
        [_addBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_addBtn setBackgroundColor:UIColor.grayColor];
        [_addBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

- (UILabel *)numLabel
{
    if (_numLabel == nil) {
        _numLabel = [[UILabel alloc] init];
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.text = @"0";
        [_numLabel setBackgroundColor:UIColor.yellowColor];
    }
    return _numLabel;
}

- (UIButton *)minusBtn
{
    if (_minusBtn == nil) {
        _minusBtn = [[UIButton alloc] init];
        [_minusBtn setTitle:@"-" forState:UIControlStateNormal];
        [_minusBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_minusBtn setBackgroundColor:UIColor.grayColor];
        [_minusBtn addTarget:self action:@selector(minusAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _minusBtn;
}

- (UILabel *)priceLabel
{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        [_priceLabel setBackgroundColor:UIColor.greenColor];
        _priceLabel.text = @"0";
    }
    return _priceLabel;
}

- (UILabel *)coinLabel
{
    if (_coinLabel == nil) {
        _coinLabel = [[UILabel alloc] init];
        _coinLabel.textAlignment = NSTextAlignmentCenter;
        [_coinLabel setBackgroundColor:UIColor.lightGrayColor];
        _coinLabel.text = @"0";
    }
    return _coinLabel;
}

- (UIButton *)actionBtn
{
    if (_actionBtn == nil) {
        _actionBtn = [[UIButton alloc] init];
        [_actionBtn setTitle:@"购买" forState:UIControlStateNormal];
        [_actionBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_actionBtn setBackgroundColor:UIColor.cyanColor];
    }
    return _actionBtn;
}

- (LZWBuyPanelModel *)buyPanelModel
{
    if (_buyPanelModel == nil) {
        _buyPanelModel = [[LZWBuyPanelModel alloc] initWithCoin:100 price:50 count:1];
    }
    return _buyPanelModel;
}


@end
