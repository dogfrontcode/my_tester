#!/bin/bash

print_section "PIPES"

# Pipes simples
echo -e "\n${YELLOW}Testing simple pipes:${NC}"
run_test "Pipe simples" "echo hello | cat" ""
run_test "Pipe com grep" "echo -e 'hello\nworld' | grep hello" ""
run_test "Pipe com wc" "echo hello world | wc -w" ""
run_test "Pipe preserva status de saída" "ls | grep arquivo_inexistente ; echo \$?" ""

# Múltiplos pipes
echo -e "\n${YELLOW}Testing multiple pipes:${NC}"
run_test "Dois pipes" "echo hello | cat | cat" ""
run_test "Três pipes" "echo hello world | cat | grep hello | cat" ""
run_test "Quatro pipes" "echo -e 'a\nb\nc' | grep -v b | cat | wc -l" ""
run_test "Muitos pipes" "echo test | cat | cat | cat | cat | cat" ""

# Pipes com builtins
echo -e "\n${YELLOW}Testing pipes with builtins:${NC}"
run_test "Pipe com echo" "echo hello | grep hello" ""
run_test "Pipe de env" "env | grep PATH | head -1" ""
run_test "Pipe para builtin não faz sentido" "ls | cd" ""

# Pipes com redirecionamentos
echo -e "\n${YELLOW}Testing pipes with redirections:${NC}"
run_test "Pipe com output redirect" "echo hello | cat > /dev/null && echo ok" ""
run_test "Pipe com input redirect" "cat < /etc/passwd | head -1" ""
run_test "Pipe complexo" "< /etc/passwd grep root | head -1 > /dev/null && echo found" ""

# Edge cases
echo -e "\n${YELLOW}Testing pipe edge cases:${NC}"
run_test "Pipe no início" "| echo hello" ""
run_test "Pipe no final" "echo hello |" ""
run_test "Pipes consecutivos" "echo hello || cat" ""
run_test "Espaços ao redor do pipe" "echo hello    |    cat" ""
run_test "Comando inexistente no pipe" "echo hello | comando_nao_existe" ""
run_test "Pipe vazio no meio" "echo hello | | cat" ""

# Pipes com muitos dados
echo -e "\n${YELLOW}Testing pipes with large data:${NC}"
run_test "Pipe com muito output" "seq 1 1000 | tail -5" ""
run_test "Pipe chain com filtros" "seq 1 100 | grep 5 | wc -l" ""

# Comportamento de buffering
echo -e "\n${YELLOW}Testing pipe behavior:${NC}"
run_test "Pipe preserva ordem" "echo -e '1\n2\n3' | cat" ""
run_test "Pipe com comando lento" "echo fast | sleep 0.1 && echo done" ""
