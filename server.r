library(shiny)
library(UsingR)


    

shinyServer(
    function(input, output, session) {
        
        suggestion <- eventReactive(input$calculate, {
            as.character(recommended_hero(c(input$opfor_1, input$opfor_2, input$opfor_3, input$opfor_4, input$opfor_5)))
        })
        
        output$opposition_print <- renderPrint({
            suggestion()
        })
        
       
    }
)