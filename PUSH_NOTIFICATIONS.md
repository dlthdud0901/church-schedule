# iPhone 무료 푸시 알림 설정

## 동작 조건

- iPhone iOS 16.4 이상
- Safari에서 사이트 접속
- 공유 버튼 > 홈 화면에 추가
- 홈 화면 아이콘으로 실행
- 앱 안의 `이 기기 알림 받기` 버튼으로 알림 허용

## 알림 종류

- 변경 요청이 생기면 모두에게 알림
- 변경 확정 시 변경 요청자에게 알림
- 변경 확정 시 새 담당자에게 바로 알림
- 새 담당자에게 D-14/D-7/D-3/D-1 중 개인 설정에 따라 알림
- 변경 요청이 승인되지 않은 경우 D-14/D-7/D-3/D-1 중 개인 설정에 따라 모두에게 알림

## Supabase SQL

`supabase-schema.sql`을 다시 실행합니다.

## VAPID 키 생성

웹 푸시에는 VAPID 공개키/비밀키가 필요합니다.

생성 후:

- 공개키: `config.js`의 `VAPID_PUBLIC_KEY`에 입력
- 공개키: Supabase Edge Function Secret `VAPID_PUBLIC_KEY`에도 입력
- 비밀키: Supabase Edge Function Secret `VAPID_PRIVATE_KEY`에 입력
- Subject: Supabase Edge Function Secret `VAPID_SUBJECT`에 `mailto:본인이메일` 입력

## Supabase Edge Function

`supabase/functions/send-schedule-notifications/index.ts`를 Supabase Edge Function으로 배포합니다.

필요한 Edge Function Secrets:

- `SUPABASE_URL`
- `SUPABASE_SERVICE_ROLE_KEY`
- `VAPID_PUBLIC_KEY`
- `VAPID_PRIVATE_KEY`
- `VAPID_SUBJECT`
- `SCHEDULE_SECRET`

`SUPABASE_SERVICE_ROLE_KEY`는 절대 GitHub Pages나 `config.js`에 넣으면 안 됩니다.

## 매일 자동 알림

`.github/workflows/daily-notifications.yml`를 GitHub 저장소에 올립니다.

GitHub 저장소 Settings > Secrets and variables > Actions에 추가:

- `NOTIFICATION_FUNCTION_URL`: `https://프로젝트ID.functions.supabase.co/send-schedule-notifications`
- `SCHEDULE_SECRET`: Supabase Edge Function Secret에 넣은 값과 같은 임의의 긴 문자열

이 워크플로는 매일 한국시간 오전 9시에 예약 알림 함수를 호출합니다.
