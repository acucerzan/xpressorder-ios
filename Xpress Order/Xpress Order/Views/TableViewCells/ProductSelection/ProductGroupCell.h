//
//  ProductGroupCell.h
//  Xpress Order
//
//  Created by Constantin Saulenco on 20/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductGroupCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelCategory;
@property (weak, nonatomic) IBOutlet UIImageView *imageCategory;
@property (weak, nonatomic) IBOutlet UIButton *buttonCategory;

-(void) imageFromURLString:(NSString *) stringURL;

@end
