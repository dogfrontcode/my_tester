#!/bin/bash

print_section "REDIRECIONAMENTOS"

# Output redirection (>)
echo -e "\n${YELLOW}Testing output redirection (>):${NC}"
run_redir_test "Redirecionamento simples >" "echo hello > outfile"
run_redir_test "Sobrescrever arquivo existente" "echo first > outfile && echo second > outfile"
run_redir_test "Múltiplos redirecionamentos >" "echo test > out1 > out2 > outfile"
run_redir_test "Redirecionamento com espaços" "echo hello >     outfile"
run_redir_test "Redirecionamento antes do comando" "> outfile echo hello"

# Append redirection (>>)
echo -e "\n${YELLOW}Testing append redirection (>>):${NC}"
run_redir_test "Append simples" "echo hello >> outfile"
run_redir_test "Append múltiplo" "echo first >> outfile && echo second >> outfile"
run_redir_test "Criar arquivo com >>" "echo new >> outfile"
run_redir_test "Mix > e >>" "echo first > outfile && echo second >> outfile"

# Input redirection (<)
echo -e "\n${YELLOW}Testing input redirection (<):${NC}"
# Criar arquivo de teste
echo "test content" > $TEMP_DIR/infile
run_test "Input redirection simples" "cat < infile" ""
run_test "Input de arquivo inexistente" "cat < arquivo_inexistente" ""
run_test "Múltiplos inputs (último vale)" "cat < infile < infile" ""
run_test "Input com espaços" "cat <    infile" ""

# Heredoc (<<)
echo -e "\n${YELLOW}Testing heredoc (<<):${NC}"
run_test "Heredoc simples" "cat << EOF
hello
world
EOF" ""

run_test "Heredoc com expansão" "export HD_VAR=42 && cat << EOF
value is \$HD_VAR
EOF" ""

run_test "Heredoc com delimitador quotes" "cat << 'EOF'
\$HOME
EOF" ""

# Combinações
echo -e "\n${YELLOW}Testing redirection combinations:${NC}"
run_redir_test "Input e output" "cat < infile > outfile"
run_redir_test "Append com input" "cat < infile >> outfile"
run_test "Heredoc com output" "cat << EOF > outfile
heredoc test
EOF
cat outfile" ""

# Edge cases
echo -e "\n${YELLOW}Testing redirection edge cases:${NC}"
run_test "Redirecionamento sem arquivo >" "echo hello >" ""
run_test "Redirecionamento sem arquivo <" "cat <" ""
run_test "Redirecionamento sem comando" "> outfile" ""
run_redir_test "Arquivo com espaços no nome" "echo test > 'out file'"
run_test "Múltiplos heredocs" "cat << EOF1 << EOF2
first
EOF1
second
EOF2" ""
