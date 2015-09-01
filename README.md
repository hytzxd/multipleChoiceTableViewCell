# multipleChoiceTableViewCell
多选tableViewCell

### **废话不多**，先看效果

![image description](https://github.com/hytzxd/multipleChoiceTableViewCell/blob/master/selected1.gif)


### **说下实现**

 在tableview改变是编辑状态的时候 
 
```
@property (nonatomic, getter=isEditing) BOOL editing;                             // default is NO. setting is not animated.
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
```
会调用cell的这个方法

```
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
```
我们知道cell默认的编辑状态又一下三种

```
typedef NS_ENUM(NSInteger, UITableViewCellEditingStyle) {
    UITableViewCellEditingStyleNone,
    UITableViewCellEditingStyleDelete,
    UITableViewCellEditingStyleInsert
};

```

如果选为     UITableViewCellEditingStyleNone cell的左边是不会出现减号或者加号的。
实现多选的话，我们可以返回tableview的编辑状态为    UITableViewCellEditingStyleNone，然后手动的再cell上加一个自己需要的图标

具体的实现看cell中的方法如下所示

```
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

```
注意这个是加载cell上的而不是cell的contentView上。如果加载cell的contentView上再tableview处于编辑状态的时候，contentview会向有移动。
好了上边就是实现的逻辑了。

### tips
tableview在处于编辑状态的时候，默认情况下单元格是不能被选中的。
可以通过tableview的一个属性控制。属性是

```
@property (nonatomic) BOOL allowsSelectionDuringEditing;                                     // default is NO. Controls whether rows can be selected when in editing mode 默认是NO 。控制当处于编辑状态时行是否可以被选中
```





