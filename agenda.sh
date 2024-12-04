#!/bin/bash

# Arquivo que armazenará os eventos
AGENDA_FILE="agenda.txt"

# Verifica se o arquivo existe, caso contrário cria
if [ ! -f "$AGENDA_FILE" ]; then
    touch "$AGENDA_FILE"
fi

# Função para marcar um evento
marcar_evento() {
    titulo=$(dialog --inputbox "Digite o título do evento:" 10 50 3>&1 1>&2 2>&3 3>&-)
    descricao=$(dialog --inputbox "Digite a descrição do evento:" 10 50 3>&1 1>&2 2>&3 3>&-)
    data=$(dialog --inputbox "Digite a data do evento (YYYY-MM-DD HH:MM):" 10 50 3>&1 1>&2 2>&3 3>&-)

    if [ -n "$titulo" ] && [ -n "$descricao" ] && [ -n "$data" ]; then
        echo "$data|$titulo|$descricao" >> "$AGENDA_FILE"
        dialog --msgbox "Evento marcado com sucesso!" 6 50
    else
        dialog --msgbox "Todos os campos são obrigatórios!" 6 40
    fi
}

# Função para listar todos os eventos
listar_eventos() {
    if [ ! -s "$AGENDA_FILE" ]; then
        dialog --msgbox "Nenhum evento cadastrado!" 6 40
        return
    fi

    # Ordena os eventos pelo campo de data
    eventos=$(sort "$AGENDA_FILE" | awk -F'|' '{printf "- [%s] %s\n", $1, $2}')
    dialog --msgbox "$eventos" 20 70
}

# Função para mostrar eventos do dia e notificar 5 minutos antes do evento
eventos_do_dia() {
    hoje=$(date +%Y-%m-%d)
    agora=$(date +%H:%M)

    eventos=$(grep "^$hoje" "$AGENDA_FILE" | sort)

    if [ -z "$eventos" ]; then
        dialog --msgbox "Nenhum evento para hoje." 6 40
    else
        # Verifica cada evento para notificar 5 minutos antes
        while IFS="|" read -r data titulo descricao; do
            evento_hora=$(echo $data | cut -d' ' -f2)
            evento_data=$(echo $data | cut -d' ' -f1)

            # Verifica se o evento é daqui a 5 minutos
            evento_timestamp=$(date -d "$data" +%s)
            agora_timestamp=$(date +%s)
            diferenca=$((evento_timestamp - agora_timestamp))

            # Se o evento for em 5 minutos
            if [ "$diferenca" -le 300 ] && [ "$diferenca" -ge 0 ]; then
                dialog --msgbox "Lembrete: O evento '$titulo' acontecerá em 5 minutos! Descrição: $descricao" 6 50
            fi
        done <<< "$eventos"

        # Exibe todos os eventos do dia
        notificacoes=$(echo "$eventos" | awk -F'|' '{printf "- %s: %s\n\n", $2, $3}')
        dialog --msgbox "Eventos do dia:\n\n$notificacoes" 20 70
    fi
}

# Função para excluir um evento
excluir_evento() {
    if [ ! -s "$AGENDA_FILE" ]; then
        dialog --msgbox "Nenhum evento cadastrado!" 6 40
        return
    fi

    # Ordena e exibe os eventos com numeração
    eventos=$(sort "$AGENDA_FILE" | awk -F'|' '{printf "%d - [%s] %s\n", NR, $1, $2}')
    numero=$(dialog --inputbox "Eventos cadastrados:\n\n$eventos\n\nDigite o número do evento que deseja excluir:" 20 70 3>&1 1>&2 2>&3 3>&-)

    if [[ "$numero" =~ ^[0-9]+$ ]]; then
        # Exclui a linha correspondente ao número informado
        sed -i "${numero}d" "$AGENDA_FILE"
        dialog --msgbox "Evento excluído com sucesso!" 6 40
    else
        dialog --msgbox "Número inválido!" 6 40
    fi
}

# Função para exportar a agenda
exportar_agenda() {
    arquivo_exportacao=$(dialog --inputbox "Digite o nome do arquivo para exportar (ex: agenda_export.csv):" 10 50 3>&1 1>&2 2>&3 3>&-)
    
    if [ -n "$arquivo_exportacao" ]; then
        # Verifica se há eventos para exportar
        if [ ! -s "$AGENDA_FILE" ]; then
            dialog --msgbox "Nenhum evento para exportar!" 6 40
            return
        fi

        # Formata os eventos como CSV
        echo "Data,Título,Descrição" > "$arquivo_exportacao"
        awk -F'|' '{printf "%s,%s,%s\n", $1, $2, $3}' "$AGENDA_FILE" >> "$arquivo_exportacao"

        dialog --msgbox "Agenda exportada para o arquivo: $arquivo_exportacao" 6 50
    else
        dialog --msgbox "Nenhum nome de arquivo foi informado!" 6 40
    fi
}


# Função para exibir os detalhes de um evento
exibir_detalhe_evento() {
    if [ ! -s "$AGENDA_FILE" ]; then
        dialog --msgbox "Nenhum evento cadastrado!" 6 40
        return
    fi

    # Ordena e exibe os eventos com numeração
    eventos=$(sort "$AGENDA_FILE" | awk -F'|' '{printf "%d - [%s] %s\n", NR, $1, $2}')
    numero=$(dialog --inputbox "Eventos cadastrados:\n\n$eventos\n\nDigite o número do evento para exibir os detalhes:" 20 70 3>&1 1>&2 2>&3 3>&-)

    if [[ "$numero" =~ ^[0-9]+$ ]]; then
        # Exibe os detalhes do evento selecionado
        evento=$(sed -n "${numero}p" "$AGENDA_FILE")
        data=$(echo $evento | cut -d'|' -f1)
        titulo=$(echo $evento | cut -d'|' -f2)
        descricao=$(echo $evento | cut -d'|' -f3)

        dialog --msgbox "Detalhes do Evento:\n\nData: $data\nTítulo: $titulo\nDescrição: $descricao" 20 70
    else
        dialog --msgbox "Número inválido!" 6 40
    fi
}

while true; do
    opcao=$(dialog --menu "Menu de Agenda:" 15 50 8 \
        1 "Marcar evento" \
        2 "Listar todos os eventos" \
        3 "Eventos do dia" \
        4 "Excluir evento" \
        5 "Exibir detalhes do evento" \
        6 "Exportar agenda" \
        7 "Sair" 3>&1 1>&2 2>&3 3>&-)

    case $opcao in
        1) marcar_evento ;;
        2) listar_eventos ;;
        3) eventos_do_dia ;;
        4) excluir_evento ;;
        5) exibir_detalhe_evento ;;
        6) exportar_agenda ;;
        7) break ;;
        *) dialog --msgbox "Opção inválida!" 6 40 ;;
    esac
done

dialog --msgbox "Saindo..." 6 40
clear
