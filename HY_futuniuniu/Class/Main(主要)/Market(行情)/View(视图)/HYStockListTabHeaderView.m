//
//  HYStockListTabHeaderView.m
//  HY_futuniuniu
//
//  Created by tongfang on 2017/11/24.
//  Copyright © 2017年 Hyman. All rights reserved.
//

#import "HYStockListTabHeaderView.h"
#import "Masonry.h"
#import "UIView+YYAdd.h"

@interface HYStockListTabHeaderView()<UIScrollViewDelegate>
@end

@implementation HYStockListTabHeaderView{
    UIScrollView *_contentScv;
    HYControlView *_controlView ;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    UIScrollView *contentScv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height)];
    _contentScv = contentScv;
    contentScv.delegate = self;
    contentScv.showsVerticalScrollIndicator = NO;
    contentScv.showsHorizontalScrollIndicator = NO;
    contentScv.pagingEnabled = YES;
    contentScv.bounces = NO;
    contentScv.contentSize = CGSizeMake(SCREEN_WIDTH*3, 80);
    [self addSubview:contentScv];
    
    //暂时设置为只开通了港美股 未开通A股
    [self layoutPageSubView:@"CN" index:0];
    [self layoutPageSubView:@"HK" index:1];
    [self layoutPageSubView:@"US" index:2];
    
    //controlView
    _controlView = [[HYControlView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-20)/2.f, self.height-10.f, 35.f, 2.2f) page:3];
    [self addSubview:_controlView];
}

- (void)layoutPageSubView:(NSString *)accountType index:(NSInteger)index{
    
    UIView *pageView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH *index, 0, SCREEN_WIDTH, self.height)];
    [_contentScv addSubview:pageView];
    
    UIImageView *accountTypeImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    [pageView addSubview:accountTypeImg];
    
    [accountTypeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15.f);
        make.top.equalTo(@15.f);
        make.width.equalTo(@16.f);
        make.height.equalTo(@16.f);
    }];
    
    UILabel *accountTypeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    accountTypeLabel.font = HYFONT(13.f);
    accountTypeLabel.textColor = HYCOLOR(121, 135, 156, 1);
    [pageView addSubview:accountTypeLabel];
    
    [accountTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accountTypeImg.mas_right).offset(5);
        make.centerY.equalTo(accountTypeImg.mas_centerY);
    }];
    
    HYCheckMarkView *markView = [[HYCheckMarkView alloc] initWithFrame:CGRectZero];
    markView.backgroundColor = [UIColor clearColor];
    [pageView addSubview:markView];
    
    [markView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accountTypeImg);
        make.top.equalTo(accountTypeImg.mas_bottom).offset(15.f);
        make.width.equalTo(@16);
        make.height.equalTo(@13);
    }];
    
    UILabel *figureLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    figureLabel.font = HYFONT(16.f);
    figureLabel.textColor = [UIColor whiteColor];
    [pageView addSubview:figureLabel];
    
    [figureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(markView.mas_right).offset(5);
        make.centerY.equalTo(markView.mas_centerY);
    }];
    
    UIImageView *enterImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    enterImg.image = [UIImage imageNamed:@"skin_common_icon_enter"];
    [pageView addSubview:enterImg];
    
    [enterImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-10));
        make.centerY.equalTo(self);
        make.width.equalTo(@12);
        make.height.equalTo(@12);
    }];
    
    UILabel *enterLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    enterLabel.font = HYFONT(15.f);
    enterLabel.textColor =HYCOLOR(121, 135, 156, 1);
    [pageView addSubview:enterLabel];
    
    [enterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(enterImg.mas_left).offset(-3);
        make.centerY.equalTo(self);
    }];
    
    if ([accountType isEqualToString:@"CN"]) {
        accountTypeImg.image = [UIImage imageNamed:@"skin_quote_icon_flag_cn"];
        accountTypeLabel.text = @"沪深账户";
        enterLabel.text = @"未绑定";
        figureLabel.hidden = YES;
        markView.hidden = YES;
    }else if ([accountType isEqualToString:@"HK"]){
        accountTypeImg.image = [UIImage imageNamed:@"skin_quote_icon_flag_hk"];
        accountTypeLabel.text = @"港股现金账户(6306)";
        enterLabel.text = @"立即入金";
        figureLabel.hidden = NO;
        figureLabel.text = @"0.00";
        markView.hidden = NO;
    }else if ([accountType isEqualToString:@"US"]){
        accountTypeImg.image = [UIImage imageNamed:@"skin_quote_icon_flag_us"];
        accountTypeLabel.text = @"美股现金账户(6071)";
        enterLabel.text = @"立即入金";
        figureLabel.hidden = NO;
        figureLabel.text = @"0.00";
        markView.hidden = NO;
    }
}

#pragma mark *** UIScrollViewDelegaete ***
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentPage = scrollView.contentOffset.x/SCREEN_WIDTH;
    _controlView.currentPage = currentPage;
}
@end

@implementation HYControlView{
    NSInteger _page;
    CGFloat _space;
}

- (instancetype)initWithFrame:(CGRect)frame page:(NSInteger)page{
    if (self = [super initWithFrame:frame]) {
        _page = page;
        _space = 2.5f;
        _currentPage = 0;
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    CGFloat itemWidth = (self.width - _space*(_page -1))/_page;
    for (int i = 0; i <_page ; i++) {
        UIView *item = [[UIView alloc] initWithFrame:CGRectMake(i*(itemWidth+_space), 0, itemWidth, self.height)];
        item.backgroundColor = HYCOLOR(85, 91, 106, 1);
        item.layer.cornerRadius = 1.f;
        item.layer.masksToBounds = YES;
        item.tag = i +10;
        [self addSubview:item];
        if (i == 0) {
            item.backgroundColor = HYCOLOR(255, 255, 255, 1);
        }
    }
}

- (void)setCurrentPage:(NSInteger)currentPage{
     UIView *lastView = [self viewWithTag:_currentPage + 10];
    lastView.backgroundColor = HYCOLOR(85, 91, 106, 1);
    _currentPage = currentPage;
    UIView *itemView = [self viewWithTag:_currentPage + 10];
    itemView.backgroundColor = HYCOLOR(255, 255, 255, 1);
}

@end

@implementation HYCheckMarkView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1.f);
    CGContextSetStrokeColorWithColor(ctx, HYCOLOR(110, 122, 142, 1).CGColor);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextMoveToPoint(ctx, rect.origin.x, rect.size.height/2.f);
    CGContextAddQuadCurveToPoint(ctx, rect.size.width/2.f, rect.size.height+5, rect.size.width, rect.size.height/2.f);
    CGContextMoveToPoint(ctx, rect.origin.x, rect.size.height/2.f);
    CGContextAddQuadCurveToPoint(ctx, rect.size.width/2.f, -5, rect.size.width, rect.size.height/2.f);
    CGContextStrokePath(ctx);
    CGContextAddArc(ctx, rect.size.width/2.f, rect.size.height/2.f, 3.f, 0, 2*M_PI, 0);
    CGContextStrokePath(ctx);
}
@end
