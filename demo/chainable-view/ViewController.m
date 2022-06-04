//
//  ViewController.m
//  chainable-view
//
//  Created by Ethan on 2022/6/4.
//

#import "ViewController.h"
#import "CVCreate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

-(void)setupViews {
    CVCreate.UIImageView([UIImage imageNamed:@"image"]).addToView(self.view)
        .centerXAnchor(self.view.centerXAnchor, 0)
        .centerYAnchor(self.view.centerYAnchor, -50);
   
    CVCreate.UILabel.text(@"Chainable UILabel").addToView(self.view)
        .textColor(UIColor.redColor)
        .fontSize(18.f)
        .centerXAnchor(self.view.centerXAnchor, 0)
        .centerYAnchor(self.view.centerYAnchor, 0);
    
    CVCreate.UIButton.text(@"Click Me").addToView(self.view)
        .cornerRadius(5)
        .textColor(UIColor.whiteColor)
        .fontSize(16.f)
        .backgroundColor(UIColor.blackColor)
        .click(self, @selector(buttonTouched))
        .size(CGSizeMake(150, 35))
        .centerXAnchor(self.view.centerXAnchor, 0)
        .centerYAnchor(self.view.centerYAnchor, 50);
}

-(void)buttonTouched {
    NSLog(@"Button Touched");
}

@end
