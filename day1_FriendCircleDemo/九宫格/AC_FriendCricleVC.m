//
//  AC_FriendCricleVC.m
//  day1_FriendCircleDemo
//
//  Created by lianshuo on 2020/3/24.
//  Copyright © 2020 Alice_ss. All rights reserved.
//

#import "AC_FriendCricleVC.h"
#import "AC_FriendCircleCell.h"

@interface AC_FriendCricleVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation AC_FriendCricleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableviewGroup  = @"1";
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.estimatedRowHeight = 100;
    self.tableview.estimatedSectionFooterHeight = 0;
    self.tableview.estimatedSectionHeaderHeight = 0;
    
    NSString *applyStr  = @"感谢您的购买，欢迎下次再来，您的支持才是我们继续前进的动力哦感谢您的购买，欢迎下次再来，您的支持才是我们继续前进的动力哦感谢您的购买，欢迎下次再来，您的支持才是我们继续前进的动力哦感谢您的购买，欢迎下次再来，您的支持才是我们继续前进的动力哦";
    
    NSString *introStr = @"质量非常好，与卖家描述的完全一致非常满意，真的很喜欢，完全超出期望值，发货速度非常快，包装非常仔细、严实，物流公司服务态度很好，运送速度很快，很满意的一次购物，收到货，第一时间拆包装，感觉质量还是比较好的，与卖家描述的还是一致的，非常满意，发货速度比较快，物流公司服务态度很好，运送速度很快，总的来说这次是很满意的一次购物，感";
    for (int i  = 0; i<10; i++) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:[NSString stringWithFormat:@"名字：%d",i+1000] forKey:@"name"];
        [dic setValue:[NSString stringWithFormat:@"时间：%d",i+1000] forKey:@"time"];

//        设置评论
        NSInteger location2 = random()%10;
        NSInteger length2  = random()%(introStr.length - location2);
       
        [dic setValue:[NSString stringWithFormat:@"%d",i] forKey:@"pics"];
        [dic setValue:[NSString stringWithFormat:@"%@",[introStr substringWithRange:NSMakeRange(location2, length2)]] forKey:@"intro"];
       
        if (i== 6) {//有内容无图
            [dic setValue:@"默认好评" forKey:@"intro"];
            [dic setValue:@"0" forKey:@"pics"];
        }
        
        NSInteger location = random()%10;
        NSInteger length  = random()%(applyStr.length - location);
        if (i== 2 || i == 5) {
            [dic setValue:@"" forKey:@"applyContent"];
        }else{
            [dic setValue:[NSString stringWithFormat:@"%@",[applyStr substringWithRange:NSMakeRange(location, length)]] forKey:@"replyContent"];
        }
        
        
        [self.tableArr addObject:dic];
    }
    
}



#pragma mark - tableviewdelageta
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier=@"AC_FriendCircleCell";
    
    AC_FriendCircleCell *cell =[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[AC_FriendCircleCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (self.tableArr.count>0) {
        
        [cell setcellWithDic:self.tableArr[indexPath.section]];
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.tableArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.000001;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
