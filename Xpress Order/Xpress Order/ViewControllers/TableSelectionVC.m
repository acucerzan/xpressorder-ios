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

@interface TableSelectionVC () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray <Table *> *dataSource;
    __weak IBOutlet UIView *viewShadowTop;
}

@property (nonatomic, strong) Cafe *currentPlace;

@end

@implementation TableSelectionVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initialise];
    
    [self downloadTablesForCurrentTable];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
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
    viewShadowTop.layer.shadowOffset = CGSizeMake(0, 50);
    viewShadowTop.layer.shadowRadius = 0;
    viewShadowTop.layer.shadowOpacity = 0.5;
    
    [self loadBackButton];
}

- (void)setPlace:(Cafe *)place
{
    self.currentPlace = place;
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
 
                // TODO load tables
            }
        }];
    }
}

#pragma mark --- TableView DataSource & Delegate
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
    return cell;
}

@end
