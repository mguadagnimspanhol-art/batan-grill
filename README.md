# Batan Grill — Gestão de marmitas

Aplicação do Batan Grill (gestão e consulta), publicada a partir deste repositório GitHub. Inclui cardápios, cortes por categoria, rendimentos, custos, saquinhos de salada, relatórios e margem de contribuição.

**Fórmula da margem:** receita − imposto de 12% − custo dos alimentos usados nas marmitas − custo dos ingredientes da salada − **custo da embalagem dos saquinhos de salada**. Não inclui outras embalagens, pessoal, gás, energia, transporte, aluguel ou despesas indiretas.

## Situação da nuvem
- Projeto Supabase: `Batan Grill Marmitas` (`eibwsstgeswiaoiajqho`, região São Paulo, plano Free).
- `public.profiles`: autenticação por e-mail + senha e papéis `manager` / `viewer`.
- `public.day_reports`: relatórios diários centralizados, sincronizados após salvar.
- `public.app_state`: catálogo, preços, rendimentos, metas, cardápio em edição e revisão semanal.
- `config.js`: URL + chave pública publishable já configuradas para este projeto.
- **Pendência:** criar contas no **Authentication > Users** no painel Supabase e associá-las a papéis no banco. Até isso, o login não permite uso.
- Regras Row Level Security ativas, consulta restrita a relatórios de contas autorizadas e escrita restrita à gestão.

**Senhas:** são criadas no Supabase, não são armazenadas no GitHub. Não compartilhe senhas nem chaves secretas com ninguém. Se quiser abrir o aplicativo em outro dispositivo, use seu e-mail + senha Supabase.

## Configurar contas
1. Acesse https://supabase.com/dashboard/project/eibwsstgeswiaoiajqho/auth/users
2. Crie duas contas com e-mails e senhas próprios: uma para sua gerente (`manager`) e uma para sua consulta (`viewer`).
3. Abra o SQL Editor em https://supabase.com/dashboard/project/eibwsstgeswiaoiajqho/sql/new e execute as duas instruções no final de `supabase.sql`, substituindo **somente os endereços de e-mail**.
4. Em Authentication > Providers > Email, desabilite **Allow new users to sign up** para evitar inscrições externas.
5. Acesse a URL do site e faça login. Nunca insira a senha no GitHub.

## Hospedagem no Netlify (gratuita)
O repositório já contém `netlify.toml` e `design.css`. Para publicar:
1. https://app.netlify.com/start → Import an existing project → GitHub → repositório `mguadagnimspanhol-art/batan-grill`.
2. Branch `main`, sem comando de build, diretório `.`, plano Free.
3. Após publicar, escolha o nome `bgmarmitaria` se estiver disponível. O domínio gratuito é `*.netlify.app`.
4. Deploys novos ocorrem automaticamente ao atualizar o GitHub. Não há migração Netlify concluída até o site ser criado lá.

A versão do GitHub Pages permanece tecnicamente acessível, mas deve ser substituída pelo Netlify para uso comercial.

## Arquivos
- `index.html` — interface de gestão.
- `consulta.html` — interface de consulta.
- `design.css` — visual responsivo.
- `config.js` — conexão pública ao Supabase, sem senhas.
- `supabase.sql` — estrutura e políticas seguras.
- `CONFIGURAR_NUVEM.md` — guia do banco.
- `netlify.toml` — configuração Netlify.

No modo nuvem, o servidor armazena os relatórios e o estado editável; não há sincronização anterior de dados locais até uma importação. Faça backup do navegador antigo antes de começar.

Planos gratuitos têm limites, e projetos Supabase gratuitos podem ser pausados por inatividade.
