//
//  ListPromotionViewController.m
//  CC
//
//  Created by Fly on 12/4/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import "ListPromotionViewController.h"

#import "WebServiceFactory.h"
#import "WebServicePromotionList.h"


#import "UtilityFactory.h"
#import "ImageUtility.h"

#import "CategoryMO.h"
#import "IconMO.h"

#import "PromotionViewCell.h"

#import "ListPromotionDetailTableViewController.h"
#import "WebServicePromotionsDetailListByCategory.h"

#import "LocalServiceFactory.h"
#import "FetchedResultController.h"


@interface ListPromotionViewController ()

@property (nonatomic, strong) NSArray *promotionList;
@property (nonatomic) CategoryMO *categoryMOSelected;

@property (nonatomic, strong) FetchedResultController *fetchedResultsController;

@end

@implementation ListPromotionViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initFetchedViewController];
    self.tableView.separatorColor = [UIColor clearColor];
    [self callWSPromotionList];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{

//    UINavigationController *navCon = [self.navigationController.viewControllers objectAtIndex:0];
////    [[navCon navigationController] setTitle: @"Promociones Unicentro"];
//    [[navCon navigationItem] setTitle: @"Promociones Unicentro"];
//    
//    [[[navCon navigationController] navigationBar ] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]}];
    [self configureNavigationBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
      return [[[_fetchedResultsController getFetchedResultsController] sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Number of cells on the table : %f wiht section %li",ceil( (float)_promotionList.count/(float)2), (long)section);
    return ceil((float)_promotionList.count/(float)3);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger indexPathRow = 0;
    NSLog(@"cellForRowAtIndexPath, indexPath: %@", indexPath);
    if(indexPath.row != 0)indexPathRow = (3*indexPath.row);
    
    PromotionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"promotionCell" forIndexPath:indexPath];
    
    if(indexPathRow < _promotionList.count){
        
        CategoryMO *categoryMO1 = _promotionList[indexPathRow];

        [[cell buttonImage1] setImage:[self loadCategoryIcons:[categoryMO1 iconMO]] forState:UIControlStateNormal];
        cell.buttonImage1.idButton = categoryMO1.categoryId;
        cell.buttonImage1.nameButton = categoryMO1.name;
        [cell.buttonImage1 addTarget:self action:@selector(iconButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.subTextField1.text =[NSString stringWithFormat: @"%ld", (long)[categoryMO1 promotionCounts]];

    }else{
        return cell;
    }
    
    if(indexPathRow+1 < _promotionList.count){
        CategoryMO *categoryMO2  = _promotionList[indexPathRow+1];
        
        [[cell buttonImage2] setImage:[self loadCategoryIcons:[categoryMO2 iconMO]] forState:UIControlStateNormal];
        cell.buttonImage2.idButton = categoryMO2.categoryId;
        cell.buttonImage2.nameButton = categoryMO2.name;
        [cell.buttonImage2 addTarget:self action:@selector(iconButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.subTextField2.text =[NSString stringWithFormat: @"%ld", (long)[categoryMO2 promotionCounts]];
    }else{
        return cell;
    }
    
    if(indexPathRow + 2 < _promotionList.count){
        
        CategoryMO *categoryMO3 = _promotionList[indexPathRow+2];
        
        [[cell buttonImage3] setImage:[self loadCategoryIcons:[categoryMO3 iconMO]] forState:UIControlStateNormal];
        cell.buttonImage3.idButton = categoryMO3.categoryId;
        cell.buttonImage3.nameButton = categoryMO3.name;
        [cell.buttonImage3 addTarget:self action:@selector(iconButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.subTextField3.text =[NSString stringWithFormat: @"%ld", (long)[categoryMO3 promotionCounts]];
    }else{
        return cell;
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        NSManagedObjectContext *context = [_fetchedResultsController getManagedObjectdContext];
//        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        [context deleteObject:[[_fetchedResultsController getFetchedResultsController] objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
//    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSManagedObject *object = [[_fetchedResultsController getFetchedResultsController ]objectAtIndexPath:indexPath];
    cell.textLabel.text = [[object valueForKey:@"timeStamp"] description];
}

-(void) iconButtonSelected: (id) button
{
    CustomButton *iconButton = (CustomButton*) button;
    NSLog(@"Button selected %li", (long)iconButton.idButton);
    _categoryMOSelected = [[CategoryMO alloc ]init];
    [_categoryMOSelected setCategoryId: iconButton.idButton];
    [_categoryMOSelected setName: iconButton.nameButton];
    
//    ListPromotionDetailViewController *listPromotionDetailViewController = [[ListPromotionDetailViewController alloc ] initWithCoder:@"ListPromotionDetailViewController" bundle:nil];
//    [self.navigationController pushViewController:listPromotionDetailViewController animated:YES];
    [self performSegueWithIdentifier:@"ListPromotionDetail" sender:self];
}

#pragma mark - Navigation

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if( [[segue identifier] isEqualToString: @"ListPromotionDetail"]){
        ListPromotionDetailTableViewController *listPromotionDetailTableViewController = [segue destinationViewController];
        listPromotionDetailTableViewController.categoryMO = _categoryMOSelected;
    }
}


#pragma mark - Customize methods class

-(void) initFetchedViewController
{
    LocalServiceFactory *localServiceFactory = [[LocalServiceFactory alloc]init];
    _fetchedResultsController = [localServiceFactory createFetchedResultControllerWithType:0];
}

-(void)callWSPromotionList
{
    
    //Register the notification proccess of complete the fetching data
    [self registerNotifyProcess];

    WebServiceFactory *ws = [[WebServiceFactory alloc]init];//TODO: convert this on Singleton
    
    WebServicePromotionList *webServicePromotionList = [ws createWebServicePromotionList:0];
    
    //Trigger the Web Service Promotion List
    [webServicePromotionList getPromotionList];
    
}

-(void)registerNotifyProcess{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivePromotionListNotification:)
                                                 name:@"PromotionListNotification"
                                               object:nil];
}

- (void) receivePromotionListNotification:(NSNotification *) notification
{
    // [notification name] should always be @"PromotionListNotification"
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:@"PromotionListNotification"]){
        NSDictionary *dictionary = notification.userInfo;
        _promotionList = (NSArray*) dictionary[@"promotionList"];
        [self saveCategoryIconsWithPromotions];
        [self.tableView reloadData];
    }
}


-(UIImage*) loadCategoryIcons:(IconMO*) iconMO{
    
    UtilityFactory *utilityFactory = [[UtilityFactory alloc]init];
    
    ImageUtility *imageUtility = [utilityFactory createImageUtility:0];
    
    return [imageUtility loadImageFromLocalURL:[iconMO url] withTypeOfImage:0];
}

-(void) saveCategoryIconsWithPromotions{
    
    UtilityFactory *utilityFactory = [[UtilityFactory alloc]init];
    
    ImageUtility *imageUtility = [utilityFactory createImageUtility:0];
    
    for (int i = 0; i<[_promotionList count]; i++) {
        CategoryMO *temp = _promotionList[i];
        [imageUtility saveImageFromHttpURL:[[temp iconMO] url] withTypeOfImage:0];
    }
}


-(void) configureNavigationBar{
    
    //The index of View controllers, for this case, should be : 1 , or the second view Added to the Navigation Controler
    UINavigationController *navigationController = [self.navigationController.viewControllers objectAtIndex:0];
    UINavigationBar *navigationBar =[[navigationController navigationController] navigationBar];
    UINavigationItem* navigationItem = [navigationController navigationItem];
    
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]}];
    
//    [navigationBar setTintColor:[UIColor redColor]];
    [navigationItem setTitle: @"Promo"];
}


@end
