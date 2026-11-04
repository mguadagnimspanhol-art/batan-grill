-- Batan Grill | Supabase - base de dados e acesso seguro (v1)
-- Executar UMA VEZ no SQL Editor do projeto Supabase.
-- Após criar as contas no Authentication > Users, atribua roles no final do arquivo.
-- NÃO publique a chave secreta/service_role nem senhas no GitHub.

create table if not exists public.profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  role text not null check (role in ('manager','viewer')),
  created_at timestamptz not null default now()
);

create table if not exists public.day_reports (
  report_date date primary key,
  payload jsonb not null,
  created_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now()
);

create table if not exists public.app_state (
  id smallint primary key check (id = 1),
  payload jsonb not null,
  updated_by uuid references auth.users(id) on delete set null,
  updated_at timestamptz not null default now()
);

alter table public.profiles enable row level security;
alter table public.day_reports enable row level security;
alter table public.app_state enable row level security;

-- Revogar permissões automáticas amplas antes de liberar apenas operações necessárias.
revoke all on public.profiles, public.day_reports, public.app_state from public, anon, authenticated;
grant usage on schema public to authenticated;
grant select on public.profiles to authenticated;
grant select, insert, update, delete on public.day_reports to authenticated;
grant select, insert, update on public.app_state to authenticated;

drop policy if exists "perfil_ve_o_proprio_papel" on public.profiles;
create policy "perfil_ve_o_proprio_papel"
  on public.profiles for select to authenticated
  using (user_id = (select auth.uid()));

-- Apenas contas explicitamente autorizadas como gerente/consulta podem ler relatórios.
drop policy if exists "relatorios_consulta_autorizada" on public.day_reports;
create policy "relatorios_consulta_autorizada"
  on public.day_reports for select to authenticated
  using (exists (
    select 1 from public.profiles p
    where p.user_id = (select auth.uid()) and p.role in ('manager','viewer')
  ));

drop policy if exists "relatorios_gerente_cria" on public.day_reports;
create policy "relatorios_gerente_cria"
  on public.day_reports for insert to authenticated
  with check (
    created_by = (select auth.uid())
    and exists (
      select 1 from public.profiles p
      where p.user_id = (select auth.uid()) and p.role = 'manager'
    )
  );

drop policy if exists "relatorios_gerente_edita" on public.day_reports;
create policy "relatorios_gerente_edita"
  on public.day_reports for update to authenticated
  using (exists (
    select 1 from public.profiles p
    where p.user_id = (select auth.uid()) and p.role = 'manager'
  ))
  with check (exists (
    select 1 from public.profiles p
    where p.user_id = (select auth.uid()) and p.role = 'manager'
  ));

drop policy if exists "relatorios_gerente_exclui" on public.day_reports;
create policy "relatorios_gerente_exclui"
  on public.day_reports for delete to authenticated
  using (exists (
    select 1 from public.profiles p
    where p.user_id = (select auth.uid()) and p.role = 'manager'
  ));

-- Configuração e preços em andamento: disponíveis somente a gerentes autenticados.
drop policy if exists "estado_gerente_consulta" on public.app_state;
create policy "estado_gerente_consulta"
  on public.app_state for select to authenticated
  using (exists (
    select 1 from public.profiles p
    where p.user_id = (select auth.uid()) and p.role = 'manager'
  ));

drop policy if exists "estado_gerente_cria" on public.app_state;
create policy "estado_gerente_cria"
  on public.app_state for insert to authenticated
  with check (
    id = 1
    and updated_by = (select auth.uid())
    and exists (
      select 1 from public.profiles p
      where p.user_id = (select auth.uid()) and p.role = 'manager'
    )
  );

drop policy if exists "estado_gerente_edita" on public.app_state;
create policy "estado_gerente_edita"
  on public.app_state for update to authenticated
  using (exists (
    select 1 from public.profiles p
    where p.user_id = (select auth.uid()) and p.role = 'manager'
  ))
  with check (
    id = 1
    and updated_by = (select auth.uid())
    and exists (
      select 1 from public.profiles p
      where p.user_id = (select auth.uid()) and p.role = 'manager'
    )
  );

-- Ativa atualizações automáticas dos relatórios entre aparelhos, se Realtime estiver disponível.
do $$
begin
  if exists (select 1 from pg_publication where pubname = 'supabase_realtime')
     and not exists (
       select 1 from pg_publication_tables
       where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'day_reports'
     ) then
    alter publication supabase_realtime add table public.day_reports;
  end if;
end $$;

-- IMPORTANTE: desabilite o cadastro público em Authentication > Providers > Email.
-- Crie manualmente 2 usuários em Authentication > Users (um gerente e um consulta).
-- Depois substitua os e-mails abaixo e EXECUTE AS DUAS INSTRUÇÕES SEPARADAMENTE.
--
-- insert into public.profiles (user_id, role)
-- select id, 'manager' from auth.users where email = 'EMAIL_DA_GERENTE'
-- on conflict (user_id) do update set role = excluded.role;
--
-- insert into public.profiles (user_id, role)
-- select id, 'viewer' from auth.users where email = 'SEU_EMAIL_DE_CONSULTA'
-- on conflict (user_id) do update set role = excluded.role;
