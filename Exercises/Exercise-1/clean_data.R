# Loading the Libraries
library(tidyverse) # Data Wrangling
library(tidylog) # Tidyverse logs
library(haven) # Loading DTA
library(fixest) # TWFE regs
library(did) # Callaway's DID package



#-------------------------------------------------------------------------------
# Wrangling Part
#-------------------------------------------------------------------------------

# Loading the dataset

# Please, change the data name accordingly (and working dir)
df_raw <- read_dta("NLSY_combined_wagescars.dta")


# Preparing the dataset for the regressions (multiple periods case)
df <- df_raw %>%
    # Only 1993 and below are important (I will keep 94 to check occ changes)
    filter(year <= 1993) %>%
    # Removing unnecessary NAs
    filter(!(is.na(sep1))) %>%
    filter(!(is.na(occ1990))) %>%
    filter(!(is.na(wage)) & wage != 0) %>% 
    filter(!is.na(age_base)) %>% 
    filter(!is.na(female_base)) %>% 
    filter(!is.na(white_base)) %>% 
    filter(!is.na(black_base)) %>% 
    filter(!is.na(raceothr_base)) %>% 
    filter(!is.na(hispanic_base)) %>% 
    filter(!is.na(mothed_base)) %>% 
    filter(!is.na(fathed_base)) %>% 
    filter(!is.na(r0000100)) %>% 
    filter(!is.na(numjobs)) %>% 
    filter(!is.na(exper))

total_years <- n_distinct(df$year)

# Creating occ score from occ1990 variable
# This variation allows changes per year AND
#          occupation score becomes a 1-4 scale
occscore_dt <- df %>%
    group_by(occ1990, year) %>%
    mutate(
        occ_score = median(wagesalary / 100, na.rm = TRUE)
    ) %>%
    ungroup() %>%
    filter(occ_score != 0 & !is.na(occ_score)) %>%
    group_by(year) %>%
    mutate(
        occ_score = case_when(
            occ_score < quantile(occ_score, 0.25) ~ 1,
            occ_score < quantile(occ_score, 0.5) &
                occ_score >= quantile(occ_score, 0.25) ~ 2,
            occ_score < quantile(occ_score, 0.75) &
                occ_score >= quantile(occ_score, 0.5) ~ 3,
            occ_score >= quantile(occ_score, 0.75) ~ 4
        )
    ) %>%
    select(occ1990, occ_score, year) %>%
    distinct()

# merging the datasets
df <- df %>%
    left_join(occscore_dt, by = c("occ1990", "year")) %>%
    distinct()


# Back to the main dataset. First we filter individuals reporting all years
df <- df %>%
    group_by(id) %>%
    mutate(
        year_sep = ifelse(sep1 == 1, year, 0),
        year_sep = max(year_sep)
    ) %>%
    # We arrange by year for the occupation change check
    arrange(year) %>%
    # Checking if they ever changed occupation
    mutate(
        treated     = ifelse(year >= year_sep & year_sep > 0, 1, 0),
        changed_occ = ifelse(occ_score != lead(occ_score), 1, 0)
    ) %>%
    filter(occ_score != 0 & !is.na(occ_score)) %>%
    filter(n_distinct(year) == total_years) %>%
    ungroup() %>% 
    mutate(lag_occscore = lag(occ_score))


df <- df %>% 
  select(occ_score, year_sep, year, id, age_base, female_base, white_base,
         mothed_base, fathed_base, r0000100, numjobs, exper,
         tenure, wagesalary, treated)

df <- df[complete.cases(df),]
df <- BMisc::makeBalancedPanel(df, "id", "year")

df$income <- df$wagesalary
df$group <- df$year_sep
df$female <- df$female_base
df$white <- df$white

data <- select(df, id, year, group, income, female, white, occ_score)
job_displacement_data <- data
save(job_displacement_data, file="job_displacement_data.RData")

#-------------------------------------------------------------------------------
# Application Part
#-------------------------------------------------------------------------------

##### Try using PTE package #####

xformla <- ~ age_base + female_base + white_base +
  mothed_base + fathed_base + r0000100 + numjobs + exper + I(exper^2)

lagged_reg <- pte_default(
  yname  = "occ_score",
  gname  = "year_sep",
  tname  = "year",
  idname = "id",
  data = df,
  xformla = ~ age_base + female_base + white_base + tenure,
  base_period = "varying",
  lagged_outcome_cov=TRUE,
  d_outcome = FALSE,
  anticipation=1,
  cband=TRUE,
  alp=0.95,
  biters=1000
)

summary(lagged_reg)
ggpte(lagged_reg)
ggdid(lagged_reg$att_gt)

#-------------------------------------------------------------------------------
# Preliminary Results -  Lagged outcome cov = TRUE
#-------------------------------------------------------------------------------
# Overall ATT:  
#   ATT    Std. Error     [ 95%  Conf. Int.]  
# -0.4297        0.0506    -0.5289     -0.3305 *
#   
#   
#   Dynamic Effects:
#   Event Time Estimate Std. Error   [95%  Conf. Band]  
# -8  -0.1236     0.2530 -0.9102      0.6629  
# -7  -0.2095     0.2282 -0.9188      0.4999  
# -6  -0.3395     0.1294 -0.7419      0.0629  
# -5  -0.2596     0.1729 -0.7972      0.2780  
# -4  -0.4128     0.1786 -0.9681      0.1425  
# -3  -0.3595     0.1385 -0.7901      0.0710  
# -2  -0.1905     0.1538 -0.6688      0.2878  
# -1  -0.4170     0.1119 -0.7650     -0.0689 *
#  0  -0.4265     0.1092 -0.7659     -0.0871 *
#  1  -0.3981     0.0881 -0.6722     -0.1241 *
#  2  -0.2927     0.1119 -0.6407      0.0553  
#  3  -0.3353     0.1514 -0.8059      0.1354  
#  4  -0.4733     0.1624 -0.9783      0.0318  
#  5  -0.3938     0.1341 -0.8108      0.0233  
#  6  -0.3543     0.1329 -0.7676      0.0590  
#  7  -0.8224     0.1050 -1.1488     -0.4960 *
#  8  -0.3400     0.2210 -1.0269      0.3470  
# ---
#   Signif. codes: `*' confidence band does not cover 0


lagged_reg <- pte_default(
  yname  = "occ_score",
  gname  = "year_sep",
  tname  = "year",
  idname = "id",
  data = df,
  xformla = xformla,
  base_period = "varying",
  d_outcome=TRUE
)

summary(lagged_reg)


library(did)

df$lwagesalary <- log(df$wagesalary)
out_res <- pte_default(
  yname  = "wagesalary",
  gname  = "year_sep",
  tname  = "year",
  idname = "id",
  data = df,
  xformla = ~ age_base + female_base + white_base + tenure,
  base_period = "varying",
  lagged_outcome_cov=FALSE,
  d_outcome = TRUE,
  anticipation=1,
  cband=TRUE,
  alp=0.95,
  biters=1000
)

summary(out_res)
ggpte(out_res)


