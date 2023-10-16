
# Exercise 2b

For this exercise, we will revisit the job displacement example from
Exercise 1, but we will try out some alternative identification
strategies: (i) change-in-changes, (ii) conditioning on lagged outcomes,
and (iii) interactive fixed effects.

To start with, load the data from the file `job_displacement_data.RData`
by running

``` r
load("job_displacement_data.RData")
```

which will load a `data.frame` called `job_displacement_data`. This is
what the data looks like

``` r
head(job_displacement_data)
```

           id year group income female white occ_score
    1 7900002 1984     0  31130      1     1         4
    2 7900002 1985     0  32200      1     1         3
    3 7900002 1986     0  35520      1     1         4
    4 7900002 1987     0  43600      1     1         4
    5 7900002 1988     0  39900      1     1         4
    6 7900002 1990     0  38200      1     1         4

You can see that the data contains the following columns:

-   `id` - an individual identifier
-   `year` - the year for this observation
-   `group` - the year that person lost his/her job. `group=0` for those
    that do not lose a job in any period being considered.
-   `income` - a person’s wage and salary income in this year
-   `female` - 1 for females, 0 for males
-   `white` - 1 for white, 0 for non-white

For the results below, we will mainly use the `qte`, `pte`, and `ife`
packages. `pte` and `ife` in particular are new packages, so we will
download the newest versions of these from GitHub. We will also need the
`BMisc` and `dplyr` packages.

``` r
devtools::install_github("bcallaway11/qte")
devtools::install_github("bcallaway11/pte")
devtools::install_github("bcallaway11/ife")
devtools::install_github("bcallaway11/BMisc")
install.packages("dplyr")
```

and then the packages can be loaded by

``` r
library(qte) # for change-in-changes
library(pte) # for lagged outcomes
library(ife) # for interactive fixed effects
library(BMisc)
library(dplyr)
```

Below, we will basically try to replicate Question 1 from Exercise 1,
but use alternative identification strategies.

## Question 1 — change-in-changes

Use the `qte` package to compute all available group-time average
treatment effects, an event study, and an overall average treatment
effect. The function that can deal with multiple periods and variation
in treatment timing is called `cic2`. In the results below, I also allow
for one year of anticipation based on our discussion in the previous
exercise.

<div style="display: none;">

</div>

## Question 2 — lagged outcome

Use the `pte` package to compute all available group-time average
treatment effects, an event study, and an overall average treatment
effect. The function `pte_default` can allow for conditioning on lagged
outcomes (it can also allow for a number of other extensions as well —
see documentation) In the results below, I also allow for one year of
anticipation based on our discussion in the previous exercise.

<div style="display: none;">

</div>

## Question 3 — interactive fixed effects

Use the `ife` package to compute all available group-time average
treatment effects, an event study, and an overall average treatment
effect. The function that can deal with multiple periods and variation
in treatment timing is called `staggered_ife2` — this function will use
the groups to identify causal effect parameters and does not require us
to specify additional instruments. We will allow for one interactive
fixed effect, by setting `nife=1`, but you can try other values. `ife`
does not currently support allowing for anticipation, so we will remove
it for these results.

<div style="display: none;">

</div>

# Question 4

What do you make of the results in this excercise relative to each other
and relative to the previous results from Exercise 1 that used
difference-in-differences?

<div style="display: none;">

</div>
