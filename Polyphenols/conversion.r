
library("Spectra")
library("MsBackendMgf")
library("stringr")

setwd("/isidora/DDA_MGF_files")
## conversion
mgf_files <- list.files("/Users/mahnoorzulfiqar/OneDriveUNI/isidora/DDA_MGF_files/MGF", full.names = TRUE)

for (i in mgf_files){
  sps <- Spectra(i, source = MsBackendMgf())
  mzml_file <- str_replace(i, "mgf", "mzML")
  export(sps, backend = MsBackendMzR(), file = mzml_file )
}

sps <- Spectra(mgf_files[i], source = MsBackendMgf())

sps$polarity <- rep(1, length(sps))

mzml_files <- list.files("/Users/mahnoorzulfiqar/OneDriveUNI/isidora/DDA_MGF_files/MGF", pattern = ".mzML", full.names = TRUE)
POS <- mzml_files[1:17]
NEG <- mzml_files[18:32]

for (i in POS){
  sps <- Spectra(i, source = MsBackendMzR())
  sps$polarity <- rep(as.integer(1), length(sps))
  export(sps, backend = MsBackendMzR(), file = i)
}
for (i in NEG){
  sps <- Spectra(i, source = MsBackendMzR())
  sps$polarity <- rep(as.integer(0), length(sps))
  export(sps, backend = MsBackendMzR(), file = i)
}


###### fix polarity for SIRIUS for positive files

file_names<- c("Isidora_polyphenols_1065.mzML",
  "Isidora_polyphenols_1067.mzML",
  "Isidora_polyphenols_1068.mzML",
  "Isidora_polyphenols_1069.mzML",
  
  "Isidora_polyphenols_1070.mzML",
  "Isidora_polyphenols_1071.mzML",
  "Isidora_polyphenols_1072.mzML",
  
  "Isidora_polyphenols_1073.mzML",
  "Isidora_polyphenols_1074.mzML",
  
  "Isidora_polyphenols_1075.mzML",
  "Isidora_polyphenols_1076.mzML",
  
  "Isidora_polyphenols_1077.mzML",
  "Isidora_polyphenols_1078.mzML",
  
  "Isidora_polyphenols_1079.mzML",
  "Isidora_polyphenols_1080.mzML",
  
  "Isidora_polyphenols_1081.mzML",
  "Isidora_polyphenols_1082.mzML"
)

sps <- Spectra(file_names[1], source = MsBackendMgf())

library("stringr")
for (i in 1:length(file_names)){
  folder_path <- paste("/Users/mahnoorzulfiqar/OneDriveUNI/isidora/DDA_MGF_files/mzML/mzML2/", (str_replace(file_names[i], ".mzML", "")), "/insilico/SIRIUS/no_isotope/", sep = "")
  print(folder_path)
  # List files with .ms extension in the specified folder
  ms_files <- list.files(folder_path, pattern = "SIRIUS_param.ms", all.files = TRUE, full.names = TRUE)
  print(ms_files)
  for (file_path in ms_files){
    lines <- readLines(file_path)
    lines[3] <- ">charge +1"
    writeLines(lines, file_path)
  }
}
