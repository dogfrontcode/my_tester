#!/bin/bash

print_section "QUOTES (ASPAS SIMPLES E DUPLAS)"

# Aspas duplas
echo -e "\n${YELLOW}Testing double quotes:${NC}"
run_test "Aspas duplas simples" 'echo "hello world"' ""
run_test "Aspas duplas com espaços" 'echo "hello     world"' ""
run_test "Aspas duplas vazias" 'echo ""' ""
run_test "Aspas duplas com variável" 'export QUOTE_TEST=42 && echo "value is $QUOTE_TEST"' ""
run_test "Aspas duplas com \$HOME" 'echo "$HOME"' ""
run_test "Aspas duplas com \$?" 'ls > /dev/null && echo "exit code: $?"' ""
run_test "Aspas duplas com caracteres especiais" 'echo "< > | & ; ( )"' ""
run_test "Aspas duplas não fechadas" 'echo "hello' ""

# Aspas simples
echo -e "\n${YELLOW}Testing single quotes:${NC}"
run_test "Aspas simples básicas" "echo 'hello world'" ""
run_test "Aspas simples com \$" "echo '\$HOME'" ""
run_test "Aspas simples protegem variáveis" "export VAR=42 && echo '\$VAR'" ""
run_test "Aspas simples com caracteres especiais" "echo '< > | & ; ( )'" ""
run_test "Aspas simples com aspas duplas dentro" "echo '\"hello\"'" ""
run_test "Aspas simples não fechadas" "echo 'hello" ""

# Combinações de aspas
echo -e "\n${YELLOW}Testing quote combinations:${NC}"
run_test "Mistura de aspas 1" 'echo "hello" world' ""
run_test "Mistura de aspas 2" "echo 'hello' world" ""
run_test "Mistura de aspas 3" 'echo "hello" "world"' ""
run_test "Mistura de aspas 4" "echo 'hello' 'world'" ""
run_test "Aspas dentro de aspas 1" 'echo "hello '"'"'world'"'"'"' ""
run_test "Aspas dentro de aspas 2" "echo 'hello \"\$USER\"'" ""
run_test "Múltiplas aspas" 'echo "a" "b" "c" "d"' ""

# Edge cases
echo -e "\n${YELLOW}Testing quote edge cases:${NC}"
run_test "Apenas aspas duplas" 'echo " "' ""
run_test "Apenas aspas simples" "echo ' '" ""
run_test "Aspas no meio do argumento" 'echo hel"lo wo"rld' ""
run_test "Aspas simples no meio" "echo hel'lo wo'rld" ""
run_test "Expansão parcial" 'echo "$USER"test' ""
run_test "Sem expansão parcial" "echo '\$USER'test" ""
