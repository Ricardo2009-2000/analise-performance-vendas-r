
library(tidyverse)


# --- CONFIGURANDO O GERADOR ---
set.seed(123) # Para garantir que os dados sejam iguais toda vez que rodar

nomes <- c("Carlos", "Ana", "Marcos", "Julia", "Roberto")
regioes <- c("Nordeste", "Sul", "Sudeste", "Centro-Oeste")

# Criando a tabela bruta
dados_sujos <- tibble(
  id = 1:500,
  # 1. Gera Vendedores com chance de erro (minúsculo ou espaço extra)
  Vendedor = sample(nomes, 500, replace = TRUE),
  
  # 2. Gera Regiões
  Regiao = sample(regioes, 500, replace = TRUE),
  
  # 3. Gera Valores Numéricos para depois estragar
  Valor_Base = runif(500, min = 100, max = 5000)
) %>%
  # --- AQUI COMEÇA A SUJEIRA ---
  mutate(
    # Estraga o nome (Ex: "ana " ou "carlos") em 20% dos casos
    Vendedor = ifelse(runif(n()) < 0.2, tolower(Vendedor), Vendedor),
    
    # Cria buracos na Região (NA) em 5% dos casos
    Regiao = ifelse(runif(n()) < 0.05, NA, Regiao),
    
    # Transforma dinheiro em texto bagunçado (Ex: "R$ 1.200,50")
    Valor_Venda = paste0("R$ ", format(round(Valor_Base, 2), big.mark = ".", decimal.mark = ","))
  ) %>%
  select(-Valor_Base) # Remove a coluna auxiliar limpa

# Mostra a bagunça
print("--- DADOS SUJOS GERADOS ---")
head(dados_sujos)
glimpse(dados_sujos)



dados_limpos <- dados_sujos %>%
  # 1. Limpeza de Texto (Vendedor)
  mutate(
    Vendedor = str_to_title(str_trim(Vendedor)) # Remove espaço e põe Maiúscula
  ) %>%
  
  # 2. Tratamento de Nulos (Região)
  mutate(
    Regiao = replace_na(Regiao, "Norte")
  ) %>%
  
  # 3. O Grande Vilão: Dinheiro (Texto -> Número)
  mutate(
    Valor_Limpo = Valor_Venda %>%
      str_remove("R\\$ ") %>%      # Tira o R$
      str_remove_all("\\.") %>%    # Tira o ponto de milhar
      str_replace(",", ".") %>%    # Troca vírgula por ponto
      as.numeric()                 # Vira número!
  )

# Mostra o resultado limpo
print("--- DADOS LIMPOS ---")
head(dados_limpos)



# 1. Ranking de Vendedores
ranking_vendedores <- dados_limpos %>%
  group_by(Vendedor) %>%
  summarise(Total = sum(Valor_Limpo)) %>%
  arrange(desc(Total))

# 2. Ranking de Regiões
ranking_regioes <- dados_limpos %>%
  group_by(Regiao) %>%
  summarise(Total = sum(Valor_Limpo)) %>%
  arrange(desc(Total))

print("🏆 TOP VENDEDORES:")
print(ranking_vendedores)

print("🌍 MELHORES REGIÕES:")
print(ranking_regioes)




ggplot(ranking_vendedores, aes(x = reorder(Vendedor, -Total), y = Total)) +
  
  # Camada das Barras
  geom_col(fill = "steelblue") +
  
  # Camada dos Rótulos (Valor em cima da barra)
  geom_text(aes(label = paste0("R$ ", round(Total/1000, 0), "k")), 
            vjust = -0.5) +
  
  # Textos e Títulos
  labs(
    title = "Performance por Vendedor",
    x = "",
    y = "Total Vendido"
  ) +

  # Tema (Visual Limpo)
  theme_minimal() +
  
  # Ajuste do título 
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))
