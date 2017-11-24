//
//  SwitchViewButton.m
//  NestVC
//
//  Created by litianqi on 2017/8/25.
//  Copyright © 2017年 UDown. All rights reserved.
//

#import "SwitchViewButton.h"

#define ColorSelect @"0xf97720"
#define ColorNomal @"0x666666"
@interface SwitchViewButton ()
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) UIView *flagLine;
@end
@implementation SwitchViewButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor greenColor]];
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-2)];
        [_scrollView setContentSize:CGSizeMake(frame.size.width, frame.size.height)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [_scrollView setBackgroundColor:[UIColor yellowColor]];
        [self addSubview:_scrollView];
        
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.trailing.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self).offset(-2);
        }];
        
        UIView * bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0,frame.size.width ,2)];
        [bottomLine setBackgroundColor:[UIColor colorWithHexString:@"0xe0e0e0"]];
        [self addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.trailing.equalTo(self);
            make.height.mas_equalTo(2);
            make.bottom.equalTo(self).offset(-2);
        }];
        
        
        _flagLine = [[UIView alloc] initWithFrame:CGRectMake(0,frame.size.height - 2,30 ,2)];
        [_flagLine setBackgroundColor:[UIColor colorWithHexString:ColorSelect]];
        [_flagLine setBackgroundColor:[UIColor redColor]];
        [self addSubview:_flagLine];
        [_flagLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(2);
            make.bottom.equalTo(self).offset(-2);
        }];
 
    }
    return self;
}

- (void)setArrayItem:(NSArray *)arrayItem{
    [self clearSubView];
    _arrayItem = arrayItem ? arrayItem : @[];
    NSInteger btnWidth = self.frame.size.width / self.arrayItem.count;
    [_flagLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(btnWidth);
    }];
    
    [self loadSubView];
}

- (void)clearSubView{
    if (!_arrayItem || _arrayItem.count == 0) {
        _arrayItem = @[];
        return;
    }
    for (UIView * view in _scrollView.subviews) {
        if (view.tag > 0) {
            [view removeFromSuperview];
        }
    }
}

-(void)loadSubView{
    NSInteger btnWidth =self.frame.size.width / self.arrayItem.count;
    NSInteger index = 0;
    for (id obj in self.arrayItem) {
        UIButton * button  = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:obj forState:UIControlStateNormal];
        if (index == 0) {
             [button setTitleColor:[UIColor colorWithHexString:ColorSelect] forState:UIControlStateNormal];
             NSInteger btnTextWidth = button.titleLabel.text.length * 16;
            [_flagLine mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(btnTextWidth);
            }];
        }
        else
            [button setTitleColor:[UIColor colorWithHexString:ColorNomal] forState:UIControlStateNormal];
        
        [button setFrame:CGRectMake(index++ * btnWidth,0, btnWidth, self.frame.size.height-2)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [button setTag: index];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        [button setBackgroundColor:[UIColor redColor]];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView);
            make.bottom.equalTo(self.scrollView);
        }];
        
    }
    [self bringSubviewToFront:_flagLine];
    self.currentIndex = 1;
}

-(void)clickButton:(id)sender{
    UIButton * btn = (UIButton*)sender;
//    [btn startAnimationCutom_ScaleDefaultDurationWithCallBack:^{
        NSInteger index = [btn tag];
        self.currentIndex = index;
        if ([self.delegate respondsToSelector:@selector(clickButton:)]) {
            [self.delegate clickButton:index];
        }

//    }];
    
}

-(void)setCurrentIndex:(NSInteger)currentIndex{
    if (currentIndex == _currentIndex) {
        return;
    }
    [self changeButtonStyle:_currentIndex withIsSelected:NO];
    _currentIndex = currentIndex;
 
    [self changeButtonStyle:_currentIndex withIsSelected:YES];
}
-(void)changeButtonStyle:(NSInteger)index  withIsSelected:(BOOL)isSelect{
    UIButton * btn = [self.scrollView viewWithTag:index];
    if (!btn || ![btn isKindOfClass:[UIButton class]]) {
        return;
    }
    NSInteger btnTextWidth = btn.titleLabel.text.length * 16;
    [_flagLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(btnTextWidth);
    }];
    if (isSelect) {
        [btn setTitleColor:[UIColor colorWithHexString:ColorSelect] forState:UIControlStateNormal];
        NSInteger newX = btn.center.x;
        POPBasicAnimation * basicAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        basicAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(newX, self.flagLine.center.y)];
        [self.flagLine pop_removeAnimationForKey:@"xtrans"];
        [self.flagLine pop_addAnimation:basicAnimation forKey:@"xtrans"];
    }
    else
        [btn setTitleColor:[UIColor colorWithHexString:ColorNomal] forState:UIControlStateNormal];
    
}

+ (CGSize)contentSize{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 50);

}
@end

@implementation SwitchViewButtonCollectionCell

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _swithchViewbutton = [[SwitchViewButton alloc] initWithFrame:CGRectMake(0, 0,[SwitchViewButton contentSize].width, [SwitchViewButton contentSize].height)];
        _swithchViewbutton.delegate = self;
        [self.contentView addSubview:_swithchViewbutton];
    }
    return self;
}

#pragma mark -- SwitchViewButtonDelegate
- (void)clickButton:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(clickButton:)]) {
        [self.delegate clickButton:index];
    }
}

@end

@implementation SwitchViewButtonCollectionReusableViewCell
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _swithchViewbutton = [[SwitchViewButton alloc] initWithFrame:CGRectMake(0, 0, [SwitchViewButton contentSize].width, [SwitchViewButton contentSize].height)];
        _swithchViewbutton.delegate = self;
        [self addSubview:_swithchViewbutton];
    }
    return self;
}

-(void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    _swithchViewbutton.currentIndex = _currentIndex;
}
#pragma mark -- SwitchViewButtonDelegate
- (void)clickButton:(NSInteger)index{
    
    if ([self.delegate respondsToSelector:@selector(clickButton:)]) {
        [self.delegate clickButton:index];
    }
}



@end
