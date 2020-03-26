//
//  AC_BaseVC.m
//  day1_FriendCircleDemo
//
//  Created by lianshuo on 2020/3/24.
//  Copyright © 2020 Alice_ss. All rights reserved.
//

#import "AC_BaseVC.h"


@interface AC_BaseVC ()


@end

@implementation AC_BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

-(void)setTableviewGroup:(NSString *)tableviewGroup{
    _tableviewGroup = tableviewGroup;
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.bottom.mas_offset(0);
    }];
}
#pragma mark - tableview
-(UITableView *)tableview{
    if (!_tableview) {
        if (self.tableviewGroup.length == 0) {
            _tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
            [self.view addSubview:_tableview];
        }else{
            _tableview  =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
            [self.view addSubview:_tableview];
        }
    }
    return _tableview;
}


#pragma mark - 懒加载数组
-(NSMutableArray *)tableArr{
    if (!_tableArr) {
        _tableArr = [NSMutableArray array];
    }return _tableArr;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
