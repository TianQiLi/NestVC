//
//  SwitchViewButton.m
//  hqedu24olapp
//
//  Created by litianqi on 16/7/21.
//  Copyright © 2016年 edu24ol. All rights reserved.
//

#import "SwitchViewButton.h"
//#import "UIView+Animation.h"
#define ColorSelect @"0xeec13c"
#define ColorNomal @"0x666666"
@interface SwitchViewButton ()
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) UIView *flagLine;
@property (nonatomic,strong) UIView * bottomLine;
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
        [self setBackgroundColor:[UIColor whiteColor]];

        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-2)];
        [_scrollView setContentSize:CGSizeMake(frame.size.width,0)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        [self addSubview:_scrollView];
        
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.trailing.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self).offset(-2);
        }];
        
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0,frame.size.width ,1)];
        [_bottomLine setBackgroundColor:[UIColor colorWithHexString:@"0xe0e0e0"]];
        [self addSubview:_bottomLine];
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.trailing.equalTo(self);
            make.height.mas_equalTo(1);
            make.bottom.equalTo(self);
        }];
        
        _flagLine = [[UIView alloc] initWithFrame:CGRectMake(20,self.frame.size.height-2,64 ,2)];
        [_flagLine setBackgroundColor:[UIColor colorWithHexString:ColorSelect]];
        [self addSubview:_flagLine];

        
    }
    return self;
}

- (void)hiddenBottomLine:(BOOL)hidden{
    _bottomLine.hidden = hidden;
}
- (void)setArrayItem:(NSArray *)arrayItem{
    [self clearSubView];
    _arrayItem = arrayItem ? arrayItem : @[];
    
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
        [button setFrame:CGRectMake(index * btnWidth,0, btnWidth, self.frame.size.height-2)];
        [self.scrollView addSubview:button];
        if (index == 0) {
            [button setTitleColor:[UIColor colorWithHexString:ColorSelect] forState:UIControlStateNormal];
            NSInteger btnTextWidth = button.titleLabel.text.length * 16;
            CGRect frame = _flagLine.frame;
            frame.size.width = btnTextWidth;
            _flagLine.frame = frame;
            CGPoint center = _flagLine.center;
            center.x = button.center.x;
            _flagLine.center = center;
        }
        else
            [button setTitleColor:[UIColor colorWithHexString:ColorNomal] forState:UIControlStateNormal];
        
        [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [button setTag: ++index];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    [self bringSubviewToFront:_flagLine];
    _currentIndex = 1;
}

-(void)clickButton:(id)sender{
    UIButton * btn = (UIButton*)sender;
    NSInteger index = [btn tag];
    self.currentIndex = index;
//    [btn startAnimationCutom_ScaleDefaultDurationWithCallBack:^{
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
   
    if (isSelect) {
        static NSInteger temp = 0;
        NSInteger btnTextWidth = btn.titleLabel.text.length * 16;
        if (temp != btnTextWidth) {
            temp = btnTextWidth;
            CGRect frame = _flagLine.frame;
            frame.size.width = btnTextWidth;
            _flagLine.frame = frame;
        }
        
        [UIView animateWithDuration:0.4 animations:^{
            CGPoint center = self.flagLine.center;
            center.x = btn.center.x;
            self.flagLine.center = center;
        } completion:nil];
        [btn setTitleColor:[UIColor colorWithHexString:ColorSelect] forState:UIControlStateNormal];
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
