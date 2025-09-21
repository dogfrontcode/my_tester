#!/bin/bash

print_section "COMANDOS BUILTIN"

# ECHO
echo -e "\n${YELLOW}Testing echo:${NC}"
run_test "echo simples" "echo hello" ""
run_test "echo sem argumentos" "echo" ""
run_test "echo com -n" "echo -n hello" ""
run_test "echo com múltiplos -n" "echo -n -n -n hello" ""
run_test "echo com -n no meio" "echo hello -n world" ""
run_test "echo com string vazia" "echo ''" ""
run_test "echo com múltiplos espaços" "echo hello      world" ""

# PWD
echo -e "\n${YELLOW}Testing pwd:${NC}"
run_test "pwd simples" "pwd" ""
run_test "pwd com argumentos (deve ignorar)" "pwd arg1 arg2" ""

# CD
echo -e "\n${YELLOW}Testing cd:${NC}"
run_test "cd para home" "cd && pwd" ""
run_test "cd para /" "cd / && pwd" ""
run_test "cd para diretório anterior" "cd / && cd - && pwd" ""
run_test "cd para diretório inexistente" "cd /diretorio_inexistente" ""
run_test "cd com caminho relativo" "cd . && pwd" ""
run_test "cd .." "cd .. && pwd" ""
run_test "cd com múltiplos argumentos" "cd / home" ""

# ENV
echo -e "\n${YELLOW}Testing env:${NC}"
run_test "env (verificar se PATH existe)" "env | grep -q '^PATH=' && echo 'PATH found'" ""
run_test "env com argumentos (deve falhar)" "env arg1" ""

# EXPORT
echo -e "\n${YELLOW}Testing export:${NC}"
run_test "export sem argumentos" "export | head -5" ""
run_test "export variável simples" "export TEST_VAR=123 && env | grep TEST_VAR" ""
run_test "export múltiplas variáveis" "export VAR1=1 VAR2=2 && env | grep VAR1 && env | grep VAR2" ""
run_test "export sem valor" "export EMPTY_VAR && export | grep EMPTY_VAR" ""
run_test "export com nome inválido" "export 123VAR=test" ""
run_test "export atualizar variável" "export UPDATE=old && export UPDATE=new && env | grep UPDATE" ""

# UNSET
echo -e "\n${YELLOW}Testing unset:${NC}"
run_test "unset variável existente" "export UNSET_TEST=123 && unset UNSET_TEST && env | grep -v UNSET_TEST | grep -q UNSET_TEST || echo 'unset ok'" ""
run_test "unset variável inexistente" "unset VAR_NAO_EXISTE" ""
run_test "unset múltiplas variáveis" "export UN1=1 UN2=2 && unset UN1 UN2 && env | grep -E 'UN1|UN2' || echo 'unset ok'" ""
run_test "unset sem argumentos" "unset" ""

# EXIT
echo -e "\n${YELLOW}Testing exit:${NC}"
run_test "exit sem argumentos" "echo 'before exit' && exit && echo 'after exit'" ""
run_test "exit com código 0" "exit 0" ""
run_test "exit com código 42" "exit 42" ""
run_test "exit com código negativo" "exit -1" ""
run_test "exit com múltiplos argumentos" "exit 1 2 3" ""
run_test "exit com argumento não numérico" "exit abc" ""
