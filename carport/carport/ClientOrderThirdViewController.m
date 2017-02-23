//
//  ClientOrderThirdViewController.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/27.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "ClientOrderThirdViewController.h"

@interface ClientOrderThirdViewController ()
/*
 A、@property(nonatomic,retain)NSString myString;
 
 B、@property(nonatomic,assign)NSString * myString;
 
 C、@property(nonatomic,assign)int mynumber;
 
 D、@property(nonatomic,retain)int mynumber;
 */
@end

@implementation ClientOrderThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //一、
    NSArray *array = [NSArray arrayWithObjects:@"one", @"two", @"three",nil];
    NSLog(@"%@",[array objectAtIndex:1]);
    NSLog(@"%@",[array objectAtIndex:3]);
    
    //二、
    NSMutableArray * arr1 = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3", nil];
    [arr1 addObject:@"0"];
    [arr1 replaceObjectAtIndex:2 withObject:@"3"];
    NSLog(@"%@",arr1);

    //三、
    /*

    @implementation Son : Father
    - (id)init
    {
        self = [super init];
        if (self) {
            NSLog(@"%@", NSStringFromClass([self class]));
            NSLog(@"%@", NSStringFromClass([super class]));
        }
        return self;
    }
    @end
     
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
