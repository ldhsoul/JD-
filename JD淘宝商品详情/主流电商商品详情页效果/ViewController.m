//
//  ViewController.m
//  主流电商商品详情页效果
//
//  Created by fubang on 2019/8/13.
//  Copyright © 2019 ldh. All rights reserved.
//

#import "ViewController.h"
#import "DHManagerViewController.h"
#import "DHGDMainViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - controller
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"example_cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"example_cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"JD淘宝商品详情效果";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        DHManagerViewController *vc = [[DHManagerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
