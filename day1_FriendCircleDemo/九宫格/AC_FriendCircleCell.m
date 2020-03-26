//
//  AC_FriendCircleCell.m
//  day1_FriendCircleDemo
//
//  Created by lianshuo on 2020/3/24.
//  Copyright © 2020 Alice_ss. All rights reserved.
//
//想要的效果：
// 头像  昵称
// 头像
// 头像  时间
// 评论内容======这里是评论内容
// 评论图片======这里是评论图片九宫格形式
// 回复内容======这里是回复内容
//

#import "AC_FriendCircleCell.h"

@interface AC_FriendCircleCell()
@property (nonatomic,strong)UIImageView *headIMG;
@property (nonatomic,strong)UILabel *nameL;
@property (nonatomic,strong)UILabel *timeL;
@property (nonatomic,strong)UILabel *introL;
@property (nonatomic,strong)UIView *imgs;
@property (nonatomic,strong)UIView *replyView;
@property (nonatomic,strong)UILabel *replayL;
@property (nonatomic,strong)UILabel *replyContent;


//重要！！！！
@property (nonatomic,strong)id bottimView;//记录最下边的一个view
@property MASConstraint *midMasContraint;//记录暂存中间可能是最后一个的约束、


@end

@implementation AC_FriendCircleCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }return self;
}


#pragma mark - 创建页面
- (void)createUI{
    _headIMG = [[UIImageView alloc]init];
    _timeL = [[UILabel alloc]init];
    _nameL = [[UILabel alloc]init];
    
    _introL = [[UILabel alloc]init];
    _introL.numberOfLines =  0;
    
    _imgs = [[UIView alloc]init];
    
    _replyView = [[UIView alloc]init];
    _replyView.backgroundColor = RGBColor(240, 240, 240);
    _replyView.clipsToBounds = YES;
    _replayL = [[UILabel alloc]init];
    _replayL.text = @"回复内容:";
    _replayL.textColor = RGBColor(110, 110, 110);
    _replyContent = [[UILabel alloc]init];
    _replyContent.numberOfLines = 0;
    [self.contentView addSubview:_headIMG];
    [self.contentView addSubview:_timeL];
    [self.contentView addSubview:_nameL];
    
    [self.contentView addSubview:_introL];
    
    [self.contentView addSubview:_imgs];
    
    [self.contentView addSubview:_replyView];
    [_replyView addSubview:_replayL];
    [_replyView addSubview:_replyContent];
    

    //设置约束 给不需要变化的部分设置约束
    [_headIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(15).priorityHigh();
        make.left.mas_offset(15);
        make.height.mas_offset(50);
        make.width.mas_offset(50);
    }];
    _headIMG.layer.cornerRadius = 25;
    _headIMG.layer.masksToBounds = YES;
    
    [_nameL  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headIMG.mas_right).offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(50/2);
        make.top.mas_equalTo(self.headIMG.mas_top).priorityHigh();
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameL.mas_left);
        make.right.mas_equalTo(self.nameL.mas_right);
        make.height.mas_equalTo(self.nameL.mas_height);
        make.top.mas_equalTo(self.nameL.mas_bottom);
    }];
    
    
}


#pragma mark - 给页面赋值
- (void)setcellWithDic:(id)dic{
    
    //这一部分是一定存在的
    _headIMG.backgroundColor = RGBColor(arc4random() % 255,arc4random() % 255,arc4random() % 255);
    _nameL.text = dic[@"name"];
    _timeL.text = dic[@"time"];
    _introL.text = dic[@"intro"];
    
    NSInteger picCount = [dic[@"pics"] integerValue];
    NSString *replyContent = dic[@"replyContent"];
    NSString *intro = dic[@"intro"];
    
    _replyContent.text =  replyContent;

    //设置评论
    if (intro.length>0) {
        _introL.hidden = NO;
        
        [self setIntro:_headIMG andContent:intro];
    }else{
        _introL.hidden = YES;
    }
    
    //设置图片
    if(picCount>0){
        _imgs.hidden = NO;
        [self setPics:intro.length>0?_introL:_headIMG andPicNum:picCount];
        
    }else{
        _imgs.hidden = YES;
        _imgs.clipsToBounds = YES;
    }
    
    
    //设置回复框
    if(replyContent.length>0){
        _replyView.hidden = NO;
        [self setReply:picCount>0?_imgs:(intro.length>0?_introL:_headIMG) andContent:replyContent];

    }else{
        _replyView.hidden = YES;
    }
    

    
    //对最后一个控件进行设置约束
    [self.midMasContraint uninstall];
    
    if (self.bottimView == self.introL) {
        [self.introL mas_updateConstraints:^(MASConstraintMaker *make) {
            self.midMasContraint = make.bottom.mas_offset(-15);
        }];
    }else if (self.bottimView  == self.imgs) {
        [self.imgs mas_updateConstraints:^(MASConstraintMaker *make) {
            self.midMasContraint = make.bottom.mas_offset(-15);
        }];
    }else if (self.bottimView  == self.replyView) {
        [self.replyView mas_updateConstraints:^(MASConstraintMaker *make) {
            self.midMasContraint = make.bottom.mas_offset(-15);
        }];
    }
}



//设置评论内容
- (void)setIntro:(UIView*)lastView andContent:(NSString*)content{
    [_introL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headIMG.mas_left);
        make.right.mas_equalTo(self.nameL.mas_right);
        make.top.mas_equalTo(lastView.mas_bottom).offset(15).priorityHigh();
    }];
    
    _bottimView = _introL;
}

//设置图片
- (void)setPics:(UIView*)lastView andPicNum:(NSInteger)count{
    
    for (UIImageView *img in _imgs.subviews) {//移除之前已有的图片 再从新添加新的图片
        [img removeFromSuperview];
    }
    
    
    [_imgs mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(lastView.mas_bottom).offset(15);
    }];
    
    CGFloat x = 15;
    CGFloat y = 0;
    CGFloat w = (KscreenW-30-30)/3;
    CGFloat h = w;
    CGFloat gap = 15;
    for (int i = 0; i<count; i++) {
        
        UIImageView *img = [[UIImageView alloc]init];
        img.backgroundColor = [UIColor redColor];
        [self.imgs addSubview:img];
        
        
        
        if (i == count-1) {
            [img mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(x);
                make.top.mas_offset(y);
                make.height.mas_offset(w);
                make.width.mas_offset(h);
                make.bottom.mas_offset(0);
            }];
        }else{
            [img mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(x);
                make.top.mas_offset(y);
                make.height.mas_offset(w);
                make.width.mas_offset(h);
            }];
        }
        
        x+=(w+gap);
        if (i%3==0 &&i!=0) {
            x = 15;
            y = y+h+gap;
        }
    }
    
    
    _bottimView = self.imgs;
}

//设置回复内容
- (void)setReply:(UIView*)lastView andContent:(NSString*)content{
    [_replyView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.top.mas_equalTo(lastView.mas_bottom).offset(15).priorityHigh();
    }];
    
    [_replayL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(15);
        make.top.mas_offset(10).priorityHigh();
    }];
    [_replyContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.top.mas_equalTo(self.replayL.mas_bottom).offset(10);
        make.bottom.mas_offset(-10).priorityHigh();
    }];
    
    _bottimView = _replyView;
}

@end
