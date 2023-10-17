# Mixtape: Minimum Wage Example Code

library(did)
library(BMisc)
library(twfeweights)
library(fixest)
library(modelsummary)
library(ggplot2)
load(url("https://github.com/bcallaway11/did_chapter/raw/master/mw_data_ch2.RData"))


## ---------------------------------------------------------------------------------
# setup data
# drops NE region and a couple of small groups
mw_data_ch2 <- subset(mw_data_ch2, (G %in% c(2004,2006,2007,0)) & (region != "1"))
head(mw_data_ch2[,c("id","year","G","lemp","lpop","region")])


## ---------------------------------------------------------------------------------
# drop 2007 as these are right before fed. minimum wage change
data2 <- subset(mw_data_ch2, G!=2007 & year >= 2003)
# keep 2007 => larger sample size
data3 <- subset(mw_data_ch2, year >= 2003)


## ---------------------------------------------------------------------------------
# twfe regression
twfe_res2 <- fixest::feols(lemp ~ post | id + year,
                           data=data2,
                           cluster="id")


modelsummary(list(twfe_res2), gof_omit=".*")


# estimate att(g,t)
attgt <- did::att_gt(yname="lemp",
                     idname="id",
                     gname="G",
                     tname="year",
                     data=data2,
                     control_group="nevertreated",
                     base_period="universal")
tidy(attgt)[,1:5] # print results, drop some extra columns

# plot att(g,t)
ggdid(attgt)


## ---------------------------------------------------------------------------------
# overall att
attO <- did::aggte(attgt, type="group")
summary(attO)

# event study
attes <- did::aggte(attgt, type="dynamic")
ggdid(attes)

# twfe weights
tw <- twfeweights::twfe_weights(attgt)
tw <- tw[tw$G != 0,]
tw$post <- as.factor(1*(tw$TP >= tw$G))
twfe_est <- sum(tw$wTWFEgt*tw$attgt)
ggplot(data=tw,
       mapping=aes(x=wTWFEgt, y=attgt, color=post)) +
  geom_hline(yintercept=0, linewidth=1.5) +
  geom_vline(xintercept=0, linewidth=1.5) + 
  geom_point(size=6) +
  theme_bw() +
  ylim(c(-.15,.05)) + xlim(c(-.4,.7))

# attO weights
wO <- attO_weights(attgt)
wO <- wO[wO$G != 0,]
attO_est = sum(wO$wOgt*wO$attgt)
wO$post <- as.factor(1*(wO$TP >= wO$G))
ggplot(data=wO,
       mapping=aes(x=wOgt, y=attgt, color=post)) +
  geom_hline(yintercept=0, linewidth=1.5) +
  geom_vline(xintercept=0, linewidth=1.5) + 
  geom_point(shape=18, size=8) +
  theme_bw() +
  ylim(c(-.15,.05)) + xlim(c(-.4,.7))


plot_df <- cbind.data.frame(tw, wOgt=wO$wOgt)
plot_df <- plot_df[plot_df$post==1,]
plot_df$g.t <- as.factor(paste0(plot_df$G,",",plot_df$TP))

ggplot(plot_df, aes(x=wTWFEgt, y=attgt, color=g.t)) +
  geom_point(size=6) +
  theme_bw() +
  ylim(c(-.15,.05)) + xlim(c(-.4,.7)) + 
  geom_point(aes(x=wOgt), shape=18, size=8) +
  geom_hline(yintercept=0, linewidth=1.5) +
  geom_vline(xintercept=0, linewidth=1.5) + 
  xlab("weight")

# calculations on contributions to differences between estimates
twfe_post <- sum(tw$wTWFEgt[tw$post==1] * tw$attgt[tw$post==1])
twfe_post

# pre-treatment contamination/bias
pre_bias <- sum(tw$wTWFEgt[tw$post==0] * tw$attgt[tw$post==0])
pre_bias

twfe_bias <- twfe_est - attO_est
pre_bias/twfe_bias # bias from pre-treatment PTA violations
(twfe_post-attO_est)/twfe_bias # bias from TWFE weights instead of ATT^O weights


# calculate att^simple weights
wsimple <- att_simple_weights(attgt)
wsimple <- wsimple[wsimple$G != 0,]
attsimple_est <- sum(wsimple$wsimplegt*wsimple$attgt)
wsimple$post <- as.factor(1*(wsimple$TP >= wsimple$G))

# comparison of att^O and att^simple weights
plot_df <- cbind.data.frame(wsimple, wOgt=wO$wOgt)
plot_df <- plot_df[plot_df$post==1,]
plot_df$g.t <- as.factor(paste0(plot_df$G,",",plot_df$TP))

ggplot(plot_df, aes(x=wsimplegt, y=attgt, color=g.t)) +
  geom_point(shape=15, size=6) +
  theme_bw() +
  ylim(c(-.15,.05)) + xlim(c(-.4,.7)) + 
  geom_point(aes(x=wOgt), shape=18, size=8) +
  geom_hline(yintercept=0, linewidth=1.5) +
  geom_vline(xintercept=0, linewidth=1.5) + 
  xlab("weight")

