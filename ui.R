#### Load the required packages ####

requiredPackages <- c("shiny", "shinydashboard" ,"shinycssloaders","plotly","DT","plyr","ggplot2")

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
                  conditionalPanel("input.sidebar == 'viz' && input.t2 == 'ov' ", selectInput(inputId = "var1" , label ="Select the Variable" , choices = c("Rating", "Review"))),
                  conditionalPanel("input.sidebar == 'viz' && input.t2 == 'rr' ", selectInput(inputId = "var2" , label ="Select your choice of variable" , choices = c("Rating", "Review"), selected = "Review")),
                menuItem("Find your place", tabName = "find" , icon= icon("table")),
                conditionalPanel("input.sidebar == 'find' && input.t3 == 'fi' ", selectInput(inputId = "var4" , label ="Select your budget" , choices = c("under $10", "$11-$30","$31-$60","over $61" ))),
                conditionalPanel("input.sidebar == 'find' && input.t3 == 'fi' ", selectInput(inputId = "var5" , label ="Select the Cuisine" , choices = c("American","Asian","Indian","Italian","Mexican","Steakhouse"))
               
                ))),
  
   

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
              tabBox(id="t2", 
                     tabPanel(title="According to Cuisine", icon= icon("star"),value="ov",
                              withSpinner(plotlyOutput("plot"))),
                     tabPanel("According to Budget", icon=icon("chart-line"), 
                              plotlyOutput("box"),value="rr"), 
                     side = "left"
                     
                     ),
              ),
      
      #third tab item
      tabItem(tabName = "find",
              #tab box
              tabBox(id="t3", 
                    
                     tabPanel(title="Recommended Resturants", icon=icon("list-alt"), value= "fi",
                              dataTableOutput("dataTN"))
                     
              )
      )
) ))





