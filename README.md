This is a preliminary repository containing the scripts used in the manuscript "The phylogenetic affinities of Chaetognathifera, with consideration of systematic error"
All scripts here require more commenting, and more detailed commenting, in order to be truly publication quality.

The scripts contained in here are (in order of intended use):
- GetSeeds.r: this RScript obtains a list of 100 randomly generated seeds for use in the subsampling process. This ensures that subsamples are repeatable.
- SubSample.PresentationQuality.sh: This shell script uses the seed file to generate 100 subsample datasets, then calls the R script TestSignificance.R (discussed below) to assess each dataset. Once completed, it outputs three summary files:
  - Unique.txt - a list of each pair recovered across the 100 subsamples.
  - Unique.Appearances.tsv - a tab-separated table of the number of occurrences of each pair across the 100 subsamples
  - Unique.Significant.tsv - a tab-separated table of the number of times a recovered pair was deemed to be significant in a subsample
- TestSignificance.r: This RScript is the standard MacroSyntR script. It runs on each of the input subsamples, and produces two outputs:
  - Rplots.pdf - a pdf file containing four plots. A disordered and ordered Oxford grid, and then 2 Oxford dot plots (one with each test species as the x axis)
  - Test_Table.tsv - a tab-separated table of each pair, and whether it was found to be significant by the MacroSyntR Fisher's Exact Test (with the adjusted p-value)
- DotPlotsWithSupport.r: This RScript is a modificated of the standard MacroSyntR script, intended for use on the original, unsampled dataset. It calculates the Oxford grid and Oxford dot plots as in the original MacroSyntR script, and then takes the information provided in Unique.Significant.tsv to overlay the support values determined by the jackknife analysis.
  
