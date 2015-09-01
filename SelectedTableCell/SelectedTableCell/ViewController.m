//
//  ViewController.m
//  SelectedTableCell
//
//  Created by 张旭东 on 15/8/31.
//  Copyright (c) 2015年 张旭东. All rights reserved.
//

#import "ViewController.h"
#import "CheckedTableViewCell.h"
@interface ViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (strong ,nonatomic)UITableView *tableView;
@property (strong ,nonatomic)NSMutableSet *selectedSet;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, 320, 568) style:UITableViewStylePlain];
    self.tableView.allowsSelectionDuringEditing = YES;
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    [self.tableView setEditing:!self.tableView.editing animated:YES];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 20, 60, 40);
    btn.backgroundColor = [UIColor yellowColor];
    [btn addTarget:self action:@selector(changeTableEdit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.selectedSet = [[NSMutableSet alloc]initWithCapacity:42];
    
}

- (void)changeTableEdit{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    [self.selectedSet removeAllObjects];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    
    CheckedTableViewCell *cell = (CheckedTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CheckedTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 10, 40, 40)];
        [view setBackgroundColor:[UIColor yellowColor]];
        [cell.contentView addSubview:view];
    }
    
    [cell  setChecked:[self.selectedSet containsObject:indexPath]];
    return cell;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (!tableView.editing)return;
    CheckedTableViewCell *cell = (CheckedTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if ([self.selectedSet containsObject:indexPath]) {
        [self.selectedSet removeObject:indexPath];
        [cell setChecked:NO];
        return;
    }
    [self.selectedSet addObject:indexPath];
    [cell  setChecked:YES];
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
