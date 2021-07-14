library(shiny)
library(shinydashboard)
library(shinythemes)
library(rsconnect)
library(ggplot2)
library(plotly)
library(graphics)

# Se lee la base de datos
matches <- read.csv("data/match.data.csv", header=TRUE)
matches1 <- matches

# Se cambian los nombres de la base matches para que la tabla  dinámica tenga nombres fáciles
names(matches) <- c("Fecha", "Equipo.Local", "Goles.Local", "Equipo.Visitante", "Goles.Visitante")#Para el gráfico de barras
names(matches1) <- c("Fecha", "Equipo Local", "Goles Local", "Equipo Visitante", "Goles Visitante")#Para que la data table sea presentable

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
                
                # Gráfica de barras
                tabItem(tabName = "Dashboard",
                        fluidRow(
                            titlePanel(h3("Cantidad de goles (2010-2020)")), 
                            selectInput("x", "Seleccione el valor de X",
                                        choices = c("Goles.Local", "Goles.Visitante")),
                            box(title = "Goles anotados en partidos en los que el equipo mostrado es visitante",
                                background="black",
                                plotlyOutput("plot1", height = 500),
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
                                     height = 250)),
                            box(title="Probabilidad del visitante",
                                #status="info", 
                                background="light-blue",solidHeader = TRUE,
                                img( src = "p3_away.png", 
                                     height = 250)),
                            box(title="Probabilidad conjunta",
                                #status="info", 
                                #background="light-blue",solidHeader = TRUE,
                                img( src = "p3_both.png", 
                                     height = 250))
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
                            titlePanel(h3("Escenarios con momios máximos y promedio")),
                            box(title="Momios máximos",
                                #status="primary",
                                background="black",solidHeader = TRUE,
                                img( src = "g1.png", 
                                    height = 250)),
                            box(title="Momios promedio",
                                #status="info", 
                                background="light-blue",solidHeader = TRUE,
                                img( src = "g2.png", 
                                     height = 250))
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
    
    #Gráfico de barras
    output$plot1 <- renderPlotly({
        
        x<-matches[,input$x]
        p <- ggplot(matches, aes(x))+
            geom_bar() + 
            facet_wrap("Equipo.Visitante")+
            theme_gray()+
            ylab("Frecuencia") + 
            xlab(input$x)+
            ylim(0,80)
        ggplotly(p)
        
        
    })
    
    
    #Data Table
    output$data_table <- renderDataTable( {matches1}, 
                                          options = list(aLengthMenu = c(5,25,50),
                                                         iDisplayLength = 5)
    )
}

# Run the application 
shinyApp(ui, server)
