# Ativar sincronização e acesso por senha — Batan Grill

O sistema já possui duas interfaces:
- **Gestão:** `https://mguadagnimspanhol-art.github.io/batan-grill/`
- **Consulta:** `https://mguadagnimspanhol-art.github.io/batan-grill/consulta.html`

Enquanto `config.js` não estiver configurado, o site continua funcionando **só no navegador local**. Depois da configuração, o login por e-mail e senha aparece nas duas páginas, e os dados ficam guardados no Supabase.

## Configuração do banco
1. Crie um projeto no [Supabase](https://supabase.com/dashboard) com região adequada. Guarde a senha do banco em local seguro (não envie pelo chat).
2. Em **SQL Editor**, execute todo o conteúdo de `supabase.sql`.
3. Em **Authentication > Providers > Email**, desative cadastro público (*Allow new users to sign up*).
4. Em **Authentication > Users**, crie pelo menos duas contas manualmente, com e-mail e senha: uma para gerente e outra para consulta. Não compartilhe a conta da gerente.
5. Ainda no SQL Editor, execute as duas instruções de `insert into public.profiles` presentes no rodapé de `supabase.sql`, substituindo pelos e-mails das contas. As contas sem perfil não têm acesso aos dados.
6. Em **Project Settings > API Keys** (ou **Connect** no projeto), obtenha **Project URL** e a chave **publishable / anon**, que é pública. Nunca use `service_role` ou `secret` em arquivos públicos.
7. Edite `config.js` no repositório público, preenchendo somente a URL e a chave pública. O GitHub Pages atualizará o site automaticamente.

## Acesso
- Gestão: conta marcada com role `manager` pode alterar a ficha técnica, preços, cardápio, quantidades, metas e relatórios.
- Consulta: conta com role `viewer` pode apenas ler relatórios salvos; não pode alterar registros no banco, mesmo usando ferramentas do navegador.
- Senhas são armazenadas pelo Supabase Auth, não no GitHub. Prefira senhas únicas e fortes, mesmo sendo um login simples de duas caixas.
- A **lista de ingredientes e cardápio em edição** é salva em `app_state`; os **relatórios diários** são guardados em `day_reports`.
- Se já houver relatórios no navegador anterior, salve antes um backup JSON na tela de Configuração. É possível importar os relatórios para o banco com a função "Enviar relatórios locais para nuvem" (caso disponível na versão atualizada).

## Segurança e privacidade
O repositório GitHub Pages é público, portanto **não coloque senhas, dados de clientes sensíveis, chave secret nem service_role no código**. As tabelas do banco têm RLS e só contas explicitamente autorizadas acessam informações. A consulta local sem sincronização não equivale a proteção por senha.

## Sem custos adicionais na margem
A fórmula segue: faturamento − 12% de imposto − custo dos alimentos. Não inclui embalagem, gás, mão de obra, aluguel ou frete.
