//
//  ViewController.m
//  VoiceOverDemo
//
//  Created by Allison on 2022/8/3.
//

#import "ViewController.h"
#import "TestCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[TestCell class] forCellReuseIdentifier:@"TestCell"];
    [self.view addSubview:self.tableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return 200;
    } else {
        return 100;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        TestCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TestCell"];
        NSString * msg = [NSString stringWithFormat:@"第%@页，共20页",@(indexPath.row)];
        cell.accessibilityLabel = msg;
        return cell;
    }
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (indexPath.section == 5 || indexPath.section == 10) {
        cell.contentView.backgroundColor = [self randomColor];
    }
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    lab.text = [NSString stringWithFormat:@"第%@",@(indexPath.section)];
    lab.textColor = [UIColor redColor];
    lab.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:lab];
    return cell;
}


- (UIColor *)randomColor {

    CGFloat hue = ( arc4random() % 256 / 256.0 );  //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}



@end
