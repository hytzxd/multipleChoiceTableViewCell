//
//  OtherTablViewCell.m
//  tjk
//
//  Created by 张旭东 on 14-4-3.
//  Copyright (c) 2014年 taig. All rights reserved.
//

#import "CheckedTableViewCell.h"
@implementation CheckedTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setCheckImageViewCenter:(CGPoint)pt alpha:(CGFloat)alpha animated:(BOOL)animated{
	if (animated){
        [UIView animateWithDuration:0.3 animations:^{
            _checkImageView.center = pt;
            _checkImageView.alpha = alpha;
        } completion:^(BOOL finished) {
            [self setChecked:NO];
        }];
        return;
    }
    _checkImageView.center = pt;
    _checkImageView.alpha = alpha;
	
}

- (void)setEditing:(BOOL)editting animated:(BOOL)animated{
	[super setEditing:editting animated:animated];
	if (editting){
		if (_checkImageView == nil){
			_checkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unchecked.png"]];
            _checkImageView.bounds = CGRectMake(0, 0 , 20, 20);
			[self addSubview:_checkImageView];
		}
		[self setChecked:_checked];
		_checkImageView.center = CGPointMake(-CGRectGetWidth(_checkImageView.frame) * 0.5 ,
											  CGRectGetHeight(self.bounds) * 0.5);
		_checkImageView.alpha = 0.0;
		[self setCheckImageViewCenter:CGPointMake(20.5, CGRectGetHeight(self.bounds) * 0.5)
								alpha:1.0
                             animated:animated];
        return;
	}
	
    _checked = NO;
    if (_checkImageView){
        [self setCheckImageViewCenter:CGPointMake(-CGRectGetWidth(_checkImageView.frame) * 0.5 ,
                                                  CGRectGetHeight(self.bounds) * 0.5)
                                alpha:0.0
                             animated:animated];
    }
	
}


- (void)setChecked:(BOOL)checked{
    _checked = checked;
    _checkImageView.image = _checked ? [UIImage imageNamed:@"checked.png"] :  [UIImage imageNamed:@"unchecked.png"];;
}



@end
