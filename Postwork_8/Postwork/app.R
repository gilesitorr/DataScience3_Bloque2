library(shiny)
library(shinydashboard)
library(shinythemes)
library(rsconnect)


# Se lee la base de datos
matches <- read.csv("data/match.data.csv")

#Se reorganiza la base para poder hacer un facet_wrap fácil
goals.L <- data.frame(Tipo="Local",Goles=matches$home.score)
goals.V <- data.frame(Tipo="Visitante",Goles=matches$away.score)
goals <- rbind(goals.L,goals.V)

# Se cambian los nombres de la base matches para que la tabla  dinámica tenga nombres fáciles
names(matches) <- c("Fecha", "Equipo Local", "Goles Local", "Equipo Visitante", "Goles Visitante")

##################
# USER INTERFACE #
##################

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    dashboardPage(
        
        dashboardHeader(title = "Postwork 8 Sports"),
        
        dashboardSidebar(
            
            sidebarMenu(
                menuItem("La Frecuencia del GOL", tabName = "Dashboard", icon = icon("dashboard")),
                menuItem("La Probabilidad de Anotar", tabName = "pos3", icon = icon("area-chart")),
                menuItem("Los Marcadores", tabName = "data_table", icon = icon("table")),
                menuItem("Los Momios", tabName = "img", icon = icon("file-picture-o"))
            )
            
        ),
        
        dashboardBody(
            
            tabItems(
                
                # Histograma
                tabItem(tabName = "Dashboard",
                        fluidRow(
                            titlePanel(h3("Frecuencia de la cantidad de goles (2010-2020)")), 
                            
                            box(title = "Frecuencia para local y visitante",
                                background="black",
                                plotlyOutput("plot1", height = 300),
                                width=10)
                           #plotlyOutput("plot1", height = 250)
                        )
                ),
                
                # Postwork 3
                tabItem(tabName = "pos3",
                        fluidRow(
                            titlePanel(h2("Probabilidad de goles (2017-2020)")),
                            box(title="Probabilidad del local",
                                #status="primary",
                                background="black",solidHeader = TRUE,
                                img( src = "p3_home.png", 
                                     height = 250, width = 290)),
                            box(title="Probabilidad del visitante",
                                #status="info", 
                                background="light-blue",solidHeader = TRUE,
                                img( src = "p3_away.png", 
                                     height = 250, width = 290)),
                            box(title="Probabilidad conjunta",
                                #status="info", 
                                #background="light-blue",solidHeader = TRUE,
                                img( src = "p3_both.png", 
                                     height = 250),
                                width = 8)
                        )
                ),
                
                
                #Data table
                tabItem(tabName = "data_table",
                        fluidRow(        
                            titlePanel(h2("Marcadores de cada partido (2010-2020)")),
                            dataTableOutput ("data_table")
                        )
                ), 
                
                # Momios
                tabItem(tabName = "img",
                        fluidRow(
                            titlePanel(h3("Escenarios con momios máximos y promedio (2010-2020)")),
                            box(title="Momios máximos",
                                #status="primary",
                                background="black",solidHeader = TRUE,
                                img( src = "g1.png", 
                                    height = 250, width = 290)),
                            box(title="Momios promedio",
                                #status="info", 
                                background="light-blue",solidHeader = TRUE,
                                img( src = "g2.png", 
                                     height = 250, width = 290))
                        )
                )
                
            )
        )
    )
)


#############################################################
#############################################################
#############################################################
#############################################################

##########
# SERVER #
##########

# Define server logic required to draw a histogram
server <- function(input, output) {

    library(ggplot2)
    library(plotly)
    
    #Gráfico de Histograma
    output$plot1 <- renderPlotly({
        
        p <- ggplot(goals, aes(x=Goles)) + 
            geom_bar() + 
            theme_light() + 
            ylab("Frecuencia") + 
            facet_wrap(~ Tipo)+
            theme_gray()
        ggplotly(p)
        
        
    })
    
    # Gráficas de dispersión
    output$output_plot <- renderPlot({ 
        
        ggplot(mtcars, aes(x =  mtcars[,input$a] , y = mtcars[,input$y], 
                           colour = mtcars[,input$z] )) + 
            geom_point() +
            ylab(input$y) +
            xlab(input$a) + 
            theme_linedraw() + 
            facet_grid(input$z)  #selección del grid
        
    })   
    
    #Data Table
    output$data_table <- renderDataTable( {matches}, 
                                          options = list(aLengthMenu = c(5,25,50),
                                                         iDisplayLength = 5)
    )
}

# Run the application 
shinyApp(ui, server)
