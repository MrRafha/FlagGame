# Flag Game

Jogo educativo de geografia desenvolvido em Flutter. O jogador recebe uma
bandeira e precisa arrastá-la até o território correspondente em um mapa
interativo.

# Video Demonstrativo
[![Assista à demonstração no YouTube](https://img.youtube.com/vi/4GdSJEOQO1g/maxresdefault.jpg)](https://www.youtube.com/watch?v=4GdSJEOQO1g)

## Status atual

O MVP está funcional e pode ser executado offline. Ele inclui partidas por
continente ou aleatórias, cronômetro, dificuldades, resultados, ranking local,
localização e mapa mundial com interação por arrastar e soltar.

O catálogo jogável atual possui 28 países distribuídos entre África, América,
Ásia, Europa e Oceania. A geometria mundial local contém 258 features; a
cobertura completa de todos os países ainda não faz parte do MVP.

## Funcionalidades

- Partidas por continente ou no modo aleatório.
- Continentes: África, América, Ásia, Europa e Oceania.
- Durações de 30 segundos, 60 segundos, 3 minutos e 5 minutos.
- Dificuldades fácil e difícil.
- Nomes dos países nos mapas continentais conforme a dificuldade.
- Mapa mundial sem nomes no modo aleatório.
- Arrastar e soltar bandeiras nos territórios correspondentes.
- Hit testing baseado na geometria real dos países e suporte a
  `Polygon`/`MultiPolygon`.
- Zoom e deslocamento para facilitar a localização de países menores.
- Feedback visual para acertos e erros.
- Tela de resultados com pontuação, desafios apresentados, acertos, erros e
  precisão.
- Ranking local com os dez melhores resultados usando `SharedPreferences`.
- Interface em português, inglês e espanhol.
- Funcionamento offline com dados, bandeiras e mapas locais.

## Pré-requisitos

- Flutter 3.35 ou superior.
- Dart 3.9.2 ou compatível com o SDK definido em `pubspec.yaml`.
- Android Studio, dispositivo Android ou emulador para gerar/executar o APK.
- Chrome ou outro navegador compatível para executar a versão web.

## Executando

Instale as dependências:

```bash
flutter pub get
```

Execute em um dispositivo ou navegador:

```bash
flutter run
flutter run -d chrome
```

Para iniciar um servidor web local:

```bash
flutter run -d web-server --release --web-port 8080
```

## Testes e validação

```bash
dart format lib test
flutter analyze
flutter test
```

Os testes cobrem seleção de desafios, controle da partida, hitbox dos países,
definições de mapa, persistência do ranking e exibição dos resultados.

## Builds

Gerar uma versão web:

```bash
flutter build web --release
```

Gerar o APK Android:

```bash
flutter build apk --release
```

O APK gerado fica em:

```text
build/app/outputs/flutter-apk/app-release.apk
```

## Organização do projeto

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
└── l10n/                    # Arquivos ARB e localizações geradas
assets/
├── data/                    # Catálogo de países
├── flags/                   # Bandeiras SVG locais
└── geo/                     # Arquivos GeoJSON
test/                        # Testes unitários e de widgets
```

## Dados e atribuições

O catálogo de países está em
[assets/data/countries.json](assets/data/countries.json). As geometrias estão
em [assets/geo/world.geojson](assets/geo/world.geojson) e são baseadas no
conjunto [`datasets/geo-countries`](https://github.com/datasets/geo-countries),
com dados derivados do Natural Earth. As informações de licença e atribuição
devem ser preservadas conforme descrito em
[assets/flags/README.md](assets/flags/README.md).

As bandeiras ficam em `assets/flags/` e são identificadas por códigos ISO
alpha-2. Todos esses recursos são empacotados localmente para manter a
experiência offline.

## Licença

Este projeto é acadêmico e não declara uma licença de distribuição própria.
Consulte as licenças e atribuições dos dados cartográficos e das bandeiras
antes de redistribuir os assets.
