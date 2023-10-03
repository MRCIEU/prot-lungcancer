setwd("~/UkbCancerMortality")
library(UkbCancerMortality)
devtools::load_all()
devtools::document()

bd1<-read.table("~/output_extracted_variables_33352_v2.tsv",sep="\t",head=T,stringsAsFactors=FALSE)
bd2<-read.table("~/output_extracted_variables_37205_v3.tsv",sep="\t",head=T,stringsAsFactors=FALSE)
bd3<-read.table("~/output_extracted_variables_33352_f21022.tsv",sep="\t",head=T,stringsAsFactors=FALSE)

bd<-merge(bd1,bd2,by=c("projectID","geneticID" )) 
bd<-merge(bd,bd3[,c("projectID","f.21022.0.0")],by="projectID")

bd<-format_behaviour()
bd<-format_date_enrollment()
bd<-format_date_diagnosis()
bd<-format_sex()

# bd_temp<-bd
# lung cancer
luc<-lung_cancer_function() 
# temp<-luc
luc2<-lung_cancer_function2(dat=luc)
lun3<-format_cancer(dat=luc2,censor_date="2018-02-06",cancer_name="overall_lung_cancer",icd10="C34")
lun4<-multiple_diagnoses2(dat=lun3,icd10="C34",icd9=16)
# head(lun4)
# Names6<-names(lun4)[grep("f.40000",names(lun4))] #Date of death

# head(lun4$date_diagnosis2)
# head(lun4$f.40000.1.0)

# deaths within 3 months of diagnosis 
length(which(lun4$survival_months<=3))/nrow(lun4)
length(which(lun4$survival_months>3))/nrow(lun4)
length(which(is.na(lun4$survival_months)))/nrow(lun4)


Pos1<-which(is.na(lun4$incident_lung_cancer))
Pos2<-which(!is.na(lun4$incident_lung_cancer))

summary(lun4$date_diagnosis2[Pos1])
summary(lun4$date_diagnosis2[Pos2])

Names6<-names(lun4)[grep("f.53\\.",names(lun4))] #Date of death

lun4$f.53.0.0
lun4$date_diagnosis2

lun4<-dat



qc_check<-function(){
	# check date of consent same as first date attended assessment centre
	if(!all(lun4$date_consent == lun4$first_date_attend_centre)) warning("consent date not always the same as first date of attendance at assessment centre")

	# check that incident cases were diagnosed after UKB baseline date using alternative method for determining incident case
	Pos1<-which(lun4$date_diagnosis2 > lun4$date_consent)
	Pos2<-which(!is.na(lun4$incident_lung_cancer))
	if(!all(Pos1==Pos2)) warning("possible conflict between date of diagnosis for incident cases and date of enrollment into UKB")

	Pos3<-which(lun4$date_diagnosis2 <= lun4$date_consent)
	Pos4<-which(is.na(lun4$incident_lung_cancer))
	if(!all(Pos3==Pos4)) warning("possible conflict between date of diagnosis for incident cases and date of enrollment into UKB")
}



dim(lun4)
table(lun4$Index_6mo)
table(lun4$Index_3yr)

# lung cancer icd10 and icd9 codes
# c("C340", "C341", "C342", "C343", "C348", "C349")
# c("1622", "1623", "1624", "1625", "1628", "1629")

# source("~/UKBB_cancer_outcomes/UKBB_lung_cancer_2.r")
bd<-cleanup_names()


# breast cancer
# UKBB_cancer_outcomes can be found on github 
# https://github.com/MRCIEU/UKBB_cancer_outcomes
# bd1<-bd
bd<-bd[,!names(bd) %in% c("overall_cervical_cancer","overall_prostate_cancer","overall_breast_cancer")]
bd<-breast_cancer_function()
source("~/UKBB_cancer_outcomes/UKBB_breast_cancer_2.r")
bd<-cleanup_names()
table(bd$incident_breast_cancer)
# table(bd$f.31.0.0)

# prostate cancer
bd<-prostate_cancer_function()
source("~/UKBB_cancer_outcomes/UKBB_prostate_cancer_2.r")
bd<-cleanup_names()
table(bd$incident_prostate_cancer)

bd<-cervical_cancer_function()
source("~/UKBB_cancer_outcomes/UKBB_cervical_cancer_2.r")
bd<-cleanup_names()
table(bd$incident_cervical_cancer)

bd<-kidney_cancer_function()
source("~/UKBB_cancer_outcomes/UKBB_kidney_cancer_2.r")
bd<-cleanup_names()
table(bd$overall_kidney_cancer)

# bd4<-bd
bd<-pancreatic_cancer_function()
source("~/UKBB_cancer_outcomes/UKBB_pancreatic_cancer_2.r")
bd<-cleanup_names()
table(bd$overall_pancreatic_cancer)

bd<-stomach_cancer_function()
source("~/UKBB_cancer_outcomes/UKBB_stomach_cancer_2.r")
bd<-cleanup_names()
table(bd$overall_stomach_cancer)

# bd4<-bd
bd<-aml_cancer_function()
source("~/UKBB_cancer_outcomes/UKBB_aml_2.r")
bd<-cleanup_names()
table(bd$overall_aml)

# bd4<-bd
bd<-endometrial_cancer_function()
source("~/UKBB_cancer_outcomes/UKBB_endometrial_cancer_2.r")
bd<-cleanup_names()
table(bd$overall_endometrial_cancer)

bd<-overall_cancer_function()
source("~/UKBB_cancer_outcomes/UKBB_overall_cancer_2.r")
bd<-cleanup_names()


bd<-overall_cancer_exclc44_function()
source("~/UKBB_cancer_outcomes/UKBB_overall_cancer_exclc44_2.r")
bd<-cleanup_names()

bd<-colorectal_cancer_function()
source("~/UKBB_cancer_outcomes/UKBB_colo_cancer_2.r")
bd<-cleanup_names()



# melanoma
bd<-melanoma_cancer_function()
source("~/UKBB_cancer_outcomes/UKBB_skin_cancer_2.r")
bd<-cleanup_names()

# pharyngeal cancer
bd<-pharynx_cancer_function()
source("~/UKBB_cancer_outcomes/UKBB_pharynx_2.r")
bd<-cleanup_names()

# ovarian cancer
bd<-ovarian_cancer_function()
source("~/UKBB_cancer_outcomes/UKBB_ovarian_cancer_2.r")
bd<-cleanup_names()

# oropharyngeal cancer
bd<-oropharyngeal_cancer_function()
source("~/UKBB_cancer_outcomes/UKBB_oral_pharynx_2.r")
bd<-cleanup_names()

# oral cancer
bd<-oral_cancer_function()
source("~/UKBB_cancer_outcomes/UKBB_oral_cavity_2.r")
bd<-cleanup_names()

# oesophageal cancer
bd<-oesophageal_cancer_function()
source("~/UKBB_cancer_outcomes/UKBB_oesoph_cancer_2.r")
bd<-cleanup_names()

# non melanoma skin cancer
bd<-nonmelanoma_skin_cancer_function()
source("~/UKBB_cancer_outcomes/UKBB_nm_skin_cancer_2.r")
bd<-cleanup_names()

# myeloid leukemia 
bd<-myeloid_leukemia_function()
source("~/UKBB_cancer_outcomes/UKBB_myel_leuk_2.r")
bd<-cleanup_names()

# multiple myeloma
bd<-multiple_myeloma_function()
source("~/UKBB_cancer_outcomes/UKBB_mult_myel_2.r")
bd<-cleanup_names()

# lymphoid leukemia
bd<-lymphoid_leukemia_function()
source("~/UKBB_cancer_outcomes/UKBB_lymph_leuk_2.r")
bd<-cleanup_names()

# Liver cell carcinoma
bd<-liver_cell_cancer_function()
source("~/UKBB_cancer_outcomes/UKBB_liver_cell_2.r")
bd<-cleanup_names()

# liver bile cancer
bd<-liver_bile_cancer_function()
source("~/UKBB_cancer_outcomes/UKBB_liver_bile_cancer_2.r")
bd<-cleanup_names()

# leukemia
bd<-leukemia_function()
source("~/UKBB_cancer_outcomes/UKBB_leuk_2.r")
bd<-cleanup_names()

# larynx cancer
bd<-larynx_cancer()
source("~/UKBB_cancer_outcomes/UKBB_larynx_2.r")
bd<-cleanup_names()

# head and neck cancer
bd<-head_and_neck_cancer()
source("~/UKBB_cancer_outcomes/UKBB_headneck_2.r")
bd<-cleanup_names()

# haematological cancer
bd<-haematological_cancer_function()
source("~/UKBB_cancer_outcomes/UKBB_haem_cancer_2.r")
bd<-cleanup_names()

# brain cancer
bd<-brain_cancer_function()
source("~/UKBB_cancer_outcomes/UKBB_brain_cancer_2.r")
bd<-cleanup_names()

# bladder cancer
bd<-bladder_cancer_function()
source("~/UKBB_cancer_outcomes/UKBB_bladder_cancer_2.r")
bd<-cleanup_names()

bd<-melanoma_plus_other_malignant_skin_cancer_function()
source("~/UKBB_cancer_outcomes/UKBB_mmplus_skin_cancer_2.r")
bd<-cleanup_names()

bd<-acute_lymphoblastic_leukemia_function()
source("~/UKBB_cancer_outcomes/UKBB_acute_lymph_leuk_2.r")
bd<-cleanup_names()

# table(bd$overall_acute_lymph_leuk)
# names(bd)

# bd4<-bd
# save(bd,file="/projects/MRC-IEU/users/ph14916/fatty_acids_summary/cox_smoking/UKBB_cancers_aspirin_smoking.Rdata")
# load("/projects/MRC-IEU/users/ph14916/fatty_acids_summary/cox_smoking/UKBB_cancers_aspirin_smoking.Rdata")

# bd5<-bd[,!names(bd) %in% c("incident_prostate_cancer","incident_breast_cancer","overall_prostate_cancer","overall_breast_cancer")   ]

# names(bd5)[1:10]
# bd6<-bd5[,c("projectID" ,"geneticID",names(bd5)[!names(bd5) %in% names(bd4)])]
# bd7<-merge(bd4,bd6,by=c("projectID","geneticID"))
# dim(bd7)
# bd<-bd7

# add in cancer mortality data
# Age at death	f.40007: three instances (0,1,2).  instance 2 is nested within 1 and 0. 1 is nested within 0. f.40007.0.0, f.40007.1.0, f.40007.2.0. The instances are identical to each other. non missing f.40007.2.0 is identical to f.40007.1.0 and f.40007.0.0. non missing f.40007.1.0 is identical to f.40007.0.0

# Secondary cause of death	f.40002
# Primary cause of death	f.40001
# Reported occurrences of cancer	f.40009
# Date of death	f.40000 . two instances, the second is nested within, and is identical to, the first 
# Description of cause of death	f.40010, exclude because can't be extracted by python script
# Date of attending assessment centre	f.53

# bd$f.21022.0.0
bd1_2<-read.table("~/output_extracted_variables_33352_v2.tsv",sep="\t",head=T,stringsAsFactors=FALSE)

bd4<-read.table("~/output_extracted_variables_37205_v3.tsv",sep="\t",head=T,stringsAsFactors=FALSE)
bd5<-merge(bd1_2,bd4,by=c("projectID","geneticID" )) 

Pos<-unlist(lapply(c("projectID"    ,"geneticID",  "40007","40002","40001","40009","f.40000","53"),FUN=function(x)
	grep(x,names(bd5))))
bd6<-bd5[,Pos]
names(bd6)[names(bd6)=="f.40007.0.0"]<-"age_at_death_40007"
names(bd6)[names(bd6)=="f.40009.0.0"]<-"occurrences_of_cancer_40009"


# bd9<-bd
bd<-merge(bd,bd6,by=c("projectID","geneticID" ))
bd<-format_date_of_death()
bd<-format_date_of_attending_assessment_centre()

# bd6[Pos1,grep("40000",names(bd6))]
# Pos0<-which(!is.na(bd6$f.40000.0.0))
# Pos1<-which(!is.na(bd6$f.40000.1.0))
# bd6$f.40000.1.0[Pos1] == bd6$f.40000.0.0[Pos1] 

# names(bd6)
# Pos0<-which(!is.na(bd6$f.40007.0.0))
# Pos1<-which(!is.na(bd6$f.40007.1.0))
# Pos2<-which(!is.na(bd6$f.40007.2.0))

bd$FID <-bd$geneticID
bd$IID <-bd$geneticID

bd<-format_smoking()
# cd /projects/MRC-IEU/research/data/ukbiobank/genetic/variants/arrays/imputed/released/2018-09-18

dim(bd)
bd<-restrict_to_white_british()
dim(bd)
bd<-add_principal_components()
dim(bd)
bd<-exclude_relateds()
dim(bd)
bd<-standard_exclusion()
dim(bd)
bd<-add_sex_array()

bd<-withdrawn_participants(Dir="/projects/MRC-IEU/research/data/ukbiobank/phenotypic/applications/15825/released/2019-05-02/data/withdrawals/",Dir_extra="~/ukbiobank/withdrawals/") #Dir_extra is for lists of withdrawn participants that have not yet been added to the standard project space on the rdsf
dim(bd)

# Asp<-read.table("/projects/MRC-IEU/users/ph14916/fatty_acids_summary/cox_smoking/UKBB_cancer_aspirin_smoking.txt",sep="\t",head=T,stringsAsFactors=F)

# Asp1<-Asp[,c("projectID","nsaid_baseline_f_6154","aspirin_baseline_f_6154","nsaid_baseline_f_20003","aspirin_baseline_f_20003")]
# head(Asp1)
# bd_asp<-merge(bd,Asp1,by="projectID")
# bd<-bd_asp

# aspirin / nsaids
bd<-format_nsaids_baseline_6154()
bd<-format_aspirin_baseline_6154()
bd<-format_nsaids_baseline_20003()
bd<-format_aspirin_baseline_20003()

# Write table
names(bd)[names(bd) == "f.200.0.0"]<-"date_consented"
names(bd)[names(bd) == "f.22000.0.0"]<-"genotype_batch"
names(bd)[names(bd) == "f.31.0.0"]<-"sex"
names(bd)[names(bd) == "f.21022.0.0"]<-"age_at_recruitment"


"f.40005"
"f.40008"
names(bd)[grep("f.40011",names(bd))]
unique(bd$f.40011.0.0)
# head(bd$nsaid_baseline_f_6154)
# head(dat$nsaid_baseline_f_6154)

dat <- bd %>% select("projectID", "geneticID","sex", "sex2","array", "date_consented","smoking","f.20116.1.0","f.20116.2.0" ,"genotype_batch","nsaid_baseline_f_6154","aspirin_baseline_f_6154","nsaid_baseline_f_20003","aspirin_baseline_f_20003", starts_with("overall"), starts_with("incident"),starts_with("pc"),"age_at_recruitment")

histology<-read.table("~/UKBB_cancer_outcomes/coding38.tsv",sep="\t",head=T,stringsAsFactors=F)
	readLines("coding38.tsv")

dat1 <- bd %>% select("projectID", "geneticID","sex", "sex2","array", "date_consented","smoking","f.20116.1.0","f.20116.2.0" ,"genotype_batch","nsaid_baseline_f_6154","aspirin_baseline_f_6154","nsaid_baseline_f_20003","aspirin_baseline_f_20003", starts_with("overall"), starts_with("incident"),starts_with("pc"),starts_with("f.40002"),starts_with("f.40001"),starts_with("f.53"),"age_at_recruitment","occurrences_of_cancer_40009","date_of_death_40000","age_at_death_40007")


# f.40008=Age at cancer diagnosis
# f.40005=Date of diagnosis


# save(dat, file = "../all_cancer_phenotypes_inclc44_ph.Rdata")
write.table(dat, file="/projects/MRC-IEU/users/ph14916/fatty_acids_summary/cox_smoking/UKBB_cancer_aspirin_smoking.txt", sep="\t", row.names = F, quote = F,col.names=TRUE)

