# 🧪 Minishell Tester

Um tester completo para verificar todas as funcionalidades do projeto minishell de acordo com os requisitos da 42.

## 📋 Características

O tester verifica:
- ✅ Comandos básicos e argumentos
- ✅ Builtins: `echo`, `cd`, `pwd`, `env`, `export`, `unset`, `exit`
- ✅ Quotes simples e duplas
- ✅ Redirecionamentos: `>`, `<`, `>>`, `<<`
- ✅ Pipes simples e múltiplos
- ✅ Variáveis de ambiente e expansão ($VAR, $?)
- ✅ Sinais (Ctrl-C, Ctrl-D, Ctrl-\)
- ✅ Operadores lógicos: `&&`, `||` (bonus)
- ✅ Erros de sintaxe e casos extremos

## 🚀 Como usar

### Executar todos os testes:
```bash
cd my_tester
./tester.sh
```

### Executar categoria específica:
```bash
cd my_tester
bash tests/01_basic_commands.sh
```

## 📁 Estrutura dos testes

```
my_tester/
├── tester.sh                    # Script principal
├── tests/
│   ├── 01_basic_commands.sh     # Comandos básicos
│   ├── 02_builtins.sh          # Comandos builtin
│   ├── 03_quotes.sh            # Aspas simples e duplas
│   ├── 04_redirections.sh      # Redirecionamentos
│   ├── 05_pipes.sh             # Pipes
│   ├── 06_variables.sh         # Variáveis e expansão
│   ├── 07_signals_manual.sh    # Testes de sinais (manual)
│   ├── 08_bonus.sh             # Operadores lógicos
│   └── 09_syntax_errors.sh     # Erros de sintaxe
├── temp/                       # Arquivos temporários
└── results/                    # Resultados dos testes
```

## 🔍 Interpretando resultados

- ✅ **Verde**: Teste passou - comportamento idêntico ao bash
- ❌ **Vermelho**: Teste falhou - comportamento diferente do bash
- 💛 **Amarelo**: Informações sobre o teste

## ⚠️ Testes manuais

Alguns testes precisam ser feitos manualmente:

### Sinais:
1. **Ctrl-C em prompt vazio**: deve mostrar novo prompt
2. **Ctrl-C durante comando**: deve interromper e retornar 130
3. **Ctrl-\ em prompt vazio**: não deve fazer nada
4. **Ctrl-\ durante comando**: deve mostrar "Quit" e retornar 131
5. **Ctrl-D**: deve sair do shell

### Memory leaks:
```bash
valgrind --leak-check=full ./minishell
```

## 📊 Cobertura dos requisitos

| Categoria | Status | Observações |
|-----------|--------|-------------|
| Preliminary tests | ✅ | Compilação e execução básica |
| General instructions | ✅ | Norminette, Makefile, etc |
| Mandatory Part | ✅ | Todos os requisitos obrigatórios |
| Bonus Part | ✅ | &&, \|\|, wildcards (*) |

## 🐛 Problemas conhecidos

- Testes de sinais são manuais devido à natureza interativa
- Wildcards podem ter comportamento diferente dependendo do shell
- Alguns edge cases podem variar entre versões do bash

## 💡 Dicas

1. Execute o tester após cada mudança significativa
2. Compare sempre com o comportamento do bash
3. Use `echo $?` para verificar exit status
4. Teste memory leaks regularmente com valgrind

## 🤝 Contribuições

Sinta-se livre para adicionar mais testes ou melhorar os existentes!
