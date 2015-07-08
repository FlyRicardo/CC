//
//  PromotionViewCell.h
//  CC
//
//  Created by Fly on 12/3/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"

@interface PromotionViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet CustomButton *buttonImage1;
@property (strong, nonatomic) IBOutlet CustomButton *buttonImage2;
@property (strong, nonatomic) IBOutlet CustomButton *buttonImage3;


@property (strong, nonatomic) IBOutlet UITextField *subTextField1;
@property (strong, nonatomic) IBOutlet UITextField *subTextField2;
@property (strong, nonatomic) IBOutlet UITextField *subTextField3;

@end
