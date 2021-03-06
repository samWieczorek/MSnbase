\name{makePEP}
\alias{makePEP}
\title{Creates the mzTab peptide section}
\usage{
  makePEP(x, sequence = NA, pepAccession = NA,
    unitId = NULL, unique = NA, pepDatabase = NA,
    pepDatabaseVersion = NA, pepSearchEngine = NA,
    pepSearchEngineScore = NA, pepReliability = NA,
    pepModifications = NA, retentionTime = NA, charge = NA,
    massToCharge = NA, pepUri = NA, spectraRef = NA,
    pepAbundance = NULL, pepAbundanceStdev = NULL,
    pepAbundanceSterr = NULL, pepOpt_ = NULL)
}
\arguments{
  \item{x}{An instance of class
  \code{\linkS4class{MSnSet}}.}

  \item{sequence}{A \code{character} of length
  \code{nrow(x)} (will be recycled a whole number of times
  if of different length) with the peptide sequence.
  Default is \code{NA}.}

  \item{pepAccession}{A \code{character} of length
  \code{nrow(x)} (will be recycled a whole number of times
  if of different length) with the assigned protein
  accession. Default is \code{NA}.}

  \item{unitId}{A \code{character} of lenth 1 or NULL
  (default), in which case \code{x}'s variable name will be
  used.}

  \item{unique}{A \code{logical} (converted to numeric to
  comply with format specification) of
  \code{length(nrow(x)} (will be recycled a whole number of
  times if of different length) specifying if peptide is
  proteotypic. Default is \code{NA}.}

  \item{pepDatabase}{A \code{character} of length
  \code{nrow(x)} (will be recycled a whole number of times
  if of different length) describing the protein database
  used for peptide identification. Default is \code{NA}.}

  \item{pepDatabaseVersion}{A \code{character} of length
  \code{nrow(x)} (will be recycled a whole number of times
  if of different length) with the database version.
  Default is \code{NA}.}

  \item{pepSearchEngine}{A \code{list} of length
  \code{nrow(x)} (of possibly multiple lists of)
  \code{CVParam} instances identifying the search engine
  used for peptide identification. Default is \code{NA}.}

  \item{pepSearchEngineScore}{A \code{list} of length
  \code{nrow(x)} (of possibly multiple lists of)
  \code{CVParam} instances specifying peptide
  identification scores. Default is \code{NA}.}

  \item{pepReliability}{A \code{numeric} of length
  \code{nrow(x)} (will be recycled a whole number of times
  if of different length). Values should be \code{1} (high
  reliability), \code{2} (medium reliability) or \code{3}
  (poor reliability). Default is \code{NA}.}

  \item{pepModifications}{A \code{character} of length
  \code{nrow(x)} (will be recycled a whole number of times
  if of different length) describing the modifications and
  their position (see \code{mzTab} format specifications
  for details). Default is \code{NA}.}

  \item{retentionTime}{A \code{numeric} of length
  \code{nrow(x)} (will be recycled a whole number of times
  if of different length). Note that currently, unique
  retention times are expected, but could be extended to
  multiple times. Default is \code{NA}.}

  \item{charge}{A \code{numeric} of length \code{nrow(x)}
  (will be recycled a whole number of times if of different
  length) indicating peptide charge state.  Default is
  \code{NA}.}

  \item{massToCharge}{A \code{numeric} of length
  \code{nrow(x)} (will be recycled a whole number of times
  if of different length) with the peptides precursor mass
  to charge ratio. Default is \code{NA}.}

  \item{pepUri}{A \code{character} of length \code{nrow(x)}
  (will be recycled a whole number of times if of different
  length) with peptide uniform resource identifiers (link
  to PRIDE database for instance). Default is \code{NA}.}

  \item{spectraRef}{A \code{character} in the format
  \code{ms_file[1-n]:{SPEC_REF}} (see \code{mzTab}
  specifications for details) of length \code{nrow(x)}
  (will be recycled a whole number of times if of different
  length). Default is \code{NA}.}

  \item{pepAbundance}{A \code{numeric} of length
  \code{nrow(x}) or \code{matrix} with \code{nrow(x)} rows
  if multiple sub-samples are reported (see metadata
  section), specifying the peptides abundance. If
  \code{NULL} (default), ignored.}

  \item{pepAbundanceStdev}{A \code{numeric} of length
  \code{nrow(x}) or \code{matrix} with \code{nrow(x)} rows
  if multiple sub-samples are reported (see metadata
  section), specifying the standard deviation of peptides
  abundances. If \code{NULL} (default), ignored. If
  \code{pepAbundance} is not \code{NULL}, then
  \code{pepAbundanceStdev} is \code{NA} if not specified.}

  \item{pepAbundanceSterr}{A \code{numeric} of length
  \code{nrow(x}) or \code{matrix} with \code{nrow(x)} rows
  if multiple sub-samples are reported (see metadata
  section), specifying the standard error of peptides
  abundances. If \code{NULL} (default), ignored. If
  \code{pepAbundance} is not \code{NULL}, then
  \code{pepAbundanceSterr} is \code{NA} if not specified.}

  \item{pepOpt_}{An optional \code{character} of
  \code{character} \code{matrix} (possibly populated with
  text represenations of \code{CVParam} instances) for any
  custom peptide annotation. Default is \code{NULL} to
  ignore.}
}
\value{
  A \code{data.frame} defining the \code{mzTab} peptide
  section.
}
\description{
  \code{mzTab} is a light-weight, tab-delimited file format
  for proteomics data. It describes general metadata,
  protein, peptide and small molecule information (all of
  which are optinal), including quantitation and
  identification. The peptide section (PEH header and PEP
  tabular data) can be generated from an
  \code{\linkS4class{MSnSet}} instance using
  \code{makePEP}. The detailed description of all the
  parameters can be found in the \code{mzTab} specification
  document (see references).
}
\author{
  Laurent Gatto
}
\seealso{
  \code{\link{makeMTD}} and \code{\link{makePRT}} to
  generate \code{mzTab} metadata and protein sections.
}

