# 🛍️ Sistema de Bazar – Flutter Web

Sistema desenvolvido para organização e controle de vendas em bazares comunitários, com foco em **simplicidade**, **rapidez no atendimento** e **transparência na prestação de contas**.

O projeto nasceu a partir de um protótipo no **Glide** e está sendo migrado para **Flutter Web**, permitindo acesso via navegador e links diretos para cada tela do sistema.

---

## 🎯 Objetivo do Projeto

Facilitar o funcionamento de um bazar presencial, eliminando o caixa central, reduzindo filas e centralizando o controle das vendas por meio de um sistema simples baseado em formulários.

---

## 🧠 Conceito de Funcionamento

- O cliente escolhe um **envelope (comanda)** ao entrar no bazar
- O cliente paga **diretamente ao vendedor**
- O vendedor registra a venda no sistema
- O cliente retira os produtos em um **ponto de entrega**
- A equipe confere a comanda no sistema
- A compra é **liberada ou ajustada**
- Ao final do evento, o sistema gera relatórios automáticos

---

## 🔐 Autenticação

- Apenas o **ADMINISTRADOR** realiza login no sistema
- Vendedores **não possuem login**
- Após o login do admin, todas as telas ficam acessíveis nos dispositivos do evento

---

## 🌐 Acesso por Navegador (Rotas)

O sistema foi pensado para funcionar via **links diretos**, facilitando o uso em celulares, tablets e computadores.

Exemplos de rotas:

- `/login` → Login do administrador
- `/vendas` → Registrar vendas (uso dos vendedores)
- `/admin/produtos` → Cadastro de produtos
- `/admin/vendedores` → Cadastro de vendedores
- `/admin/comandas` → Comandas abertas e fechadas
- `/admin/pacotes` → Conferência e liberação de compras

> ⚠️ Todas as rotas exigem que o admin esteja logado.

---

## 🖥️ Telas do Sistema

### 🔐 Login (Admin)
- Usuário
- Senha

---

### 🛍️ Registrar Venda (Vendedores)
Tela simples e rápida, pensada para uso intenso durante o evento.

Campos:
- Vendedor
- Número da comanda (envelope)
- Tipo de produto:
  - Produto cadastrado
  - Produto não cadastrado
- Nome do produto (se não cadastrado)
- Valor unitário
- Quantidade
- Desconto (opcional):
  - Valor fixo (R$)
  - Percentual (%)
- Total calculado automaticamente

---

### 🧾 Cadastro de Produtos (Admin)
- Nome do produto
- Categoria
- Preço base (opcional)
- Observações

> Os produtos cadastrados servem como apoio e organização, não sendo obrigatórios para o registro de vendas.

---

### 👥 Cadastro de Vendedores (Admin)
- Nome do vendedor
- Status (ativo / inativo)

---

### 📂 Comandas
- Visualização de comandas abertas e fechadas
- Total de itens
- Valor total acumulado

---

### 📦 Pacotes / Compras por Comanda (Entrega)
- Visualização detalhada das vendas por comanda
- Conferência de valores, quantidades e descontos
- Ações:
  - Liberar entrega
  - Reprovar / ajustar venda
- Fechamento da comanda após liberação

---

## 📊 Relatórios Automáticos

Ao final do evento, o sistema permite visualizar:

- Total vendido por vendedor
- Total geral arrecadado
- Cálculo automático de **10% de desconto solidário**
- Lista de comandas finalizadas
- Conferência geral das vendas

---

## 🧱 Tecnologias

- **Flutter Web**
- Gerenciamento de estado: Provider / Riverpod (a definir)
- Navegação: GoRouter
- Backend / Persistência:
  - Em definição (Firebase, Supabase ou local)

---

## 🚀 Status do Projeto

🔧 Em desenvolvimento  
📱 Protótipo funcional existente no Glide  
🧠 Fluxos e mockups definidos  
➡️ Migração para Flutter Web em andamento  

---

## 📌 Próximos Passos

- Implementar layout das telas no Flutter
- Criar modelo de dados (Venda, Comanda, Vendedor)
- Implementar validações de formulário
- Definir persistência dos dados
- Testes em ambiente real de evento

---

## 🤝 Contribuição

Este projeto foi pensado para uso comunitário e educacional. Sugestões e melhorias são bem-vindas.

