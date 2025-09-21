#!/bin/bash

print_section "SINAIS (TESTES MANUAIS)"

echo -e "${YELLOW}Os testes de sinais devem ser feitos manualmente:${NC}\n"

echo -e "${CYAN}1. Ctrl-C (SIGINT) em prompt vazio:${NC}"
echo "   - Execute ./minishell"
echo "   - Pressione Ctrl-C"
echo "   - Deve mostrar novo prompt na linha seguinte"
echo "   - echo \$? deve retornar 130"

echo -e "\n${CYAN}2. Ctrl-C durante comando:${NC}"
echo "   - Execute: sleep 10"
echo "   - Pressione Ctrl-C"
echo "   - Comando deve ser interrompido"
echo "   - echo \$? deve retornar 130"

echo -e "\n${CYAN}3. Ctrl-\\ (SIGQUIT) em prompt vazio:${NC}"
echo "   - Execute ./minishell"
echo "   - Pressione Ctrl-\\"
echo "   - Nada deve acontecer"

echo -e "\n${CYAN}4. Ctrl-\\ durante comando:${NC}"
echo "   - Execute: sleep 10"
echo "   - Pressione Ctrl-\\"
echo "   - Deve mostrar 'Quit: 3' e interromper comando"
echo "   - echo \$? deve retornar 131"

echo -e "\n${CYAN}5. Ctrl-D (EOF) em prompt vazio:${NC}"
echo "   - Execute ./minishell"
echo "   - Pressione Ctrl-D"
echo "   - Deve sair do shell mostrando 'exit'"

echo -e "\n${CYAN}6. Ctrl-D com input parcial:${NC}"
echo "   - Digite: echo hello (sem pressionar Enter)"
echo "   - Pressione Ctrl-D"
echo "   - Nada deve acontecer"

echo -e "\n${CYAN}7. Sinais em heredoc:${NC}"
echo "   - Execute: cat << EOF"
echo "   - Pressione Ctrl-C"
echo "   - Deve cancelar o heredoc e voltar ao prompt"

echo -e "\n${CYAN}8. Sinais em pipes:${NC}"
echo "   - Execute: sleep 10 | sleep 10"
echo "   - Pressione Ctrl-C"
echo "   - Ambos processos devem ser interrompidos"

echo -e "\n${CYAN}9. Sinais com processos em background (se implementado):${NC}"
echo "   - Execute: sleep 100 &"
echo "   - Pressione Ctrl-C"
echo "   - Apenas o prompt deve ser afetado, não o processo em background"

echo -e "\n${GREEN}Para testar automaticamente alguns comportamentos básicos:${NC}"

# Teste básico de exit status após sinal simulado
run_test "Exit status após comando inexistente" "comando_nao_existe 2>/dev/null ; echo \$?" ""
run_test "Exit status após false" "false ; echo \$?" ""
run_test "Exit status após true" "true ; echo \$?" ""
