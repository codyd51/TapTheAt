#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>
#import <UIKit/UIKeyboardLayoutStar.h>
#import <UIKit/UIKeyboardInput.h>
#import <UIKit/UITextInput.h>

#define kSettingsPath [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Preferences/com.phillipt.taptheat.plist"]

@interface UIKeyboardImpl : UIView
    + (UIKeyboardImpl*)activeInstance;
    - (BOOL)isLongPress;
    - (void)handleDelete;
    - (void)insertText:(id)text;
    - (void)clearAnimations;
    - (void)clearTransientState;
    - (void)deleteFromInput;
    @property (readonly, assign, nonatomic) UIResponder <UITextInputPrivate> *privateInputDelegate;
    @property (readonly, assign, nonatomic) UIResponder <UITextInput> *inputDelegate;
    @property(readonly, nonatomic) id <UIKeyboardInput> legacyInputDelegate;
@end

@interface UIKBShape : NSObject
@end

@interface UIKBKey : UIKBShape
    @property(copy) NSString * representedString;
@end

static BOOL isLongPressed = false;
static UIPasteboard *pasteboard;
static id delegate;
static NSString *key;
static UITouch *touch;
static NSMutableDictionary* prefs = [NSMutableDictionary dictionaryWithContentsOfFile:kSettingsPath];
static BOOL enabled;

%hook UIKeyboardLayoutStar
    - (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    	if (enabled) {
        	pasteboard = [UIPasteboard generalPasteboard];
        	touch = [touches anyObject];
        	key = [[[self keyHitTest:[touch locationInView:touch.view]] representedString] lowercaseString];

        	UIKeyboardImpl *impl = [%c(UIKeyboardImpl) activeInstance];

        	delegate = impl.privateInputDelegate ?: impl.inputDelegate;
        	isLongPressed = [impl isLongPress];

        	if (isLongPressed) {
				if ([key isEqualToString:@"@"]) {
                	if ([delegate respondsToSelector:@selector(selectedTextRange)]) {

                		NSString* email;
                    	if (prefs[@"email"]) {
                    		email = prefs[@"email"];
                    	}
                    	else {
                    		email = @"Please enter your email in Settings.";
                    	}

                    	[impl insertText:email];
                    	[impl clearTransientState];
                    	[impl clearAnimations];

                    	return;
                	}
				}
        	}
        }
        %orig;
    }
%end

%ctor {
	prefs = [NSMutableDictionary dictionaryWithContentsOfFile:kSettingsPath];
	if (prefs) {
		if (prefs[@"enabled"]) {
			if ([prefs[@"enabled"] boolValue]) {
				enabled = YES;
			}
			else {
				NSLog(@"TapTheAt not enabled");
				enabled = NO;
			}
		}
		else {
			enabled = NO;
		}
	}
}