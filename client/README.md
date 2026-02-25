# Folder Structure
lib/
├── core/               # Ferramentas globais da aplicação
│   ├── network/        # Clientes de comunicação (GraphQL e WebSockets) 
│   └── theme/          # Cores, estilos de texto e tema (ex: app_theme.dart)
│
├── data/               # Camada de Dados (Onde brilham os Design Patterns) [cite: 39]
│   ├── models/         # As tuas classes de dados (ex: package.dart, event.dart)
│   └── repositories/   # Padrão Repository para isolar a lógica (ex: package_repository.dart)
│
├── presentation/       # Camada Visual (Onde separas Web e Mobile)
│   ├── mobile/         # Tudo o que é EXCLUSIVO para telemóvel
│   │   ├── screens/    # ex: mobile_list_screen.dart
│   │   └── widgets/    # ex: mobile_bottom_nav.dart
│   │
│   ├── web/            # Tudo o que é EXCLUSIVO para o browser
│   │   ├── screens/    # ex: web_dashboard_screen.dart
│   │   └── widgets/    # ex: web_sidebar.dart, map_placeholder.dart
│   │
│   └── shared/         # Componentes usados em AMBOS (Reutilização de código)
│       ├── layout/     # ex: responsive_layout.dart (O cérebro que decide qual UI mostrar)
│       └── widgets/    # ex: package_card.dart (Usado tanto no mobile como na web)
│
└── main.dart           # O ponto de entrada que arranca a aplicação