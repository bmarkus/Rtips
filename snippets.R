# generate pw distance from PCA coordinates
Dmat <- df %>%
  # assuming a df[FID, PCA1, PCA2, ...] (plink style)
  select(starts_with('PC'),FID) %>% 
  column_to_rownames('FID') %>%
  dist(diag=FALSE, upper=TRUE) %>% 
  as.matrix()

# convert to pw
# https://stackoverflow.com/questions/27892100/distance-matrix-to-pairwise-distance-list-in-r
xy <- t(combn(colnames(Dmat), 2))
Dpw <- data.frame(xy, dist=Dmat[xy]) %>% 
  as_tibble()
