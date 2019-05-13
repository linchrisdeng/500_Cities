library(shiny)
library(leaflet)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("500 Cities"),
  
  # Select State
  sidebarLayout(
    
    sidebarPanel(
       selectInput("StateAbbr",
                   "Selected State: ",
                   choices = unique(df$StateAbbr), 
                   selected = ""),
    
  # Select City
       selectInput("PlaceName",
                   "Selected City: ",
                   choices = "", 
                   selected = ""),
  
       selectInput("Measure",
                   "Measure: ", 
                   choices = c(
                     "Arthritis" = "ARTHRITIS_CrudePrev", 
                     "Current Asthma" = "CASTHMA_CrudePrev", 
                     "High Blood Pressure" = "BPHIGH_CrudePrev",
                     "Cancer (except skin)" = "CANCER_CrudePrev",
                     "High Cholesterol" = "HIGHCHOL_CrudePrev",
                     "Chronic Kidney Disease" = "KIDNEY_CrudePrev",
                     "COPD (Chronic Obstructive Pulmonary Disease)" = "COPD_CrudePrev",
                     "Coronary Heart Disease" = "CHD_CrudePrev",
                     "Diabetes" = "DIABETES_CrudePrev",
                     "Mental Health" = "MHLTH_CrudePrev",
                     "Physical Health" = "PHLTH_CrudePrev",
                     "Teeth Loss" = "TEETHLOST_CrudePrev",
                     "Stroke" = "STROKE_CrudePrev",
                     "Health Insurance" = "ACCESS2_CrudePrev",
                     "Annual Checkup" = "CHECKUP_CrudePrev",
                     "Dental Visit" = "DENTAL_CrudePrev",
                     "Taking BP Medication" = "BPMED_CrudePrev",
                     "Cholesterol Screening" = "CHOLSCREEN_CrudePrev",
                     "Mammography" = "MAMMOUSE_CrudePrev",
                     "Papanicolaou Smear Test" = "PAPTEST_CrudePrev",
                     "Colorecatal Cancer Screening" = "COLON_SCREEN_CrudePrev",
                     "Core Preventive Services for Men" = "COREM_CrudePrev",
                     "Core Preventive Services for Women" = "COREW_CrudePrev",
                     "Binge Drinking" = "BINGE_CrudePrev",
                     "Current Smoking" = "CSMOKING_CrudePrev",
                     "Physical Inactivity" = "LPA_CrudePrev",
                     "Obesity" = "OBESITY_CrudePrev",
                     "Sleep <7 hours" = "SLEEP_CrudePrev"
                   ))
    ),
    # Plot 
    mainPanel(
      leafletOutput("selected_map")
  )
  )))
