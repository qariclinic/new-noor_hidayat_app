# نورِ ہدایت — Flutter پروجیکٹ

رول بیسڈ اسلامی تعلیمی ایپ (بچے / خواتین / مرد)۔
نوٹ: اس پروجیکٹ میں android/ اور ios/ فولڈر شامل نہیں ہیں، وہ نیچے کی کمانڈ سے خود بن جائیں گے۔

## APK بنانے کے مراحل
1. [Flutter SDK](https://docs.flutter.dev/get-started/install) اور Android Studio انسٹال کریں۔
2. اس ZIP کو کھولیں اور ٹرمینل میں فولڈر کے اندر جائیں۔
3. پلیٹ فارم فولڈر بنائیں:
   `flutter create . --project-name noor_hidayat --org com.noorhidayat --platforms=android,ios`
4. `flutter pub get`
5. موبائل یا ایمولیٹر پر ٹیسٹ: `flutter run`
6. APK: `flutter build apk --release`
   فائل یہاں ملے گی: `build/app/outputs/flutter-apk/app-release.apk`
7. Play Store کے لیے: `flutter build appbundle` (اس سے پہلے signing key بنانا ضروری ہے)۔

نیٹ ورک سے آڈیو چلانے کے لیے `android/app/src/main/AndroidManifest.xml` میں یہ سطر شامل کریں:
`<uses-permission android:name="android.permission.INTERNET"/>`

## فولڈر ساخت
- lib/models: Profile، ContentItem، UserRole
- lib/providers: پروفائل (PIN سمیت)، لائبریری (تلاش، بک مارک، پیش رفت، اسٹریک)
- lib/screens: آن بورڈنگ، ہوم، تفصیل، بک مارکس، پیش رفت، والدین PIN
- assets/data/content.json: نمونہ مواد (معتبر علماء سے منظور شدہ مواد سے بدلیں)
- docs/backend_schema.md: بیک اینڈ کا خاکہ
- admin_panel/: ویب ایڈمن پینل کی جگہ

## جو شامل ہے / جو باقی ہے
شامل: رول سلیکشن، ملٹی پروفائل، بچوں کے لیے PIN، متن اور آڈیو، تلاش اور فلٹر، بک مارک، پیش رفت (ستارے / اسٹریک)۔
باقی: آف لائن ڈاؤن لوڈ، وائس سرچ، Firebase/Supabase اور سیگمنٹڈ پش نوٹیفکیشن، ویڈیو پلیئر، ایڈمن پینل۔

## GitHub پر APK بنانا (بغیر کمپیوٹر پر Flutter کے)
1. GitHub پر نئی repository بنائیں اور اس ZIP کے سارے فائلیں (`.github` فولڈر سمیت) اس میں اپ لوڈ کریں۔ فولڈر کا نام نہیں، اندر کی فائلیں اوپر کی سطح پر ہوں۔
2. برانچ کا نام `main` رکھیں۔ پہلی push پر build خود شروع ہو جائے گی۔
3. repository میں **Actions** ٹیب کھولیں، "Build APK" پر کلک کریں، مکمل ہونے پر نیچے **Artifacts** سے `noor-hidayat-apk` ڈاؤن لوڈ کریں۔
4. یہ APK debug key سے sign ہوتی ہے، موبائل پر انسٹال ہو جائے گی مگر Play Store کے لیے الگ signing key چاہیے۔
