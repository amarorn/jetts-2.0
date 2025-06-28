import 'package:flutter/material.dart';
import '../../../design_system/tokens/app_colors.dart';
import '../../../design_system/tokens/app_typography.dart';

class ClientSupportChatScreen extends StatefulWidget {
  const ClientSupportChatScreen({super.key});

  @override
  State<ClientSupportChatScreen> createState() =>
      _ClientSupportChatScreenState();
}

class _ClientSupportChatScreenState extends State<ClientSupportChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<_ChatMessage> _messages = [];

  final Map<String, String> chatbotKnowledgeBase = {
    // ================ SAUDAÇÕES E CORTESIA ================
    'olá': 'Olá! Bem-vindo ao Jetts! 🚢 Como posso ajudar você hoje?',
    'oi': 'Oi! Como posso ajudar você hoje?',
    'boa tarde': 'Boa tarde! Como posso ajudar você no Jetts hoje?',
    'bom dia': 'Bom dia! Pronto para navegar? Como posso ajudar?',
    'boa noite': 'Boa noite! Como posso ajudar você no Jetts?',
    'obrigado': 'De nada! Se precisar de mais alguma coisa, é só perguntar. 😊',
    'valeu': 'Sempre às ordens! Precisa de mais alguma coisa?',
    'tchau': 'Até logo! Tenha ótimas navegações! ⛵',
    'adeus': 'Até mais! Estarei aqui quando precisar! 🌊',

    // ================ CADASTRO E LOGIN ================
    'como criar conta': 'Para criar sua conta: 1) Clique em "Cadastrar" na tela inicial, 2) Preencha nome, email e senha, 3) Aceite os termos de uso, 4) Clique em "Criar Conta". Você também pode entrar com Google ou Apple.',
    'como fazer login': 'Na tela inicial, digite seu email e senha, ou use login social (Google/Apple). Marque "Lembrar de mim" para facilitar próximos acessos.',
    'esqueci minha senha': 'Na tela de login, clique em "Esqueci minha senha", digite seu email e siga as instruções que enviaremos.',
    'como alterar senha': 'Vá em "Perfil" > "Configurações" > "Alterar Senha" e digite sua senha atual e a nova.',
    'como sair do app': 'Acesse o menu "Perfil" e clique em "Sair" para deslogar da sua conta.',
    'não consigo entrar': 'Verifique se email e senha estão corretos. Se persistir, use "Esqueci minha senha" ou entre em contato conosco.',

    // ================ BUSCA E FILTROS ================
    'como buscar barco': 'Use a barra de busca na tela inicial para pesquisar por nome, localização ou tipo de barco. Você também pode usar busca por voz clicando no microfone.',
    'como usar filtros': 'Na tela de busca, ajuste: preço (R$ 500-5000), capacidade de pessoas, avaliação mínima, categorias (Luxo, Esporte, Família) e comodidades desejadas.',
    'busca por voz': 'Clique no ícone do microfone na barra de busca e fale o que procura. Ex: "barco de luxo no Rio de Janeiro".',
    'como filtrar por preço': 'Na busca, use o slider de preço para definir o range entre R$ 500 e R$ 5.000 por dia.',
    'como ver barcos próximos': 'O app usa sua localização para mostrar barcos próximos. Certifique-se que a localização está ativada.',
    'categorias de barco': 'Temos: Luxo (iates premium), Esporte (lanchas rápidas), Família (embarcações espaçosas), Romântico (ambiente íntimo), Econômico (opções em conta).',

    // ================ RESERVAS ================
    'como fazer reserva': 'Escolha o barco, selecione datas no calendário, número de pessoas, adicione observações e clique em "Reservar". Depois escolha forma de pagamento.',
    'como cancelar reserva': 'Acesse "Minhas Reservas", selecione a reserva e clique em "Cancelar". Veja a política de cancelamento antes.',
    'como ver minhas reservas': 'Na tela inicial, clique em "Minhas Reservas" ou acesse pelo menu principal.',
    'posso alterar data': 'Sim! Em "Minhas Reservas", clique na reserva e em "Alterar Data" (sujeito à disponibilidade e taxas).',
    'como ver histórico': 'Clique no ícone de "Histórico" na tela inicial ou vá em "Perfil" > "Histórico de Reservas".',
    'reserva está confirmada': 'Verifique em "Minhas Reservas". Reservas confirmadas aparecem em verde com status "Confirmada".',
    'não recebi confirmação': 'Verifique sua caixa de entrada e spam. Se não chegou, vá em "Minhas Reservas" para ver o status.',
    'posso levar animais': 'Depende do barco. Verifique na descrição se aceita pets ou pergunte ao proprietário no chat.',

    // ================ PAGAMENTOS ================
    'formas de pagamento': 'Aceitamos: Cartão de Crédito, Cartão de Débito e PIX. Pagamento é seguro e processado na hora.',
    'quais cartões aceitam': 'Aceitamos Visa, Mastercard, Elo, American Express e outros cartões nacionais e internacionais.',
    'como pagar com pix': 'Escolha PIX no pagamento, escaneie o QR Code ou copie a chave PIX. Pagamento é confirmado automaticamente.',
    'posso parcelar': 'Sim! Cartões de crédito podem ser parcelados em até 12x (consulte taxas do seu cartão).',
    'como dividir pagamento': 'Na tela de pagamento, clique em "Dividir Conta", adicione email dos amigos e defina valores. Cada um paga sua parte.',
    'taxa de serviço': 'Incluímos uma pequena taxa de serviço para manter a plataforma. O valor total já aparece antes do pagamento.',
    'posso usar cupom': 'Sim! Digite o código do cupom na tela de pagamento antes de finalizar.',
    'onde vejo cupons': 'Clique em "Promoções" na tela inicial para ver ofertas e cupons disponíveis.',

    // ================ BARCOS E DETALHES ================
    'tipos de barco': 'Temos: Iates de Luxo, Lanchas Esportivas, Veleiros, Catamarãs, Jet Skis, Barcos de Pesca e embarcações para eventos.',
    'o que inclui aluguel': 'Inclui: acesso ao barco, equipamentos básicos de segurança, combustível básico. Pode incluir tripulação (varia por barco).',
    'precisa de habilitação': 'Alguns barcos exigem habilitação náutica. Verificamos isso na reserva. Barcos com tripulação não exigem.',
    'capacidade máxima': 'Cada barco tem capacidade específica (2-20 pessoas). Veja nos detalhes do barco antes de reservar.',
    'tem churrasqueira': 'Muitos barcos têm churrasqueira! Use o filtro "Churrasqueira" na busca ou veja nas comodidades.',
    'tem bar a bordo': 'Barcos de luxo geralmente têm bar completo. Verifique nas comodidades ou pergunte ao proprietário.',
    'tem piscina': 'Iates maiores podem ter piscina ou jacuzzi. Use o filtro "Piscina" para encontrar essas opções.',
    'combustível incluso': 'Combustível básico está incluso. Para viagens longas, pode haver taxa extra (informada antes).',

    // ================ LOCALIZAÇÃO E MARINAS ================
    'onde tem barcos': 'Temos barcos em: Rio de Janeiro, São Paulo, Florianópolis, Salvador, Angra dos Reis, Búzios, Ilhabela e outras cidades litorâneas.',
    'marinas disponíveis': 'Trabalhamos com Marina da Glória (RJ), Marina Itajaí (SC), Marina Bahia (BA) e outras marinas certificadas.',
    'como chegar na marina': 'Enviamos a localização exata e instruções de acesso por email após confirmação da reserva.',
    'tem estacionamento': 'A maioria das marinas oferece estacionamento. Informamos na confirmação da reserva.',
    'endereço da marina': 'O endereço específico é enviado por email. Ex: Marina da Glória - Av. Infante Dom Henrique, s/n - Rio de Janeiro.',

    // ================ AVALIAÇÕES E REVIEWS ================
    'como avaliar barco': 'Após o passeio, acesse "Minhas Reservas", clique na reserva concluída e em "Avaliar" para dar nota e comentário.',
    'como ver avaliações': 'Na página do barco, role para baixo até a seção "Avaliações" para ver comentários de outros usuários.',
    'posso alterar avaliação': 'Sim, você pode editar sua avaliação por até 7 dias após publicá-la.',
    'não aparece para avaliar': 'A opção aparece apenas após a data do passeio. Se não apareceu, entre em contato conosco.',

    // ================ PERFIL E CONFIGURAÇÕES ================
    'como editar perfil': 'Acesse "Perfil" > "Editar Perfil" para atualizar nome, email, telefone e outras informações.',
    'como adicionar foto': 'No menu "Perfil", toque na sua foto de perfil para tirar nova foto ou escolher da galeria.',
    'como ativar notificações': 'Vá em "Perfil" > "Configurações" > "Notificações" e ative as que desejar receber.',
    'não recebo notificações': 'Verifique se estão ativadas nas configurações do app e do seu celular.',
    'como mudar localização': 'Em "Perfil" > "Configurações" > "Localização" ou use o seletor de localização na tela inicial.',
    'como ativar modo escuro': 'Vá em "Perfil" > "Configurações" > "Aparência" e escolha "Modo Escuro".',

    // ================ FAVORITOS ================
    'como favoritar barco': 'Na página do barco, clique no ícone de coração para adicionar aos favoritos.',
    'onde ver favoritos': 'Clique na aba "Favoritos" no menu inferior ou acesse pelo menu principal.',
    'como remover favorito': 'Em "Favoritos", clique no coração preenchido para remover da lista.',

    // ================ CLIMA E SEGURANÇA ================
    'informações do clima': 'Mostramos clima atual e previsão na tela inicial para ajudar no planejamento do passeio.',
    'passeio com chuva': 'Recomendamos reagendar em caso de tempestade. Para chuva leve, muitos barcos têm cobertura.',
    'equipamentos segurança': 'Todos os barcos incluem: coletes salva-vidas, kit primeiros socorros, sinalizadores e rádio de emergência.',
    'seguro incluso': 'Oferecemos seguro básico. Na reserva, você pode contratar seguro adicional para maior cobertura.',

    // ================ CHAT E SUPORTE ================
    'como falar proprietário': 'Na página do barco, clique em "Conversar" para abrir chat direto com o proprietário.',
    'chat não funciona': 'Verifique sua conexão. Se persistir, reinicie o app ou entre em contato pelo suporte.',
    'como entrar em contato': 'Use este chat de suporte, email suporte@jetts.com ou telefone (21) 99999-9999.',
    'horário de atendimento': 'Suporte funciona 24/7. Proprietários respondem conforme disponibilidade.',

    // ================ PROMOÇÕES E OFERTAS ================
    'como ver promoções': 'Clique em "Promoções" na tela inicial para ver ofertas especiais, cupons e descontos.',
    'quando tem desconto': 'Oferecemos descontos sazonais, early bird (reserva antecipada) e para usuários frequentes.',
    'programa fidelidade': 'A cada 5 reservas, você ganha 10% de desconto na próxima. Acompanhe em "Perfil" > "Recompensas".',
    'desconto primeira reserva': 'Novos usuários ganham 15% de desconto na primeira reserva! Use o cupom BEM-VINDO.',

    // ================ PROBLEMAS TÉCNICOS ================
    'app não abre': 'Tente fechar e abrir novamente. Se persistir, reinicie o celular ou reinstale o app.',
    'app está lento': 'Verifique sua conexão com internet. Feche outros apps para liberar memória.',
    'não consigo fazer pagamento': 'Verifique dados do cartão e limite. Para PIX, confirme se escaneou o QR Code corretamente.',
    'fotos não carregam': 'Problemas de conexão podem afetar carregamento. Tente novamente com Wi-Fi.',
    'busca não funciona': 'Verifique se permitiu acesso à localização. Tente buscar por cidade específica.',

    // ================ POLÍTICAS E TERMOS ================
    'política cancelamento': 'Cancelamento gratuito até 24h antes. Entre 24h-12h: 50% de taxa. Menos de 12h: 100% de taxa.',
    'política reembolso': 'Reembolso processado em 5-7 dias úteis no mesmo método de pagamento original.',
    'termos de uso': 'Acesse "Perfil" > "Termos de Uso" para ler todas as condições de uso da plataforma.',
    'política privacidade': 'Seus dados são protegidos conforme LGPD. Veja em "Perfil" > "Política de Privacidade".',
    'idade mínima': 'Usuários menores de 18 anos precisam de autorização dos responsáveis para usar o app.',

    // ================ MODO PROPRIETÁRIO ================
    'como ser proprietário': 'Clique em "Seja um Proprietário" no menu ou cadastre seu barco em "Perfil" > "Meus Barcos".',
    'como cadastrar barco': 'No modo proprietário: clique em "Adicionar Barco", preencha informações, adicione fotos e defina preços.',
    'como aprovar reservas': 'No painel do proprietário, vá em "Reservas Pendentes" e clique em "Aprovar" ou "Recusar".',
    'taxa do proprietário': 'Cobramos 15% de comissão sobre cada reserva confirmada (já incluída no preço mostrado).',
    'como receber pagamentos': 'Pagamentos são transferidos para sua conta bancária em até 2 dias úteis após o check-in.',

    // ================ RECURSOS ESPECIAIS ================
    'busca por voz': 'Clique no microfone e diga o que procura: "quero um iate de luxo no Rio de Janeiro para 8 pessoas".',
    'compartilhar barco': 'Na página do barco, clique em "Compartilhar" para enviar por WhatsApp, Instagram ou copiar link.',
    'lista desejos': 'Salve barcos em "Favoritos" para criar sua lista de desejos e acompanhar mudanças de preço.',
    'reservas grupos': 'Para grupos grandes (+15 pessoas), entre em contato para cotação especial e descontos.',

    // ================ COMODIDADES ESPECÍFICAS ================
    'tem wifi': 'Muitos barcos modernos oferecem Wi-Fi. Verifique na lista de comodidades de cada embarcação.',
    'tem som': 'A maioria tem sistema de som. Você pode conectar via Bluetooth ou levar playlist no pendrive.',
    'tem geladeira': 'Barcos maiores têm geladeira/frigobar. Perfeito para manter bebidas e comidas geladas.',
    'tem banheiro': 'Embarcações acima de 20 pés geralmente têm banheiro completo. Veja nas especificações.',
    'tem cozinha': 'Iates e catamarãs têm cozinha equipada. Ótimo para preparar refeições a bordo.',
    'tem deck': 'Todos têm área de deck para relaxar. Alguns têm deck superior com vista panorâmica.',

    // ================ CASOS DE USO ESPECÍFICOS ================
    'festa aniversário': 'Temos barcos ideais para festas! Procure por "Eventos" ou barcos com deck amplo e som.',
    'lua de mel': 'Para românticos: busque por categoria "Romântico" ou iates com jacuzzi e jantar a bordo.',
    'pesca esportiva': 'Temos barcos específicos para pesca com equipamentos inclusos. Use filtro "Pesca".',
    'evento corporativo': 'Para empresas, oferecemos pacotes especiais com catering e apresentação. Entre em contato.',
    'casamento': 'Realizamos cerimônias a bordo! Entre em contato para pacotes especiais de casamento.',

    // ================ DICAS E ORIENTAÇÕES ================
    'o que levar': 'Leve: protetor solar, óculos escuros, toalha, roupas confortáveis, água e lanches.',
    'melhor horário': 'Manhã (8h-12h) e tarde (14h-18h) são ideais. Pôr do sol (17h-19h) é mágico!',
    'documentos necessários': 'Leve RG ou CNH. Para estrangeiros: passaporte. Menores: autorização dos pais.',
    'pode beber': 'Consumo responsável é permitido. Proprietário define regras específicas do barco.',
    'pode fumar': 'Política varia por barco. Muitos permitem apenas em deck aberto. Verifique com proprietário.',

    // ================ EMERGÊNCIAS ================
    'emergência no mar': 'Todos os barcos têm rádio de emergência. Ligue 185 (Marinha) ou use o botão SOS do app.',
    'acidente no barco': 'Acione o proprietário imediatamente e ligue 192 (SAMU) se houver feridos.',
    'barco quebrou': 'Entre em contato com proprietário pelo chat. Há seguro para reboque e assistência.',
    'me perdi': 'Use o GPS do app ou ligue para o proprietário. Todos os barcos têm localização em tempo real.',

    // ================ FEEDBACK E SUGESTÕES ================
    'como dar sugestão': 'Adoramos feedback! Use "Perfil" > "Sugerir Melhoria" ou fale conosco pelo chat.',
    'reportar problema': 'Para reportar bugs ou problemas, use "Perfil" > "Reportar Problema" com detalhes.',
    'como avaliar app': 'Avalie-nos na App Store/Google Play! Sua opinião ajuda a melhorar para todos.',

    // ================ RECURSOS FUTUROS ================
    'novidades app': 'Acompanhe em "Perfil" > "Novidades" ou ative notificações para saber das atualizações.',
    'quando nova cidade': 'Expandimos constantemente! Cadastre-se na lista de espera para sua cidade.',

    // ================ FALLBACK E AJUDA GERAL ================
    'não entendi': 'Desculpe, não entendi sua pergunta. Pode reformular ou escolher um tópico: Reservas, Pagamentos, Barcos, Perfil ou Suporte.',
    'ajuda': 'Posso ajudar com: Fazer Reservas, Pagamentos, Encontrar Barcos, Configurar Perfil, Dúvidas sobre o App. O que você precisa?',
    'como funciona app': 'O Jetts conecta você aos melhores barcos do Brasil! Busque, reserve, pague e aproveite. Tudo pelo app de forma segura e fácil.',
    'app confiável': 'Sim! Somos certificados, com pagamento seguro, seguro incluído e suporte 24/7. Milhares de navegadores felizes!',
    'outras dúvidas': 'Se sua dúvida não foi esclarecida, fale comigo! Estou aqui para ajudar com tudo sobre o Jetts. 🚢',
  };

  @override
  void initState() {
    super.initState();
    // Mensagem de saudação automática
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _messages.add(_ChatMessage(
            'bot',
            'Olá! 👋 Eu sou o assistente virtual da Jetts. Posso te ajudar com dúvidas sobre cadastro, reservas, pagamentos, promoções e mais! É só perguntar. 😊',
            TimeOfDay.now().format(context)));
      });
    });
  }

  void _sendMessage() {
    String text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages
          .add(_ChatMessage('user', text, TimeOfDay.now().format(context)));
      _controller.clear();
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      String lower = text.toLowerCase();
      String? botText;
      for (final key in chatbotKnowledgeBase.keys) {
        if (lower.contains(key)) {
          botText = chatbotKnowledgeBase[key];
          break;
        }
      }
      botText ??= chatbotKnowledgeBase['não entendi'] ?? 'Desculpe, não entendi sua pergunta. Pode reformular ou escolher um tópico: Reservas, Pagamentos, Barcos, Perfil ou Suporte.';
      setState(() {
        _messages.add(
            _ChatMessage('bot', botText!, TimeOfDay.now().format(context)));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6C7AE0),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: _buildHeader(),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg.type == 'user';
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 14),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color:
                          isUser ? AppColors.primaryBlue500 : Colors.grey[100],
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20),
                        bottomLeft: Radius.circular(isUser ? 20 : 4),
                        bottomRight: Radius.circular(isUser ? 4 : 20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          msg.text,
                          style: TextStyle(
                            color: isUser ? Colors.white : Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            msg.time,
                            style: TextStyle(
                              color: isUser ? Colors.white70 : Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return AppBar(
      backgroundColor: const Color(0xFF6C7AE0),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.2),
            radius: 22,
            child:
                const Icon(Icons.support_agent, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Suporte',
                  style: AppTypography.titleMedium.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  const Icon(Icons.circle, color: Colors.green, size: 10),
                  const SizedBox(width: 4),
                  Text('Online',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.85), fontSize: 13)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.add, color: AppColors.primaryBlue500),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Mensagem',
                border: InputBorder.none,
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryBlue500,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_upward_rounded, color: Colors.white),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final String type; // 'user' ou 'bot'
  final String text;
  final String time;
  _ChatMessage(this.type, this.text, this.time);
}
