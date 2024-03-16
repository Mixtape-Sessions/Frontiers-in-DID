<img src="https://raw.githubusercontent.com/Mixtape-Sessions/Frontiers-in-DID/main/img/banner.png" alt="Mixtape Sessions Banner" width="100%"> 


## About

This course provides an in-depth introduction to panel data approaches to causal inference. The first part of the course reviews how new "heterogeneity-robust" estimation strategies address some important limitations of traditional two-way fixed effects regressions in difference-in-differences applications, and then provides an in-depth discussion/comparison of many of these approaches. This part also includes a number of practical extensions such as how to include covariates in the parallel trends assumption and dealing with "bad controls". The second part of the course discusses how the insights of recent work on difference-in-differences can apply in a number of other settings that frequently arise in empirical work. And, in particular, this part of the course provides connections between the difference-in-differences literature and alternative identification strategies (conditioning on lagged outcomes, change-in-changes, and interactive fixed effects models) and also how to deal with more complicated treatment regimes (continuous treatments or treatments that can change value over time).

This is one of our advanced courses. These courses are designed <strong>assuming a solid foundation in the basics of the difference-in-differences methodology</strong> and will cover the frontiers of the topic. A good review is: https://github.com/Mixtape-Sessions/Causal-Inference-2.


## Schedule

### Introduction

#### About

High-level discussion about using panel data for causal inference and an introduction/review of DID approaches

#### Slides

[Slides](https://mixtape-sessions.github.io/Frontiers-in-DID/Slides/)

[[R Data full](https://mixtape-sessions.github.io/Frontiers-in-DID/mw_data_ch2.RData)] [[Stata dta full](https://mixtape-sessions.github.io/Frontiers-in-DID/mw_data_ch2.dta)]

[[R Data subset used in slides](https://mixtape-sessions.github.io/Frontiers-in-DID/data2.RData)] [[Stata dta subset used in slides](https://mixtape-sessions.github.io/Frontiers-in-DID/data2.dta)]

[[R Code used in slides](https://mixtape-sessions.github.io/Frontiers-in-DID/DID-Introduction.R)]

### Relaxing Parallel Trends (& Covariates Good and Bad)

#### About

Relaxing the parallel trends assumption by conditioning on covariates and dealing with covariates that could have been affected by the treatment

#### Slides

[Slides](https://mixtape-sessions.github.io/Frontiers-in-DID/Slides/Relaxing-Parallel-Trends.html)

[Data] - same as in first session

[[R Code used in slides](https://mixtape-sessions.github.io/Frontiers-in-DID/Relaxing-Parallel-Trends.R)]

#### Coding Exercises

[Exercise 1](https://mixtape-sessions.github.io/Frontiers-in-DID/Exercises/Exercise-1/exercise1.html)

[[R data](https://mixtape-sessions.github.io/Frontiers-in-DID/Exercises/Exercise-1/job_displacement_data.RData)] [[Stata dta](https://mixtape-sessions.github.io/Frontiers-in-DID/Exercises/Exercise-1/job_displacement_data.dta)]

[Solutions](https://mixtape-sessions.github.io/Frontiers-in-DID/Exercises/Exercise-1/exercise1_sol.html)




### More Complicated Treatment Regimes (or, I have a complicated treatment, what now?)

#### About

Continuous treatment and a treatment that can turn on and off plus a high-level discussion of how to adapt "heterogeneity robust" strategies to new empirical settings

#### Slides

[Slides](https://mixtape-sessions.github.io/Frontiers-in-DID/Slides/More-Complicated-Treatment-Regimes.html)

[Min. Wage Example Replication Code](https://mixtape-sessions.github.io/Frontiers-in-DID/mw_wage_application_example.R)

#### Coding Exercises

[Exercise 2a](https://mixtape-sessions.github.io/Frontiers-in-DID/Exercises/Exercise-2/exercise2a.html)

[Data](https://mixtape-sessions.github.io/Frontiers-in-DID/Exercises/Exercise-2/medicare1.RData)

[Solutions](https://mixtape-sessions.github.io/Frontiers-in-DID/Exercises/Exercise-2/exercise2a_sol.html)




### Alternative Identification Strategies

#### About

Many recent developments in panel data approaches to causal inference have come in the context of difference-in-differences, but many of these insights extend (in a straighforward way) to other using other identification strategies as well.  This part will consider changes-in-changes, interactive fixed effects models, and conditioning on lagged outcomes as alternative under-the-hood identification strategies.

#### Slides

[Slides](https://mixtape-sessions.github.io/Frontiers-in-DID/Slides/Alternative-Identification-Strategies.html)

#### Coding Exercises


[Exercise 2b](https://mixtape-sessions.github.io/Frontiers-in-DID/Exercises/Exercise-2/exercise2b.html)

Data Same as Exercise 1

[Solutions](https://mixtape-sessions.github.io/Frontiers-in-DID/Exercises/Exercise-2/exercise2b_sol.html)



