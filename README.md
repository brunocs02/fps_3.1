# Agenda Interativa em Shell Script

Bem-vindo ao repositório **Agenda Interativa**, um projeto em Shell Script para gerenciar eventos de forma simples e eficiente diretamente pelo terminal, utilizando a biblioteca `dialog` para criar interfaces interativas.

---

## 💡 Ideia do Produto

A **Agenda Interativa** é uma ferramenta para agendamento e gerenciamento de eventos no formato texto, com notificações para alertar eventos futuros. Seu foco é oferecer uma solução prática e funcional para usuários que preferem ferramentas minimalistas e utilizam frequentemente o terminal.

---

## 🛠 Problema Resolvido

O projeto resolve a necessidade de:

- Gerenciar eventos em sistemas que não possuem interfaces gráficas completas.
- Receber notificações de eventos iminentes (5 minutos antes do horário marcado).
- Exportar a lista de eventos em formato CSV para visualização ou compartilhamento.
- Listar, visualizar detalhes e excluir eventos de forma interativa.

Ideal para desenvolvedores, estudantes e administradores de sistemas que valorizam agilidade e simplicidade.

---

## 🔧 Ferramentas Utilizadas

- **Shell Script**: A base do projeto, garantindo compatibilidade com sistemas Unix/Linux.
- **`dialog`**: Biblioteca para interfaces interativas em terminal.
- **Ferramentas de sistema**: `awk`, `grep`, `sed` e `date` para manipulação de texto e datas.

---

## 🚀 Funcionalidades

- **Adicionar eventos**: Título, descrição e data/hora.
- **Listar eventos**: Exibição interativa e ordenada por data.
- **Notificações**: Alertas 5 minutos antes de eventos do dia.
- **Excluir eventos**: Remoção interativa com numeração.
- **Exportar eventos**: Geração de arquivo CSV.
- **Visualizar detalhes de eventos**: Detalhamento de eventos cadastrados.

---

## 📂 Estrutura do Repositório

- `agenda.sh`: Script principal com toda a lógica do programa.
- `agenda.txt`: Arquivo gerado dinamicamente para armazenar os eventos.
- `README.md`: Documentação do projeto.

---

## 🌐 Link do Repositório

[Repositório no GitHub](https://github.com/seu-usuario/agenda-interativa)

---

## 📝 Como Usar

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/agenda-interativa.git
   cd agenda-interativa

2. Dê permissão de execução ao script:
    ```bash
    chmod +x agenda.sh
3. Execute o script:
    ```bash
    ./agenda.sh
##⚡ Requisitos
- Sistema operacional Linux ou macOS.
- Ferramentas padrão do Unix (awk, sed, grep, date).
- Biblioteca dialog instalada:
      ```bash
      sudo apt install dialog # Debian/Ubuntu
      sudo yum install dialog # Red Hat/CentOS
      brew install dialog     # macOS (via Homebrew)
## 🔗 Próximos Passos
- Implementar suporte a notificações integradas ao sistema operacional.
- Criar suporte para múltiplas agendas.
- Desenvolver interface web ou mobile para sincronização com o terminal.
## 🤝 Contribua
Contribuições são bem-vindas! Siga os passos abaixo para colaborar:

- Faça um fork do repositório.
- Crie uma branch para suas alterações
- Commit suas mudanças
- Envie as alterações
- Abra um Pull Request.
