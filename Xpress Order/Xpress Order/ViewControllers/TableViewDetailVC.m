//
//  TableViewDetail.m
//  Xpress Order
//
//  Created by Constantin Saulenco on 16/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "TableViewDetailVC.h"
#import "DWBubbleMenuButton.h"
#import "ProductSelectionVC.h"

@interface TableViewDetailVC ()
{
    
    __weak IBOutlet UILabel *labelTableViewId;
    __weak IBOutlet UILabel *labelSpaceName;
    __weak IBOutlet UIView *viewShare;
    __weak IBOutlet UIView *viewBottomBase;
    
    NSArray *buttons;

}

@end

@implementation TableViewDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    XPModel *shared = [XPModel sharedInstance];
    [labelSpaceName setText:shared.selectedCafe.place_name];
    [labelTableViewId setText:shared.selectedTable.table_id];
    
   // [self loadBackButton];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.title = @"Back";
    [self setTitleString:@"Welcome"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addSharedBoobles];
    
}
-(void) addSharedBoobles
{
    [viewShare setBackgroundColor:[UIColor clearColor]];
    // Create up menu button
    UIImageView * imageView = [self createHomeButtonView];
    
    DWBubbleMenuButton *upMenuView = [[DWBubbleMenuButton alloc] initWithFrame:CGRectMake(viewShare.frame.origin.x,
                                                                                          viewShare.frame.origin.y+viewBottomBase.frame.origin.y+64,
                                                                                          viewShare.frame.size.width,
                                                                                          viewShare.frame.size.height)
                                                            expansionDirection:DirectionUp];
    upMenuView.homeButtonView = imageView;
    
    [upMenuView addButtons:[self createButtonArray]];
    
    [self.view addSubview:upMenuView];

}


- (UIImageView *)createHomeButtonView
{
    CGRect frame = viewShare.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    
    [imageView setImage:[UIImage imageNamed:@"table_page_social_btn"]];
    
    return imageView;
}

- (NSArray *)createButtonArray {
    NSMutableArray *buttonsMutable = [[NSMutableArray alloc] init];
    
    int i = 0;
    for (NSString *title in @[@"social_twitter", @"social_facebook", @"social_google", @"social_exit"]) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:title] forState:0];
        
        button.frame = CGRectMake(0.f, 0.f, 35.f, 35.f);
        button.layer.cornerRadius = button.frame.size.height / 2.f;
        //button.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
        button.clipsToBounds = YES;
        button.tag = i++;
        
        [button addTarget:self action:@selector(buttonSocialPress:) forControlEvents:1<<6];
        [button setUserInteractionEnabled:YES];
        
        [buttonsMutable addObject:button];
    }
    
    buttons = buttonsMutable;
    
    return buttons;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonMenuPress:(id)sender
{
    ProductSelectionVC *productSelection = [[ProductSelectionVC alloc] initWithNibName:@"ProductSelectionVC" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:productSelection animated:YES];
    
    NSLog(@"Button Menu Press");
}
- (IBAction)buttonCallPress:(id)sender
{
    NSLog(@"Button Call Press");
}

-(IBAction)buttonSocialPress:(id)sender
{
    switch ([sender tag]) {
        case 0: NSLog(@"Twitter pressed"); break;
        case 1: NSLog(@"facevook pressed"); break;
        case 2: NSLog(@"google pressed"); break;
        case 3: NSLog(@"Exit pressed"); break;
        default:
            break;
    }
    
}
@end
