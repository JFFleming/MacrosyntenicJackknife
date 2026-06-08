
library(macrosyntR)
args = commandArgs(trailingOnly=TRUE)
getwd()
# Load table of orthologs and integrate with genomic coordinates :
my_orthologs <- load_orthologs(
  orthologs_table = args[1],
  bedfiles = c(
    "Bflo.bed",
    "Pyes.bed"
  )
)

# Draw an oxford grid :
p1 <- plot_oxford_grid(my_orthologs,
                       sp1_label = "Branchiostoma",
                       sp2_label = "Mizuhopecten")
p1

# Automatically reorder the Oxford grid and color the detected clusters (communities):
p2 <- plot_oxford_grid(my_orthologs,
                       sp1_label = "Branchiostoma",
                       sp2_label = "Mizuhopecten",
                       reorder = TRUE,
                       color_by = "clust")
p2

# Plot the significant linkage groups :
my_macrosynteny <- compute_macrosynteny(my_orthologs)
write.table(my_macrosynteny, sep="\t", file="Test_Table.tsv")
p3 <- plot_macrosynteny(my_macrosynteny)
p3


# Call the reordering function, test significance and plot it :
my_orthologs_reordered <- reorder_macrosynteny(my_orthologs)
my_macrosynteny <- compute_macrosynteny(my_orthologs_reordered)
p4 <- plot_macrosynteny(my_macrosynteny)
p4

