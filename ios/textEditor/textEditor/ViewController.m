//
//  ViewController.m
//  textEditor
//
//  Created by lalit on 17/12/12.
//  Copyright (c) 2012 logicnext. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)bold;
- (IBAction)italic;
- (IBAction)underline;
@end

@implementation ViewController
@synthesize webview;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

    NSString* htmlContentString = [NSString stringWithFormat:
                                   @"<html>"
                                   "<body>"
                                   "<div id=\"content\" contenteditable=\"true\" style=\"overflow-y: scroll;\"><ul><li><span class=\"Apple-style-span\" style=\"-webkit-tap-highlight-color: rgba(26, 26, 26, 0.296875); -webkit-composition-fill-color: rgba(175, 192, 227, 0.230469); -webkit-composition-frame-color: rgba(77, 128, 180, 0.230469); \">This is out Rich Text Editing View</span></li><li><span class=\"Apple-style-span\" style=\"-webkit-tap-highlight-color: rgba(26, 26, 26, 0.296875); -webkit-composition-fill-color: rgba(175, 192, 227, 0.230469); -webkit-composition-frame-color: rgba(77, 128, 180, 0.230469); \">&nbsp;Sfdg</span></li><li><span class=\"Apple-style-span\" style=\"-webkit-tap-highlight-color: rgba(26, 26, 26, 0.296875); -webkit-composition-fill-color: rgba(175, 192, 227, 0.230469); -webkit-composition-frame-color: rgba(77, 128, 180, 0.230469); \">&nbsp;Df</span></li></ul><div>G</div><div>&nbsp;<i>Sdf</i></div><div>G</div><div>&nbsp;<u>Df</u></div><div><u>G&nbsp;</u></div><div><u>Df</u>s</div><div>G</div><div>&nbsp;</div></div>"
                                   "</body>"
                                   "</html>"];
    [webview loadHTMLString:[NSString stringWithFormat:@"%@", htmlContentString] baseURL:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardWillShow:(NSNotification *)note {
    [self performSelector:@selector(removeBar) withObject:nil afterDelay:0];
}

- (void)removeBar {
    // Locate non-UIWindow.
    UIWindow *keyboardWindow = nil;
    for (UIWindow *testWindow in [[UIApplication sharedApplication] windows]) {
        if (![[testWindow class] isEqual:[UIWindow class]]) {
            keyboardWindow = testWindow;
            break;
        }
    }
    
    // Locate UIWebFormView.
    for (UIView *possibleFormView in [keyboardWindow subviews]) {
        // iOS 5 sticks the UIWebFormView inside a UIPeripheralHostView.
        if ([[possibleFormView description] rangeOfString:@"UIPeripheralHostView"].location != NSNotFound) {
            for (UIView *subviewWhichIsPossibleFormView in [possibleFormView subviews]) {
                if ([[subviewWhichIsPossibleFormView description] rangeOfString:@"UIWebFormAccessory"].location != NSNotFound) {
                    [subviewWhichIsPossibleFormView removeFromSuperview];
                }
            }
        }
    }
}


- (IBAction)bold {
    //[webview stringByEvaluatingJavaScriptFromString:@"document.execCommand(\"Bold\")"];
    
     [webview stringByEvaluatingJavaScriptFromString:@"document.execCommand(\"InsertUnorderedList\")"];
    
}

- (IBAction)italic {
    [webview stringByEvaluatingJavaScriptFromString:@"document.execCommand(\"Italic\")"];
}

- (IBAction)underline {
    [webview stringByEvaluatingJavaScriptFromString:@"document.execCommand(\"Underline\")"];
}


-(IBAction)ShowText:(id)sender{
    NSString *html = [webview stringByEvaluatingJavaScriptFromString:
                      @"document.body.innerHTML"];
    NSLog(@"TEXT: %@",html);
}

/*
 int totalWidth = [[_webview stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollWidth"] intValue];
 totalPageInChapter = (int)((float)totalWidth/_webview.bounds.size.width);
 float pageOffset = currentPageInChapter*_webview.bounds.size.width;
 
 NSString* goToOffsetFunc = [NSString stringWithFormat:@" function pageScroll(xOffset){ window.scroll(xOffset,0); } "];
 NSString* goTo =[NSString stringWithFormat:@"pageScroll(%f)", pageOffset];
 
 [_webview stringByEvaluatingJavaScriptFromString:goToOffsetFunc];
 [_webview stringByEvaluatingJavaScriptFromString:goTo];

 */

@end
