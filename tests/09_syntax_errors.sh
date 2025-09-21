#!/bin/bash

print_section "ERROS DE SINTAXE E CASOS EXTREMOS"

# Sintaxe inválida
echo -e "\n${YELLOW}Testing syntax errors:${NC}"
run_test "Pipe no início" "| echo hello" ""
run_test "Pipe no final" "echo hello |" ""
run_test "Pipe duplo" "echo hello || echo world" ""
run_test "Redirecionamento sem arquivo" "echo hello >" ""
run_test "Redirecionamento múltiplo mesmo arquivo" "echo test > file > file" ""
run_test "Input de arquivo inexistente" "cat < arquivo_que_nao_existe" ""

# Comandos vazios
echo -e "\n${YELLOW}Testing empty commands:${NC}"
run_test "Comando totalmente vazio" "" ""
run_test "Apenas espaços" "   " ""
run_test "Apenas tabs" "		" ""
run_test "Pipe com comando vazio" "| echo hello" ""
run_test "Comando vazio com pipe" "echo hello | " ""

# Caracteres especiais
echo -e "\n${YELLOW}Testing special characters:${NC}"
run_test "Comando com ;" "echo hello ; echo world" ""
run_test "Comando com &" "echo hello & echo world" ""
run_test "Comando com \$\$" 'echo $$' ""
run_test "Comando com ~" "echo ~" ""
run_test "Comando com *" "echo *" ""

# Limites
echo -e "\n${YELLOW}Testing limits:${NC}"
run_test "Comando muito longo" "echo $(printf 'a%.0s' {1..1000})" ""
run_test "Muitos argumentos" "echo $(seq 1 100)" ""
run_test "Path muito longo" "echo /$(printf 'dir/%.0s' {1..100})file" ""
run_test "Muitos pipes" "echo test | cat | cat | cat | cat | cat | cat | cat | cat | cat" ""

# Combinações estranhas
echo -e "\n${YELLOW}Testing weird combinations:${NC}"
run_test "Múltiplos espaços entre comandos" "echo    hello    |    cat" ""
run_test "Tabs e espaços misturados" "echo	  hello  	world" ""
run_test "Quotes não fechadas (deve dar erro)" "echo 'hello" ""
run_test "Quotes mistas não fechadas" "echo \"hello'" ""
run_test "Escape no final" "echo hello\\" ""

# Casos de PATH
echo -e "\n${YELLOW}Testing PATH behavior:${NC}"
run_test "Comando com ./" "./minishell -c 'exit' 2>/dev/null || echo 'no -c flag'" ""
run_test "Comando com caminho absoluto" "/bin/echo test" ""
run_test "Comando sem PATH" "PATH= echo 'will this work?'" ""
run_test "PATH vazio" "PATH='' /bin/echo 'explicit path'" ""

# Memory leaks check (manual)
echo -e "\n${YELLOW}Para verificar memory leaks, execute manualmente:${NC}"
echo "valgrind --leak-check=full --show-leak-kinds=all ./minishell"
echo "E teste vários comandos antes de sair com 'exit'"
