#!/bin/bash

print_section "BONUS - OPERADORES LÓGICOS E EXTRAS"

# && (AND)
echo -e "\n${YELLOW}Testing && operator:${NC}"
run_test "AND simples - sucesso" "true && echo success" ""
run_test "AND simples - falha" "false && echo not_printed" ""
run_test "AND múltiplo" "true && true && echo all_good" ""
run_test "AND para na primeira falha" "true && false && echo not_printed" ""
run_test "AND com comandos reais" "ls > /dev/null && echo 'ls worked'" ""
run_test "AND com comando inexistente" "nao_existe 2>/dev/null && echo not_printed" ""

# || (OR)
echo -e "\n${YELLOW}Testing || operator:${NC}"
run_test "OR simples - sucesso" "true || echo not_printed" ""
run_test "OR simples - falha" "false || echo printed" ""
run_test "OR múltiplo" "false || false || echo finally" ""
run_test "OR para no primeiro sucesso" "false || true || echo not_printed" ""
run_test "OR com comandos reais" "ls /nao_existe 2>/dev/null || echo 'fallback'" ""

# Combinações && e ||
echo -e "\n${YELLOW}Testing && and || combinations:${NC}"
run_test "AND então OR" "true && echo yes || echo no" ""
run_test "AND falha então OR" "false && echo yes || echo no" ""
run_test "Cadeia complexa" "true && false || true && echo complex" ""
run_test "Precedência" "false || echo first && echo second" ""

# Parênteses (se implementado)
echo -e "\n${YELLOW}Testing parentheses (if implemented):${NC}"
run_test "Parênteses simples" "(echo hello)" ""
run_test "Parênteses com AND" "(true && echo yes)" ""
run_test "Parênteses com OR" "(false || echo yes)" ""
run_test "Parênteses aninhados" "((echo nested))" ""
run_test "Parênteses mudando precedência" "false && (echo not_printed || echo also_not)" ""

# Wildcards * (se implementado)
echo -e "\n${YELLOW}Testing wildcards (if implemented):${NC}"
# Criar arquivos de teste
touch $TEMP_DIR/test1.txt $TEMP_DIR/test2.txt $TEMP_DIR/other.log
run_test "Wildcard simples" "echo *.txt" ""
run_test "Wildcard no meio" "echo test*.txt" ""
run_test "Wildcard múltiplo" "echo *.txt *.log" ""
run_test "Wildcard sem match" "echo *.nonexistent" ""
run_test "Wildcard em quotes" "echo '*.txt'" ""
rm -f $TEMP_DIR/*.txt $TEMP_DIR/*.log

# Exit status com operadores
echo -e "\n${YELLOW}Testing exit status with operators:${NC}"
run_test "Exit status após AND sucesso" "true && true ; echo \$?" ""
run_test "Exit status após AND falha" "true && false ; echo \$?" ""
run_test "Exit status após OR sucesso" "false || true ; echo \$?" ""
run_test "Exit status após OR falha" "false || false ; echo \$?" ""

# Edge cases
echo -e "\n${YELLOW}Testing operator edge cases:${NC}"
run_test "Operador no início" "&& echo hello" ""
run_test "Operador no final" "echo hello &&" ""
run_test "Operadores consecutivos" "echo hello && && echo world" ""
run_test "Mix com pipes" "echo hello | cat && echo piped" ""
run_test "Mix com redirecionamento" "echo hello > /dev/null && echo redirected" ""
