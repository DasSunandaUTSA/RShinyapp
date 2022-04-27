#### Load the required packages ####

requiredPackages <- c("shiny", "shinydashboard" ,"shinycssloaders","plotly","DT","plyr","ggplot2","ggtext")

ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg))
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

ipak(requiredPackages)

### Shiny Dashboard

dashboardPage(
  dashboardHeader(title="Where to Eat in Austin, Texas", titleWidth = 700,
  tags$li(class="dropdown",tags$a(href="https://github.com/DasSunandaUTSA/RShinyapp.git", icon("github"), "Source Code"))),
  dashboardSidebar(
    sidebarMenu(id = "sidebar",
                menuItem("Webdata", tabName = "data", icon = icon("database")),
                menuItem("Visualization", tabName = "viz", icon=icon("chart-line")),
                  conditionalPanel("input.sidebar == 'viz' && input.t2 == 'ov'", selectInput(inputId = "var1" , label ="Select the Variable" , choices = c1, selected = "Rating")),
                  conditionalPanel("input.sidebar == 'viz' && input.t2 == 'rr' ", selectInput(inputId = "var2" , label ="Select the Price Range" , choices = c2, selected = "under $10"))
                )),

  dashboardBody(
    tabItems(
      #first tab item
      tabItem(tabName = "data",
              #tab box
              tabBox(id="t1", width = 30,
                     tabPanel("Background",icon = icon("yelp"),
                              fluidRow(
                                column(width = 5, tags$img(src="image.jpg", width =600 , height = 300),
                                       tags$br() , 
                                       tags$b("WEBSITE link : https://www.yelp.com/search?find_desc=Restaurants&find_loc=Austin%2C+TX"),
                                       align = "center"),
                                column(width = 4, tags$br() ,
                                       tags$button("Starting on Yelp main page, I collected all the URLs of restaurants associated with major 6 cuisines. The URL's included information about the restaurants. This information was collected from the main page of each cuisine.

                                                   Scraped every restaurant for 6 popular cuisines and Collected Data for a total 2203 restaurants.")
                                ))),
                     tabPanel(title="Data",icon = icon("table"), dataTableOutput("dataT"))
                     
                     )
              ),
      #second tab item
      tabItem(tabName = "viz",
              tabBox(id="t2",width=30,
                     tabPanel(title="Overall", icon= icon("chart-line"),value="ov",
                              withSpinner(plotlyOutput("plot"))),
                     tabPanel("Where is the best place to eat", icon=icon("star"), value="rr",
                              radioButtons(inputId ="var1" , label = "Select the option" , choices = c1, selected = "Rating"),
                              withSpinner(plotlyOutput("box"))),
                     
                     ))
) ))





