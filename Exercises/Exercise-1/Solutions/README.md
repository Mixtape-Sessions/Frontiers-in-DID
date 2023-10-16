
# Exercise 1 Solutions

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

<div style="border-left: 2px solid black; padding-left: 1rem">

<b>Solution:</b>

``` r
no_covs <- att_gt(yname="income",
                  tname="year",
                  idname="id",
                  gname="group",
                  data=job_displacement_data)
```

    Warning in pre_process_did(yname = yname, tname = tname, idname = idname, :
    Dropped 26 units that were already treated in the first period.

``` r
summary(no_covs)
```


    Call:
    att_gt(yname = "income", tname = "year", idname = "id", gname = "group", 
        data = job_displacement_data)

    Reference: Callaway, Brantly and Pedro H.C. Sant'Anna.  "Difference-in-Differences with Multiple Time Periods." Journal of Econometrics, Vol. 225, No. 2, pp. 200-230, 2021. <https://doi.org/10.1016/j.jeconom.2020.12.001>, <https://arxiv.org/abs/1803.09015> 

    Group-Time Average Treatment Effects:
     Group Time    ATT(g,t) Std. Error [95% Simult.  Conf. Band]  
      1985 1985  -9455.7583   3921.380   -19703.1482    791.6315  
      1985 1986 -14981.1547   4431.668   -26562.0350  -3400.2743 *
      1985 1987  -6129.2132   4422.875   -17687.1153   5428.6890  
      1985 1988  -4815.9179   4761.061   -17257.5712   7625.7354  
      1985 1990  -8011.9173   5965.174   -23600.1727   7576.3381  
      1985 1991  -8164.4924   5834.400   -23411.0054   7082.0207  
      1985 1992  -6325.8880   5760.825   -21380.1353   8728.3594  
      1985 1993  -9669.5840   5786.164   -24790.0482   5450.8802  
      1986 1985  -1801.9373   2490.342    -8309.7254   4705.8509  
      1986 1986  -1919.4474   3578.017   -11269.5595   7430.6647  
      1986 1987  -2596.8189   4633.111   -14704.1131   9510.4752  
      1986 1988  -2081.7535   7320.921   -21212.8605  17049.3535  
      1986 1990  -6064.0942   6972.770   -24285.4076  12157.2192  
      1986 1991  -5903.9636   7464.344   -25409.8645  13601.9372  
      1986 1992  -6804.4833   8122.359   -28029.9151  14420.9485  
      1986 1993  -1801.5755   7634.738   -21752.7504  18149.5994  
      1987 1985   4518.5745   5135.991    -8902.8505  17939.9994  
      1987 1986  -8012.4879   4393.421   -19493.4216   3468.4458  
      1987 1987   7048.8565   6527.596   -10009.1261  24106.8391  
      1987 1988   4489.4666   6600.151   -12758.1165  21737.0498  
      1987 1990   8004.1361   7432.054   -11417.3846  27425.6568  
      1987 1991   9475.0656   7940.100   -11274.0863  30224.2175  
      1987 1992   8533.5413  10940.393   -20056.0069  37123.0896  
      1987 1993   7881.3931   8293.453   -13791.1443  29553.9305  
      1988 1985  -8350.7706   4905.920   -21170.9724   4469.4311  
      1988 1986  -3420.8529   3552.422   -12704.0797   5862.3738  
      1988 1987  -3617.6742   3608.262   -13046.8210   5811.4726  
      1988 1988  -1173.8167   3100.307    -9275.5703   6927.9369  
      1988 1990    280.6263   5997.155   -15391.2005  15952.4531  
      1988 1991   6099.7271   4377.023    -5338.3541  17537.8083  
      1988 1992  13737.8166  13879.563   -22532.4014  50008.0347  
      1988 1993   1688.7819   7724.918   -18498.0533  21875.6170  
      1990 1985  -5281.5363   3241.277   -13751.6745   3188.6018  
      1990 1986   3654.1728   2481.321    -2830.0420  10138.3876  
      1990 1987   5934.8952   2823.433    -1443.3296  13313.1199  
      1990 1988   1034.1988   3447.775    -7975.5622  10043.9597  
      1990 1990  -4343.9488  12060.892   -35861.5971  27173.6996  
      1990 1991 -21910.2102   4808.983   -34477.0948  -9343.3255 *
      1990 1992 -15365.9271   3807.494   -25315.7095  -5416.1448 *
      1990 1993 -16411.1053   6347.687   -32998.9476    176.7370  
      1991 1985    891.2874   3625.418    -8582.6920  10365.2667  
      1991 1986  -2816.6357   3512.101   -11994.4942   6361.2229  
      1991 1987  -1340.0549   3141.413    -9549.2286   6869.1188  
      1991 1988  -7025.0387   3716.800   -16737.8179   2687.7405  
      1991 1990   2568.6223   6071.384   -13297.1820  18434.4267  
      1991 1991 -12150.6450   4046.556   -22725.1479  -1576.1421 *
      1991 1992   1433.9979   4518.417   -10373.5775  13241.5733  
      1991 1993  -2679.8275   7099.436   -21232.1462  15872.4912  
      1992 1985 -12110.0572   6872.698   -30069.8631   5849.7487  
      1992 1986  -3287.5606   2637.878   -10180.8894   3605.7681  
      1992 1987   2300.0285   3604.409    -7119.0498  11719.1067  
      1992 1988  -7273.9345   2897.878   -14846.6991    298.8300  
      1992 1990   7351.4926   4596.267    -4659.5206  19362.5058  
      1992 1991 -10031.7028   7418.021   -29416.5528   9353.1472  
      1992 1992  -8990.8504   4269.305   -20147.4435   2165.7426  
      1992 1993  -8662.6119  14706.615   -47094.0897  29768.8660  
      1993 1985  -7424.6641   5366.096   -21447.4029   6598.0747  
      1993 1986    677.9060   3188.292    -7653.7707   9009.5827  
      1993 1987   1424.1385   3897.973    -8762.0850  11610.3619  
      1993 1988   4778.2556   1613.587      561.6137   8994.8975 *
      1993 1990  -3797.3928   4231.945   -14856.3542   7261.5686  
      1993 1991   3664.8825   6458.334   -13212.1024  20541.8674  
      1993 1992  -4108.9169   5638.206   -18842.7343  10624.9006  
      1993 1993 -22828.3617   6755.109   -40480.8836  -5175.8398 *
    ---
    Signif. codes: `*' confidence band does not cover 0

    P-value for pre-test of parallel trends assumption:  0
    Control Group:  Never Treated,  Anticipation Periods:  0
    Estimation Method:  Doubly Robust

</div>

2)  *Bonus Question* Try to manually calculate $ATT(g=1992, t=1992)$.
    Can you calculate exactly the same number as in part (a)?

<div style="border-left: 2px solid black; padding-left: 1rem">

<b>Solution:</b>

``` r
  mean(subset(job_displacement_data, group==1992 & year==1992)$income) -
    mean(subset(job_displacement_data, group==1992 & year==1991)$income) - 
    ( mean(subset(job_displacement_data, group==0 & year==1992)$income) -
    mean(subset(job_displacement_data, group==0 & year==1991)$income) )
```

    [1] -8990.85

</div>

3)  Aggregate the group-time average treatment effects into an event
    study and plot the results. What do you notice? Is there evidence
    against parallel trends?

<div style="border-left: 2px solid black; padding-left: 1rem">

<b>Solution:</b>

``` r
  no_covs_es <- aggte(no_covs, type="dynamic")
  ggdid(no_covs_es)
```

![](exercise1_sol_files/figure-gfm/unnamed-chunk-7-1.png)

</div>

4)  Aggregate the group-time average treatment effects into a single
    overall treatment effect. How do you interpret the results?

<div style="border-left: 2px solid black; padding-left: 1rem">

<b>Solution:</b>

``` r
  no_covs_overall <- aggte(no_covs, type="group")
  summary(no_covs_overall)
```


    Call:
    aggte(MP = no_covs, type = "group")

    Reference: Callaway, Brantly and Pedro H.C. Sant'Anna.  "Difference-in-Differences with Multiple Time Periods." Journal of Econometrics, Vol. 225, No. 2, pp. 200-230, 2021. <https://doi.org/10.1016/j.jeconom.2020.12.001>, <https://arxiv.org/abs/1803.09015> 


    Overall summary of ATT's based on group/cohort aggregation:  
           ATT    Std. Error     [ 95%  Conf. Int.]  
     -5631.049       2062.71  -9673.886   -1588.211 *


    Group Effects:
     Group   Estimate Std. Error [95% Simult.  Conf. Band]  
      1985  -8444.241   4638.444    -18986.414    2097.933  
      1986  -3881.734   6184.505    -17937.767   10174.299  
      1987   7572.077   6545.803     -7305.108   22449.261  
      1988   4126.627   4451.676     -5991.063   14244.317  
      1990 -14507.798   4525.356    -24792.947   -4222.649 *
      1991  -4465.492   4645.462    -15023.615    6092.632  
      1992  -8826.731   8072.496    -27173.757    9520.294  
      1993 -22828.362   6407.897    -37392.115   -8264.608 *
    ---
    Signif. codes: `*' confidence band does not cover 0

    Control Group:  Never Treated,  Anticipation Periods:  0
    Estimation Method:  Doubly Robust

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

<div style="border-left: 2px solid black; padding-left: 1rem">

<b>Solution:</b>

There is a moderate amount of evidence for anticipation in the previous
results. It hinges on the estimate for event-time equal to -1. It is
negative which is in line with the discussion about anticipation above,
but it is only marginally statistically significant.

</div>

2)  Repeat parts (a)-(d) of Question 1 allowing for one year of
    anticipation.

<div style="border-left: 2px solid black; padding-left: 1rem">

<b>Solution:</b>

``` r
  # part a
  ant_res <- att_gt(yname="income",
                    tname="year",
                    idname="id",
                    gname="group",
                    data=job_displacement_data,
                    anticipation=1)
```

    Warning in pre_process_did(yname = yname, tname = tname, idname = idname, :
    Dropped 26 units that were already treated in the first period.

``` r
  summary(ant_res)
```


    Call:
    att_gt(yname = "income", tname = "year", idname = "id", gname = "group", 
        data = job_displacement_data, anticipation = 1)

    Reference: Callaway, Brantly and Pedro H.C. Sant'Anna.  "Difference-in-Differences with Multiple Time Periods." Journal of Econometrics, Vol. 225, No. 2, pp. 200-230, 2021. <https://doi.org/10.1016/j.jeconom.2020.12.001>, <https://arxiv.org/abs/1803.09015> 

    Group-Time Average Treatment Effects:
     Group Time    ATT(g,t) Std. Error [95% Simult.  Conf. Band]  
      1986 1985  -1801.9373   2625.472    -8442.9564   4839.0819  
      1986 1986  -3721.3846   3401.437   -12325.1715   4882.4023  
      1986 1987  -4398.7562   3893.398   -14246.9370   5449.4246  
      1986 1988  -3883.6907   6477.813   -20269.0387  12501.6572  
      1986 1990  -7866.0314   5910.116   -22815.4147   7083.3518  
      1986 1991  -7705.9009   6323.799   -23701.6763   8289.8746  
      1986 1992  -8606.4205   6727.753   -25623.9818   8411.1407  
      1986 1993  -3603.5128   6639.184   -20397.0409  13190.0154  
      1987 1985   4518.5745   5520.583    -9445.5009  18482.6498  
      1987 1986  -8012.4879   4710.964   -19928.6674   3903.6915  
      1987 1987   -963.6314   6794.495   -18150.0135  16222.7506  
      1987 1988  -3523.0213   7702.663   -23006.5756  15960.5330  
      1987 1990     -8.3518   6084.064   -15397.7299  15381.0262  
      1987 1991   1462.5776   7289.988   -16977.1311  19902.2864  
      1987 1992    521.0534   9585.570   -23725.2317  24767.3385  
      1987 1993   -131.0948   7321.440   -18650.3622  18388.1725  
      1988 1985  -8350.7706   4644.408   -20098.6004   3397.0591  
      1988 1986  -3420.8529   3564.361   -12436.7511   5595.0452  
      1988 1987  -3617.6742   3726.049   -13042.5544   5807.2060  
      1988 1988  -4791.4908   4669.170   -16601.9552   7018.9736  
      1988 1990  -3337.0478   8117.070   -23868.8254  17194.7297  
      1988 1991   2482.0529   6326.173   -13519.7292  18483.8350  
      1988 1992  10120.1424  14880.404   -27519.1980  47759.4829  
      1988 1993  -1928.8923   7744.430   -21518.0936  17660.3090  
      1990 1985  -5281.5363   3551.675   -14265.3454   3702.2728  
      1990 1986   3654.1728   2483.678    -2628.1836   9936.5291  
      1990 1987   5934.8952   3020.203    -1704.5781  13574.3684  
      1990 1988   1034.1988   3365.498    -7478.6834   9547.0809  
      1990 1990  -4343.9488  12307.238   -35474.5769  26786.6794  
      1990 1991 -21910.2102   4892.813   -34286.3693  -9534.0510 *
      1990 1992 -15365.9271   3944.358   -25343.0111  -5388.8432 *
      1990 1993 -16411.1053   6234.352   -32180.6309   -641.5798 *
      1991 1985    891.2874   3786.800    -8687.2606  10469.8353  
      1991 1986  -2816.6357   3624.622   -11984.9603   6351.6890  
      1991 1987  -1340.0549   3090.425    -9157.1511   6477.0414  
      1991 1988  -7025.0387   3742.442   -16491.3834   2441.3060  
      1991 1990   2568.6223   6422.567   -13676.9837  18814.2283  
      1991 1991  -9582.0227   7944.092   -29676.2595  10512.2142  
      1991 1992   4002.6202   7830.637   -15804.6375  23809.8779  
      1991 1993   -111.2052   9745.241   -24761.3723  24538.9620  
      1992 1985 -12110.0572   6920.591   -29615.3942   5395.2798  
      1992 1986  -3287.5606   2698.312   -10112.8237   3537.7024  
      1992 1987   2300.0285   3610.658    -6832.9742  11433.0311  
      1992 1988  -7273.9345   2868.963   -14530.8539    -17.0152 *
      1992 1990   7351.4926   4385.243    -3740.7904  18443.7756  
      1992 1991 -10031.7028   7851.303   -29891.2343   9827.8287  
      1992 1992 -19022.5532   6927.824   -36546.1859  -1498.9206 *
      1992 1993 -18694.3146   8569.343   -40370.0965   2981.4672  
      1993 1985  -7424.6641   5282.206   -20785.7769   5936.4486  
      1993 1986    677.9060   3360.158    -7821.4688   9177.2808  
      1993 1987   1424.1385   3921.959    -8496.2872  11344.5641  
      1993 1988   4778.2556   1668.293      558.3803   8998.1308 *
      1993 1990  -3797.3928   4449.040   -15051.0479   7456.2623  
      1993 1991   3664.8825   6478.355   -12721.8357  20051.6007  
      1993 1992  -4108.9169   5687.407   -18494.9665  10277.1328  
      1993 1993 -26937.2785   5261.651   -40246.3976 -13628.1594 *
    ---
    Signif. codes: `*' confidence band does not cover 0

    P-value for pre-test of parallel trends assumption:  0
    Control Group:  Never Treated,  Anticipation Periods:  1
    Estimation Method:  Doubly Robust

``` r
  # part b
  mean(subset(job_displacement_data, group==1992 & year==1992)$income) -
    mean(subset(job_displacement_data, group==1992 & year==1990)$income) - 
    ( mean(subset(job_displacement_data, group==0 & year==1992)$income) -
    mean(subset(job_displacement_data, group==0 & year==1990)$income) )
```

    [1] -19022.55

``` r
  # part c
  ant_es <- aggte(ant_res, type="dynamic")
  ggdid(ant_es)
```

![](exercise1_sol_files/figure-gfm/unnamed-chunk-10-1.png)

``` r
  # part d
  ant_overall <- aggte(ant_res, type="group")
  summary(ant_overall)
```


    Call:
    aggte(MP = ant_res, type = "group")

    Reference: Callaway, Brantly and Pedro H.C. Sant'Anna.  "Difference-in-Differences with Multiple Time Periods." Journal of Econometrics, Vol. 225, No. 2, pp. 200-230, 2021. <https://doi.org/10.1016/j.jeconom.2020.12.001>, <https://arxiv.org/abs/1803.09015> 


    Overall summary of ATT's based on group/cohort aggregation:  
           ATT    Std. Error     [ 95%  Conf. Int.]  
     -7711.634      2452.866  -12519.16   -2904.105 *


    Group Effects:
     Group    Estimate Std. Error [95% Simult.  Conf. Band]  
      1986  -5683.6710   5804.551     -18428.53    7061.184  
      1987   -440.4114   6409.143     -14512.75   13631.926  
      1988    508.9529   5705.130     -12017.61   13035.514  
      1990 -14507.7979   4312.172     -23975.89   -5039.708 *
      1991  -1896.8692   8270.962     -20057.14   16263.401  
      1992 -18858.4339   4734.962     -29254.83   -8462.038 *
      1993 -26937.2785   5648.167     -39338.77  -14535.791 *
    ---
    Signif. codes: `*' confidence band does not cover 0

    Control Group:  Never Treated,  Anticipation Periods:  1
    Estimation Method:  Doubly Robust

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

<div style="border-left: 2px solid black; padding-left: 1rem">

<b>Solution:</b>

``` r
  # part a
  covs_res <- att_gt(yname="income",
                    tname="year",
                    idname="id",
                    gname="group",
                    data=job_displacement_data,
                    anticipation=1,
                    xformla=~female + white)
```

    Warning in pre_process_did(yname = yname, tname = tname, idname = idname, :
    Dropped 26 units that were already treated in the first period.

    Warning in pre_process_did(yname = yname, tname = tname, idname = idname, : Be aware that there are some small groups in your dataset.
      Check groups: 1992,1993.

``` r
  summary(covs_res)
```


    Call:
    att_gt(yname = "income", tname = "year", idname = "id", gname = "group", 
        xformla = ~female + white, data = job_displacement_data, 
        anticipation = 1)

    Reference: Callaway, Brantly and Pedro H.C. Sant'Anna.  "Difference-in-Differences with Multiple Time Periods." Journal of Econometrics, Vol. 225, No. 2, pp. 200-230, 2021. <https://doi.org/10.1016/j.jeconom.2020.12.001>, <https://arxiv.org/abs/1803.09015> 

    Group-Time Average Treatment Effects:
     Group Time    ATT(g,t) Std. Error [95% Simult.  Conf. Band]  
      1986 1985  -1724.0034   2807.315    -8728.0287   5280.0219  
      1986 1986  -4258.8672   3316.394   -12533.0037   4015.2693  
      1986 1987  -4861.6136   3856.869   -14484.1924   4760.9653  
      1986 1988  -4729.6121   6288.107   -20417.9344  10958.7103  
      1986 1990  -8685.9902   6283.129   -24361.8927   6989.9124  
      1986 1991  -8753.8554   6596.322   -25211.1500   7703.4391  
      1986 1992  -9530.3951   6846.081   -26610.8172   7550.0269  
      1986 1993  -4727.7652   6472.128   -20875.2059  11419.6756  
      1987 1985   4559.7049   5215.430    -8452.3733  17571.7831  
      1987 1986  -8337.6804   4613.229   -19847.3167   3171.9559  
      1987 1987  -1244.4854   6982.147   -18664.3820  16175.4111  
      1987 1988  -4009.1142   7759.701   -23368.9467  15350.7183  
      1987 1990   -483.2506   6291.223   -16179.3478  15212.8467  
      1987 1991    865.8558   7420.484   -17647.6559  19379.3675  
      1987 1992     -1.1369   9584.363   -23913.3530  23911.0792  
      1987 1993   -760.5834   7431.374   -19301.2654  17780.0986  
      1988 1985  -8427.9592   4591.569   -19883.5551   3027.6367  
      1988 1986  -3208.6634   3430.042   -11766.3425   5349.0157  
      1988 1987  -3540.3348   3685.617   -12735.6532   5654.9836  
      1988 1988  -4496.7178   4507.551   -15742.6966   6749.2611  
      1988 1990  -2886.2705   7892.628   -22577.7449  16805.2038  
      1988 1991   3026.1289   6046.821   -12060.2055  18112.4632  
      1988 1992  10422.7498  14817.144   -26544.8372  47390.3367  
      1988 1993  -1710.3233   7345.894   -20037.7385  16617.0920  
      1990 1985  -5423.4224   3410.698   -13932.8398   3085.9950  
      1990 1986   4124.3571   2627.329    -2430.6187  10679.3328  
      1990 1987   6034.5096   3215.492    -1987.8860  14056.9052  
      1990 1988   1473.8450   3539.265    -7356.3381  10304.0281  
      1990 1990  -4087.0904  12754.627   -35908.8623  27734.6815  
      1990 1991 -21451.7077   4562.579   -32834.9768 -10068.4385 *
      1990 1992 -15350.4684   3926.331   -25146.3497  -5554.5871 *
      1990 1993 -16489.8656   6460.707   -32608.8111   -370.9202 *
      1991 1985    787.4357   3677.531    -8387.7100   9962.5813  
      1991 1986  -2463.7125   3889.214   -12166.9903   7239.5653  
      1991 1987  -1271.9440   3264.267    -9416.0293   6872.1413  
      1991 1988  -6698.7830   3792.759   -16161.4132   2763.8472  
      1991 1990   2753.4298   5840.845   -11819.0105  17325.8701  
      1991 1991  -9246.2829   8041.720   -29309.7295  10817.1637  
      1991 1992   4013.8999   7730.061   -15271.9835  23299.7833  
      1991 1993   -162.2495   9968.578   -25033.0522  24708.5531  
      1992 1985 -12170.1207   6684.270   -28846.8383   4506.5969  
      1992 1986  -3584.4939   2566.824    -9988.5139   2819.5262  
      1992 1987   2598.5246   3604.461    -6394.3154  11591.3645  
      1992 1988  -7330.9148   2970.064   -14740.9856     79.1561  
      1992 1990   7649.2124   4887.750    -4545.3323  19843.7571  
      1992 1991 -10130.9141   7626.948   -29159.5386   8897.7104  
      1992 1992 -19327.7970   6860.799   -36444.9394  -2210.6546 *
      1992 1993 -19410.4421   8742.874   -41223.2127   2402.3285  
      1993 1985  -7391.9287   5860.727   -22013.9734   7230.1161  
      1993 1986     50.7636   3380.339    -8382.9103   8484.4376  
      1993 1987   1618.3041   3821.959    -7917.1759  11153.7842  
      1993 1988   4453.4544   1776.459       21.3307   8885.5781 *
      1993 1990  -3630.4984   4004.217   -13620.6983   6359.7014  
      1993 1991   3439.7874   6714.051   -13311.2324  20190.8071  
      1993 1992  -4123.7577   5784.147   -18554.7399  10307.2245  
      1993 1993 -27304.4090   5575.419   -41214.6317 -13394.1864 *
    ---
    Signif. codes: `*' confidence band does not cover 0

    P-value for pre-test of parallel trends assumption:  0
    Control Group:  Never Treated,  Anticipation Periods:  1
    Estimation Method:  Doubly Robust

``` r
  # part c
  covs_es <- aggte(covs_res, type="dynamic")
  ggdid(covs_es)
```

![](exercise1_sol_files/figure-gfm/unnamed-chunk-11-1.png)

``` r
  # part d
  covs_overall <- aggte(covs_res, type="group")
  summary(covs_overall)
```


    Call:
    aggte(MP = covs_res, type = "group")

    Reference: Callaway, Brantly and Pedro H.C. Sant'Anna.  "Difference-in-Differences with Multiple Time Periods." Journal of Econometrics, Vol. 225, No. 2, pp. 200-230, 2021. <https://doi.org/10.1016/j.jeconom.2020.12.001>, <https://arxiv.org/abs/1803.09015> 


    Overall summary of ATT's based on group/cohort aggregation:  
           ATT    Std. Error     [ 95%  Conf. Int.]  
     -7931.965      2287.069  -12414.54   -3449.392 *


    Group Effects:
     Group    Estimate Std. Error [95% Simult.  Conf. Band]  
      1986  -6506.8712   5436.927     -18443.65    5429.912  
      1987   -938.7858   6659.496     -15559.72   13682.150  
      1988    871.1134   6164.210     -12662.42   14404.649  
      1990 -14344.7830   4232.224     -23636.64   -5052.927 *
      1991  -1798.2108   8210.508     -19824.40   16227.975  
      1992 -19369.1196   4610.090     -29490.58   -9247.658 *
      1993 -27304.4090   6057.209     -40603.02  -14005.794 *
    ---
    Signif. codes: `*' confidence band does not cover 0

    Control Group:  Never Treated,  Anticipation Periods:  1
    Estimation Method:  Doubly Robust

</div>

2)  By default, the `did` package uses the doubly robust approach that
    we discussed during our session. How do the results change if you
    use a regression approach or propensity score re-weighting?

<div style="border-left: 2px solid black; padding-left: 1rem">

<b>Solution:</b>

For simplicity, I am just going to show the overall results when using
the regression approach and the propensity score re-weighting approach.

``` r
  reg_res <- att_gt(yname="income",
                    tname="year",
                    idname="id",
                    gname="group",
                    data=job_displacement_data,
                    anticipation=1,
                    xformla=~female + white,
                    est_method="reg")
```

    Warning in pre_process_did(yname = yname, tname = tname, idname = idname, :
    Dropped 26 units that were already treated in the first period.

    Warning in pre_process_did(yname = yname, tname = tname, idname = idname, : Be aware that there are some small groups in your dataset.
      Check groups: 1992,1993.

``` r
  summary(aggte(reg_res, type="group"))
```


    Call:
    aggte(MP = reg_res, type = "group")

    Reference: Callaway, Brantly and Pedro H.C. Sant'Anna.  "Difference-in-Differences with Multiple Time Periods." Journal of Econometrics, Vol. 225, No. 2, pp. 200-230, 2021. <https://doi.org/10.1016/j.jeconom.2020.12.001>, <https://arxiv.org/abs/1803.09015> 


    Overall summary of ATT's based on group/cohort aggregation:  
           ATT    Std. Error     [ 95%  Conf. Int.]  
     -7919.691      2344.635  -12515.09   -3324.291 *


    Group Effects:
     Group    Estimate Std. Error [95% Simult.  Conf. Band]  
      1986  -6434.0559   5267.914     -18081.92    5213.807  
      1987   -912.7508   6460.831     -15198.27   13372.766  
      1988    862.1890   6138.900     -12711.51   14435.887  
      1990 -14343.8838   4481.354     -24252.59   -4435.180 *
      1991  -1796.2167   8253.437     -20045.36   16452.924  
      1992 -19441.0738   4402.083     -29174.50   -9707.646 *
      1993 -27302.1029   5670.956     -39841.13  -14763.075 *
    ---
    Signif. codes: `*' confidence band does not cover 0

    Control Group:  Never Treated,  Anticipation Periods:  1
    Estimation Method:  Outcome Regression

``` r
  ipw_res <- att_gt(yname="income",
                    tname="year",
                    idname="id",
                    gname="group",
                    data=job_displacement_data,
                    anticipation=1,
                    xformla=~female + white,
                    est_method="ipw")
```

    Warning in pre_process_did(yname = yname, tname = tname, idname = idname, : Dropped 26 units that were already treated in the first period.

    Warning in pre_process_did(yname = yname, tname = tname, idname = idname, : Be aware that there are some small groups in your dataset.
      Check groups: 1992,1993.

``` r
  summary(aggte(ipw_res, type="group"))
```


    Call:
    aggte(MP = ipw_res, type = "group")

    Reference: Callaway, Brantly and Pedro H.C. Sant'Anna.  "Difference-in-Differences with Multiple Time Periods." Journal of Econometrics, Vol. 225, No. 2, pp. 200-230, 2021. <https://doi.org/10.1016/j.jeconom.2020.12.001>, <https://arxiv.org/abs/1803.09015> 


    Overall summary of ATT's based on group/cohort aggregation:  
          ATT    Std. Error     [ 95%  Conf. Int.]  
     -7931.69      2134.468  -12115.17   -3748.209 *


    Group Effects:
     Group    Estimate Std. Error [95% Simult.  Conf. Band]  
      1986  -6506.2796   5358.326     -18515.08    5502.524  
      1987   -938.6980   6477.483     -15455.70   13578.302  
      1988    871.1522   6087.633     -12772.14   14514.441  
      1990 -14345.0498   4512.996     -24459.34   -4230.757 *
      1991  -1798.1771   8360.382     -20535.03   16938.678  
      1992 -19368.1395   4671.304     -29837.22   -8899.055 *
      1993 -27303.3746   5359.530     -39314.88  -15291.873 *
    ---
    Signif. codes: `*' confidence band does not cover 0

    Control Group:  Never Treated,  Anticipation Periods:  1
    Estimation Method:  Inverse Probability Weighting

You can see that the results are very similar across estimation
strategies in this example.

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

<div style="border-left: 2px solid black; padding-left: 1rem">

<b>Solution:</b>

``` r
  # part a
  occ_res <- att_gt(yname="income",
                    tname="year",
                    idname="id",
                    gname="group",
                    data=job_displacement_data,
                    anticipation=1,
                    xformla=~female + white + occ_score)
```

    Warning in pre_process_did(yname = yname, tname = tname, idname = idname, :
    Dropped 26 units that were already treated in the first period.

    Warning in pre_process_did(yname = yname, tname = tname, idname = idname, : Be aware that there are some small groups in your dataset.
      Check groups: 1992,1993.

``` r
  summary(occ_res)
```


    Call:
    att_gt(yname = "income", tname = "year", idname = "id", gname = "group", 
        xformla = ~female + white + occ_score, data = job_displacement_data, 
        anticipation = 1)

    Reference: Callaway, Brantly and Pedro H.C. Sant'Anna.  "Difference-in-Differences with Multiple Time Periods." Journal of Econometrics, Vol. 225, No. 2, pp. 200-230, 2021. <https://doi.org/10.1016/j.jeconom.2020.12.001>, <https://arxiv.org/abs/1803.09015> 

    Group-Time Average Treatment Effects:
     Group Time    ATT(g,t) Std. Error [95% Simult.  Conf. Band]  
      1986 1985  -2195.2252   2614.410    -8794.4183   4403.9679  
      1986 1986  -4943.5726   3498.218   -13773.6391   3886.4938  
      1986 1987  -5648.5248   4049.587   -15870.3349   4573.2852  
      1986 1988  -5486.8776   6626.075   -22212.1595  11238.4043  
      1986 1990  -9355.8673   6209.571   -25029.8251   6318.0905  
      1986 1991  -9341.8431   6155.359   -24878.9608   6195.2747  
      1986 1992 -10108.9739   6931.922   -27606.2621   7388.3143  
      1986 1993  -5529.8989   6428.499   -21756.4671  10696.6693  
      1987 1985   3820.8904   5589.225   -10287.2142  17928.9950  
      1987 1986  -8340.0613   4428.396   -19518.0479   2837.9254  
      1987 1987  -1140.5127   7206.757   -19331.5279  17050.5026  
      1987 1988  -3872.3621   8118.160   -24363.9065  16619.1822  
      1987 1990   -245.3064   6601.600   -16908.8097  16418.1968  
      1987 1991   1163.8056   7353.880   -17398.5737  19726.1849  
      1987 1992    357.4786   9971.172   -24811.3675  25526.3248  
      1987 1993   -573.4507   7423.956   -19312.7116  18165.8102  
      1988 1985  -9335.5672   4841.074   -21555.2179   2884.0835  
      1988 1986  -3340.6154   3670.648   -12605.9236   5924.6928  
      1988 1987  -3382.3715   4058.888   -13627.6585   6862.9156  
      1988 1988  -4249.2023   4719.396   -16161.7188   7663.3141  
      1988 1990  -2636.2457   7782.676   -22280.9743  17008.4829  
      1988 1991   3600.9662   6333.187   -12385.0193  19586.9518  
      1988 1992  10870.4646  15165.245   -27409.0594  49149.9886  
      1988 1993  -1193.1813   7524.621   -20186.5371  17800.1745  
      1990 1985  -6306.9131   3274.371   -14571.9539   1958.1277  
      1990 1986   3619.3463   2796.236    -3438.8040  10677.4965  
      1990 1987   6300.9857   3155.142    -1663.1024  14265.0738  
      1990 1988   1669.2779   3387.010    -6880.0799  10218.6357  
      1990 1990  -3975.3758  12214.970   -34807.9300  26857.1785  
      1990 1991 -21181.3377   4612.681   -32824.4880  -9538.1874 *
      1990 1992 -15120.4248   3717.064   -24502.8924  -5737.9572 *
      1990 1993 -16136.7404   5992.606   -31263.0452  -1010.4355 *
      1991 1985    275.2798   3799.138    -9314.3564   9864.9159  
      1991 1986  -2972.7479   3726.340   -12378.6300   6433.1341  
      1991 1987  -1061.8712   3245.588    -9254.2571   7130.5148  
      1991 1988  -6533.7425   4059.619   -16780.8763   3713.3913  
      1991 1990   2973.9229   5994.632   -12157.4937  18105.3395  
      1991 1991  -8630.5915   8508.100   -30106.4067  12845.2236  
      1991 1992   4461.4852   8142.776   -16092.1954  25015.1657  
      1991 1993    625.5103  10572.812   -26061.9707  27312.9913  
      1992 1985 -11419.6688   6280.085   -27271.6165   4432.2790  
      1992 1986  -3525.3900   2593.018   -10070.5860   3019.8059  
      1992 1987   2689.5473   3625.758    -6462.4511  11841.5458  
      1992 1988  -7336.2075   2920.588   -14708.2421     35.8272  
      1992 1990   7673.1535   4836.391    -4534.6783  19880.9853  
      1992 1991 -10337.3059   7584.832   -29482.6438   8808.0320  
      1992 1992 -19895.1794   7168.608   -37989.9018  -1800.4570 *
      1992 1993 -19597.7636   8631.207   -41384.3201   2188.7930  
      1993 1985  -7566.2072   4390.785   -18649.2569   3516.8425  
      1993 1986     50.1090   3507.174    -8802.5634   8902.7814  
      1993 1987   1781.7444   3702.822    -7564.7760  11128.2648  
      1993 1988   4377.3771   1649.745      213.1536   8541.6006 *
      1993 1990  -3777.5137   4480.522   -15087.0732   7532.0458  
      1993 1991   3464.8956   6865.545   -13864.8455  20794.6368  
      1993 1992  -4041.1832   5553.203   -18058.3617   9975.9954  
      1993 1993 -27091.4909   5812.021   -41761.9695 -12421.0124 *
    ---
    Signif. codes: `*' confidence band does not cover 0

    P-value for pre-test of parallel trends assumption:  0
    Control Group:  Never Treated,  Anticipation Periods:  1
    Estimation Method:  Doubly Robust

``` r
  # part c
  occ_es <- aggte(occ_res, type="dynamic")
  ggdid(occ_es)
```

![](exercise1_sol_files/figure-gfm/unnamed-chunk-15-1.png)

``` r
  # part d
  occ_overall <- aggte(occ_res, type="group")
  summary(occ_overall)
```


    Call:
    aggte(MP = occ_res, type = "group")

    Reference: Callaway, Brantly and Pedro H.C. Sant'Anna.  "Difference-in-Differences with Multiple Time Periods." Journal of Econometrics, Vol. 225, No. 2, pp. 200-230, 2021. <https://doi.org/10.1016/j.jeconom.2020.12.001>, <https://arxiv.org/abs/1803.09015> 


    Overall summary of ATT's based on group/cohort aggregation:  
           ATT    Std. Error     [ 95%  Conf. Int.]  
     -7873.709      2324.263  -12429.18   -3318.238 *


    Group Effects:
     Group    Estimate Std. Error [95% Simult.  Conf. Band]  
      1986  -7202.2226   5687.788     -19459.88    5055.437  
      1987   -718.3913   6494.437     -14714.45   13277.665  
      1988   1278.5603   6505.274     -12740.85   15297.970  
      1990 -14103.4696   4192.969     -23139.67   -5067.269 *
      1991  -1181.1987   8343.273     -19161.65   16799.254  
      1992 -19746.4715   4458.380     -29354.65  -10138.289 *
      1993 -27091.4909   5562.073     -39078.23  -15104.757 *
    ---
    Signif. codes: `*' confidence band does not cover 0

    Control Group:  Never Treated,  Anticipation Periods:  1
    Estimation Method:  Doubly Robust

</div>

2)  What additional assumptions (with respect to occupation) do you need
    to make in order to rationalize this approach?
