

library(shiny)
library(tidyverse)
library(Lahman)

data("LahmanData")

ui <- shinyUI(fluidPage(
        fluidRow(
                headerPanel("Lahman's Baseball Database"),
                sidebarLayout(
                        sidebarPanel(                                    
                                sliderInput("year","Years To Plot",min=1871,max=2018,value=c(1985,2014), sep=""),
                                selectInput("xVar", "X Variable",
                                            choices = c("yearID","W", "L", "R", "AB", "H", "HR", "SO", "SB", "ERA", "FP"),
                                            selected = "yearID"),
                                selectInput("yVar", "Y Variable",
                                            choices = c("W", "L", "R", "AB", "H", "HR", "SO", "SB", "ERA", "FP"),
                                            selected = "HR"),
                                selectInput("hVar", "Histogram Variable",
                                            choices = c("W", "L", "R", "AB", "H", "HR", "SO", "SB", "ERA", "FP"),
                                            selected = "HR"),
                                sliderInput("bVar", "# of Bins in Histogram", 
                                            min = 1, max = 100, value = 50)
                        ),
                        mainPanel(
                                tabsetPanel(
                                        tabPanel("Plot", plotOutput("sPlot")),
                                        tabPanel("Histogram", plotOutput("Hist")),
                                        tabPanel("Help/Notes",htmlOutput("help"))
                                )
                        )
                )
        )
))