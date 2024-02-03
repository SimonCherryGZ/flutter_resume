#import "PalettePlugin.h"
#import <iOSPalette/Palette.h>
#import <iOSPalette/PaletteColorModel.h>

@implementation PalettePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"com.simoncherry.plugins/palette"
            binaryMessenger:[registrar messenger]];
  PalettePlugin* instance = [[PalettePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getImagePrimaryColors" isEqualToString:call.method]) {
      [self handleGetImagePrimaryColorsWithCall:call result:result];
  } else {
      result(FlutterMethodNotImplemented);
  }
}

- (void)handleGetImagePrimaryColorsWithCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        FlutterStandardTypedData *typedData = call.arguments[@"imageBytes"];
        NSData *data = typedData.data;
        if (!data) {
            dispatch_async(dispatch_get_main_queue(), ^{
                result(@([self colorToHex:[UIColor clearColor]]));
            });
            return;
        }
        UIImage *image = [UIImage imageWithData:data];
        NSNumber* sampleSize = call.arguments[@"sampleSize"];
        if (sampleSize == nil) {
            sampleSize = @256;
        }
        image = [self scaleImage:image andMaxSize:[sampleSize intValue]];

        Palette *palette = [[Palette alloc] initWithImage:image];
        [palette startToAnalyzeImage:^(NSArray<PaletteColorModel *> *recommendColors, NSDictionary *allModeColorDics, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableArray *colors = [NSMutableArray arrayWithCapacity:recommendColors.count];
                for (PaletteColorModel *colorModel in recommendColors) {
                    int color = (int)([self colorToHex:[self colorFromHexString:colorModel.imageColorString]]);
                    [colors addObject:@(color)];
                }
                result(colors);
            });
        }];
    });
}

- (NSInteger)colorToHex:(UIColor*)color{
    CGFloat r,g,b,a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    return (int)(a*255)<<24 | (int)(r*255)<<16 | (int)(g*255)<<8 | (int)(b*255);
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

- (UIImage *)scaleImage:(UIImage *)image andMaxSize:(int)imageSize {
    float maxSize = MAX(image.size.width, image.size.height);
    float scale = imageSize / maxSize;
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scale, image.size.height * scale));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scale, image.size.height * scale)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
