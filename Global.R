#read the restaurants data
urlfile<-'https://raw.githubusercontent.com/DasSunandaUTSA/RShinyapp/main/combined_restaurants.csv'
my_data <-read.csv(urlfile)

summary(my_data)

#choice for selectinput

c1 = names(my_data[,2:3]) 
c2 = names(table(my_data$price)) 
  
  
