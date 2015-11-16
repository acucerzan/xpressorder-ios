//
//  MasterViewController.m
//  Xpress Order
//
//  Created by Adrian Cucerzan on 02/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "PlacesVC.h"
#import "TableSelectionVC.h"
#import "HCSStarRatingView.h"

#import "PlaceCell.h"

@interface PlacesVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) NSMutableArray *arrayCafe;
@end

@implementation PlacesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initialise];

    [self downloadPlaces];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initialise
{
    self.arrayCafe = [NSMutableArray arrayWithCapacity:0];
    
    [self.myTableView setBackgroundColor:[UIColor clearColor]];
    [self.myTableView setSeparatorColor:[UIColor clearColor]];
    [self.myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.navigationController.navigationBar.barTintColor = XP_PURPLE;
    [self setTitleString:@"Alegeți locația dorită"];
}

- (void)downloadPlaces
{
    MainNetworkingDataSource *networkingDataSource = [[XPModel sharedInstance] mainNetworkingDataSource];
    
    [networkingDataSource getPlacesWithCompletitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
        NSLog(@"Finished places request");
        
        if (items)
        {
            if (items.count > 0)
                NSLog(@"Cafe items: %@", items);
            
            [self.arrayCafe removeAllObjects];
            [self.arrayCafe addObjectsFromArray:items];
            
            [self.myTableView reloadData];
        }
    }];

}


- (void)setReview:(id)sender
{
    CafeReviewButton *btn = (CafeReviewButton *)sender;
    
    if (btn.weakPlace)
    {
        NSLog(@"Clicked review for Place: %@", btn.weakPlace);
    
    
        MainNetworkingDataSource *networkingDataSource = [[XPModel sharedInstance] mainNetworkingDataSource];
        
        [networkingDataSource setReview:btn.weakPlace.place_review forPlaceWithId:btn.weakPlace.place_id withCompletitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
            NSLog(@"Finished set review request");
            
        }];
    }
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrayCafe.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifierLast = @"cellIdentifierLast1";
    PlaceCell *cell = (PlaceCell *) [self.myTableView dequeueReusableCellWithIdentifier:cellIdentifierLast];
    
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PlaceCell" owner:self options:nil];
        cell = (PlaceCell *) [nib objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    Cafe *cafeObj = [self.arrayCafe objectAtIndex:indexPath.row];
    
    [cell loadItem:cafeObj];
    
    CafeReviewButton *btnreview = [cell reviewButton];
    [btnreview setWeakPlace:cafeObj];
    [btnreview addTarget:self action:@selector(setReview:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", indexPath);
    
    Cafe *cafeObj = [self.arrayCafe objectAtIndex:indexPath.row];

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TableSelectionVC *vc = (TableSelectionVC *)[sb instantiateViewControllerWithIdentifier:@"TableSelectionVC"];
    
    if (vc)
    {
        [[XPModel sharedInstance] setSelectedCafe:cafeObj];
        [vc setPlace:cafeObj];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
