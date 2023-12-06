#### Reshaping the datasets ####

# Packages used #####
library(dplyr)
library(readxl)

# Reading raw datasets  #####

# Gennai
dataset.blank.gennai.raw <- read_excel("datasets/Gennai_Rom.Ansab_Blanks.xlsx")

dataset.core.gennai.raw <- read_excel("datasets/Gennai_Rom.Ansab_Cores.xlsx")

# Niochet (to do: core dataset missing)

dataset.blank.niochet.raw <- read_excel("datasets/Niochet_CTS-US04inf_Blanks.xlsx")

# Falcucci (for now the one used in the JASs paper)

dataset.blank.falcucci.raw <- read_excel("datasets/Falcucci_Fumane_Blanks.xlsx")


# Renaming attributes for better flow (to do: include also attributes linked to tool type/retouch once ready) #####

# Gennai, blanks
dataset.blank.gennai.reshaped <- dataset.blank.gennai.raw %>%
  rename(ID = "Piece Original ID", Preservation = "Entirety", Cortex = "CxSimpl", Cortex.position = "CxPosition", Thickness = "Thick", Elongation = "El", Platform = "ButtType", Bulb = "BulbMorph", Lip = "Lipp", Abrasion = "OvAb", Outline.morphology = "Out", Cross.section = "CrossSectMorph", Profile = "Pro", Distal.end.morpho = "DEndMorph",Blank.type = "StructureCat", Technology = "TechCat", Number.negatives = "NegN", Negatives.type = "NegType", Dorsal.scar.1 = "NegOSimpl", Dorsal.scar.2 = "NegO", Tool = "R") %>%
  mutate(Cortex.y.n = Cortex, .after = Cortex.position) %>%
  mutate(Cortex.y.n = recode(Cortex.y.n, Extensive = "Yes", Full = "Yes", Semi = "Yes"))

dataset.blank.gennai.reshaped$Torsion <- NA

# Niochet, blanks
dataset.blank.niochet.reshaped <- dataset.blank.niochet.raw %>%
  rename(ID = "Piece Original ID", Preservation = "Entirety", Cortex = "CxSimpl", Cortex.position = "CxPosition", Thickness = "Thick", Elongation = "El", Platform = "ButtType", Bulb = "BulbMorph", Lip = "Lipp", Abrasion = "OvAb", Outline.morphology = "Out", Cross.section = "CrossSectMorph", Profile = "Pro", Distal.end.morpho = "DEndMorph",Blank.type = "StructureCat", Technology = "TechCat", Number.negatives = "NegN", Negatives.type = "NegType", Dorsal.scar.1 = "NegOSimpl", Dorsal.scar.2 = "NegO", Tool = "R") %>%
  mutate(Cortex.y.n = Cortex, .after = Cortex.position) %>%
  mutate(Cortex.y.n = recode(Cortex.y.n, Extensive = "Yes", Full = "Yes", Semi = "Yes"))

dataset.blank.niochet.reshaped$Torsion <- NA

# Falcucci, blanks
dataset.blank.falcucci.reshaped <- dataset.blank.falcucci.raw %>%
  rename(Bulb = "bulb.type", Platform = "platform.type", Bulb = "bulb.type", Lip = "lip.type", Abrasion = "dorsal.thinning", Outline.morphology = "blank.shape", Cross.section = "cross.section", Symmetry = "cross.section.symmetry", Profile = "curvature", Torsion = "torsion", Distal.end.morpho = "distal.end", Blank.type = "blank", Technology = "technology", Axiality = "axiality", Number.negatives = "scar.count", Negatives.type = "bladelet.neg.blade", Dorsal.scar.1 = "scar.pattern", Tool = "class") %>%
  mutate(Tool = recode(Tool, Blank = "No", Tool = "Yes")) %>%
  mutate(Dorsal.scar.2 = Dorsal.scar.1)

dataset.blank.falcucci.reshaped$Symmetry <- as.factor(dataset.blank.falcucci.reshaped$Symmetry)

dataset.blank.falcucci.reshaped <- dataset.blank.falcucci.reshaped %>%
  mutate(Symmetry = recode(Symmetry, `TRUE` = "symmetric", `FALSE` = "asymmetric"))


# Selecting the attributes needed, as data anaysis progresses (to do: see retouch stuff) #####

# Gennai
dataset.blank.gennai.reshaped <- dataset.blank.gennai.reshaped %>%
  select(Site, Layer, ID, Preservation, Cortex.y.n, Cortex, Cortex.position, Length, Width, Thickness, Elongation, Platform, Bulb, Lip, Abrasion, Axiality, Outline.morphology, Symmetry, Cross.section, Profile, Torsion, Distal.end.morpho, Blank.type, Technology, Number.negatives, Negatives.type, Dorsal.scar.1, Dorsal.scar.2, Tool)

# Niochet
dataset.blank.niochet.reshaped <- dataset.blank.niochet.reshaped %>%
  select(Site, Layer, ID, Preservation, Cortex.y.n, Cortex, Cortex.position, Length, Width, Thickness, Elongation, Platform, Bulb, Lip, Abrasion, Axiality, Outline.morphology, Symmetry, Cross.section, Profile, Torsion, Distal.end.morpho, Blank.type, Technology, Number.negatives, Negatives.type, Dorsal.scar.1, Dorsal.scar.2, Tool)

# Falcucci
dataset.blank.falcucci.reshaped <- dataset.blank.falcucci.reshaped %>%
  select(Site, Layer, ID, Preservation, Cortex.y.n, Cortex, Cortex.position, Length, Width, Thickness, Elongation, Platform, Bulb, Lip, Abrasion, Axiality, Outline.morphology, Symmetry, Cross.section, Profile, Torsion, Distal.end.morpho, Blank.type, Technology, Number.negatives, Negatives.type, Dorsal.scar.1, Dorsal.scar.2, Tool)

# Merging datasets ####

dataset.blank.main <- rbind(dataset.blank.gennai.reshaped, dataset.blank.niochet.reshaped, dataset.blank.falcucci.reshaped)


# Exporting the merged datasets ####

writexl::write_xlsx(dataset.blank.main, "datasets/dataset.merged.xlsx")
