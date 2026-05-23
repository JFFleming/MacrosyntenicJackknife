n_reps <- 100
seeds <- sample.int(1e9, n_reps)

# save seeds for reproducibility
write.table(
  data.frame(seed = seeds),
  file = "seeds.txt",
  col.names = FALSE,
  row.names = FALSE,
  quote = FALSE
)

