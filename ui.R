library(httr)
library(rlist)
library(jsonlite)
library(tidyverse)
library(stringr)
library(readxl)
library(shiny)
library(shinythemes)
library(tidyverse)
library(shinydashboard)

source("apidata.R")

sidebar <- dashboardSidebar(
    collapsed = F,
    sidebarMenu(id = "tabs",
        menuItem("Control Terminologies",
                 tabName = "HCT",
                 icon = icon("fa-light fa-table")),
        
        menuItem("Implementation Guide",
                 tabName = "HIG",
                 icon = icon("fa-light fa-receipt")), 
        
        menuItem("Support",
                 tabName = "SUPP",
                 icon = icon("fa-light fa-headset"))))

body <- dashboardBody(
    tabItems(
        tabItem(tabName = "HCT",
        fluidRow(
            column(width = 5,
           box(title = "Make Your Selection", 
               status = "warning", 
               solidHeader = T,
               collapsible = T,
               width = "auto",
            selectInput(inputId = "IN101",
                        "CDISC Standard", 
                        choices = sort(unique(termData$origin)),
                        selected = NULL,
                        selectize=T),
            
            selectInput("IN102", 
                        "CDISC Published Date", 
                        choices = NULL, 
                        selected = NULL,
                        selectize=T),
            
            selectInput("IN103", 
                        "CDISC Submission Value", 
                        choices = NULL, 
                        selected = NULL,
                        selectize=T))),
            column(width = 7,    
            box(title = "Overview of selection", 
                style = 'font-size:14px;',
                status = "info",
                width = "auto",
                height= "auto",
                solidHeader = TRUE,
                collapsible = TRUE,
                tags$li(textOutput("TAB.B101",inline = T)),
                br(),
                tags$li(textOutput("TAB.B102",inline = T)),
                br(),
                tags$li(textOutput("TAB.B103",inline = T)),
                br(),
                tags$li(textOutput("TAB.B104",inline = T)),
                br(),
                tags$li(textOutput("TAB.B105",inline = T)),
                br(),
                tags$li(textOutput("TAB.B106",inline = T)),
                br()))),
        
        fluidRow(box(title = "Results", 
                status = "danger", 
                solidHeader = T,
                collapsible = T,
                width = "auto",
                DT::dataTableOutput("TAB.B107",width = "auto", height = "auto")))),

        tabItem(tabName = "HIG",
                fluidRow(
                    column(width = 3,
                           box(title = "Make Your Selection", 
                               status = "warning", 
                               solidHeader = T,
                               collapsible = T,
                               width = "auto",
                               selectInput(inputId = "IN201",
                                           "CDISC Standard", 
                                           choices = sort(unique(alligdata$origin)),
                                           selected = NULL,
                                           selectize=T),
                               
                               selectInput("IN202", 
                                           "CDISC Version", 
                                           choices = NULL, 
                                           selected = NULL,
                                           selectize=T),
                               
                               selectInput("IN203", 
                                           "Domain/Dataset", 
                                           choices = NULL, 
                                           selected = NULL,
                                           selectize=T))),
                    column(width = 9,    
                           box(title = "Overview of Selection",
                               status = "info",
                               width = "auto",
                               height= "auto",
                               solidHeader = TRUE,
                               collapsible = TRUE,
                               br(),
                               tags$li(textOutput("TAB.B201",inline = T)),
                               br(),
                               tags$li(textOutput("TAB.B202",inline = T)), 
                               br(),
                               tags$li(textOutput("TAB.B203",inline = T)),
                               br(),
                               tags$li(textOutput("TAB.B204",inline = T)),
                               br(),
                               tags$li(textOutput("TAB.B205",inline = T)),
                               br(),
                               br()))),
                
                fluidRow(box(title = "Results", 
                             status = "danger", 
                             solidHeader = T,
                             collapsible = T,
                             width = "auto",
                             DT::dataTableOutput("TAB.B206",width = "auto", height = "auto")))),
        tabItem(tabName = "SUPP",
                fluidRow(
                    box(title = "About Us",
                        status = "success",
                        width = "auto",
                        height= "auto",
                        solidHeader = TRUE,
                        collapsible = F,
                        tags$li("We believe that everyone should have easy access to 
                                control terminologies, CDISC information for Clinical Development. 
                                Our goal is to overcome any technical barriers that can prevent
                                individuals working in clinical teams from achieving their work 
                                efficiently. Innovation and simplicity is our primary objective. 
                                We are excited to help you and make you a part of our journey!"),
                        br(),
                        tags$li("For any questions, concern please contact us on tapswi2696@gmail.com")
                        )))))

ui <- dashboardPage(
    dashboardHeader(title = "HandyCT"),
    sidebar,
    body)

