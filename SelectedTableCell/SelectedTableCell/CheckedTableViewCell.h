//
//  OtherTablViewCell.h
//  tjk
//
//  Created by 张旭东 on 14-4-3.
//  Copyright (c) 2014年 张旭东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckedTableViewCell : UITableViewCell
@property (nonatomic ,strong)UIImageView *checkImageView;
@property (nonatomic ,assign)BOOL checked;
@end
