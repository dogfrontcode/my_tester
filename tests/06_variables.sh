#!/bin/bash

print_section "VARIÁVEIS E EXPANSÃO"

# Expansão básica
echo -e "\n${YELLOW}Testing basic variable expansion:${NC}"
run_test "Expansão de HOME" 'echo $HOME' ""
run_test "Expansão de PATH" 'echo $PATH | grep -q : && echo "PATH ok"' ""
run_test "Expansão de USER" 'echo $USER' ""
run_test "Expansão de PWD" 'echo $PWD' ""

# Variáveis customizadas
echo -e "\n${YELLOW}Testing custom variables:${NC}"
run_test "Criar e expandir variável" 'export TEST=hello && echo $TEST' ""
run_test "Variável com espaços" 'export MSG="hello world" && echo $MSG' ""
run_test "Variável com números" 'export NUM=42 && echo $NUM' ""
run_test "Variável vazia" 'export EMPTY= && echo "$EMPTY"end' ""
run_test "Variável não definida" 'echo $UNDEFINED_VAR' ""

# $? (exit status)
echo -e "\n${YELLOW}Testing \$? (exit status):${NC}"
run_test "Exit status sucesso" 'ls > /dev/null && echo $?' ""
run_test "Exit status falha" 'ls /nao_existe 2>/dev/null ; echo $?' ""
run_test "Exit status após builtin" 'cd . && echo $?' ""
run_test "Exit status após pipe" 'echo hello | grep hello > /dev/null && echo $?' ""
run_test "Exit status preservado" 'false ; echo $? ; echo $?' ""

# Expansão em diferentes contextos
echo -e "\n${YELLOW}Testing expansion contexts:${NC}"
run_test "Expansão em aspas duplas" 'export VAR=test && echo "$VAR"' ""
run_test "Sem expansão em aspas simples" "export VAR=test && echo '\$VAR'" ""
run_test "Expansão parcial" 'export NAME=user && echo my$NAME' ""
run_test "Múltiplas expansões" 'export A=1 B=2 && echo $A$B' ""
run_test "Expansão com texto" 'export VAR=hello && echo ${VAR}world' ""

# Edge cases
echo -e "\n${YELLOW}Testing variable edge cases:${NC}"
run_test "Variável com $ no valor" 'export DOLLAR="$100" && echo $DOLLAR' ""
run_test "Variável com = no valor" 'export EQ="a=b" && echo $EQ' ""
run_test "$ sozinho" 'echo $' ""
run_test "$ no final" 'echo test$' ""
run_test "Múltiplos $" 'echo $$$$' ""
run_test "Variável numérica (não suportada)" 'echo $1' ""

# Comportamento com unset
echo -e "\n${YELLOW}Testing unset behavior:${NC}"
run_test "Expandir após unset" 'export REM=123 && unset REM && echo $REM' ""
run_test "Re-exportar após unset" 'export RE=old && unset RE && export RE=new && echo $RE' ""

# Nomes de variáveis
echo -e "\n${YELLOW}Testing variable names:${NC}"
run_test "Nome válido com underscore" 'export MY_VAR=ok && echo $MY_VAR' ""
run_test "Nome válido com números" 'export VAR123=ok && echo $VAR123' ""
run_test "Nome começando com número (inválido)" 'export 123VAR=fail 2>/dev/null || echo "export failed"' ""
