create table if not exists public.schedule_state (
  id text primary key,
  state jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.schedule_state enable row level security;

drop policy if exists "schedule_state_public_read" on public.schedule_state;
create policy "schedule_state_public_read"
on public.schedule_state
for select
using (true);

drop policy if exists "schedule_state_public_insert" on public.schedule_state;
create policy "schedule_state_public_insert"
on public.schedule_state
for insert
with check (true);

drop policy if exists "schedule_state_public_update" on public.schedule_state;
create policy "schedule_state_public_update"
on public.schedule_state
for update
using (true)
with check (true);

do $$
begin
  begin
    alter publication supabase_realtime add table public.schedule_state;
  exception
    when duplicate_object then null;
    when undefined_object then null;
  end;
end $$;

create table if not exists public.push_subscriptions (
  endpoint text primary key,
  person_id text not null,
  state_id text not null default 'main',
  subscription jsonb not null,
  user_agent text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.push_subscriptions enable row level security;

drop policy if exists "push_subscriptions_public_insert" on public.push_subscriptions;
create policy "push_subscriptions_public_insert"
on public.push_subscriptions
for insert
with check (true);

drop policy if exists "push_subscriptions_public_update" on public.push_subscriptions;
create policy "push_subscriptions_public_update"
on public.push_subscriptions
for update
using (true)
with check (true);

create table if not exists public.notification_logs (
  id uuid primary key default gen_random_uuid(),
  state_id text not null default 'main',
  event_key text not null,
  person_id text,
  title text not null,
  body text not null,
  sent_at timestamptz not null default now()
);

create unique index if not exists notification_logs_event_person_idx
on public.notification_logs (state_id, event_key, coalesce(person_id, '*'));

alter table public.notification_logs enable row level security;
