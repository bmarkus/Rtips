# Extract single list element as part of a "pipeline"
# https://community.rstudio.com/t/extract-single-list-element-as-part-of-a-pipeline/1095/5
# pipe this ... `[[`(1)

# contrasts in R
# https://rstudio-pubs-static.s3.amazonaws.com/65059_586f394d8eb84f84b1baaf56ffb6b47f.html
lm(y ~ relevel(cond, ref="C"), data=data)
