//
//  AC_BaseVC.h
//  day1_FriendCircleDemo
//
//  Created by lianshuo on 2020/3/24.
//  Copyright © 2020 Alice_ss. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AC_BaseVC : UIViewController
@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,copy)NSString *tableviewGroup;//table的样式
@property (nonatomic,strong)NSMutableArray *tableArr;
@end

NS_ASSUME_NONNULL_END
