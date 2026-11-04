# Batan Grill — Controle de Marmitas

Site estático em português para gestão e consulta de custos de marmitas. O cálculo desconta apenas **12% de imposto sobre o faturamento** e **custo dos alimentos** (não inclui embalagem, mão de obra, aluguel ou frete).

- `index.html`: gestão, cardápios, pesos por tamanho, receitas de pratos mistos, preços de insumos crus, resultados e relatórios.
- `consulta.html`: interface somente de leitura no navegador (não é controle de permissão de servidor).

## Como colocar online

No GitHub, abra **Settings > Pages > Build and deployment**. Escolha **Deploy from a branch**, branch **main**, pasta **/(root)** e clique **Save**.

Links esperados após a publicação:
- Gestão: https://mguadagnimspanhol-art.github.io/batan-grill/
- Consulta: https://mguadagnimspanhol-art.github.io/batan-grill/consulta.html

**Importante:** Inicialmente os dados ficam salvos somente no navegador onde foram lançados. O GitHub Pages hospeda os arquivos mas **não sincroniza registros entre celulares**. A sincronização exige conectar a um backend com contas e permissões como o Supabase antes de usar a interface de consulta em outro aparelho. Sem backend, a consulta no mesmo navegador pode ver os dados locais; um link com relatório compartilhado é instantâneo estático, não atualizado em tempo real.

Os preços reais dos insumos precisam ser informados. Fatores de rendimento são estimativas editáveis. Não publique credenciais sigilosas no repositório público.
