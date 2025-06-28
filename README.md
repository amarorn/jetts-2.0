# Jetts 🚤

[![Flutter](https://img.shields.io/badge/Flutter-3.7.2-blue?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.7.2-blue?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-blue)]()

## Sobre o Jetts

O **Jetts** é o seu app para encontrar, reservar e curtir passeios de barco de um jeito fácil, seguro e divertido! Seja para um rolê de luxo, uma pescaria, um evento ou só relaxar no mar, aqui você encontra a embarcação perfeita. Navegue, reserve, pague e aproveite – tudo pelo app! 🌊

---

## Fluxo do App

1. **Onboarding:** Apresentação do app e principais recursos.
2. **Cadastro/Login:** Crie sua conta ou entre com Google/Apple.
3. **Home:** Veja destaques, promoções, clima, localização e atalhos rápidos.
4. **Busca:** Pesquise barcos por nome, local, categoria ou filtros avançados.
5. **Detalhes do Barco:** Veja fotos, comodidades, avaliações e faça sua reserva.
6. **Reserva:** Escolha datas, pessoas, adicione observações e pague (cartão, Pix, etc).
7. **Chat:** Converse com proprietários ou com o suporte (chatbot).
8. **Perfil:** Gerencie dados, histórico, favoritos, promoções e configurações.
9. **Notificações:** Receba alertas de reservas, promoções e clima.

---

## Diagrama de Contexto (C4 Model)

```mermaid
<!-- O diagrama será inserido abaixo -->
```

---

## Descrição Detalhada & Descontraída

Imagine um app que é tipo o Airbnb dos mares, mas com aquele toque brasileiro de alegria e praticidade! O Jetts conecta você aos melhores barcos do Brasil, seja para um passeio romântico, uma festa com os amigos ou aquela pescaria raiz. Tudo fácil: escolha, reserve, pague e navegue. E se pintar dúvida, tem chat com suporte e chatbot simpático. Segurança, praticidade e diversão – só falta o bronzeador!

---

## Detalhamento Técnico

### Principais Pacotes Utilizados
- **flutter**: Framework principal para multiplataforma.
- **google_fonts**: Tipografia moderna e customizada.
- **card_swiper**: Carrossel de destaques.
- **flutter_staggered_grid_view**: Grades responsivas para exibir barcos e destinos.
- **qr_flutter**: Geração de QR Code para pagamentos Pix.
- **geocoding**: Conversão de endereços e localização.
- **provider** ou **get_it** (caso use): Gerenciamento de estado e injeção de dependências.
- **http**: Comunicação com APIs REST.

### Padrões de Desenvolvimento
- **Arquitetura em Camadas**: Separação clara entre apresentação, domínio e dados.
- **Design System**: Componentes reutilizáveis e tokens de design (cores, tipografia, espaçamento).
- **Responsividade**: Layout adaptável para mobile, tablet e desktop.
- **Internacionalização**: Pronto para múltiplos idiomas.
- **Clean Code**: Código limpo, comentado e fácil de manter.
- **Null Safety**: Todo o projeto usa null safety para maior segurança.
- **Testes**: Testes unitários e de widget para garantir qualidade.

---

## Como rodar o projeto

```bash
flutter pub get
flutter run
```

---

## Contribua!
Curtiu o projeto? Manda um PR, sugira melhorias ou só venha bater um papo! 😄

---

## Licença
MIT
