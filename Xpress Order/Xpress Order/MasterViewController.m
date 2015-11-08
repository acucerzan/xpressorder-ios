//
//  MasterViewController.m
//  Xpress Order
//
//  Created by Adrian Cucerzan on 02/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

#import "HCSStarRatingView.h"

#import "PlaceCell.h"

@interface MasterViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) NSMutableArray *arrayCafe;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    self.arrayCafe = [NSMutableArray arrayWithCapacity:0];
    
    [self downloadPlaces];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)insertNewObject:(id)sender {
    
//    OpenViewControllerInNavigation(ViewControllerWithIdentifier(@"DetailViewController"), self.navigationController);
//
//    if (!self.objects) {
//        self.objects = [[NSMutableArray alloc] init];
//    }
//    [self.objects insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = self.objects[indexPath.row];
//        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
//        [controller setDetailItem:object];
//        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
//        controller.navigationItem.leftItemsSupplementBackButton = YES;
//    }
//}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrayCafe.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifierLast = @"cellIdentifierLast";
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
    
//    HCSStarRatingView *ratingView = (HCSStarRatingView*)[cell viewWithTag:3];
    //Star
//    [ratingView setImagesDeselected:@"place_list_star_white1.png" partlySelected:@"place_list_star_red1.png" fullSelected:@"place_list_star_red1.png" andDelegate:nil];
//    [ratingView displayRating:cafeObj.place_review.floatValue];
    
    CafeReviewButton *btnreview = [cell reviewButton];
    [btnreview setWeakPlace:cafeObj];
    [btnreview addTarget:self action:@selector(setReview:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}

- (void) gotoCafe:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    NSInteger index = btn.tag;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    //    Cafe *mTempCafe = (Cafe *)[arrayCafe objectAtIndex:index];
    //    NSString *strName = (NSString*)[mTempCafe name];
    //
    //    NSLog(@"%@", strName);
    
    //    UITableViewCell *cell = (UITableViewCell *)[tblView cellForRowAtIndexPath:indexPath];
    //    NSString *strName = ((UILabel*)[cell viewWithTag:2]).text;
    
//    TableListController *vc = (TableListController *)ViewControllerWithIdentifier(@"TableListViewID");
//    vc.strPlaceID = [[arrayCafe objectAtIndex:indexPath.row] place_id];
//    vc.strPlaceName = [[arrayCafe objectAtIndex:indexPath.row] place_name];
//    
//    OpenViewControllerInNavigation(vc, self.navigationController);
}

- (void) setReview:(id)sender
{
    
    CafeReviewButton *btn = (CafeReviewButton *)sender;

    if (btn.weakPlace)
    {
        NSLog(@"Clicked review for Place: %@", btn.weakPlace);
    }
    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
//    NSLog(@"setReview index %@", indexPath);
    
//    NSString *str = [URL_SERVER stringByAppendingString:@"set_review.php"];
//    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.labelText = @"Loading";
//    
//    strRequest = @"setReview";
//    
//    UITableViewCell *cell = (UITableViewCell *)[tblView cellForRowAtIndexPath:indexPath];
//    RatingView *ratingView = (RatingView*)[cell viewWithTag:3];
//    float freview = ratingView.rating;
//    
//    NSString *strReview = [NSString stringWithFormat:@"%f", freview];
    
    //Start parser thread
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:str]];
//    [request setPostValue:[[arrayCafe objectAtIndex:indexPath.row] place_id] forKey:@"place_id"];
//    [request setPostValue:strReview forKey:@"place_review"];
//    [request setDelegate:self];
//    [request startAsynchronous];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", indexPath);
    
    Cafe *cafeObj = [self.arrayCafe objectAtIndex:indexPath.row];
    
    if (self.navigationController)
        NSLog(@"%@", self.navigationController);
    
//    TableListController *vc = (TableListController *)ViewControllerWithIdentifier(@"TableListViewID");
//    vc.strPlaceID = [cafeObj place_id];
//    vc.strPlaceName = [cafeObj place_name];
//    
//    OpenViewControllerInNavigation(vc, self.navigationController);
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 116.0f;
}

@end
