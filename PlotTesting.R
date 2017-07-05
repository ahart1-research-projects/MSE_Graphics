# This is me testing different types of plots

##### boxplot #####
# Arguments
xlab = Label
ReferenceValue

# Actual plot
boxplot(formula=(Data[,i]~as.factor(CatchCeiling)), data=Data, ylab=paste(PerformMet[i],sep=""), xlab=Label, cex.lab=1.5, cex.axis=1.5, boxwex=0.75)
abline(h=ReferenceValue)


# ?????? I want to add horizontal threshold lines
# ????? figure out plot, pictogram plot
# look at other code to plot timeseries
# make sure that values can be printed below plot (in margin space below labels)

pictogram(data=vector counts with names,
          size.gap= fraction of column height is gap fraction=icon.height/size.gap,
          dtree=primary icon.png, (must be cropped to edges)
          ctree=secondary icon.pnd,
          aspect=width/height of icon,
          ypos=positions the ylabel vertically[0,1] default is highest column)

radarPlot() =web diagram with confidence intervals
https://github.com/kwiter/R-Plots

CatchData <- c(1000,2000,1500,1000,3000)
dtree <- "TestFish.png"
aspect <-1/1
size.gap<-1/1

#####



#       if(i %% 2 != 0){icon = dtree}else{icon = ctree}
#       rasterImage(image=icon,xleft=xs[1]+xshift*(i-1),xright=xs[2]+xshift*(i-1),ybottom=ys[1]+yshift*(j-1),ytop=ys[2]+yshift*(j-1)) # single pack 
#     }


# pictogram(data=CatchData, size.gap=size.gap, dtree = dtree, aspect=aspect)
# 
# #example Data
# data = c(3300,11000,19900,15600,33000,2222,4345,23123)
# names(data)= c('Red Oak','White Oak','Tulip Poplar','Red Maple','Sugar Maple','Ironwood','Beech','Cedar')
# 
# pictogram <- function(data,size.gap = 3, dtree, ctree = NULL,aspect = .7,Main.Title = '',xTitle = '', yTitle='',ypos=NA,Unit.Name = ''){ #plot a pictogram
#   #data: vector of counts with names
#   #size.gap: fraction of column height is gap fraction = icon.height/size.gap, 
#   #dtree: primary icon.png 
#   #ctree: secondary icon.pnd
#   #aspect:width/height of icon
#   #ypos: positions the ylabel vertically [0,1] default is the highest column
#   #make sure icon is croped to the edges
#   
#   require(png)  
#   ndata = length(data)
#   height = 1/ndata 
#   gap = height / size.gap
#   height = height - gap
#   width = aspect*height
#   
#   xs = c(0,width)
#   ys = c(0,height)
#   xshift = width
#   yaxe = seq(height/2,1,by = height+gap)[1:ndata]
#   yshift = height + gap
#   
#   num = floor(1/xshift)
#   size = ceiling(max(data)/num)
#   ns = data/size
#   Title = Main.Title
#   xTit = yTitle
#   yTit = xTitle
#   
#   par(mar=c(3, 4, 3, 2), oma=c(0,0,0,0), bg="#F0F0F0", xpd=FALSE, xaxs="r", yaxs="i", mgp=c(2.1,.3,0), las=1, col.axis="#434343", col.main="#343434", tck=0, lend=1)
#   plot(0,0,xlim=c(0,1),ylim=c(0,1),type='n',xaxt='n',yaxt='n',bty='n',las=1,main=Title, xlab=bquote(bold(.(xTit))), ylab=bquote(bold(.(yTit))), family="Helvetica", cex.main=1.5, cex.axis=0.8, cex.lab=0.8)
#   
#   if(is.null(ctree))ctree = dtree
#   for(j in 1:length(data)){ # for each piece of data
#     for(i in 1:ceiling(ns[j])){ # for each number from 1 to rounded value of ns
#       if(i %% 2 != 0){icon = dtree}else{icon = ctree} # if remainder when divided by 2 is not equal to zero (i is an odd number) use dtree icon
#       rasterImage(image=icon,xleft=xs[1]+xshift*(i-1),xright=xs[2]+xshift*(i-1),ybottom=ys[1]+yshift*(j-1),ytop=ys[2]+yshift*(j-1)) # single pack 
#     }
#     rect(col = "#F0F0F0",border="#F0F0F0",
#          xleft=xs[1]+xshift*(i-1)+(ns[j]%%1)*diff(xs),xright=xs[2]+xshift*(i-1),ybottom=ys[1]+yshift*(j-1),ytop=ys[2]+yshift*(j-1))
#   }
#   grid(NULL, NULL, col="#DEDEDE", lty="solid", lwd=0.9)
#   axis(1,at = c(0,(max(ns)/2)*xshift,max(ns)*xshift),labels=c(0,floor(max(data)/2),max(data)), cex.axis=0.9)
#   axis(2,at =yaxe,labels=names(data),tick=F, cex.axis=0.9,line=-.4)
#   
#   if(is.na(ypos))ypos = ys[1]+yshift*(j-1)
#   icon = dtree
#   zoom = 0.9
#   a = strwidth('Each ', cex = zoom)
#   b = strwidth(paste(' equals',size,Unit.Name), cex = zoom)
#   xpos = 1-a-b - width
#   rasterImage(image=icon,xleft=xpos,xright=xpos+width,ybottom=ypos,ytop=ypos+height)
#   text(xpos,ypos+height/2,labels = 'Each ',adj=c(1,0.5))
#   text(xpos+width,ypos+height/2,labels = paste(' equals',size,Unit.Name),adj=c(0,.5))
#   
# }

library(grid)


# More data to test plots

rasterImage(image=icon,xleft=xs[1]+xshift*(i-1),xright=xs[2]+xshift*(i-1),ybottom=ys[1]+yshift*(j-1),ytop=ys[2]+yshift*(j-1)) # single pack 

CroppedFishImage <- crop(RasterFishImage,0,100,0,0)
plotRGB(RasterFishImage)
TestFishImage <- readPNG("TestFish.png")
dim(TestFishImage)
RasterFish <- as.raster(TestFishImage) #No
RasterFish2 <- raster(RasterFish) # No
#RasterFishImage <- as.raster(TestFishImage)
#RasterFishImage <- rasterImage(TestFishImage, 1,1,1,1)
crop(RasterFish, 0,50,0,0) # still gives error
#library(fields)
#crop.image(TestFishImage, from=1)

StartFishRaster <- rasterImage(TestFishImage, xleft=0,ybottom=0,xright=1,ytop=1) # start reference
ScaledFishRaster <- rasterImage(TestFishImage, xleft=0.5,ybottom=0.5,xright=1,ytop=1) # makes smaller

TryScaledFishRaster <- rasterImage(TestFishImage, xleft=0.5,ybottom=0.5,xright=1,ytop=1)

TestFishAgain <- image_read("TestFish.png") # ????
Try <- image_crop(TestFishAgain, geometry="10x10+5-5") # ????
plot(Try) # ????
image_chop() # lets you move file

###############################################################################
# image_crop(TestFishAgain, geometry="FullLengthCanBeScaledXHeight")
image_crop(TestFishAgain, geometry="227x203")
image_crop(TestFishAgain, geometry="113x203") #227/2=113

###
CountData/1000
CountData/10000
CountData/100000

# %% gives Remainder
# %/% gives Quotient 6%/%4 = 1
# 6%%4=2
#if(SomeNumber %% 2 !=0){}
###
CountData <- 10550

##### Code should do what I want #####
library(gridExtra)
Icon <- image_read("TestFish.png")
IconDimensions <- image_info(Icon)
IconWidth <- IconDimensions["width"]
IconHeight<- IconDimensions["height"]
if(CountData %% 10000 =0){ # if CountData/10000 has a remainder of zero then
  # plot using IconWidth and IconHeight CountData %/% 10000 times 
  CountData%/%10000
} else if(CountData %% 10000 !=0){ # if CountData/10000 has a remainder other than zero
  # plot using IconWidth and IconHeight CountData %/% 10000 times 
  CountData%/%10000
  # and plot once with IconWidth *(CountData %% 10000/10000) and IconHeight
  CroppedIconWidth <- IconWidth * CountData %% 10000 /10000
  CroppedIconHeight <- IconHeight 
  CroppedIcon <- image_crop(Icon, geometry= paste(CroppedIconWidth, "x", CroppedIconHeight, sep="")) # to see image, type CroppedIcon below
  # plot(as.raster(CroppedIcon))
  #rasterImage(Icon, 1,0,20,20), plotting as a raster should work but i don't know how to set position
  # grid.raster(Icon)
  # grid.raster(CroppedIcon)
  # image_append(image_scale(Icon,"x100")) # append may add new image next to old, not sure
  # image_append(image_scale(CroppedIcon,"x100"))
  # image_append(Icon)

  par(mfrow=c(3,3), mar=c(1,1,1,1))
  plot(Icon)
  plot(CroppedIcon) # why is this not small like the other two?
  plot(Icon)
  # 
  # par(mfrow=c(2,3), mar=c(1,1,1,1))
  # plot(CroppedIcon)
  # plot(Icon)
  
  # try exporting then importing
  

  # TryIcon <- rasterGrob(Icon)
  # TryCroppedIcon <- rasterGrob(CroppedIcon)
  # grid.arrange(TryIcon, TryCroppedIcon, TryIcon, TryCroppedIcon, ncol=2,nrow=2)# This also could work if not coerced weird, cropped is blown up (granier image but same number of pixels tall)
  library(rasterVis) # may be good for spatial data and time series
  
  #   eval(parse(text=paste(rep("TryIcon",3),sep=",")) ) almost works, only plots 1
  # as.symbol(paste(rep("TryIcon",3),sep=","))  # problem since it doesnt comma separate list 
  #   
  # assign("FinalIcon", rasterGrob(Icon))
  # assign("FinalCroppedIcon", rasterGrob(CroppedIcon))
  # grid.arrange(rep(FinalIcon,3),ncol=2, nrow=1) # problem not comma separated
  # 
  # as.character(rep(FinalIcon,3))
  # 
  # StringName<-as.character(TryIcon)
  # 
  # TryStringName <- paste(StringName, ",", sep="")
  # NewNames <- rep(TryStringName, 4)
  # eval(parse(text=NewNames))


# NewNames <- rep("TryIcon",4)
# do.call("print", list(as.name(NewNames)))
# get(paste("TryIcon",no,sep=""))
# rep("TryIcon,",4)
  
  #grid.arrange(TryIcon, TryCroppedIcon, ncol=2,nrow=2)# This also could work if not coerced weird, cropped is blown up (granier image but same number of pixels tall)
  #library(rasterVis) # may be good for spatial data and time series
  
}

# https://cran.r-project.org/web/packages/magick/vignettes/intro.html

