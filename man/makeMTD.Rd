\name{makeMTD}
\alias{makeMTD}
\title{Creates the mzTab metadata section}
\usage{
  makeMTD(x, unitId = NULL, title = NULL,
    mtdDescription = NULL, sampleProcessing = NULL,
    instrumentSource = NULL, instrumentAnalyzer = NULL,
    instrumentDetector = NULL, software = NULL, fdr = NULL,
    publication = NULL, contactName = NULL,
    contactAffiliation = NULL, contactEmail = NULL,
    mtdUri = NULL, mtdModifications = NULL,
    modProbabilityMethod = NULL, quantitationMethod = NULL,
    protQuantUnit = NULL, pepQuantUnit = NULL,
    msFileFormat = NULL, msFileLocation = NULL,
    msFileIdFormat = NULL, custom = NULL, species_ = NULL,
    tissue_ = NULL, cellType_ = NULL, disease_ = NULL,
    description_ = NULL, quantitationReagent_ = NULL,
    custom_ = NULL)
}
\arguments{
  \item{x}{An instance of class
  \code{\linkS4class{MSnSet}}.}

  \item{unitId}{A \code{character} of lenth 1 or NULL
  (default), in which case \code{x}'s variable name will be
  used. This identifier references the item under study all
  sections.}

  \item{title}{A \code{character} of lenght 1 or
  \code{NULL} (default), in which case \code{exptitle(x)}
  is used if available.}

  \item{mtdDescription}{A \code{character} of length 1
  describing the unit or \code{NULL} (default) to ignore.}

  \item{sampleProcessing}{A \code{list} of (possibly
  multiple) valid \code{CVParam} objects or \code{NULL}
  (default) to ignore.}

  \item{instrumentSource}{A list of valid \code{CVParam}
  instances or \code{NULL} (default), in which case
  \code{ionSource(x)} is used to generate a
  \code{CVParam}.}

  \item{instrumentAnalyzer}{A list of valid \code{CVParam}
  instances or \code{NULL} (default), in which case
  \code{analyzer(x)} is used to generate a \code{CVParam}.}

  \item{instrumentDetector}{A list of valid \code{CVParam}
  instances or \code{NULL} (default), in which case
  \code{detectorType(x)} is used to generate a
  \code{CVParam}.}

  \item{software}{A list of valid \code{CVParam} instances
  describing the ordered list of software used to process
  the data. \code{NULL} (default) to ignore.}

  \item{fdr}{A list of valid \code{CVParam} instances
  describing the unit's false discovery rate or \code{NULL}
  (default) to ignore.}

  \item{publication}{A \code{character} (of lenght > 0) or
  \code{NULL} (default), in which case \code{pubMedIds(x)}
  is used.}

  \item{contactName}{A \code{character} (of length > 0) or
  \code{NULL} (default), in which case
  \code{expinfo(x)["name"]} is used.}

  \item{contactAffiliation}{A \code{character} (of length >
  0) or \code{NULL} (default), in which case
  \code{expinfo(x)["lab"]} is used.}

  \item{contactEmail}{A \code{character} (of length > 0) or
  \code{NULL} (default), in which case \code{expemail(x)}
  is used.}

  \item{mtdUri}{A \code{character} (of length > 0)
  describing the unit's uniform resource identifier (a
  PRIDE experiment or a PeptideAtlas build for example).
  \code{NULL} (default) to ignore.}

  \item{mtdModifications}{A list of (possibly multiplt)
  \code{CVParam} instances describing all (distinct) PTMs
  reported in the unit. \code{NULL} (default) to ignore.}

  \item{modProbabilityMethod}{A user defined \code{CVParam}
  reporting the modifiction (position) probabilities.
  \code{NULL} (default) to ignore.}

  \item{quantitationMethod}{A valid \code{CVParam}, a
  \code{\linkS4class{ReporterIons}} instance or \code{NULL}
  (default), in which case the isobaric tagging system is
  guessed from the number of columns in \code{exprs(x)} (4
  or 8 for iTRAQ, 6 for TMT).}

  \item{protQuantUnit}{A valid \code{CVParam} or
  \code{NULL} (default) to use PRIDE:0000330 (Arbitrary
  quantificatio unit).}

  \item{pepQuantUnit}{A valid \code{CVParam} or \code{NULL}
  (default) to use PRIDE:0000330 (Arbitrary quantificatio
  unit).}

  \item{msFileFormat}{A list of valid \code{CVParam}
  instances to \code{NULL} (default), in which case, the
  extension of \code{fileNames(x)[1]} is used to define the
  appropriate \code{CVParam}. Recognised extensions are
  \code{mzData}, \code{mzXML}, \code{mzML} or \code{mgf}.}

  \item{msFileLocation}{A \code{character} (of length > 0)
  or \code{NULL} (default), in which case
  \code{fileNames(x)} is used.}

  \item{msFileIdFormat}{A list of \code{CVParam} instances
  describing the original identification format used in the
  external data file. \code{NULL} (default) to ignore.}

  \item{custom}{A list of user defined \code{CVParam}
  instances with additional parameters describing the unit.
  \code{NULL} (default) to ignore.}

  \item{species_}{A list of (possibly several)
  \code{CVParam} instances with the respective (sub-)unit
  species. \code{NULL} (default) to ignore.}

  \item{tissue_}{A list of (possibly several)
  \code{CVParam} instances describing the respective
  (sub-)unit tissue. \code{NULL} (default) to ignore.}

  \item{cellType_}{A list of (possibly several)
  \code{CVParam} instances describing the respective
  (sub-)unit cell type. \code{NULL} (default) to ignore.}

  \item{disease_}{A list of (possibly several)
  \code{CVParam} instances describing the respective
  (sub-)unit disease states. \code{NULL} (default) to
  ignore.}

  \item{description_}{A list of \code{characters}
  describing the (sub-)unit in human raedable free text.
  \code{NULL} (default) to ignore.}

  \item{quantitationReagent_}{A list of \code{CVParam}
  instances or \code{NULL} (default), in which case the
  reporter ions as defined by \code{quantitationMethod} as
  used.}

  \item{custom_}{A list of user defined \code{CVParam}
  instances with additional (sub-)unit properties.
  \code{NULL} (default) to ignore.}
}
\value{
  A \code{character} defining the mzTab metadata section.
}
\description{
  \code{mzTab} is a light-weight, tab-delimited file format
  for proteomics data. It describes general metadata,
  protein, peptide and small molecule information (all of
  which are optinal), including quantitation and
  identification. The metadata section (MTD) can be
  generated from an \code{\linkS4class{MSnSet}} instance
  using \code{makeMTD}. The detailed description of all the
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
  \code{\link{makePEP}} and \code{\link{makePRT}} to
  generate \code{mzTab} peptide and protein sections.
}

