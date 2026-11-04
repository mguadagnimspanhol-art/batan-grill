# Batan Grill — Gestão de marmitas

Sistema em português para controle de produção, pesos, receitas, preços por kg cru, custos dos alimentos e margem de contribuição após **12% de imposto** (sem incluir outros custos).

- `index.html`: gestão, ingredientes, cortes bovinos e suínos, receitas, preços e relatórios.
- `consulta.html`: interface de consulta, com permissões efetivas ao ativar o banco Supabase.
- `config.js`: configuração **pública** do Supabase (URL + chave publishable/anon, nunca segredo).
- `supabase.sql`: schema e políticas de acesso seguro por papéis.
- `CONFIGURAR_NUVEM.md`: etapas para ativar armazenamento em qualquer dispositivo e credenciais separadas.
- `netlify.toml`: publicação do site estático no Netlify.

## Hospedagem gratuita: Netlify

1. Acesse https://app.netlify.com/start e crie uma conta Free.
2. Escolha **Import an existing project** → **GitHub**, autorize o repositório `mguadagnimspanhol-art/batan-grill`.
3. Confirme a branch `main`, **Build command** em branco e **Publish directory** em `.` (raiz).
4. Clique em **Deploy / Publish**. A integração com o GitHub fará publicações automáticas sempre que o código mudar.
5. Abra **Project overview → Customize → Project name** e tente `bgmarmitaria`. Se disponível, o endereço será `https://bgmarmitaria.netlify.app/`, com a consulta em `/consulta.html`. O nome pode não estar livre.

**Não haverá link Netlify ativo até o projeto ser criado na conta Netlify.** A publicação GitHub Pages anterior ainda existe, mas não é a opção recomendada para este uso comercial.

## Banco de dados, login e sincronização: Supabase

Confira o arquivo [CONFIGURAR_NUVEM.md](CONFIGURAR_NUVEM.md). O modo online exige um projeto Supabase configurado, a execução de `supabase.sql`, duas contas autenticadas (gerente / consulta), atribuição das permissões e configuração pública `config.js`.

Enquanto não houver uma URL e chave pública em `config.js`, o sistema funciona apenas localmente no navegador: **não há sincronização nem proteção por senha real**. Com o banco devidamente configurado e RLS ligado, dados são centralizados e o acesso é protegido por login.

Não coloque senhas ou chave `service_role` no GitHub, em mensagens ou em `config.js`. Senhas são gerenciadas pelo Supabase Auth.

**Observação:** planos gratuitos têm limites e o Supabase pode pausar projetos com pouca atividade. Faça backups periódicos.

## Cálculo financeiro

Resultado por marmita = preço de venda − imposto de 12% − custo dos alimentos crus ajustado pelo rendimento. O percentual é **margem após alimentos e imposto**, não lucro líquido contábil.
