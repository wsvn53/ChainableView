//
//  UICreate.m
//  sycrm
//
//  Created by Ethan on 2022/3/5.
//

#import "CVCreate.h"

@protocol CVCreateProtocol <NSObject>
@optional
-(void)setText:(NSString *)text;
-(void)setTextColor:(UIColor *)color;
-(void)setTextAlignment:(NSTextAlignment)alignment;
-(void)setTitle:(nullable NSString *)title forState:(UIControlState)state;
-(void)setTitleColor:(nullable UIColor *)color forState:(UIControlState)state;
-(void)setFont:(UIFont *)font;
-(void)setEditable:(BOOL)editable;
-(void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
-(void)setContentInset:(UIEdgeInsets)inset;
-(void)setSecureTextEntry:(BOOL)secure;
-(void)setDelegate:(id)delegate;
@end

@interface CVCreate ()
// Source view for wrapper
@property (nonatomic, strong)   UIView <CVCreateProtocol>  *sourceView;
@end

@implementation CVCreate

+(CVCreate *(^)(Class viewClass))create {
    return ^CVCreate * (Class viewClass){
        CVCreate *create = [[CVCreate alloc] init];
        create.sourceView = (UIView <CVCreateProtocol> *)[(UIView *)[viewClass alloc] initWithFrame:(CGRectZero)];
        return create;
    };
}

+(instancetype)UILabel {
    CVCreate *create = [CVCreate new];
    create.sourceView = (UIView <CVCreateProtocol>*)[[UILabel alloc] initWithFrame:(CGRectZero)];
    return create;
}

+(instancetype)UIButton {
    CVCreate *create = [CVCreate new];
    create.sourceView = (UIView <CVCreateProtocol>*)[UIButton buttonWithType:(UIButtonTypeCustom)];
    return create;
}

+(instancetype)UIView {
    CVCreate *create = [CVCreate new];
    create.sourceView = (UIView <CVCreateProtocol>*)[[UIView alloc] initWithFrame:(CGRectZero)];
    return create;
}

+(instancetype)UITextView {
    CVCreate *create = [CVCreate new];
    create.sourceView = (UIView <CVCreateProtocol>*)[[UITextView alloc] initWithFrame:(CGRectZero)];
    return create;
}

+(CVStackViewCreate * _Nonnull (^)(NSArray<CVCreate *> * _Nonnull))UIStackView {
    return ^CVStackViewCreate * (NSArray <CVCreate *> *subviews) {
        CVStackViewCreate *create = [[CVStackViewCreate alloc] init];
        __block NSMutableArray *arrangedSubviews = [NSMutableArray array];
        [subviews enumerateObjectsUsingBlock:^(CVCreate *obj, NSUInteger idx, BOOL *stop) {
            [arrangedSubviews addObject:obj.view];
        }];
        create.sourceView = (UIStackView <CVCreateProtocol> *)[[UIStackView alloc] initWithArrangedSubviews:arrangedSubviews];
        return create;
    };
}

+(CVCreate * _Nonnull (^)(UIImage * _Nonnull))UIImageView {
    return ^CVCreate * (UIImage *image) {
        CVCreate *create = [[CVCreate alloc] init];
        create.sourceView = (UIView <CVCreateProtocol> *)[[UIImageView alloc] initWithImage:image];
        return create;
    };
}

+(CVCreate * _Nonnull (^)(UIView * _Nonnull))withView {
    return ^CVCreate * (UIView *view){
        CVCreate *create = [[CVCreate alloc] init];
        create.sourceView = (UIView <CVCreateProtocol> *)view;
        return create;
    };
}

-(UIView *)view {
    return self.sourceView;
}

#pragma mark - Common Properties

-(CVCreate * _Nonnull (^)(NSString * _Nonnull))text {
    return ^CVCreate * (NSString *text) {
        if ([self.sourceView respondsToSelector:@selector(setText:)]) {
            [(id<CVCreateProtocol>)self.sourceView setText:text];
            return self;
        }
        
        if ([self.sourceView respondsToSelector:@selector(setTitle:forState:)]) {
            [(id<CVCreateProtocol>)self.sourceView setTitle:text forState:(UIControlStateNormal)];
            return self;
        }
        return self;
    };
}

-(CVCreate * _Nonnull (^)(UIColor * _Nonnull))textColor {
    return ^CVCreate * (UIColor *textColor) {
        if ([self.sourceView respondsToSelector:@selector(setTextColor:)]) {
            [self.sourceView setTextColor:textColor];
            return self;
        }
        
        if ([self.sourceView respondsToSelector:@selector(setTitleColor:forState:)]) {
            [self.sourceView setTitleColor:textColor forState:(UIControlStateNormal)];
            [self.sourceView setTitleColor:[textColor colorWithAlphaComponent:0.5] forState:(UIControlStateHighlighted)];
            return self;
        }
        return self;
    };
}

-(CVCreate * _Nonnull (^)(NSTextAlignment))textAlignment {
    return ^CVCreate * (NSTextAlignment alignment) {
        if ([self.sourceView respondsToSelector:@selector(setTextAlignment:)]) {
            [self.sourceView setTextAlignment:alignment];
        }
        return self;
    };
}

-(CVCreate * _Nonnull (^)(CGFloat))fontSize {
    return ^CVCreate * (CGFloat fontSize) {
        return self.font([UIFont systemFontOfSize:fontSize]);
    };
}

-(CVCreate * _Nonnull (^)(UIFont * _Nonnull))font {
    return ^CVCreate * (UIFont *font){
        if ([self.sourceView respondsToSelector:@selector(setFont:)]) {
            [self.sourceView setFont:font];
            return self;
        }
        
        if ([self.sourceView isKindOfClass:UIButton.class]) {
            [((UIButton *)self.sourceView).titleLabel setFont:font];
            return self;
        }
        return self;
    };
}

-(CVCreate * _Nonnull (^)(CGFloat))boldFontSize {
    return ^CVCreate * (CGFloat boldFontSize){
        return self.font([UIFont boldSystemFontOfSize:boldFontSize]);
    };
}

-(CVCreate * _Nonnull (^)(CGSize))size {
    return ^CVCreate * (CGSize size){
        if (size.width > 0) {
            SetViewAnchor(self.view, self.view.widthAnchor, nil, size.width);
        }
        if (size.height > 0) {
            SetViewAnchor(self.view, self.view.heightAnchor, nil, size.height);
        }
        return self;
    };
}

-(CVCreate * _Nonnull (^)(UIView * _Nonnull, CGFloat))top {
    return ^CVCreate * (UIView *alignView, CGFloat top){
        SetViewAnchor(self.view, self.view.topAnchor, alignView.topAnchor, top);
        return self;
    };
}

-(CVCreate * _Nonnull (^)(UIView * _Nonnull, CGFloat))bottom {
    return ^CVCreate * (UIView *alignView, CGFloat bottom){
        SetViewAnchor(self.view, self.view.bottomAnchor, alignView.bottomAnchor, bottom);
        return self;
    };
}

-(CVCreate * _Nonnull (^)(UIView * _Nonnull, CGFloat))leading {
    return ^CVCreate * (UIView *alignView, CGFloat leading){
        SetViewAnchor(self.view, self.view.leadingAnchor, alignView.leadingAnchor, leading);
        return self;
    };
}

-(CVCreate * _Nonnull (^)(UIView * _Nonnull, CGFloat))trailing {
    return ^CVCreate * (UIView *alignView, CGFloat trailing){
        SetViewAnchor(self.view, self.view.trailingAnchor, alignView.trailingAnchor, trailing);
        return self;
    };
}

-(CVCreate * _Nonnull (^)(CGFloat))cornerRadius {
    return ^CVCreate * (CGFloat cornerRadius){
        self.view.layer.cornerRadius = cornerRadius;
        self.view.layer.masksToBounds = YES;
        return self;
    };
}

-(CVCreate * _Nonnull (^)(UIColor * _Nonnull))backgroundColor {
    return ^CVCreate * (UIColor *backgroundColor){
        self.view.backgroundColor = backgroundColor;
        return self;
    };
}

-(CVCreate * _Nonnull (^)(UIColor * _Nonnull, CGFloat))border {
    return ^CVCreate * (UIColor *borderColor, CGFloat borderWidth){
        self.view.layer.borderColor = borderColor.CGColor;
        self.view.layer.borderWidth = borderWidth;
        return self;
    };
}

-(CVCreate * _Nonnull (^)(BOOL))editable {
    return ^CVCreate * (BOOL editable){
        if ([self.view respondsToSelector:@selector(setEditable:)]) {
            [(id<CVCreateProtocol>)self.view setEditable:editable];
        }
        return self;
    };
}

-(CVCreate * _Nonnull (^)(id _Nonnull, SEL _Nonnull))click {
    return ^CVCreate * (id target, SEL selector){
        if ([self.view respondsToSelector:@selector(addTarget:action:forControlEvents:)]) {
            [(id<CVCreateProtocol>)self.view addTarget:target
                                                action:selector
                                      forControlEvents:(UIControlEventTouchUpInside)];
        } else {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target
                                                                                  action:selector];
            [self.view addGestureRecognizer:tap];
            self.view.userInteractionEnabled = YES;
        }
        return self;
    };
}

-(CVCreate * _Nonnull (^)(UIEdgeInsets))contentInset {
    return ^CVCreate * (UIEdgeInsets inset){
        if ([self.view respondsToSelector:@selector(setContentInset:)]) {
            [(id<CVCreateProtocol>)self.view setContentInset:inset];
        }
        return self;
    };
}

-(CVCreate * _Nonnull (^)(BOOL))secureTextEntry {
    return ^CVCreate * (BOOL secure){
        if ([self.view respondsToSelector:@selector(setSecureTextEntry:)]) {
            [(id<CVCreateProtocol>)self.view setSecureTextEntry:secure];
        }
        return self;
    };
}

-(CVCreate * _Nonnull (^)(CVCreate * _Nonnull))addSubview {
    return ^CVCreate * (CVCreate *subview) {
        [self.view addSubview:subview.view];
        return self;
    };
}

-(CVCreate * _Nonnull (^)(UIView * _Nonnull))addToView {
    return ^CVCreate * (UIView *superview) {
        [superview addSubview:self.view];
        return self;
    };
}

-(CVCreate * _Nonnull (^)(NSLayoutAnchor<NSLayoutDimension *> *, CGFloat))widthAnchor {
    return ^CVCreate * (NSLayoutAnchor<NSLayoutDimension *> *widthAnchor, CGFloat offset) {
        self.view.translatesAutoresizingMaskIntoConstraints = NO;
        if (widthAnchor == nil) {
            [[self.view.widthAnchor constraintEqualToConstant:offset] setActive:YES];
        } else {
            [[self.view.widthAnchor constraintEqualToAnchor:widthAnchor constant:offset] setActive:YES];
        }
        return self;
    };
}

-(CVCreate * _Nonnull (^)(NSLayoutAnchor<NSLayoutDimension *> *, CGFloat))heightAnchor {
    return ^CVCreate * (NSLayoutAnchor <NSLayoutDimension *> *heightAnchor, CGFloat offset) {
        self.view.translatesAutoresizingMaskIntoConstraints = NO;
        if (heightAnchor == nil) {
            [[self.view.heightAnchor constraintEqualToConstant:offset] setActive:YES];
        } else {
            [[self.view.heightAnchor constraintEqualToAnchor:heightAnchor constant:offset] setActive:YES];
        }
        return self;
    };
}

-(CVCreate * _Nonnull (^)(NSLayoutXAxisAnchor *, CGFloat))leftAnchor {
    return ^CVCreate * (NSLayoutXAxisAnchor *leftAnchor, CGFloat offset) {
        self.view.translatesAutoresizingMaskIntoConstraints = NO;
        [[self.view.leftAnchor constraintEqualToAnchor:leftAnchor constant:offset] setActive:YES];
        return self;
    };
}

-(CVCreate * _Nonnull (^)(NSLayoutXAxisAnchor *, CGFloat))rightAnchor {
    return ^CVCreate * (NSLayoutXAxisAnchor *rightAnchor, CGFloat offset) {
        self.view.translatesAutoresizingMaskIntoConstraints = NO;
        [[self.view.rightAnchor constraintEqualToAnchor:rightAnchor constant:offset] setActive:YES];
        return self;
    };
}

-(CVCreate * _Nonnull (^)(NSLayoutYAxisAnchor *, CGFloat))topAnchor {
    return ^CVCreate * (NSLayoutYAxisAnchor *topAnchor, CGFloat offset) {
        self.view.translatesAutoresizingMaskIntoConstraints = NO;
        [[self.view.topAnchor constraintEqualToAnchor:topAnchor constant:offset] setActive:YES];
        return self;
    };
}

-(CVCreate * _Nonnull (^)(NSLayoutYAxisAnchor *, CGFloat))bottomAnchor {
    return ^CVCreate * (NSLayoutYAxisAnchor *bottomAnchor, CGFloat offset) {
        self.view.translatesAutoresizingMaskIntoConstraints = NO;
        [[self.view.bottomAnchor constraintEqualToAnchor:bottomAnchor constant:offset] setActive:YES];
        return self;
    };
}

-(CVCreate * _Nonnull (^)(NSLayoutXAxisAnchor *, CGFloat))centerXAnchor {
    return ^CVCreate * (NSLayoutXAxisAnchor *centerXAnchor, CGFloat offset) {
        self.view.translatesAutoresizingMaskIntoConstraints = NO;
        [[self.view.centerXAnchor constraintEqualToAnchor:centerXAnchor constant:offset] setActive:YES];
        return self;
    };
}

-(CVCreate * _Nonnull (^)(NSLayoutYAxisAnchor *, CGFloat))centerYAnchor {
    return ^CVCreate * (NSLayoutYAxisAnchor *centerYAnchor, CGFloat offset) {
        self.view.translatesAutoresizingMaskIntoConstraints = NO;
        [[self.view.centerYAnchor constraintEqualToAnchor:centerYAnchor constant:offset] setActive:YES];
        return self;
    };
}

-(CVCreate * _Nonnull (^)(void (^ _Nonnull)(id _Nonnull)))customView {
    return ^CVCreate * (void (^customBlock)(id view)) {
        customBlock(self.view);
        return self;
    };
}

-(CVCreate * _Nonnull (^)(void (^ _Nonnull)(CVCreate * _Nonnull)))customAction {
    return ^CVCreate * (void (^customBlock)(CVCreate *create)) {
        customBlock(self);
        return self;
    };
}

-(CVCreate * _Nonnull (^)(id _Nonnull))delegate {
    return ^CVCreate * (id delegate) {
        if ([self.view respondsToSelector:@selector(setDelegate:)]) {
            [(id<CVCreateProtocol>)self.view setDelegate:delegate];
        }
        return self;
    };
}

@end

@implementation CVStackViewCreate

-(CVStackViewCreate * _Nonnull (^)(UILayoutConstraintAxis))axis {
    return ^CVStackViewCreate * (UILayoutConstraintAxis axis) {
        ((UIStackView *)self.view).axis = axis;
        return self;
    };
}

-(CVStackViewCreate * _Nonnull (^)(UIStackViewDistribution))distribution {
    return ^CVStackViewCreate * (UIStackViewDistribution distribution) {
        ((UIStackView *)self.view).distribution = distribution;
        return self;
    };
}

-(CVStackViewCreate * _Nonnull (^)(CGFloat))spacing {
    return ^CVStackViewCreate * (CGFloat spacing) {
        ((UIStackView *)self.view).spacing = spacing;
        return self;
    };
}

@end
