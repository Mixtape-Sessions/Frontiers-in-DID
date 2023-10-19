load("data2.RData")
library(dplyr)
library(ggplot2)

treated_state_list <- unique(subset(data2, G != 0)$state_name)

plot_df <- unique(select(subset(data2, G != 0), state_name, state_mw, year))
ggplot(plot_df, aes(x=year, y=state_mw, color=state_name)) + 
  geom_line(linewidth=1.2) +
  geom_point(size=1.5) + 
  theme_bw()

res <- list()
counter <- 1
for (i in 1:length(treated_state_list)) {
  state <- treated_state_list[i]
  g <- unique(subset(data2, state_name==state)$G)
  base_period <- g-1
  for (period in 2004:2007) {
    Y1_treated <- subset(data2, state_name==state & year==period)$lemp
    Y1_untreated <- subset(data2, G==0 & year==period)$lemp
    Y0_treated <- subset(data2, state_name==state & year==base_period)$lemp
    Y0_untreated <- subset(data2, G==0 & year==base_period)$lemp
    Y1 <- c(Y1_treated, Y1_untreated)
    Y0 <- c(Y0_treated, Y0_untreated)
    D <- c(rep(1, length(Y1_treated)), rep(0, length(Y1_untreated)))
    attst <- DRDID::drdid_panel(Y1, Y0, D, covariates=NULL)
    state_mw <- unique(subset(data2, state_name==state & year==period)$state_mw)
    treat_amount <- state_mw - 5.15
    res[[counter]] <- data.frame(state=state, year=period, attst=attst$ATT, attst.se=attst$se,
                                 treat_amount=treat_amount, attst.per=attst$ATT/treat_amount,
                                 attst.per.se=attst$se/treat_amount, g=g, state_size=sum(D))
    counter <- counter+1
  }
}

result_df <- do.call(rbind.data.frame, res)
post_res <- subset(result_df, year >= g)
post_res$event_time <- post_res$year - post_res$g

ggplot(post_res, aes(x=year, y=attst, color=state)) +
  geom_line(linewidth=1.2) +
  geom_point(size=1.5) +
  ylim(c(-.2,.05)) + 
  theme_bw()

ggplot(post_res, aes(x=year, y=attst.per, color=state)) +
  geom_line(linewidth=1.2) +
  geom_point(size=1.5) + 
  ylim(c(-.2,.05)) + 
  theme_bw() 

# make an event study
es_att <- c()
es_se <- c()
for (e in 0:3) {
  this_res <- subset(post_res, event_time==e)
  es_att[e+1] <- weighted.mean(this_res$attst.per, this_res$state_size)
  es_se[e+1] <- weighted.mean(this_res$attst.per.se, this_res$state_size)
}

ggplot(data.frame(es_att=es_att, es_se=es_se, e=0:3),
       aes(x=e, y=es_att)) + 
  geom_line(color="steelblue", linewidth=1.2) + 
  geom_point(size=1.5, color="steelblue") + 
  geom_line(aes(y=es_att+1.96*es_se), linetype="dashed") +
  geom_line(aes(y=es_att-1.96*es_se), linetype="dashed") + 
  ylim(c(-.2, .05)) + 
  theme_bw() 
