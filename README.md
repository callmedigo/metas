#  App de Metas Diárias

Este é um aplicativo Flutter para acompanhar e gerenciar metas diárias de exercícios. O app permite adicionar, remover e personalizar metas, além de marcar as atividades feitas no dia.

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

## Proximas funcionalidades para implementar

1. Relatório/Histórico de Exercícios
Guardar registros diários do que foi feito (quantidade, data).
Mostrar gráficos semanais/mensais (barra, pizza, linha) para visualizar o progresso.

2. Reset Diário Automático
A cada novo dia, resetar o feito de Hoje e somar o que não foi feito no acumulado.

3. Notificações e Lembretes
Lembretes para o usuário não esquecer de fazer.

4. Interface e UX
Melhorar visual, usar cores, ícones, animações suaves.
Tela de boas-vindas/tutorial.

5. Sincronização / Backup na Nuvem
Salvar dados em Firebase, Google Drive, ou algum backend para não perder dados.
Sincronizar entre dispositivos.

6. Categorias e Grupos de Exercícios
Permitir criar categorias.
Filtrar e organizar metas por categoria.

7. Metas Personalizadas com Desafios
Criar desafios temporários, metas semanais.
Recompensas virtuais, medalhas, conquistas.

8. Modo Dark/Light
Alternar tema do app para melhor experiência visual.