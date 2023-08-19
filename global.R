
# ENVIRONNEMENT ---------
library(leaflet)
library(sf)
library(ttt)
library(dplyr)
library(stringr)
library(oceanis) # add title to map
library(glue)

# setwd("/Users/julia/Documents/DESCAMPS 2022/ofpra")

# * Base de donnée OFPRA 2022 --------
df <- read.csv2("decisions_ofpra_long_final.csv")



df <- rename(df, iso3 = norme_iso_3166)


# * Création variables --------
# ** Nombre de demandes --------
# Création variable nombre de demandes traitées par pays (attention, il ne s'agit pas du nombre de demandes déposées une année donnée)

df$nb_demandes <- df$refugie + df$protection_subsidiaire + df$rejet


# ** Nombre de demandes discret --------

df$nb_demandes_discret <- NA
df$nb_demandes_discret <- cut(df$nb_demandes, c(0, 500, 1000, 2000, 5000, 10000, 17000), include.lowest=TRUE, right=FALSE)
df$nb_demandes_discret_r <- factor(df$nb_demandes_discret, labels = c("[0-500[", "[500-1000[", "[1000-2000[", "[2000-5000[", "[5000-10 000[", "[10 000-17 000]"))
df$nb_demandes_discret_r <- factor(df$nb_demandes_discret_r, levels = c("[0-500[", "[500-1000[", "[1000-2000[", "[2000-5000[", "[5000-10 000[", "[10 000-17 000]"))
table(df$nb_demandes_discret_r)

# ** Taux d'admission arrondi --------
# Création variable pourcentage arrondi
df$taux_admission_p <- round(df$taux_admission*100)


# * Réorganisation dataframe -----
df <- subset(df, select = -c(nb_demandes_discret))
df_demandes <- df
df_demandes$leaf_taux <- FALSE
df_demandes$leaf_demandes <- TRUE
df$leaf_taux <- TRUE
df$leaf_demandes <- FALSE

df$taux_admission_p_clear <- df$taux_admission_p
df$nb_demandes_clear <- NA
df$nb_demandes_discret_clear <- NA

df_demandes$taux_admission_p_clear <- NA
df_demandes$nb_demandes_clear <- df_demandes$nb_demandes
df_demandes$nb_demandes_discret_clear <- df_demandes$nb_demandes_discret

df_final <- rbind(df, df_demandes)
df_final$nb_demandes_discret_clear <- factor(df_final$nb_demandes_discret_clear, levels = c("[0-500[", "[500-1000[", "[1000-2000[", "[2000-5000[", "[5000-10 000[", "[10 000-17 000]"))
table(df_final$nb_demandes_discret_clear)

# * Import fond de carte --------
borders <- read_sf(
  dsn = "TM_WORLD_BORDERS-0.3.shp", 
  layer = "TM_WORLD_BORDERS-0.3")
# %>% 
#  mutate(iso3 = str_conv(iso3, "utf-8"))
borders <- rename(borders, iso3 = ISO3)

# Jointure fond de carte et données
world_ofpra_wgs84 <- borders %>% 
  left_join(df_final, by = "iso3")
world_ofpra_wgs84

table(world_ofpra_wgs84$nb_demandes_discret_clear)


# * Palette --------
pal <- colorBin(
  palette = "RdYlGn",
  domain = world_ofpra_wgs84$taux_admission_p_clear,
  reverse = FALSE,
  na.color = "#f2eee9"
)

pal2 <- colorFactor(
  palette = "YlOrBr",
  domain = world_ofpra_wgs84$nb_demandes_discret_clear,
  reverse = FALSE,
  na.color = "transparent" )



