# Обновление bitMystic в Google Play (существующее приложение)

Приложение уже опубликовано с **Application ID** `com.bitMystic.app`. Этот релиз — **обновление**, не новое приложение.

## Перед сборкой

### 1. Upload keystore (FlutterFlow)

Ключ из FlutterFlow:

- **alias:** `bit-app-test-js8wpx`
- Файл `.jks` скачайте в FlutterFlow → **Settings → App Details → Android → Download keystore**
- Положите в `android/bit-app-test-js8wpx-keystore.jks`
- Пароли — в `android/key.properties` (уже настроен, файл в `.gitignore`)

Проверка:

```powershell
keytool -list -v -keystore android/bit-app-test-js8wpx-keystore.jks -alias bit-app-test-js8wpx
```

### 2. versionCode

В Play Console посмотрите текущий **version code** (целое число). Новый должен быть **строго больше**.

Сейчас в `pubspec.yaml`:

```yaml
version: 1.1.0+11
```

- `1.1.0` — versionName (видит пользователь)
- `10` — versionCode для Play

Если в Play уже versionCode ≥ 10 — увеличьте число после `+`.

### 3. bePaid — production

Включён боевой режим:

- клиент: `lib/backend/bepaid/bepaid_config.dart` → `testMode: false`
- Cloud Functions: `firebase/functions/bepaid.js` → `test: false` по умолчанию

После деплоя functions проверьте в Firestore документ `app_config/bepaid`:

```json
{
  "shop_id": "34475",
  "secret_key": "<production secret>",
  "test": false,
  "currency": "BYN"
}
```

Если поле `test: true` останется в Firestore — тестовый режим включится только при явном `test: true`.

Деплой functions:

```powershell
cd firebase
firebase deploy --only functions:createBePaidCheckout,functions:confirmBePaidCheckout,functions:bepaidNotification
```

## Сборка AAB

```powershell
.\scripts\build-play-release.ps1
```

Файл для загрузки:

`build/app/outputs/bundle/release/app-release.aab`

## Загрузка в Play Console

1. Откройте **существующее** приложение bitMystic (не создавайте новое).
2. **Release** → **Production** (или Internal / Closed testing).
3. **Create new release** → загрузите `app-release.aab`.
4. **Release notes** — что нового (bePaid, тарифы, NBRB, админка и т.д.).
5. Отправьте на проверку.

## Чеклист перед отправкой

- [ ] Подпись тем же upload key, что и раньше
- [ ] versionCode выше, чем в production
- [ ] bePaid production (`test: false`), реальная оплата проходит
- [ ] Пополнение баланса и покупка тарифа
- [ ] Firebase / вход / гадания работают
- [ ] Политика конфиденциальности доступна по URL

## Версия 1.1.0 (кратко для release notes)

- Оплата через bePaid (production)
- Пополнение и тарифы в USD с конвертацией в BYN (НБРБ)
- Улучшения админки и тарифов
- Исправления стабильности и UI

## Полезные команды

```powershell
# Сборка
flutter build appbundle --release

# SHA-1 для Firebase / Maps
keytool -list -v -keystore android/bit-app-test-js8wpx-keystore.jks -alias bit-app-test-js8wpx

# Размер bundle
Get-Item build/app/outputs/bundle/release/app-release.aab
```
