//
//  UICreate.h
//  sycrm
//
//  Created by Ethan on 2022/3/5.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static inline void SetViewAnchor(UIView * _Nullable view, id _Nullable srcAnchor, id _Nullable dstAnchor, CGFloat offset) {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    if (dstAnchor == nil) {
        [[srcAnchor constraintEqualToConstant:offset] setActive:YES];
    } else {
        [[srcAnchor constraintEqualToAnchor:dstAnchor constant:offset] setActive:YES];
    }
}

static inline UIColor * _Nullable ColorWithHex(NSInteger hex) {
    CGFloat r = (CGFloat)(hex >> 16 & 0xff) / (CGFloat)0xff;
    CGFloat g = (CGFloat)(hex >> 8 & 0xff) / (CGFloat)0xff;
    CGFloat b = (CGFloat)(hex & 0xff) / (CGFloat)0xff;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

NS_ASSUME_NONNULL_BEGIN

#define V(c)    [c underlyingView]

@class CVStackViewCreate;

@interface CVCreate : NSObject

@property (nonatomic, strong, readonly)   UIView *view;

#pragma mark - Common Properties

@property (nonatomic, copy)     CVCreate *(^text)(NSString *);
@property (nonatomic, copy)     CVCreate *(^textColor)(UIColor *);
@property (nonatomic, copy)     CVCreate *(^textAlignment)(NSTextAlignment alignment);
@property (nonatomic, copy)     CVCreate *(^fontSize)(CGFloat);
@property (nonatomic, copy)     CVCreate *(^boldFontSize)(CGFloat);
@property (nonatomic, copy)     CVCreate *(^font)(UIFont *);
@property (nonatomic, copy)     CVCreate *(^size)(CGSize);
@property (nonatomic, copy)     CVCreate *(^leading)(UIView *, CGFloat);
@property (nonatomic, copy)     CVCreate *(^trailing)(UIView *, CGFloat);
@property (nonatomic, copy)     CVCreate *(^top)(UIView *, CGFloat);
@property (nonatomic, copy)     CVCreate *(^bottom)(UIView *, CGFloat);
@property (nonatomic, copy)     CVCreate *(^cornerRadius)(CGFloat);
@property (nonatomic, copy)     CVCreate *(^backgroundColor)(UIColor *);
@property (nonatomic, copy)     CVCreate *(^border)(UIColor *borderColor, CGFloat borderWidth);
@property (nonatomic, copy)     CVCreate *(^editable)(BOOL editable);
@property (nonatomic, copy)     CVCreate *(^click)(id target, SEL selector);
@property (nonatomic, copy)     CVCreate *(^contentInset)(UIEdgeInsets inset);
@property (nonatomic, copy)     CVCreate *(^secureTextEntry)(BOOL secure);
@property (nonatomic, copy)     CVCreate *(^addSubview)(CVCreate *subview);
@property (nonatomic, copy)     CVCreate *(^addToView)(UIView *superview);
@property (nonatomic, copy)     CVCreate *(^widthAnchor)(NSLayoutAnchor<NSLayoutDimension *> *toAnchor, CGFloat offset);
@property (nonatomic, copy)     CVCreate *(^heightAnchor)(NSLayoutAnchor<NSLayoutDimension *> *toAnchor, CGFloat offset);
@property (nonatomic, copy)     CVCreate *(^leftAnchor)(NSLayoutXAxisAnchor *toAnchor, CGFloat offset);
@property (nonatomic, copy)     CVCreate *(^rightAnchor)(NSLayoutXAxisAnchor *toAnchor, CGFloat offset);
@property (nonatomic, copy)     CVCreate *(^topAnchor)(NSLayoutYAxisAnchor *toAnchor, CGFloat offset);
@property (nonatomic, copy)     CVCreate *(^bottomAnchor)(NSLayoutYAxisAnchor *toAnchor, CGFloat offset);
@property (nonatomic, copy)     CVCreate *(^centerXAnchor)(NSLayoutXAxisAnchor *toAnchor, CGFloat offset);
@property (nonatomic, copy)     CVCreate *(^centerYAnchor)(NSLayoutYAxisAnchor *toAnchor, CGFloat offset);
@property (nonatomic, copy)     CVCreate *(^customView)(void(^customBlock)(id view));
@property (nonatomic, copy)     CVCreate *(^customAction)(void(^customBlock)(CVCreate *create));
@property (nonatomic, copy)     CVCreate *(^delegate)(id delegate);

#pragma mark - Methods

// Create UILabel
+(instancetype)UILabel;

// Create UIButton
+(instancetype)UIButton;

// Create UIView
+(instancetype)UIView;

// Create UITextView
+(instancetype)UITextView;

// Create UIStackView
+(CVStackViewCreate * (^)(NSArray <CVCreate *>*subviews))UIStackView;

// Create UIImageView
+(CVCreate * (^)(UIImage *image))UIImageView;

// Common create
+(CVCreate * (^)(Class viewClass))create;

// With view
+(CVCreate * (^)(UIView *view))withView;

@end

@interface CVStackViewCreate : CVCreate

// Axis setter
@property (nonatomic, copy)     CVStackViewCreate *(^axis)(UILayoutConstraintAxis axis);

// Distribution setter
@property (nonatomic, copy)     CVStackViewCreate *(^distribution)(UIStackViewDistribution distribution);

// Spacing
@property (nonatomic, copy)     CVStackViewCreate *(^spacing)(CGFloat spacing);

@end

NS_ASSUME_NONNULL_END
