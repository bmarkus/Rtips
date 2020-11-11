# Linear Models using lm
# -----------------------

# 3 different ways to get a likelihood ratio test between nested models 
# Note: alt model includes the null model parameters
# these are the output of lm.
# links: 
# https://api.rpubs.com/tomanderson_34/lrt
# https://stackoverflow.com/questions/40456314/how-do-i-get-rss-from-a-linear-model-output

alt.df <- alt_model$df.residual
null.df <- null_model$df.residual
alt.lik <- logLik(alt_model)
null.lik <- logLik(null_model)
test_stat <- -2 * (as.numeric(null.lik) - as.numeric(alt.lik))
pchisq(test_stat, df = null.df-alt.df, lower.tail = FALSE)
# 1.712318e-17  

# calculate using the redsiduals
# Broman, Karl W., and Saunak Sen. A Guide to QTL Mapping with R/qtl. Vol. 46. New York: Springer, 2009. (Cp 4.1, Pg77)
# should be the same as loglik calculations
# loglik = -n/2Log(RSS)
alt.rss <- deviance(alt_model)
null.rss <- deviance(null_model)
n=length(resid(null_model))
pchisq(2 * n/2*log(null.rss/alt.rss), 
                              null.df - alt.df,
                              lower.tail = FALSE)
# 1.712318e-17

anova(null_model, alt_model, test='Chisq') %>% 
  as_tibble()
#   Res.Df   RSS    Df `Sum of Sq` `Pr(>Chi)`
#    <dbl> <dbl> <dbl>       <dbl>      <dbl>
# 1    237  44.9    NA        NA    NA       
# 2    234  31.9     3        13.0   1.74e-20
# slightly lower p value. Why? 

