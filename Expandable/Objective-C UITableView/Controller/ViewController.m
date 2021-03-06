//
//  ViewController.m
//  Objective-C UITableView
//
//  Created by NP2 on 5/20/19.
//  Copyright © 2019 shndrs. All rights reserved.
//

#import "ViewController.h"
#import "ExpandableCell.h"

@interface ViewController ()
@end

@implementation ViewController

NSString *const cellId = @"ExpandableCell";
NSString *const navTitle = @"Electric Guitars";
NSString *const sevenStrings = @"7 Strings";
NSString *const sixStrings = @"6 Strings";
@synthesize arrRowBrand,arrRowNumberOfStrings,arrRowPrice,tableView,selectedIndex;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCell];
    [self setNavigationBar];
    [self setData];
    [self reloadTableView];
}

-(void)setNavigationBar {
    self.navigationItem.title = navTitle;
    self.navigationController.navigationBar.prefersLargeTitles = YES;
}

- (void)setData {
    
    selectedIndex = -1;
    
    arrRowBrand = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 9; i++) {
        NSString *string = [[NSString alloc]initWithFormat:@"Ibanez rg277%i",i];
        
        [arrRowBrand addObject:string];
    }
    
    arrRowNumberOfStrings = [[NSMutableArray alloc]initWithObjects:sevenStrings, sevenStrings, sixStrings, sixStrings, sevenStrings, sixStrings, sevenStrings, sevenStrings, sevenStrings, sixStrings, nil];
    
    arrRowPrice = [[NSMutableArray alloc]initWithObjects:@"1499 US$", @"1999 US$", @"2499 US$", @"1999 US$", @"1799 US$", @"2999 US$", @"1199 US$", @"1699 US$", @"1499 US$", @"1999 US$", nil];
}

// MARK: TableView DataSource Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrRowBrand.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ExpandableCell *cell = (ExpandableCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:cellId owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    
    cell.brandTitleLabel = arrRowBrand[indexPath.row];
    cell.numberOfStringsTitleLabel = arrRowNumberOfStrings[indexPath.row];
    cell.priceTitleLabel = arrRowPrice[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (selectedIndex == indexPath.row) {
        return 274;
    } else {
        return 40;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (selectedIndex == indexPath.row) {
        selectedIndex = -1;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    if (selectedIndex == -1) {
        NSIndexPath *prev = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        selectedIndex = indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:prev] withRowAnimation:UITableViewRowAnimationFade];
    }
    selectedIndex = indexPath.row;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)registerCell {
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellReuseIdentifier:cellId];
}

-(void)reloadTableView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self->tableView reloadData];
    });
}

@end
