# 반주자 스케줄 앱 배포 방법

## 1. Supabase 만들기

1. Supabase에서 새 프로젝트를 만듭니다.
2. SQL Editor에서 `supabase-schema.sql` 내용을 실행합니다.
3. Settings > Data API에서 `Project URL`을 복사합니다.
4. Settings > API Keys에서 `Publishable key`를 복사합니다.
5. `config.js`에 아래처럼 넣습니다.

```js
window.SCHEDULE_APP_CONFIG = {
  SUPABASE_URL: "https://YOUR_PROJECT.supabase.co",
  SUPABASE_ANON_KEY: "YOUR_PUBLISHABLE_KEY",
  STATE_ID: "main",
  VAPID_PUBLIC_KEY: ""
};
```

## 2. GitHub Pages 배포

`outputs` 폴더 안 파일들을 GitHub 저장소 최상단에 올립니다.

필수 파일:

- `index.html`
- `schedule-manager.html`
- `config.js`
- `manifest.json`
- `service-worker.js`
- `.nojekyll`
- `supabase-schema.sql`

로고를 바로 쓰려면 이것도 올립니다.

- `church-logo.png`

GitHub 저장소 Settings > Pages에서:

- Source: `Deploy from a branch`
- Branch: `main`
- Folder: `/ (root)`

로 설정합니다.

## 3. iPhone 홈 화면 추가

1. iPhone Safari에서 배포 URL을 엽니다.
2. Safari 공유 버튼을 누릅니다.
3. `홈 화면에 추가`를 누릅니다.
4. 홈 화면 아이콘으로 앱을 실행합니다.

## 4. 푸시 알림

iPhone 푸시 알림을 쓰려면 `PUSH_NOTIFICATIONS.md`를 따라 추가 설정합니다.

필요한 추가 파일:

- `supabase/functions/send-schedule-notifications/index.ts`
- `.github/workflows/daily-notifications.yml`

## 5. 운영 메모

- 같은 `STATE_ID`를 쓰는 접속자는 같은 스케줄을 공유합니다.
- 교회별/팀별로 분리하려면 `STATE_ID`를 `main`, `youth`, `choir`처럼 다르게 둡니다.
- 지금 버전은 로그인 없이 URL을 아는 사람이 수정할 수 있습니다. 실제 공개 운영 전에는 로그인/비밀번호 또는 관리자 모드를 붙이는 것을 권장합니다.
