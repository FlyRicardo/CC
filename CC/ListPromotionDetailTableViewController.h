//
//  ListPromotionDetailTableViewController.h
//  CC
//
//  Created by Fly on 12/5/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CategoryMO.h"

@interface ListPromotionDetailTableViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property(nonatomic) CategoryMO* categoryMO;

@end
