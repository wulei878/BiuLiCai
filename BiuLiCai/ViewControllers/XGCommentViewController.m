//
//  XGCommentViewController.m
//  XGCG
//
//  Created by Owen on 15/5/4.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGCommentViewController.h"

@interface XGCommentViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *wordCount;
@property (weak, nonatomic) IBOutlet UIView *toolBarContainer;
@property (weak, nonatomic) IBOutlet UIButton *moneyButton;
@property (weak, nonatomic) IBOutlet UIButton *emojiButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarContainerTop;

@end

@implementation XGCommentViewController
+ (instancetype)getInstance
{
    return [[UIStoryboard storyboardWithName:@"XGCommentViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"XGCommentViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rootViewDidPan:)];
    [self.view addGestureRecognizer:pan];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *keyboardInfo = [notification userInfo];
    CGRect rect = [keyboardInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = ((NSNumber *)keyboardInfo[UIKeyboardAnimationDurationUserInfoKey]).doubleValue;
    UIViewAnimationCurve curve = ((NSNumber *)keyboardInfo[UIKeyboardAnimationCurveUserInfoKey]).integerValue;
    
    if (self.toolBarContainer.bottom > self.view.height - rect.size.height) {
        self.toolBarContainerTop.constant = self.view.height - rect.size.height - self.toolBarContainer.height;
        [self.toolBarContainer setNeedsUpdateConstraints];
        [UIView animateWithDuration:animationDuration animations:^{
            [UIView setAnimationCurve:curve];
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *keyboardInfo = [notification userInfo];
    NSTimeInterval animationDuration = ((NSNumber *)keyboardInfo[UIKeyboardAnimationDurationUserInfoKey]).doubleValue;
    UIViewAnimationCurve curve = ((NSNumber *)keyboardInfo[UIKeyboardAnimationCurveUserInfoKey]).integerValue;
    self.toolBarContainerTop.constant = 317;
    [self.toolBarContainer setNeedsUpdateConstraints];
    [UIView animateWithDuration:animationDuration animations:^{
        [UIView setAnimationCurve:curve];
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)didTapCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)didTapSubmitButton:(id)sender {
    NSString *aString = [self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (aString.length > 140) {
        [MBProgressHUD showTimedDetailsTextHUDOnView:self.view message:@"超过字数限制" animated:YES];
        return;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)didTapMoneyButton:(id)sender {
    NSString *string = self.textView.text;
    self.textView.text = [NSString stringWithFormat:@"%@$$",string];
    [self.textView setSelectedRange:NSMakeRange(self.textView.text.length - 1, 0)];
}
- (IBAction)didTapEmojiButton:(id)sender {
}

-(void)textViewDidChange:(UITextView *)textView
{
    self.wordCount.text = [NSString stringWithFormat:@"%lu/140",(unsigned long)textView.text.length];
    if (textView.text.length > 140) {
        NSMutableAttributedString *mutableAttrString = [[NSMutableAttributedString alloc] initWithString:self.wordCount.text];
        NSRange range = NSMakeRange(0, [self.wordCount.text rangeOfString:@"/"].location);
        [mutableAttrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        self.wordCount.attributedText = mutableAttrString;
    }
    [textView scrollRangeToVisible:textView.selectedRange];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)rootViewDidPan:(UIPanGestureRecognizer *)sender
{
    [self.textView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
