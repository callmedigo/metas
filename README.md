#  App de Metas Diárias

Aplicativo simples em Flutter para acompanhar e gerenciar metas diárias. O app permite adicionar, remover e personalizar metas, além de marcar as atividades feitas no dia.

##  Funcionalidades

-  Adição e remoção de metas personalizadas
-  Controle diário do que ainda precisa ser feito
-  Acúmulo de metas não concluídas para o dia seguinte
-  Modal de personalização para editar suas metas
-  Persistência de dados local com `shared_preferences`

##  Interface

A interface é dividida em duas abas principais:

- **Hoje**: onde você marca as metas feitas e vê o progresso.
- **Personalizar Metas**: onde você adiciona, remove e edita as metas.

##  Tecnologias utilizadas

- [Flutter](https://flutter.dev/)
- Dart
- shared_preferences (armazenamento local)
- intl

## Proximas funcionalidades para implementar

1. Relatório/Histórico de Exercícios
Guardar registros diários do que foi feito (quantidade, data).
Mostrar gráficos semanais/mensais (barra, pizza, linha) para visualizar o progresso.

~~Reset Diário Automático~~ implementado.

4. Interface e UX
Melhorar visual, usar cores, ícones, animações suaves.
Tela de boas-vindas/tutorial.

5. Sincronização / Backup na Nuvem
Salvar dados em Firebase, Google Drive, ou algum backend para não perder dados.
Sincronizar entre dispositivos.

~~Modo Dark/Light~~ implementado.