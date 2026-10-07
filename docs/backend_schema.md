# بیک اینڈ اسکیما (Firebase Firestore / Supabase)

## content
| فیلڈ | قسم | وضاحت |
|---|---|---|
| id | string | یکتا شناخت |
| title | string | عنوان |
| body | string | متن |
| category | string | عقائد / عبادات / مابعد الموت ... |
| audiences | array | child / woman / man / all |
| mediaType | string | text / audio / video |
| mediaUrl | string | S3 یا Cloudinary لنک |
| published | bool | ایڈمن پینل سے شائع/غیر شائع |
| updatedAt | timestamp | تازہ ترین تبدیلی |

## Push Notifications
FCM topics: `child`, `woman`, `man`، اور `all`۔ پروفائل بننے پر متعلقہ topic کو subscribe کریں۔

## آف لائن موڈ (اگلا مرحلہ)
ڈاؤن لوڈ سروس `path_provider` + `dio` سے بنائیں، فائل مقامی فولڈر میں رکھیں اور `mediaUrl` کی جگہ مقامی راستہ استعمال کریں۔
