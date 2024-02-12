#import "ScreenSecurityPlugin.h"

@interface ScreenSecurityPlugin ()

@property (nonatomic, strong) UITextField* textField;

@end

@implementation ScreenSecurityPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"com.simoncherry.plugins/screen_security"
            binaryMessenger:[registrar messenger]];
  ScreenSecurityPlugin* instance = [[ScreenSecurityPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
    
  [instance configTextField];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"enable" isEqualToString:call.method]) {
      [self enable];
  } else if ([@"disable" isEqualToString:call.method]) {
      [self disable];
  } else {
      result(FlutterMethodNotImplemented);
  }
}

- (void)configTextField {
    if (self.textField == nil) {
        self.textField = [[UITextField alloc] init];
    }
    UIWindow* window = UIApplication.sharedApplication.delegate.window;
    if (![window.subviews containsObject:self.textField]) {
        [window addSubview:self.textField];
        [self.textField.centerXAnchor constraintEqualToAnchor:window.centerXAnchor].active = YES;
        [self.textField.centerYAnchor constraintEqualToAnchor:window.centerYAnchor].active = YES;
        [window.layer.superlayer addSublayer:self.textField.layer];
        if (@available(iOS 17.0, *)) {
            [[self.textField.layer.sublayers lastObject] addSublayer:window.layer];
        } else {
            [[self.textField.layer.sublayers firstObject] addSublayer:window.layer];
        }
    }
}

- (void)enable {
    if (self.textField != nil) {
        self.textField.secureTextEntry = YES;
    }
}

- (void)disable {
    if (self.textField != nil) {
        self.textField.secureTextEntry = NO;
    }
}

@end
