# number of repetitions - default 100 - and draw seeds as random numbers from 1 to 1,000,000,000
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

