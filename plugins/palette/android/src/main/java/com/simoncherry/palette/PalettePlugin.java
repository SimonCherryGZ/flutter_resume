package com.simoncherry.palette;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import androidx.annotation.NonNull;
import androidx.palette.graphics.Palette;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * PalettePlugin
 */
public class PalettePlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {

    private MethodChannel channel;
    private Activity activity;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "com.simoncherry.plugins/palette");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        this.activity = binding.getActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        this.activity = binding.getActivity();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getImagePrimaryColors")) {
            Map<String, Object> arguments = (Map<String, Object>) call.arguments;
            handleGetImagePrimaryColors(arguments, result);
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        this.activity = null;
    }

    @Override
    public void onDetachedFromActivity() {
        this.activity = null;
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
        channel = null;
        activity = null;
    }

    private void handleGetImagePrimaryColors(final Map<String, Object> arguments, final MethodChannel.Result result) {
        new Thread(() -> {
            byte[] bytes = (byte[]) arguments.get("imageBytes");
            if (bytes == null) {
                activity.runOnUiThread(() -> result.success(null));
                return;
            }
            Integer sampleSize = (Integer) arguments.get("sampleSize");
            if (sampleSize == null) {
                sampleSize = 256;
            }
            BitmapFactory.Options options = new BitmapFactory.Options();
            options.inSampleSize = calculateInSampleSize(options, sampleSize, sampleSize);
            Bitmap bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.length);
            Palette.Builder paletteBuilder = Palette.from(bitmap);
            Palette palette = paletteBuilder.generate();
            List<Palette.Swatch> swatches = palette.getSwatches();
            final List<Integer> colors = new ArrayList<>();
            for (Palette.Swatch swatch : swatches) {
                colors.add(swatch.getRgb());
            }
            activity.runOnUiThread(() -> result.success(colors));
        }).start();
    }

    private int calculateInSampleSize(BitmapFactory.Options options, int reqWidth, int reqHeight) {
        // Raw height and width of image
        final int height = options.outHeight;
        final int width = options.outWidth;
        int inSampleSize = 1;
        if (height > reqHeight || width > reqWidth) {
            final int halfHeight = height / 2;
            final int halfWidth = width / 2;
            // Calculate the largest inSampleSize value that is a power of 2 and keeps both
            // height and width larger than the requested height and width.
            while ((halfHeight / inSampleSize) > reqHeight
                    && (halfWidth / inSampleSize) > reqWidth) {
                inSampleSize *= 2;
            }
        }
        return inSampleSize;
    }
}
