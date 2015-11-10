//
//  BaseViewController.m
//  Xpress Order
//
//  Created by Adrian Cucerzan on 10/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)loadBackButton
{
    //    [btnItem setTintColor:[UIColor whiteColor]];
    
    UIButton *homeBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    
    [homeBtn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    
    [homeBtn setShowsTouchWhenHighlighted:YES];
    
    [homeBtn setFrame:CGRectMake(0, 0, 20, 20)];
    
    [homeBtn setContentMode:UIViewContentModeLeft];
    
    homeBtn.exclusiveTouch = YES;
    
    [homeBtn addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
    
    [self.navigationItem setLeftBarButtonItem:btnItem];
}

- (void)popBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setTitleString:(NSString *)titleString
{
    NSLog(@"Opened VC with title: %@", titleString);
    
    NSString *theTitle = [titleString stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 30)];
    
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont systemFontOfSize:15]];
    [titleLabel setText:theTitle];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    titleLabel.numberOfLines = 2;
    //    titleLabel.minimumScaleFactor = 8./titleLabel.font.pointSize;
    //    titleLabel.adjustsFontSizeToFitWidth = YES;
    
    self.navigationItem.titleView = titleLabel;
    
    //    [self setTitle:titleString];
}

@end
