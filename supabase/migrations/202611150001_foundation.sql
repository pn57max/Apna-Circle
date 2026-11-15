-- Initial backend foundation; apply only to a fresh Supabase staging project.
begin;
create table public.activities (
 id uuid primary key default gen_random_uuid(),
 host_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
 title text not null check (char_length(title) between 5 and 120),
 venue text not null check (char_length(venue) between 3 and 200),
 starts_at timestamptz not null, ends_at timestamptz not null,
 capacity integer not null check (capacity between 2 and 20),
 check (ends_at > starts_at)
);
create table public.join_requests (
 activity_id uuid references public.activities(id) on delete cascade,
 member_id uuid references auth.users(id) on delete cascade,
 status text not null default 'pending' check (status in ('pending','approved','declined')),
 primary key(activity_id,member_id)
);
alter table public.activities enable row level security;
alter table public.join_requests enable row level security;
revoke all on public.activities, public.join_requests from anon, authenticated;
grant select, insert on public.activities to authenticated;
grant select on public.join_requests to authenticated;
create policy activity_read on public.activities for select to authenticated using (true);
create policy activity_insert on public.activities for insert to authenticated with check (host_id=auth.uid() and starts_at>now());
create policy request_read on public.join_requests for select to authenticated using (member_id=auth.uid() or exists(select 1 from public.activities a where a.id=activity_id and a.host_id=auth.uid()));
create function public.request_join(p_activity uuid) returns void language plpgsql security definer set search_path='' as $$
declare a public.activities%rowtype;
begin
 if auth.uid() is null then raise exception 'Authentication required'; end if;
 select * into strict a from public.activities where id=p_activity for update;
 if a.host_id=auth.uid() or a.starts_at<=now() then raise exception 'Not eligible'; end if;
 insert into public.join_requests(activity_id,member_id) values(p_activity,auth.uid()) on conflict do nothing;
end; $$;
create function public.decide_join(p_activity uuid,p_member uuid,p_approve boolean) returns void language plpgsql security definer set search_path='' as $$
declare a public.activities%rowtype; n integer;
begin
 select * into strict a from public.activities where id=p_activity for update;
 if auth.uid() is null or a.host_id<>auth.uid() or a.starts_at<=now() then raise exception 'Not authorized'; end if;
 if not exists(select 1 from public.join_requests where activity_id=p_activity and member_id=p_member and status='pending') then raise exception 'No pending request'; end if;
 if p_approve then
 select count(*) into n from public.join_requests where activity_id=p_activity and status='approved';
 if n>=a.capacity-1 then raise exception 'Activity full'; end if;
 end if;
 update public.join_requests set status=case when p_approve then 'approved' else 'declined' end where activity_id=p_activity and member_id=p_member;
end; $$;
revoke all on function public.request_join(uuid), public.decide_join(uuid,uuid,boolean) from public, anon;
grant execute on function public.request_join(uuid), public.decide_join(uuid,uuid,boolean) to authenticated;
commit;
