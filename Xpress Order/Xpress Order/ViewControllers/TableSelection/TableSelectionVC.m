//
//  TableSelectionVC.m
//  Xpress Order
//
//  Created by Constantin Saulenco on 09/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "TableSelectionVC.h"
#import "Table.h"
#import "TableSelectionCell.h"
#import "TableReservedPopUp.h"
#import "TableViewDetailVC.h"

@interface TableSelectionVC () <UITableViewDataSource, UITableViewDelegate, TableReservationProtocol>
{
    NSArray <Table *> *dataSource;
    __weak IBOutlet UIView *viewShadowTop;
    __weak IBOutlet UIView *viewShadowBottom;
    
    Table *selectedTable;
}

@property (nonatomic, strong) Cafe *currentPlace;

@end

@implementation TableSelectionVC

- (instancetype) loadFromNibForPlace:(Cafe *)place
{
    TableSelectionVC *vc = [[[NSBundle mainBundle]loadNibNamed:@"TableSelectionVC" owner:self options:nil] objectAtIndex:0];
    if(vc)
    {
        vc.currentPlace = place;
    }
    return vc;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.title = @"Back";
    [self setTitleString:@"Choose desire table"];

}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self downloadTablesForCurrentTable];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.tableViewTableSelection setBackgroundColor:[UIColor clearColor]];
    [self.tableViewTableSelection setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
    
   }

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(self.tableViewTableSelection.contentOffset.y < self.tableViewTableSelection.contentSize.height - self.tableViewTableSelection.frame.size.height)
        [viewShadowBottom setHidden:NO];
    else
        [viewShadowBottom setHidden:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initialise
{
    dataSource = @[[[Table alloc]init],[[Table alloc]init],[[Table alloc]init],[[Table alloc]init],[[Table alloc]init],[[Table alloc]init],[[Table alloc]init],[[Table alloc]init],[[Table alloc]init]];
    [self.tableViewTableSelection setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    viewShadowTop.layer.masksToBounds = NO;
    viewShadowTop.layer.shadowOffset = CGSizeMake(0, viewShadowTop.frame.size.height);
    viewShadowTop.layer.shadowRadius = 0;
    viewShadowTop.layer.shadowOpacity = 0.5;
    
    viewShadowBottom.layer.masksToBounds = NO;
    viewShadowBottom.layer.shadowOffset = CGSizeMake(0, -viewShadowBottom.frame.size.height);
    viewShadowBottom.layer.shadowRadius = 0;
    viewShadowBottom.layer.shadowOpacity = 0.5;
    
   // [self loadBackButton];
}


- (void)downloadTablesForCurrentTable
{
    if (self.currentPlace) {
        MainNetworkingDataSource *networkingDataSource = [[XPModel sharedInstance] mainNetworkingDataSource];
        
        [networkingDataSource getTablesForPlaceWithId:self.currentPlace.place_id withCompletitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
            NSLog(@"Finished tables request for %@", self.currentPlace);
            
            if (items)
            {
                if (items.count > 0)
                    NSLog(@"Tables: %@", items);
 
                dataSource = items;
                [self.tableViewTableSelection reloadData];
            }
        }];
    }
}

#pragma mark --- TableView DataSource & Delegate
#define kDefaultNavigationBarHeight 64

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int yOffset  = self.tableViewTableSelection.contentOffset.y  + kDefaultNavigationBarHeight;

    [viewShadowTop setHidden:yOffset<=0];
    
    //if(self.tableViewTableSelection.contentSize.height + kDefaultNavigationBarHeight > self.tableViewTableSelection.frame.size.height)
    if(self.tableViewTableSelection.contentOffset.y < self.tableViewTableSelection.contentSize.height - self.tableViewTableSelection.frame.size.height)
        [viewShadowBottom setHidden:NO];
    else
        [viewShadowBottom setHidden:YES];
    
//    NSLog(@"offset Y %d",yOffset);
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kTableSelectionCellHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count/2 + dataSource.count % 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableSelectionCell"];
    if(!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TableSelectionCell" owner:self options:nil] objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    [cell.labelLeftTable setText:@"Table"];
    [cell.labelRightTable setText:@"Table"];
    
    NSInteger index = indexPath.row *2;
    Table *table = [dataSource objectAtIndex:index];
    [cell setLeftTableViewWithTable:table];
    
    index +=1;
    if(index == dataSource.count)
       [cell.viewContainerRightTable setHidden:YES];
    else
    {
        table = [dataSource objectAtIndex:index];
        [cell setRightTableViewWithTable:table];
    }
    
    cell.buttonTablePress = ^(Table *table)
    {
        NSLog(@"Table press %@", table);
        selectedTable = table;
        [self openTablePopUpForTable:table];
    };
    
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

#pragma mark --- Helper Functions

-(void) openTablePopUpForTable:(Table *) table
{
    [[XPModel sharedInstance] setSelectedTable:table];
    
    TableReservedPopUp *tablePopUp = [[TableReservedPopUp alloc] initWithNibName:@"TableReservedPopUp" bundle:[NSBundle mainBundle]];
    tablePopUp.selectedTable = table;
    tablePopUp.delegate = self;
    
    [tablePopUp showPopUpInViewController:self];
}

-(void) tableReservation:(TableReservedPopUp *) tablePopUp dismissedForOption:(DismissOption) dismissOption forTableView:(Table *) selectedTable
{
    [tablePopUp closePopUp];
    
    if(dismissOption == DismissOptionMakeReservation)
    {
        //TODO make reservation Logic
    }
    
    if(dismissOption == DismissOptionPinSubmition)
    {
        [self performSelector:@selector(openTableViewDetails) withObject:nil afterDelay:.3];
    }
    
    
}

-(void) openTableViewDetails
{
    TableViewDetailVC *tableViewDetail = [[TableViewDetailVC alloc] initWithTable:selectedTable];
    [self.navigationController pushViewController:tableViewDetail animated:YES];
}
@end
