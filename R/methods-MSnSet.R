#######################################################################
## NOTE: MSnSet is based in the ExpressionSet class defined in the
##       Biobase package and should have the exact same functionnality.
##       Some of the code is heavily inspired and sometimes
##       directly copies from the respective ExpressionSet method.

setMethod("initialize", "MSnSet",
          function(.Object,
                   assayData,
                   phenoData,
                   featureData,
                   experimentData,
                   exprs = new("matrix"),
                   ... ) {
            if (missing(assayData)) {
              if (missing(phenoData))
                phenoData <- annotatedDataFrameFrom(exprs, byrow=FALSE)
              if (missing(featureData))
                featureData <- annotatedDataFrameFrom(exprs, byrow=TRUE)
              if (missing(experimentData))
                experimentData <- new("MIAPE")
              .Object <- callNextMethod(.Object,
                                        phenoData = phenoData,
                                        featureData = featureData,
                                        exprs = exprs,
                                        experimentData = experimentData,
                                        ...)
            } else if (missing(exprs)) {
              if (missing(phenoData))
                phenoData <- annotatedDataFrameFrom(assayData, byrow=FALSE)
              if (missing(featureData))
                featureData <- annotatedDataFrameFrom(assayData, byrow=TRUE)
              if (missing(experimentData))
                experimentData <- new("MIAPE")
              .Object <- callNextMethod(.Object,
                                        assayData = assayData,
                                        phenoData = phenoData,
                                        featureData = featureData,
                                        experimentData = experimentData,
                                        ...)
            } else stop("provide at most one of 'assayData' or 'exprs' to initialize MSnSet",
                        call.=FALSE)
            .Object@processingData <- new("MSnProcess")            
            if (validObject(.Object))
              Biobase:::.harmonizeDimnames(.Object)
          })



setValidity("MSnSet", function(object) {
  msg <- validMsg(NULL, Biobase:::isValidVersion(object, "MSnSet"))
  msg <- validMsg(msg, Biobase::assayDataValidMembers(assayData(object), c("exprs")))
  if ( nrow(qual(object)) != 0 ) {
    nrow.obs <- nrow(qual(object))
    nrow.exp <- nrow(object)*length(object$reporters)
    if (nrow.obs != nrow.exp)
      msg <- validMsg(msg,
                      "number of rows in assayData and qual slots do not match.")
  }
  if (!inherits(experimentData(object),"MIAPE"))
    msg <- validMsg(msg, 
                    "experimentData slot in MSnSet must be 'MIAPE' object")
  if (is.null(msg)) TRUE else msg
})

setMethod("exprs", signature(object="MSnSet"),
          function(object) assayDataElement(object,"exprs"))

setReplaceMethod("exprs", signature(object="MSnSet",value="matrix"),
                 function(object, value) assayDataElementReplace(object, "exprs", value))

setMethod("show","MSnSet",
          function(object) {
            callNextMethod()
            show(processingData(object))
            invisible(NULL)
          })


setMethod("normalize", "MSnSet",
          function(object,
                   method = c("sum","max",
                     "center.mean", "center.median",
                     "quantiles",
                     "quantiles.robust",
                     "vsn"), ...)
          normalise_MSnSet(object, match.arg(method), ...)
          )

normalise <- normalize

setMethod("scale", "MSnSet",
          function(x, center = TRUE, scale = TRUE) {
            e <- scale(exprs(x), center = center, scale = scale)
            proc <- NULL
            if (!is.null(attr(e, "scaled:scale"))) {
              escale <- attr(e, "scaled:scale")
              attr(e, "scaled:scale") <- NULL
              escale <- paste(round(escale, ), 3)              
              proc <- c(proc,
                        paste("Scaled",
                              paste0("[", escale, collapse = ", "), "]:",
                              date()))
            }
            if (!is.null(attr(e, "scaled:center"))) {
              ecenter <- attr(e, "scaled:center")
              attr(e, "scaled:center") <- NULL
              ecenter <- paste(round(ecenter, ), 3)              
              proc <- c(proc,
                        paste("Centered",
                              paste0("[", ecenter, collapse = ", "), "]:",
                              date()))
            }            
            exprs(x) <- e
            x@processingData@processing <-
              c(x@processingData@processing,
                proc)
            if (validObject(x))
              return(x) 
          })

setMethod("purityCorrect",
          signature=signature("MSnSet","matrix"),
          function(object,impurities) {
            if (ncol(impurities)!=nrow(impurities))
              stop("Impurity matrix must be a square matrix")
            if (ncol(object)!=ncol(impurities))
              stop("Impurity matrix should be ",ncol(object)," by ",ncol(object))
            .purcor <- function(x, .impurities = impurities) {
              keep <- !is.na(x)
              if (sum(keep)>1) 
                x[keep] <- solve(.impurities[keep, keep], x[keep])
              x[x<0] <- NA
              return(x)
            }
            corr.exprs <- apply(exprs(object), 1, .purcor)
            exprs(object) <- t(corr.exprs)
            object@processingData@processing <-             
              c(object@processingData@processing,
                paste0("Purity corrected: ", date()))
            if (validObject(object))
              return(object)
          })


setMethod("dim","MSnSet",function(x) dim(exprs(x)))
setMethod("qual","MSnSet", function(object) object@qual)
## Not sure about these...
## setReplaceMethod("featureNames",
##                  signature(object="MSnSet",
##                            value="character"),
##                  function(object, value) {
##                    object@features = value
##                    if (validObject(object))
##                      return(object)
##                  })

## No proteomicsData anymore (since version 0.2.0 of MSnSet and MSnbase).
## experimentData is not proper MIAPE
## setMethod("proteomicsData","MSnSet",function(object) object@proteomicsData)
## setReplaceMethod("proteomicsData",
##                  signature(object="MSnSet",
##                            value="MIAPE"),
##                  function(object, value) {
##                    object@proteomicsData = value
##                    if (validObject(object))
##                      return(object)
##                  })

setMethod("fileNames",
          signature(object="MSnSet"),
          function(object) processingData(object)@files)

setMethod("processingData",
          signature(object="MSnSet"),
          function(object) object@processingData)

setMethod("msInfo","MSnSet",
          function(object) msInfo(experimentData(object)))

setMethod("expinfo","MSnSet",
          function(object) expinfo(experimentData(object)))

setMethod("exptitle","MSnSet",
          function(object) exptitle(experimentData(object)))

setMethod("expemail","MSnSet",
          function(object) expemail(experimentData(object)))

setMethod("ionSource","MSnSet",
          function(object) ionSource(experimentData(object)))

setMethod("analyser","MSnSet",
          function(object) analyser(experimentData(object)))

setMethod("analyzer","MSnSet",
          function(object) analyzer(experimentData(object)))

setMethod("detectorType","MSnSet",
          function(object) detectorType(experimentData(object)))

setMethod("meanSdPlot",
          signature="MSnSet",
          definition =
          function(x, ranks=TRUE, xlab = ifelse(ranks, "rank(mean)", "mean"),
                   ylab = "sd", pch  = ".", plot = TRUE, ...)
          vsn::meanSdPlot(exprs(x), ranks=ranks, xlab=xlab, ylab=ylab, pch=pch, plot=plot, ...))

t.MSnSet <- function(x) {  
  ans <- new("MSnSet",
             exprs = t(exprs(x)),
             phenoData = featureData(x),
             featureData = phenoData(x),
             experimentData = experimentData(x),
             annotation = annotation(x))
  ans@processingData@processing <-
    x@processingData@processing
  ans <- logging(ans, "MSnSet transposed")  
  if (validObject(ans))
    return(ans)
}


setMethod("[", "MSnSet", function(x, i, j, ...) {
  dim0 <- dim(x)
  .Object <- callNextMethod(...)
  dim1 <- dim(.Object)
  ## subsetting qual - requires pData(x)$mz!
  ## fn <- featureNames(.Object)
  ## reps <- match(.Object$mz,x$mz)
  ## qrows <- paste(rep(fn,each=length(reps)),reps,sep=".")
  ## .Object@qual <- .Object@qual[qrows,]
  .Object@qual <- data.frame()
  dim0 <- paste0("[", paste0(dim0, collapse = ","), "]")
  dim1 <- paste0("[", paste0(dim1, collapse = ","), "]")  
  .Object@processingData@processing <- c(.Object@processingData@processing,
                                         paste0("Subset ", dim0, dim1, " ", date()))
  if (validObject(.Object))
    return(.Object)
})

  
setAs("MSnSet", "ExpressionSet",
      function (from)
      new("ExpressionSet",
          exprs = exprs(from),
          phenoData = phenoData(from),
          featureData = featureData(from),
          annotation = annotation(from),
          experimentData = as(experimentData(from), "MIAME"), 
          protocolData = protocolData(from))
      )

as.ExpressionSet.MSnSet <- function(x) as(x,"ExpressionSet")

setAs("MSnSet", "data.frame",
      function (from) {
          ## MSnSet -> ExpressionSet -> data.frame
          from <- as(from, "ExpressionSet")
          as(from, "data.frame")
      })

as.data.frame.MSnSet <-
    function(x, row.names=NULL, optional=FALSE, ...) as(x,"data.frame")    


ms2df <- function(x, fcols = fvarLabels(x)) {
    if (is.null(fcols)) {
        res <- data.frame(exprs(x))
    } else {
        sel <- fvarLabels(x) %in% fcols
        res <- data.frame(exprs(x),
                          fData(x)[, sel])
    }
    return(res)
}

setMethod("write.exprs",
          signature(x="MSnSet"),
          function(x,
                   fDataCols=NULL,
                   file="tmp.txt", quote=FALSE,
                   sep="\t", col.names=NA, ...) {
            res <- exprs(x)
            if (!is.null(fDataCols))
              res <- cbind(res,fData(x)[,fDataCols])
            write.table(res, file=file, quote=quote, sep=sep, col.names=col.names, ...)
          })

setReplaceMethod("experimentData",
                 signature = signature(
                   object = "MSnSet",
                   value = "MIAPE"),
                 function(object, value) {
                   if (!validObject(value))
                     stop("Not a valid MIAPE instance.")
                   object@experimentData <- value
                   object
                 })



setMethod("combine",
          signature=signature(
            x="MSnSet", y="MSnSet"),
          function(x, y, ...) {
            if (class(x) != class(y))
              stop(paste("objects must be the same class, but are ",
                         class(x), ", ", class(y), sep=""))
            ## if (!isCurrent(x)[["MSnSet"]])
            ##     x <- updateObject(x)
            assayData(x) <- combine(assayData(x), assayData(y))
            phenoData(x) <- combine(phenoData(x), phenoData(y))
            featureData(x) <- combine(featureData(x), featureData(y))
            experimentData(x) <- combine(experimentData(x),experimentData(y))
            protocolData(x) <- combine(protocolData(x), protocolData(y))
            x@processingData <- combine(processingData(x), processingData(y))
            x@processingData@processing <- paste("Combined [",
                                                 paste(dim(x), collapse = ","),
                                                 "] and [",
                                                 paste(dim(y), collapse = ","),
                                                 "] MSnSets ", date(), sep = "")
            x@qual <- data.frame() ## dropping qual slot
            ## annotation -- constant / not used
            if (validObject(x))
              return(x)
          })


setMethod("topN", signature(object = "matrix"), 
          function(object, groupBy, n=3, fun, ...) {
            if (missing(groupBy))
              stop("Specify how to group features to select top ", n, ".")
            if (missing(fun)) {
              fun <- sum
              if (ncol(object) > 1)
                message("Ranking features using their sum.")
            }
            rn <- rownames(object)
            idx <- by(object, groupBy, getTopIdx, n, fun, ...)
            object <- subsetBy(object, groupBy, idx)
            if (!is.null(rn)) {
              rownames(object) <- subsetBy(rn, groupBy, idx)
            } else {
              rownames(object) <- NULL
            }
            return(object)
          })

setMethod("topN", signature(object = "MSnSet"), 
          function(object, groupBy, n=3, fun, ...) {
            if (missing(groupBy))
              stop("Specify how to group features to select top ", n, ".")
            if (missing(fun)) {
              fun <- sum
              if (ncol(object) > 1)
                message("Ranking features using their sum.")
            }
            idx <- by(exprs(object), groupBy, getTopIdx, n, fun, ...)
            fn <- subsetBy(featureNames(object), groupBy, idx)
            .eset <- subsetBy(exprs(object), groupBy, idx)
            if (!is.matrix(.eset)) 
              .eset <- matrix(.eset, ncol = 1)
            rownames(.eset) <- fn
            .proc <- processingData(object)
            .proc@processing <- c(.proc@processing,
                                  paste0("Selected top ", n,
                                         " features: ", date()))
            .fdata <- subsetBy(fData(object), groupBy, idx)
            ## message("Dropping spectrum-level 'qual' slot.")
            ans <- new("MSnSet",
                       experimentData = experimentData(object),
                       exprs = .eset,
                       phenoData = phenoData(object),
                       featureData = new("AnnotatedDataFrame", data = .fdata),
                       annotation = object@annotation,
                       protocolData = protocolData(object))
            ans@processingData <- .proc
            featureNames(ans) <- fn
            if (validObject(ans))
              return(ans)
          })


getRatios <- function(x, log = FALSE) {
  ## x: a vector of numerics
  ## returns a vector of all xi/xj ratios
  x <- as.numeric(x)
  cmb <- combn(length(x),2)
  r <- numeric(ncol(cmb))
  for (i in 1:ncol(cmb)) {
    j <- cmb[1, i]
    k <- cmb[2, i]
    ifelse(log,
           r[i] <- x[j]-x[k],
           r[i] <- x[j]/x[k])
  }
  return(r)
}


setMethod("exprsToRatios",
          "MSnSet",
          function(object, log = FALSE) {
            if (ncol(object) == 2) {
              ifelse(log,
                     r <- exprs(object)[, 1] - exprs(object)[, 2],
                     r <- exprs(object)[, 1] / exprs(object)[, 2])
              dim(r) <- c(length(r), 1)
            } else {
              r <- apply(exprs(object), 1, getRatios, log)
              r <- t(r)
            }
            rownames(r) <- featureNames(object)
            cmb <- combn(ncol(object),2)            
            ratio.description <- apply(cmb,2, function(x)
                                       paste(sampleNames(object)[x[1]],
                                             sampleNames(object)[x[2]],
                                             sep="/"))
            phenodata <- new("AnnotatedDataFrame",
                             data=data.frame(ratio.description))
            processingdata <- processingData(object)
            processingdata@processing <- c(processingdata@processing,
                                           paste("Intensities to ratios: ",date(),sep=""))
            message("Dropping protocolData.")
            res <- new("MSnSet",
                       exprs = r,
                       featureData = featureData(object),
                       phenoData = phenodata,
                       processingData = processingdata,
                       experimentData = experimentData(object))
            if (validObject(res))
              return(res)
          })


setMethod("exprsToRatios",
          "matrix",
          function(object, log = FALSE) {
            if (ncol(object) == 2) {
              ifelse(log,
                     r <- object[, 1] - object[, 2],
                     r <- object[, 1] / object[, 2])
              dim(r) <- c(length(r), 1)
            } else {
              r <- apply(object, 1, getRatios, log)
              r <- t(r)
              conames(r) <- 
                apply(combn(ncol(object), 2), 2,
                      paste, collapse = ".")
            }
            r
          })


setMethod("plotNA", signature(object = "MSnSet"), 
          function(object, pNA = .5) {
            if (pNA > 1)
              pNA <- 1
            if (pNA < 0)
              pNA <- 0
            X <- exprs(object)
            p <- plotNA_matrix(X, pNA)
            invisible(p)
          })


setMethod("plotNA", signature(object = "matrix"), 
          function(object, pNA = .5) {
            if (pNA > 1)
              pNA <- 1
            if (pNA < 0)
              pNA <- 0
            p <- plotNA_matrix(object, pNA)
            invisible(p)
          })

setMethod("filterNA", signature(object = "matrix"), 
          function(object, pNA = 0, pattern) {
            if (missing(pattern)) { ## using pNA
              if (pNA > 1)
                pNA <- 1
              if (pNA < 0)
                pNA <- 0            
              k <- apply(object, 1,
                         function(x) sum(is.na(x))/length(x))
              accept <- k <= pNA
              if (sum(accept) == 1) {              
                ans <- matrix(object[accept, ], nrow = 1)
                rownames(ans) <- rownames(object)[accept]
              } else {
                ans <- object[accept, ]
              }
            } else { ## using pattern
              accept <- getRowsFromPattern(object, pattern)
              ans <- object[accept, ]
            }
            return(ans)
          })


setMethod("filterNA", signature(object = "MSnSet"), 
          function(object, pNA = 0, pattern, droplevels = TRUE) {
            if (missing(pattern)) { ## using pNA
              if (pNA > 1)
                pNA <- 1
              if (pNA < 0)
                pNA <- 0
              k <- apply(exprs(object), 1,
                         function(x) sum(is.na(x))/length(x))
              accept <- k <= pNA
              ans <- object[accept, ]
              ans@processingData@processing <-
                c(processingData(ans)@processing,
                  paste0("Removed features with more than ",
                         round(pNA, 3), " NAs: ", date()))
            } else { ## using pattern
              accept <- getRowsFromPattern(exprs(object), pattern)
              ans <- object[accept, ]
              ans@processingData@processing <-
                c(processingData(ans)@processing,
                  paste0("Removed features with according to pattern ",
                         pattern, " ", date()))              
            }            
            if (droplevels) 
              ans <- droplevels(ans)
            if (validObject(ans))
              return(ans)
          })

is.na.MSnSet <- function(x) is.na(exprs(x))

droplevels.MSnSet <- function(x, ...) {
    fData(x) <- droplevels(fData(x), ...)
    x@processingData@processing <-
      c(x@processingData@processing,
        paste("Dropped featureData's levels", date()))    
    if (validObject(x))
      return(x)
  }

setMethod("log",
          signature = "MSnSet",
          function(x, base, ...) {
            exprs(x) <-  log(exprs(x), base)
            x@processingData@processing <-
              c(x@processingData@processing,
                paste0("Log transformed (base ", base, ") ", date()))
            if (validObject(x))
              return(x)
          })


setMethod("MAplot",
          signature = "MSnSet",
          function(object, log.it = TRUE, base = 2, ...) {
            if (ncol(object) < 2)
              stop("Need at least 2 samples to produce an MA plot.")
            if (log.it)
              object <- log(object, base)              
            if (ncol(object) == 2) {
              x <- exprs(object[, 1])
              y <- exprs(object[, 2])
              sel <- !is.na(x) & !is.na(y)
              x <- x[sel]
              y <- y[sel]
              M <- x - y
              A <- (x + y)/2
              ma.plot(A, M, ...)
            } else {
              mva.pairs(exprs(object), log.it = FALSE, ...)
            }
          })


##############################################
## This should also be implemented for pSet!

## o MSnSet $ and [[ now dispatch on featureData, 
##   instead of phenoData (as was inherited from 
##   ExpressionSet via eSet)

## setMethod("$", "MSnSet", function(x, name) {
##   eval(substitute(featureData(x)$NAME_ARG, list(NAME_ARG=name)))
## })


## setReplaceMethod("$", "MSnSet", function(x, name, value) {
##   featureData(x)[[name]] = value
##   x
## })

## setMethod("[[", "MSnSet", function(x, i, j, ...) featureData(x)[[i]])

## setReplaceMethod("[[", "MSnSet",
##                  function(x, i, j, ..., value) {
##                      featureData(x)[[i, ...]] <- value
##                      x
##                  })
