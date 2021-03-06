\name{Spectrum2-class}
\Rdversion{1.1}
\docType{class}
\alias{Spectrum2-class}
\alias{class:Spectrum2}
\alias{Spectrum2}

\alias{precursorMz,Spectrum-method}
\alias{precursorMz}
\alias{precScanNum,Spectrum-method}
\alias{precScanNum}
\alias{precAcquisitionNum,Spectrum-method}
\alias{precAcquisitionNum}
\alias{precursorIntensity,Spectrum-method}
\alias{precursorIntensity}
\alias{precursorCharge,Spectrum-method}
\alias{precursorCharge}
\alias{collisionEnergy,Spectrum-method}
\alias{collisionEnergy}
\alias{removeReporters,Spectrum-method}

\title{The "Spectrum2" Class for MSMS Spectra}

\description{
  \code{Spectrum2} extends the \code{"\linkS4class{Spectrum}"} class and
  introduces several MS2 specific attributes in addition to the slots in
  \code{"\linkS4class{Spectrum}"}. \code{Spectrum2} are not created
  directly but are contained in the \code{assayData} slot of an
  \code{"\linkS4class{MSnExp}"}. 
}


\section{Slots}{
  \describe{
    \item{\code{merged}:}{Object of class \code{"numeric"} indicating of
      how many combination the current spectrum is the result of. }
    \item{\code{precScanNum}:}{Object of class \code{"integer"} indicating
      the precursor MS scan index in the original input file. Accessed
      with the \code{precScanNum} or \code{precAcquisitionNum} methods.}
    \item{\code{precursorMz}:}{Object of class \code{"numeric"}
      providing the precursor ion MZ value. }
    \item{\code{precursorIntensity}:}{Object of class \code{"numeric"}
      providing the precursor ion intensity. }
    \item{\code{precursorCharge}:}{Object of class \code{"integer"}
      indicating the precursor ion charge. }
    \item{\code{collisionEnergy}:}{Object of class \code{"numeric"}
      indicating the collision energy used to fragment the parent ion. }
    %% ------------------------------------------------------------- %%
    \item{\code{msLevel}:}{Object of class \code{"integer"} indicating
      the MS level: 2 in this case (inherited from
      \code{"\linkS4class{Spectrum}"}). }
    \item{\code{peaksCount}:}{Object of class \code{"integer"}
      indicating the number of MZ peaks (inherited from
      \code{"\linkS4class{Spectrum}"}). }
    \item{\code{rt}:}{Object of class \code{"numeric"} indicating the
      retention time (in seconds) for the current ions (inherited from
      \code{"\linkS4class{Spectrum}"}). }
    \item{\code{acquisitionNum}:}{Object of class \code{"integer"}
      corresponding to the acquisition number of the current spectrum
      (inherited from \code{"\linkS4class{Spectrum}"}). }
    \item{\code{scanIndex}:}{Object of class \code{"integer"} indicating
      the scan index of the current spectrum (inherited from
      \code{"\linkS4class{Spectrum}"}). }
    \item{\code{mz}:}{Object of class \code{"numeric"} of length equal
      to the peaks count (see \code{peaksCount} slot) indicating the MZ
      values that have been measured for the current ion (inherited from
      \code{"\linkS4class{Spectrum}"}). }
    \item{\code{intensity}:}{Object of class \code{"numeric"} of same
      length as \code{mz} indicating the intensity at which each \code{mz}
      datum has been measured \code{"\linkS4class{Spectrum}"}).}
    \item{\code{.__classVersion__}:}{Object of class \code{"Versions"}
      indicating the versions of the \code{Spectrum} and \code{Spectrum2}
      classes of the instance. Intended for developer use and debugging. }
  }
}

\section{Extends}{
  Class \code{"\linkS4class{Spectrum}"}, directly.
  Class \code{"\linkS4class{Versioned}"}, by class "Spectrum", distance 2.
}

\section{Methods}{
  See \code{"\linkS4class{Spectrum}"} for additional accessors and
  methods for \code{Spectrum2} objects.
  \describe{
    \item{\code{precursorMz(object)}}{ Returns the precursor MZ value as
      a numeric. }
    \item{\code{precursorMz(object)}}{ Returns the precursor scan number
      in the original data file as an integer. }
    \item{\code{precursorIntensity(object)}}{ Returns the precursor
      intensity as a numeric. }
    \item{\code{precursorCharge(object)}}{ Returns the precursor
      intensity as a integer. }
    \item{\code{collisionEnergy(object)}}{ Returns the collision energy
      as an numeric. }
    \item{\code{removeReporters(object, ...)}}{ Removes all reporter ion
      peaks. See \code{\link{removeReporters}} documentation for more
      details and examples. }
    \item{\code{precAcquisitionNum}:}{Returns the precursor's
      acquisition number. }
    \item{\code{precScanNum}:}{See \code{precAcquisitionNum}. }
  }
}

\author{
  Laurent Gatto <lg390@cam.ac.uk>
}

\seealso{
  Virtual super-class \code{"\linkS4class{Spectrum}"},
  \code{"\linkS4class{Spectrum1}"} for MS1 spectra and
  \code{"\linkS4class{MSnExp}"} for a full experiment container. 
}

\keyword{classes}
