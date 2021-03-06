% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/adjust.methylC.R, R/methylDBFunctions.R
\docType{methods}
\name{adjustMethylC}
\alias{adjustMethylC}
\alias{adjustMethylC,methylRaw,methylRaw-method}
\alias{adjustMethylC,methylRawList,methylRawList-method}
\alias{adjust.methylC}
\alias{adjustMethylC,methylRawDB,methylRawDB-method}
\alias{adjustMethylC,methylRawListDB,methylRawListDB-method}
\title{Adjust measured 5mC levels using 5hmC levels}
\usage{
adjustMethylC(mc,hmc,save.db,...,chunk.size)

\S4method{adjustMethylC}{methylRaw,methylRaw}(mc, hmc, save.db = FALSE, ...,
  chunk.size = 1e+06)

\S4method{adjustMethylC}{methylRawList,methylRawList}(mc, hmc,
  save.db = FALSE, ..., chunk.size = 1e+06)

\S4method{adjustMethylC}{methylRawDB,methylRawDB}(mc, hmc, save.db = TRUE,
  ..., chunk.size = 1e+06)

\S4method{adjustMethylC}{methylRawListDB,methylRawListDB}(mc, hmc,
  save.db = TRUE, ..., chunk.size = 1e+06)
}
\arguments{
\item{mc}{a \code{methylRawList}, \code{methylRaw}, \code{methylRawDB} 
or \code{methylRawListDB} containing 5mC levels of a sample or set of samples}

\item{hmc}{a \code{methylRawList}, \code{methylRaw}, \code{methylRawDB} or
\code{methylRawListDB} containing 5hmC levels of a sample or set of samples. 
          If a \code{methylRawList} or \code{methylRawListDB} given the 
          sample order should be same as "mc" \code{methylRawList} or
           \code{methylRawListDB} object.}

\item{save.db}{A Logical to decide whether the resulting object should be 
saved as flat file database or not, default: explained in Details sections}

\item{...}{optional Arguments used when save.db is TRUE

\code{suffix}
      A character string to append to the name of the output 
      flat file database, 
      only used if save.db is true, default actions: 
      append \dQuote{_filtered} to current filename 
      if database already exists or generate new file with 
      filename \dQuote{sampleID_filtered}
      
\code{dbdir} 
      The directory where flat file database(s) should 
      be stored, defaults
      to getwd(), working directory for newly stored databases
      and to same directory for already existing database
      
\code{dbtype}
       The type of the flat file database, currently only 
       option is "tabix"
       (only used for newly stored databases)}

\item{chunk.size}{Number of rows to be taken as a chunk for processing the 
\code{methylRawDB} or \code{methylRawListDB} objects (default: 1e6)}
}
\value{
returns adjusted 5-methyl cytosine levels in the form of 
\code{methylRawList}, \code{methylRaw}, \code{methylRawDB} or 
\code{methylRawListDB} object depending on the input object
}
\description{
Measured 5mC levels via bisulfite sequencing might be a combination of 5hmC 
and 5mC levels since bisulfite sequencing can not distinguish
between the two. This function can adjust 5mC levels of a bisulfite 
sequencing experiment
if the user supplies corresponding 5hmC levels from the same sample.
}
\section{Details}{

The parameter \code{chunk.size} is only used when working with 
\code{methylRawDB} or \code{methylRawListDB} objects, 
as they are read in chunk by chunk to enable processing 
large-sized objects which are stored as flat file database.
Per default the chunk.size is set to 1M rows, which should work 
for most systems. If you encounter memory problems or 
have a high amount of memory available feel free to adjust the
 \code{chunk.size}.

The parameter \code{save.db} is per default TRUE for methylDB objects 
as \code{methylRawDB} and \code{methylRawListDB}, 
while being per default FALSE for \code{methylRaw} and \code{methylRawList}. 
If you wish to save the result of an 
in-memory-calculation as flat file database or if the size of the database
 allows the calculation in-memory, 
then you might change the value of this parameter.
}

\examples{

# read 5hmC and 5mC files
hmc.file=system.file("extdata", "test1.myCpG.txt", package = "methylKit")
mc.file =system.file("extdata", "test2.myCpG.txt", package = "methylKit")

my5hmC=methRead( hmc.file,sample.id="hmc",assembly="hg18")
my5mC =methRead( mc.file,sample.id="mc",assembly="hg18")

# adjusting the 5mC levels using 5hmC levels
adjusted.5mC=adjustMethylC(my5mC,my5hmC)


}
\references{
1. Booth, Branco, et al. (2012). Quantitative Sequencing of 5-Methylcytosine 
and 5-Hydroxymethylcytosine at Single-Base Resolution. Science, 934

2. Yu, Hon, et al. (2012). Base-resolution analysis of 
5-hydroxymethylcytosine in the Mammalian genome. Cell, 149(6), 1368-80.
}
