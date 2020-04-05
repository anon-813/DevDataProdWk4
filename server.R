library(shiny)
library(tidyverse)
library(Lahman)


server <- shinyServer(function(input, output) {
        
        # create a reactive dataset which is passed to ggplot object
        df <- reactive({ 
                Teams %>% filter(yearID >= input$year[1] & yearID <= input$year[2]) %>%
                        mutate(HRperGame = HR / G)
        })
        

        
        output$sPlot<-renderPlot({
                df1 <- df()
                p <- ggplot(df(), aes_string(input$xVar, input$yVar)) +
                        geom_point() +
                        geom_smooth(method = "lm") +
                        expand_limits(y=0) +
                        xlab(input$xVar) +
                        ylab(input$yVar) +
                        theme_minimal()
                
                print(p)
        })
        

        output$Hist <- renderPlot({
                df1 <- df()
                p <- ggplot(df1, aes_string(input$hVar)) + geom_histogram(bins=input$bVar, fill="grey", color="black") 
                p <- p + geom_vline(xintercept = mean(df1[[input$hVar]], na.rm=T),  col="orangered3", lwd=1, lty=1, show.legend = TRUE)
                p <- p + xlab(input$hVar)
                p <- p + labs(title = paste("Distribution of ", input$hVar, "Per Team in", input$year[1], "to", input$year[2]),
                             subtitle=paste("with", input$bVar, "bins"),
                             caption = paste("Mean", input$hVar, "(red line) = ", format(mean(df1[[input$hVar]], na.rm=T), big.mark = "," )))
                p <- p + theme_minimal()

                print(p)
        })
        
        output$help <- renderUI({
                
    
                HTML("This is a simple shiny app that allows us to explore the Teams table in Lahman’s Baseball Database. 
                The table provides yearly statistics and standings for baseball teams and is included in the Lahman package for R.  
                 More information on the data can be found on <a href='http://www.seanlahman.com/baseball-archive/statistics/'>
                Lahman's Site</a>.  <br/> <br/> 
                
                This app will produce 
                        <ol>
                        <li>A scatter plot with linear model trend line on the Plot tab.</li>
                        <li>A histogram on the histogram tab.</li>
                        </ol>

                <br/> 
                To use this app: <br/> 
                     <ol>
                    <li>Use the first slider to select which years you want see plotted.  This applies to both the plot and the histogram.</li>
                     <li>Select the x-variable for the scatter plot.</li>
                     <li>Select the y-variable for the scatter plot.</li>
                     <li>Select the variable for the histogram.</li>
                     <li>Select the number of bins that you want to see on the histogram.</li>
                     <li>Click the tab you want to see.</li>
                     </ol>
                       
                <br/> 
                The variables are: <br/>  <br/> 

                        <table>
                        <tr><th>Variable</th><th>Description</th></tr>
                        <tr><td>yearID</td><td>Calendar Year</td></tr>
                        <tr><td>G</td><td>Games Played</td></tr>
                        <tr><td>W</td><td>Team Wins</td></tr>
                        <tr><td>L</td><td>Team Losses</td></tr>
                        <tr><td>R</td><td>Runs Scored</td></tr>
                        <tr><td>AB</td><td>At Bats</td></tr>
                        <tr><td>H</td><td>Number of Hits</td></tr>
                        <tr><td>HR</td><td>Number of Home Runs</td></tr>
                        <tr><td>SO</td><td>Number of Strike Outs</td></tr>
                        <tr><td>ERA</td><td>Earned Run Average</td></tr>
                        <tr><td>SB</td><td>Number of Stolen Bases</td></tr>
                        <tr><td>FP</td><td>Fielding Percentage</td></tr>
                        </table>

                <br/>      
                Full Code for this app can be found at 
                        <a href='https://github.com/anon-813/DevDataProdWk4'> https://github.com/anon-813/DevDataProdWk4 </a> 

<br/>  <br/>  
               Presentation can be found at 
                        <a href='https://rpubs.com/ocdobv/595191'> https://rpubs.com/ocdobv/595191 </a>       
                     ")

             
        })
    
        
})