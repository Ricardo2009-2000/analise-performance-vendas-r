# 📊 Análise de Performance de Vendas e ETL (R Studio)

Este projeto prático tem como foco a área comercial e a gestão de desempenho da equipe. O objetivo principal foi receber uma base de dados bruta contendo inconsistências comuns do dia a dia (erros de digitação, valores nulos e números formatados como texto) e aplicar um processo completo de ETL para extrair insights precisos sobre a performance dos vendedores.

## 🛠️ Tecnologias Utilizadas
- **Linguagem:** R
- **Pacotes Principais:** `tidyverse` (para manipulação e limpeza de dados) e `ggplot2` (para visualização gráfica de alta qualidade)

## ⚙️ Estrutura do Projeto
- **1. Simulação de Dados Brutos:** Geração de um dataset com 500 registros contendo falhas propositais de preenchimento para simular a extração de um sistema legado.
- **2. Transformação e Limpeza (ETL):** - Padronização de texto (correção de nomes minúsculos para o formato Título).
  - Tratamento de valores nulos (identificação de campos de região vazios e preenchimento com "Norte").
  - Conversão de tipos de dados (transformação de strings monetárias como "R$ 1.200,50" para valores numéricos calculáveis).
- **3. Análise Exploratória:** Agrupamento e sumarização de dados para identificar o volume financeiro total gerado por cada funcionário e por região.
- **4. Visualização de Dados:** Construção de um gráfico de barras centralizado e ranqueado, destacando de forma rápida os melhores vendedores do período.

## 🚀 Como visualizar o projeto
- O script completo, com o passo a passo documentado, encontra-se no arquivo `.R` deste repositório.
- O resultado visual final da análise está disponível na imagem `.png` anexada para rápida visualização.
