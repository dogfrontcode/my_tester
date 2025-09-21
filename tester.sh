#!/bin/bash

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Configurações
MINISHELL="../minishell"
TEMP_DIR="./temp"
RESULTS_DIR="./results"
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Limpar diretórios temporários
rm -rf $TEMP_DIR/*
rm -rf $RESULTS_DIR/*
mkdir -p $TEMP_DIR
mkdir -p $RESULTS_DIR

# Função para imprimir cabeçalho
print_header() {
    echo -e "\n${PURPLE}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}${BOLD}                          MINISHELL TESTER                              ${NC}"
    echo -e "${PURPLE}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

# Função para imprimir seção
print_section() {
    echo -e "\n${BLUE}${BOLD}▶ $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# Função para executar teste
run_test() {
    local test_name="$1"
    local test_cmd="$2"
    local expected_behavior="$3"
    
    ((TOTAL_TESTS++))
    
    # Executar no bash
    echo -e "$test_cmd\nexit" | bash > $TEMP_DIR/bash_output 2> $TEMP_DIR/bash_error
    local bash_exit=$?
    
    # Executar no minishell
    echo -e "$test_cmd\nexit" | $MINISHELL > $TEMP_DIR/mini_output 2> $TEMP_DIR/mini_error
    local mini_exit=$?
    
    # Comparar outputs
    if diff -q $TEMP_DIR/bash_output $TEMP_DIR/mini_output > /dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} $test_name"
        ((PASSED_TESTS++))
    else
        echo -e "${RED}✗${NC} $test_name"
        echo -e "  ${YELLOW}Comando:${NC} $test_cmd"
        echo -e "  ${YELLOW}Esperado:${NC}"
        cat $TEMP_DIR/bash_output | sed 's/^/    /'
        echo -e "  ${YELLOW}Recebido:${NC}"
        cat $TEMP_DIR/mini_output | sed 's/^/    /'
        ((FAILED_TESTS++))
    fi
}

# Função para teste de redirecionamento
run_redir_test() {
    local test_name="$1"
    local test_cmd="$2"
    
    ((TOTAL_TESTS++))
    
    # Limpar arquivos de output
    rm -f $TEMP_DIR/outfile*
    
    # Executar no bash
    cd $TEMP_DIR && echo -e "$test_cmd\nexit" | bash > /dev/null 2>&1
    local bash_exit=$?
    cp outfile* ../bash_outfile 2>/dev/null || touch ../bash_outfile
    cd ..
    
    # Executar no minishell
    cd $TEMP_DIR && echo -e "$test_cmd\nexit" | ../$MINISHELL > /dev/null 2>&1
    local mini_exit=$?
    cp outfile* ../mini_outfile 2>/dev/null || touch ../mini_outfile
    cd ..
    
    # Comparar arquivos criados
    if diff -q bash_outfile mini_outfile > /dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} $test_name"
        ((PASSED_TESTS++))
    else
        echo -e "${RED}✗${NC} $test_name"
        echo -e "  ${YELLOW}Comando:${NC} $test_cmd"
        ((FAILED_TESTS++))
    fi
    
    rm -f bash_outfile mini_outfile
}

# Função para imprimir resultados finais
print_results() {
    echo -e "\n${PURPLE}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}${BOLD}                            RESULTADOS                                  ${NC}"
    echo -e "${PURPLE}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BOLD}Total de testes:${NC} $TOTAL_TESTS"
    echo -e "${GREEN}${BOLD}Passou:${NC} $PASSED_TESTS"
    echo -e "${RED}${BOLD}Falhou:${NC} $FAILED_TESTS"
    
    if [ $FAILED_TESTS -eq 0 ]; then
        echo -e "\n${GREEN}${BOLD}🎉 Todos os testes passaram! 🎉${NC}"
    else
        echo -e "\n${RED}${BOLD}❌ Alguns testes falharam ❌${NC}"
    fi
}

# Main
print_header

# Verificar se minishell existe
if [ ! -f "$MINISHELL" ]; then
    echo -e "${RED}Erro: minishell não encontrado em $MINISHELL${NC}"
    exit 1
fi

# Executar testes por categoria
for test_file in tests/*.sh; do
    if [ -f "$test_file" ]; then
        source "$test_file"
    fi
done

print_results
