library(shiny)
shinyUI(fluidPage(
   titlePanel("The Distribution of the Sample Mean"),
   fluidRow(
         h3("Background"),
         p("Students often struggle with understanding the concept of a sampling distribution of 
         a statistic such as the sample mean. Since a sample represents the population from which 
         it was drawn, we hope that the sample mean is close to the unknown population mean. 
         This helps in statistical inference, when we draw conclusions about the population mean 
         based on the sample mean. But how do we know how close the sample and population means 
         are to each other? One way to find out is to generate repeated samples from a given 
         population and observe how far the sample means get from the population mean. 
         This app shows us what happens when we randomly generate such samples."),
         h3("How to Use the App and Interpret Results"),
         p("In the side bar below on the left, one can select a population distribution and use the slider to 
           provide the size of the samples that will be generated. Each time you select those values, a new 
           data set is generated, where 4,000 samples of a given size are randomly drawn from the specified 
           distribution. Only the first 20 sample are shown in the top chart below on the right, where each 
           horizontal line represents one sample with values marked by small circles. The mean of each sample 
           is plotted as a red diamond, so that we can observe how those means vary from sample to sample. 
           Note that variability of the means is smaller than that of the individual data points, and it gets 
           even smaller with increased sample size."),
         p("The plotted histogram shows the distribution of all 4,000 values of the sample means. 
           The histogram approximates the theoretical distribution of the sample mean. The more samples we 
           generate, the better approximation we get, and the 4,000 samples chosen here give us a pretty 
           good idea about the shape of the theoretical distribution."),
         p("A normal curve (density) is plotted in the histogram to see how well the distribution of 
           the sample mean can be approximated by the normal distribution. One can observe that the 
           normal approximation gets better for larger sample sizes. For a fixed sample size, precision 
           of the normal approximation depends on the shape of the original distribution.")
      ),
   sidebarLayout(
      sidebarPanel(
      #numericInput('samplesize', 'provide the sample size', 10, min = 2, max = 100, step = 5),
      #submitButton('Submit')
      # h4("Sampling Distribution of the Means"),
      selectInput("DistributionType", "Select the type of distribution:", 
                  choices = c("standard normal", "standard exponential", 
                        "uniform on (0,1)")),
      sliderInput('samplesize', 'Use the slider to provide the sample size', 
                  min = 2, max = 200,  value = 20)
      ),
      mainPanel(
         plotOutput('DotPlot'),
         plotOutput('newHist')
      )
   )
))