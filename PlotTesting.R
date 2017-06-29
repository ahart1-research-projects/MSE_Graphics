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

