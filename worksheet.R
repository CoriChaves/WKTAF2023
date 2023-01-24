# run the following lines in R to update to the most recent version of icesTAF
install.packages("icesTAF", repos = c(
  icestoolsprod = 'https://ices-tools-prod.r-universe.dev',
  CRAN = 'https://cloud.r-project.org'))
library(icesTAF)
?icesTAF
setwd("D:/Corina/MeoCloud/000 A/WKTAF/WKTAF2023")

#better help page
?draft.data

#create TAF structure
taf.skeleton("example-1")

setwd("D:/Corina/MeoCloud/000 A/WKTAF/WKTAF2023/example-1")
#import data
##load tree dataset
data(trees)
write.taf(trees, dir = "bootstrap/initial/data")

#create a BIB entry for trees dataset
draft.data(
  data.files = "trees.csv",
  data.scripts = NULL,
  originator = "Ryan, T. A., Joiner, B. L. and Ryan, B. F. (1976) The Minitab Student Handbook. Duxbury Press.",
  title = "Diameter, Height and Volume for Black Cherry Trees",
  file = TRUE,
  append = FALSE # create a new DATA.bib
)

?trees

#run taf.bootstrap procedure
taf.bootstrap()

#collection of files
#In case you have more than 1 file. You can load easily severeal data files
data(cars)
# make the directory we want to write to
mkdir("bootstrap/initial/data/my-collection")
# save files there
write.taf(trees, dir = "bootstrap/initial/data/my-collection")
write.taf(cars, dir = "bootstrap/initial/data/my-collection")

# Document this using draft.data() to add it to the DATA.bib file, but this time there are two differences as you are adding a new record, so we set append = TRUE as we want to add a record to an existing list of records.

draft.data(
  data.files = "my-collection",
  data.scripts = NULL,
  originator = "R datasets package",
  title = "Collection of R data",
  source = "folder",
  file = TRUE,
  append = TRUE # create a new DATA.bib
)

#draft.data creates the same data.bib with added lines, as it picks from both folders with files
taf.bootstrap()

#new file from url
#
#
draft.data(
  data.files = "HadSST.4.0.1.0_median.nc",
  data.scripts = NULL,
  originator = "UK MET office",
  title = "Met Office Hadley Centre observations datasets",
  year = 2022,
  source = "https://www.metoffice.gov.uk/hadobs/hadsst4/data/netcdf/HadSST.4.0.1.0_median.nc",
  file = TRUE,
  append = TRUE
)

#create you own data entry
mkdir("bootstrap/initial/data/datras")
hhdata <- getHHdata(survey = "PT-IBTS", year = 2018, quarter = 4)
hldata <- getHLdata(survey = "PT-IBTS", year = 2018, quarter = 4)
write.taf(hhdata, dir = "bootstrap/initial/data/datras")
write.taf(hldata, dir = "bootstrap/initial/data/datras")

draft.data(
  data.files = "datras",
  data.scripts = NULL,
  originator = "ICES  DATRAS database",
  title = "PT-IBTS 2018 HH and HL data",
  year = 2018,
  source = "folder",
  file = TRUE,
  append = TRUE
)

#if you make erros, you can open the DATA.bib and delete incorrect entries
taf.bootstrap()