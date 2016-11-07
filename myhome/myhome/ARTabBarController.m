//
//  ARTabBarController.m
//  myhome
//
//  Created by FudonFuchina on 2016/11/3.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "ARTabBarController.h"
#import "FSNavigationController.h"

@interface ARTabBarController ()

@end

@implementation ARTabBarController

- (instancetype)initWithClasses:(NSArray<NSString*>*)classes titles:(NSArray<NSString*>*)titles types:(NSArray<NSNumber*>*)types
{
    self = [super init];
    if (self) {
        NSMutableArray *vcs = [[NSMutableArray alloc] initWithCapacity:classes.count];
        for (int x = 0; x < classes.count; x ++) {
            Class Controller = NSClassFromString(classes[x]);
            UIViewController *controller = [[Controller alloc] init];
            FSNavigationController *navi = [[FSNavigationController alloc] initWithRootViewController:controller];
            UITabBarItem *tbi = [[UITabBarItem alloc] initWithTabBarSystemItem:[types[x] integerValue] tag:x];
            [tbi setValue:titles[x] forKeyPath:@"_title"];
            navi.tabBarItem = tbi;
            [vcs addObject:navi];
        }
        self.viewControllers = vcs;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
