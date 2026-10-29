# Flag Game

Jogo educativo de geografia desenvolvido em Flutter. O jogador recebe uma
bandeira e a arrasta até o território correspondente em um mapa interativo.
Quando a resposta está correta, o território permanece preenchido com a
bandeira durante a partida.

## Status

O repositório contém a base inicial do aplicativo e um protótipo visual. A
implementação completa da partida, do mapa vetorial e dos dados cartográficos
será feita por etapas, conforme [contexto.md](contexto.md).

## Funcionalidades planejadas

- Partidas por continente e modo aleatório.
- Durações de 30 segundos, 60 segundos, 3 minutos e 5 minutos.
- Dificuldades fácil e difícil.
- Mapa vetorial local com GeoJSON.
- Bandeiras SVG e dados locais para funcionamento offline.
- Resultados e ranking local.
- Interface em português, inglês e espanhol.

## Pré-requisitos

- Flutter 3.35 ou superior.
- Dart compatível com o SDK definido em [pubspec.yaml](pubspec.yaml).
- Um dispositivo ou emulador Android/iOS, ou uma plataforma desktop/web
  suportada pelo Flutter.

## Executando o projeto

```bash
flutter pub get
flutter run
```

Para validar o código:

```bash
dart format lib test
flutter analyze
flutter test
```

## Organização

```text
lib/
├── app.dart                 # Configuração raiz do MaterialApp
├── main.dart                # Ponto de entrada
├── core/                    # Tema e recursos transversais
├── data/                    # Leitura e validação dos dados locais
├── models/                  # Entidades e configurações do domínio
├── services/                # Regras de jogo e persistência
├── screens/                 # Telas e navegação
├── widgets/                 # Componentes reutilizáveis de interface
├── map/                     # Projeção, geometrias, pintura e hit testing
└── l10n/                    # Arquivos ARB de localização
assets/
├── data/                    # countries.json
├── flags/                   # Imagens locais das bandeiras
└── geo/                     # Arquivos GeoJSON
test/                        # Testes unitários e de widgets
```

## Dados e atribuições

O protótipo atual usa cinco países da América do Sul em
`assets/geo/south_america.geojson`. O arquivo foi recortado do conjunto
[`datasets/geo-countries`](https://github.com/datasets/geo-countries), que
declara licença Open Data Commons Open Database License (ODbL). A atribuição e
a licença devem ser mantidas quando o conjunto for atualizado ou substituído.

As imagens definitivas das bandeiras ainda precisam ser adicionadas e ter sua
fonte/licença registrada. Consulte também
[assets/flags/README.md](assets/flags/README.md).

## Desenvolvimento

As decisões já aprovadas e os pontos que ainda precisam de validação estão
registrados em [contexto.md](contexto.md). A prioridade é validar primeiro um
protótipo pequeno da América do Sul antes de ampliar o mapa e o banco de
países.

O protótipo atual já permite arrastar uma bandeira até o mapa, identificar o
território pela geometria e recortar a bandeira dentro do território resolvido.

O ranking local mantém os dez melhores resultados e exibe o contexto da
partida. O controlador também protege contra respostas após o fim e contra
callbacks de uma inicialização assíncrona anterior.

O mapa possui zoom e pan para facilitar a interação com territórios menores.
Cada região usa uma viewport cartográfica própria e renderiza a região inteira;
os desafios da partida são apenas os alvos interativos. Territórios resolvidos
são destacados por cor e check, sem deformar bandeiras dentro dos polígonos.
O arraste usa a transformação real do mapa e uma tolerância curta para países
pequenos, preservando a prioridade do polígono exato quando as áreas se tocam.
O catálogo inicial usa um GeoJSON mundial local com países representativos dos
cinco continentes. A geometria foi obtida do conjunto `datasets/geo-countries`
(base Natural Earth em domínio público, pacote sob PDDL), enquanto as bandeiras são arquivos
SVG locais nomeados por código ISO. A expansão para cobertura completa de todos
os países e a validação em dispositivos móveis continuam pendentes.
