#!/bin/bash

# Script rápido para executar testes básicos

echo "🚀 Executando testes rápidos do minishell..."
echo ""

# Teste 1: Echo
echo "1. Testando echo:"
echo 'echo hello world' | ../minishell 2>/dev/null | grep -v "minishell" | head -1

# Teste 2: Pipes
echo -e "\n2. Testando pipes:"
echo 'echo hello | cat' | ../minishell 2>/dev/null | grep -v "minishell" | head -1

# Teste 3: Redirecionamento
echo -e "\n3. Testando redirecionamento:"
echo 'echo test > /tmp/test.txt && cat /tmp/test.txt' | ../minishell 2>/dev/null | grep -v "minishell" | head -1

# Teste 4: Variáveis
echo -e "\n4. Testando variáveis:"
echo 'export TEST=42 && echo $TEST' | ../minishell 2>/dev/null | grep -v "minishell" | head -1

# Teste 5: Exit status
echo -e "\n5. Testando exit status:"
echo 'ls /nao_existe 2>/dev/null ; echo $?' | ../minishell 2>/dev/null | grep -v "minishell" | tail -1

echo -e "\n✅ Testes rápidos concluídos!"
echo "Para testes completos, execute: ./tester.sh"
