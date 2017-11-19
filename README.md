# McKinsey-Analytics-Hackathon

### Result
Leaderboard rank: 48 <br>
Evaluation metric(RMSE) = 8.035319

### Problem Statement

###### Mission
You are working with the government to transform your city into a smart city. The vision is to convert it into a digital and intelligent city to improve the efficiency of services for the citizens. One of the problems faced by the government is traffic. You are a data scientist working to manage the traffic of the city better and to provide input on infrastructure planning for the future.
 
The government wants to implement a robust traffic system for the city by being prepared for traffic peaks. They want to understand the traffic patterns of the four junctions of the city. Traffic patterns on holidays, as well as on various other occasions during the year, differ from normal working days. This is important to take into account for your forecasting.
 
###### Task
To predict traffic patterns in each of these four junctions for the next 4 months.

### About my approach
##### Language used: R <br>
##### Architecture of Code
Data preparation and Feature extraction [Code](https://github.com/sm86/McKinsey-Analytics-Hackathon/blob/master/DataPreparation.R)<br>
I have used XGBoost model based on few parameters here [Code](https://github.com/sm86/McKinsey-Analytics-Hackathon/blob/master/XGBoostModel.R)<br>
Then I tried creating seperate model for each junction and took average over all the models [Code](https://github.com/sm86/McKinsey-Analytics-Hackathon/blob/master/Models.R)

##### Can be worked on
* ARIMA time series models
* Feature of public holiday detection 
* Season feature 
* Prophet R package
* Average over more models as it helps in stablizing model during prediction on unseen data.


The hackathon is hosted on Analytics Vidya platform on Nov 18-19, 2017. [Link to hackathon](https://datahack.analyticsvidhya.com/contest/mckinsey-analytics-hackathon/)
