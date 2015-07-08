//
//  ArticlesViewCell.h
//  CC
//
//  Created by Fly on 12/12/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"

@interface ArticlesViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet CustomButton *articleButton1;


@property (strong, nonatomic) IBOutlet UITextField *storeNameTextField1;



@property (strong, nonatomic) IBOutlet UITextField *discountTextField1;



@property (strong, nonatomic) IBOutlet CustomButton *articleButton2;


@property (strong, nonatomic) IBOutlet UITextField *storeNameTextField2;



@property (strong, nonatomic) IBOutlet UITextField *discountTextField2;

@end
