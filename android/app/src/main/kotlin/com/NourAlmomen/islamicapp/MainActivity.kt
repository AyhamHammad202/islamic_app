package com.NourAlmomen.islamicapp

import io.flutter.embedding.android.FlutterActivity
import com.ryanheise.audioservice.AudioServiceActivity

// MainActivity extends AudioServiceActivity for proper audio service integration
// توسيع MainActivity من AudioServiceActivity لدعم خدمة الصوت بشكل صحيح
class MainActivity: AudioServiceActivity() {
    // No additional configuration needed as AudioServiceActivity handles FlutterEngine setup
    // لا حاجة لإعدادات إضافية حيث أن AudioServiceActivity تتولى إعداد FlutterEngine
}