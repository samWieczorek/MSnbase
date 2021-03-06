\name{makePRT}
\alias{makePRT}
\title{Creates the mzTab protein section}
\usage{
  makePRT(x, protAccession = NA, unitId = NULL,
    protDescription = NA, taxId = NA, species = NA,
    protDatabase = NA, protDatabaseVersion = NA,
    protSearchEngine = NA, protSearchEngineScore = NA,
    protReliability = NA, numPep = NA, numPepDistinct = NA,
    numPepUnambiguous = NA, ambiguityMembers = NA,
    protModifications = NA, protUri = NA, goTerms = NA,
    protCoverage = NA, protAbundance = NULL,
    protAbundanceStdev = NULL, protAbundanceSterr = NULL,
    protOpt_ = NULL)
}
\arguments{
  \item{x}{An instance of class
  \code{\linkS4class{MSnSet}}.}

  \item{protAccession}{A \code{character} of length
  \code{nrow(x)} (will be recycled a whole number of times
  if of different length) with the protein accession.
  Default is \code{NA}.}

  \item{unitId}{A \code{character} of lenth 1 or NULL
  (default), in which case \code{x}'s variable name will be
  used.}

  \item{protDescription}{A \code{character} of length
  \code{nrow(x)} (will be recycled a whole number of times
  if of different length) with the protein name or
  description. Default is \code{NA}.}

  \item{taxId}{A \code{numeric} of length \code{nrow(x)}
  (will be recycled a whole number of times if of different
  length) referencing the species NCBI/NEWT taxonomy id.
  Default is \code{NA}.}

  \item{species}{A \code{character} of length
  \code{nrow(x)} (will be recycled a whole number of times
  if of different length) describing the species in human
  readable form. Default is \code{NA}.}

  \item{protDatabase}{A \code{character} of length
  \code{nrow(x)} (will be recycled a whole number of times
  if of different length) describing the protein database.
  Default is \code{NA}.}

  \item{protDatabaseVersion}{A \code{character} of length
  \code{nrow(x)} (will be recycled a whole number of times
  if of different length) describing the database version.
  Default is \code{NA}.}

  \item{protSearchEngine}{A \code{list} of length
  \code{nrow(x)} (of possibly several) \code{CVParam}
  instances describing the search engine used for protein
  identification. Default is \code{NA}.}

  \item{protSearchEngineScore}{A \code{list} of length
  \code{nrow(x)} (of possibly multiple lists of)
  \code{CVParam} instances specifying peptide
  identification scores. Default is \code{NA}.}

  \item{protReliability}{A \code{numeric} of length
  \code{nrow(x)} (will be recycled a whole number of times
  if of different length). Values should be \code{1} (high
  reliability), \code{2} (medium reliability) or \code{3}
  (poor reliability). Default is \code{NA}.}

  \item{numPep}{A \code{numeric} of length \code{nrow(x)}
  (will be recycled a whole number of times if of different
  length) indicating the number of peptides identifying the
  proteins. Default is \code{NA}.}

  \item{numPepDistinct}{A \code{numeric} of length
  \code{nrow(x)} (will be recycled a whole number of times
  if of different length) indicating the number of distinct
  peptides (sequence and modifications) identifying the
  proteins. Default is \code{NA}.}

  \item{numPepUnambiguous}{A \code{numeric} of length
  \code{nrow(x)} (will be recycled a whole number of times
  if of different length) indicating the number of
  unambiguous disctinct peptides identifying the proteins.
  Default is \code{NA}.}

  \item{ambiguityMembers}{A \code{character} of
  comma-separated protein accessions. See the \code{mzTab}
  specification document for details. Defaut is \code{NA}.}

  \item{protModifications}{A \code{character} of
  comma-delimited modifications/scores/positions describing
  the proteins. See the \code{mzTab}specification document
  for details. Defaut is \code{NA}.}

  \item{protUri}{A \code{character} of length
  \code{nrow(x)} (will be recycled a whole number of times
  if of different length) with peptide uniform resource
  identifiers (link to PRIDE database for instance).
  Default is \code{NA}.}

  \item{goTerms}{A \code{character} of length
  \code{nrow(x)} (will be recycled a whole number of times
  if of different length) with comma-delimited GO terms
  describing the proteins. Default is \code{NA}.}

  \item{protCoverage}{A \code{numeric} of length
  \code{nrow(x)} (will be recycled a whole number of times
  if of different length) with the protein coverages
  ranging between 0 and 1. Default is \code{NA}.}

  \item{protAbundance}{A \code{numeric} of length
  \code{nrow(x}) or \code{matrix} with \code{nrow(x)} rows
  if multiple sub-samples are reported (see metadata
  section), specifying the protein abundance. If
  \code{NULL} (default), ignored.}

  \item{protAbundanceStdev}{A \code{numeric} of length
  \code{nrow(x}) or \code{matrix} with \code{nrow(x)} rows
  if multiple sub-samples are reported (see metadata
  section), specifying the standard deviation of protein
  abundances. If \code{NULL} (default), ignored. If
  \code{protAbundance} is not \code{NULL}, then
  \code{protAbundanceStdev} is \code{NA} if not specified.}

  \item{protAbundanceSterr}{A \code{numeric} of length
  \code{nrow(x}) or \code{matrix} with \code{nrow(x)} rows
  if multiple sub-samples are reported (see metadata
  section), specifying the standard error of protein
  abundances. If \code{NULL} (default), ignored. If
  \code{protAbundance} is not \code{NULL}, then
  \code{protAbundanceSterr} is \code{NA} if not specified.}

  \item{protOpt_}{An optional \code{character} of
  \code{character} \code{matrix} (possibly populated with
  text represenations of \code{CVParam} instances) for any
  custom protein annotation. Default is \code{NULL} to
  ignore.}
}
\value{
  A \code{data.frame} defining the \code{mzTab} protein
  section.
}
\description{
  \code{mzTab} is a light-weight, tab-delimited file format
  for proteomics data. It describes general metadata,
  protein, peptide and small molecule information (all of
  which are optinal), including quantitation and
  identification. The proteine section (PRH header and PRT
  tabular data) can be generated from an
  \code{\linkS4class{MSnSet}} instance using
  \code{makePRT}. The detailed description of all the
  parameters can be found in the \code{mzTab} specification
  document (see references).
}
\author{
  Laurent Gatto
}
\references{
  mzTab - Reporting Proteomics Results
  (\url{http://code.google.com/p/mztab/})
}
\seealso{
  \code{\link{makeMTD}} and \code{\link{makePEP}} to
  generate \code{mzTab} metadat and peptide sections.
}

