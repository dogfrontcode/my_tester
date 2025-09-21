#!/bin/bash

# Script para debug de testes individuais

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

MINISHELL="../minishell"
TEMP_DIR="./temp"

if [ $# -eq 0 ]; then
    echo "Uso: ./debug_test.sh \"comando para testar\""
    echo "Exemplo: ./debug_test.sh \"echo hello | cat\""
    exit 1
fi

TEST_CMD="$1"

echo -e "${BLUE}Testando comando: ${YELLOW}$TEST_CMD${NC}\n"

# Executar no bash
echo -e "${GREEN}BASH output:${NC}"
echo -e "$TEST_CMD\nexit" | bash 2>&1
BASH_EXIT=$?
echo -e "${YELLOW}BASH exit code: $BASH_EXIT${NC}\n"

# Executar no minishell
echo -e "${GREEN}MINISHELL output:${NC}"
echo -e "$TEST_CMD\nexit" | $MINISHELL 2>&1
MINI_EXIT=$?
echo -e "${YELLOW}MINISHELL exit code: $MINI_EXIT${NC}\n"

# Comparação lado a lado
echo -e "${BLUE}Comparação detalhada:${NC}"
echo -e "$TEST_CMD\nexit" | bash > $TEMP_DIR/bash_debug 2>&1
echo -e "$TEST_CMD\nexit" | $MINISHELL > $TEMP_DIR/mini_debug 2>&1

if diff -u $TEMP_DIR/bash_debug $TEMP_DIR/mini_debug; then
    echo -e "${GREEN}✓ Outputs são idênticos!${NC}"
else
    echo -e "${RED}✗ Outputs são diferentes${NC}"
fi
