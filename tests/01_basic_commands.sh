#!/bin/bash

print_section "COMANDOS BÁSICOS E ARGUMENTOS"

# Comandos simples
run_test "Comando simples - ls" "ls -la /dev/null" ""
run_test "Comando simples - echo" "echo hello world" ""
run_test "Comando com path absoluto" "/bin/echo test" ""
run_test "Comando com múltiplos argumentos" "echo arg1 arg2 arg3 arg4" ""
run_test "Comando sem argumentos" "ls" ""

# Comandos não encontrados
run_test "Comando não encontrado" "comando_inexistente" ""
run_test "Comando vazio" "" ""
run_test "Apenas espaços" "    " ""

# Argumentos especiais
run_test "Argumentos com espaços múltiplos" "echo    hello     world" ""
run_test "Argumentos com tabs" "echo	hello	world" ""

# Caminhos
run_test "Comando com ./" "./minishell --version 2>/dev/null || echo 'error'" ""
run_test "Comando com caminho relativo" "src/../minishell --version 2>/dev/null || echo 'error'" ""
