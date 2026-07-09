# 반주자 스케줄 앱 배포 방법

## 1. Supabase 만들기

1. Supabase에서 새 프로젝트를 만듭니다.
2. SQL Editor에서 `supabase-schema.sql` 내용을 실행합니다.
3. Project Settings > API에서 `Project URL`과 `anon public key`를 복사합니다.
4. `config.js`에 아래처럼 넣습니다.

```js
window.SCHEDULE_APP_CONFIG = {
  SUPABASE_URL: "https://YOUR_PROJECT.supabase.co",
  SUPABASE_ANON_KEY: "YOUR_ANON_PUBLIC_KEY",
  STATE_ID: "main"
};
```

## 2. 정적 사이트로 배포하기

`outputs` 폴더 안 파일들을 Netlify, Vercel, GitHub Pages 중 하나에 올리면 됩니다.

필수 파일:

- `index.html`
- `schedule-manager.html`
- `config.js`
- `church-logo.png`

배포 후 나온 `https://...` 주소를 모바일에서 열면 됩니다.

## 3. 운영 메모

- 같은 `STATE_ID`를 쓰는 접속자는 같은 스케줄을 공유합니다.
- 교회별/팀별로 분리하려면 `STATE_ID`를 예: `main`, `youth`, `choir`처럼 다르게 두면 됩니다.
- 지금 버전은 로그인 없이 URL을 아는 사람이 수정할 수 있습니다. 실제 공개 운영 전에는 로그인/비밀번호 또는 관리자 모드를 붙이는 것을 권장합니다.
