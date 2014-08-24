library(UsingR)
shinyServer(
   function(input, output) {
      k <- 4000 # number of samples
      k2 <- 20 # only k2 samples shown in dotplots
      Range.v <- c(-3.5,3.5) # fixed range in order to see impact of sample size
      # DistributionType <- reactive({input$DistributionType})
      obj <- reactive({n <- input$samplesize
         switch(input$DistributionType,
            "standard normal" = list(data=matrix(rnorm(n*k),n,k),Range=c(-3.5,3.5),m=0),
            "standard exponential" = list(data=matrix(rexp(n*k),n,k),Range=c(0,7),m=1),
             "uniform on (0,1)" = list(data=matrix(runif(n*k),n,k),Range=c(0,1),m=0.5)
         )
      })   
      output$DotPlot <- renderPlot({a
         Data <- obj()$data[,1:k2]
         Range.v <- obj()$Range
         Mean.v <- apply(Data,2,mean)
         stripchart(data.frame(Data), xlab = "Sample values", 
            ylab = "Sample Number", group.names = paste(1:k2), pch = 1, 
            cex.lab = 1.4, xlim=Range.v,
            main=paste("Only",k2,"samples are shown out of",k,"samples generated"))
         for (i in 1:k2) lines(Range.v + c(-0.001, 0.001), rep(i, 
                                                                  2), lty = 3)
         points(Mean.v,1:k2,pch = 18,cex=2.4,col="red")
      })
      output$newHist <- renderPlot({
         Mean.v <- apply(obj()$data,2,mean)
         hist(Mean.v, freq = F, xlim=obj()$Range,
              main=paste("Histogram of the sample means. The population mean is equal to",obj()$m),
              xlab="Means",  col="red", breaks=60)
         curve(dnorm(x, mean=mean(Mean.v), sd=sd(Mean.v)), n=301,
               col="darkblue", lwd=2, add=TRUE)
         box()
      })
   }
)