find . -maxdepth 1 -name "*.fa" -exec phylosift search --isolate --besthit {} \;
find . -maxdepth 1 -name "*.fa" -exec phylosift align --isolate --besthit {} \;
find . -type f -regex '.*alignDir/concat.codon.updated.1.fasta' -exec cat {} \; | sed -r 's/\.1\..*//'  > codon_alignment.fa

FastTree -nt -gtr < codon_alignment.fa > codon_tree.tre
