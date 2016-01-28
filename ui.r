library(shiny)

shinyUI(pageWithSidebar(
    headerPanel("DOTA 2 Hero Recommender - V1.0"),
    
    sidebarPanel(
        selectizeInput("opfor_1", "First Opposing Hero:", choices = hero_frame$hero_names),
        selectizeInput("opfor_2", "Second Opposing Hero:", choices = hero_frame$hero_names),
        selectizeInput("opfor_3", "Third Opposing Hero:", choices = hero_frame$hero_names),
        selectizeInput("opfor_4", "Fourth Opposing Hero:", choices = hero_frame$hero_names),
        selectizeInput("opfor_5", "Fith Opposing Hero:", choices = hero_frame$hero_names),
        actionButton('calculate', 'calculate')
    ),
    mainPanel(
        textOutput("opposition_print"),
        
        h5('By: Zachary Vincent Smith zv2.2smith@gmail.com')
    )
))