//
//  ProductGroupCell.m
//  Xpress Order
//
//  Created by Constantin Saulenco on 20/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "ProductGroupCell.h"

@implementation ProductGroupCell
{
    UIImage *image;
}

- (void)awakeFromNib
{
    [self.labelCategory setNumberOfLines:0];
    [self.labelCategory setAdjustsFontSizeToFitWidth:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) imageFromURLString:(NSString *) stringURL
{
    
    if(!image)
    {
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringURL]];
        image = [UIImage imageWithData:data];
    }
    
    [self.imageCategory setImage:image];
}
@end
