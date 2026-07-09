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
