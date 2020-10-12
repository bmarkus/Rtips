
# generate PCA from melted (genomics) data
# -----------------------------------------
# Assuming input df[marker_key, sample, gt(numeric)]

# Make a matrix with samples in the columns
data_as_mat <- melted_gt %>% 
  spread(sample, gt) %>% 
  column_to_rownames('marker_key') %>% 
  as.matrix()

# PCA on vcf matrix (sample in columns)
pca <- prcomp(t(data_as_mat), scale=TRUE, center = TRUE)
var_explained <- data.frame(PC = 1:length(pca$sdev), percent_var = pca$sdev^2/sum(pca$sdev^2)*100)
pca_df = as.data.frame(pca$x) %>% tibble::rownames_to_column(var='Sample')

# plot
pca_df %>% 
  ggplot(aes(x=PC1, y=PC2, label=Sample))+
  geom_point()


# generate pw distance from PCA coordinates
# -----------------------------------------
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
