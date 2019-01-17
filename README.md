# Ruby on Rails on Docker on Linux on Azure

A new Ruby on Rails application, developed locally in a Docker Container using docker-compose, and continuously deployed using Azure Pipelines to Azure Web App for Containers.

## Application Hosting

We are using an Azure WebApp for containers to host this application

## Logging and Anayltics

Our goal with logging and analytics is to have a unified platform providing a singple pane of glass for monitoring our application.  Within Azure
the Azure Monitor provides a single place to pull data from Application Insights as well as Azure Log Analytics.

####Application Insights
We are leveraging the `application_insights`s Gem along with configuring a piece of Rack Middleware that it provides to capture all HTTP requests and stream the data back to Application Insights.

``` Gemfile
gem 'application_insights', '~> 0.5.6'
```


``` application.rb
config.middleware.use ApplicationInsights::Rack::TrackRequest, 'a056a552-5c5a-42e5-bf48-121a6432fae3', 1
```

#### Log Analytics
To accomplish logging within Azure Web App 

## Contact
For further information you can reach me at the following:
 - joseph.lorich@microsoft.com
 - https://linkedin.com/in/jlorich/
