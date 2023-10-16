
# Exercise 1

This exercise will involve estimating causal effect parameters using a
difference-in-differences identification strategy that involves
conditioning on covariates in the parallel trends assumption and
possibly allows for anticipation effects.

In particular, we will use data from the National Longitudinal Study of
Youth to learn about causal effects of job displacement (where job
displacement roughly means “losing your job through no fault of your
own” — a mass layoff is a main example).

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

For the results below, we will mainly use the `did` package which you
can install using `install.packages("did")`, and you can load it using

``` r
library(did)
```

## Question 1

We will start by computing group-time average treatment effects without
including any covariates in the parallel trends assumption.

1)  Use the `did` package to compute all available group-time average
    treatment effects.

<div style="display: none;">

</div>

2)  *Bonus Question* Try to manually calculate $ATT(g=1992, t=1992)$.
    Can you calculate exactly the same number as in part (a)?

<div style="display: none;">

</div>

3)  Aggregate the group-time average treatment effects into an event
    study and plot the results. What do you notice? Is there evidence
    against parallel trends?

<div style="display: none;">

</div>

4)  Aggregate the group-time average treatment effects into a single
    overall treatment effect. How do you interpret the results?

<div style="display: none;">

</div>

# Question 2

A major issue in the job displacement literature concerns a version of
anticipation. In particular, there is some empirical evidence that
earnings of displaced workers start to decline *before* they are
actually displaced (a rough explanation is that firms where there are
mass layoffs typically “struggle” in the time period before the mass
layoff actually takes place and this can lead to slower income growth
for workers at those firms).

1)  Is there evidence of anticipation in your results from Question 1?

<div style="display: none;">

</div>

2)  Repeat parts (a)-(d) of Question 1 allowing for one year of
    anticipation.

<div style="display: none;">

</div>

# Question 3

Now, let’s suppose that we think that parallel trends holds only after
we condition on a person sex and race (in reality, you could think of
including many other variables in the parallel trends assumption, but
let’s just keep it simple). In my view, I think allowing for
anticipation is desirable in this setting too, so let’s keep allowing
for one year of anticipation.

1)  Answer parts (a), (c), and (d) of Question 1 but including `sex` and
    `white` as covariates.

<div style="display: none;">

</div>

2)  By default, the `did` package uses the doubly robust approach that
    we discussed during our session. How do the results change if you
    use a regression approach or propensity score re-weighting?

<div style="display: none;">

</div>

# Question 4

Finally, the data that we have contains a variable called `occ_score`
which is roughly a variable that measures the occupation “quality”.
Suppose that we (i) are interested in including a person’s occupation in
the parallel trends assumption, (ii) are satisfied that `occ_score`
sufficiently summarizes a person’s occupation, but (iii) are worried
that a person’s occupation is a “bad control” (in the sense that it
could be affected by the treatment).

1)  Repeat parts (a), (c), and (d) of Question 1 but including
    `occ_score` in the parallel trends assumption. Continue to allow for
    1 year of anticipation effects.

<div style="display: none;">

</div>

2)  What additional assumptions (with respect to occupation) do you need
    to make in order to rationalize this approach?
