# This script makes visually appealing tables (in reality it is a multi-panel plot not a table)


GraphicLayout <- c(  1,  1,  1,  1,  2,  3,  4,  5,  6,  7,
                     8,  8,  8,  8,  8,  8,  8,  8,  8,  8,
                     9, 10, 10, 10, 10, 10, 10, 10, 10, 10,
                     9, 11, 11, 11, 11, 11, 11, 11, 11, 11,
                     9, 12, 13, 14, 15, 16, 17, 18, 19, 20,
                    21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
                    22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
                    32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
                    33, 34, 35, 36, 37, 38, 39, 40, 41, 42,
                    43, 43, 43, 43, 43, 43, 43, 43, 43, 43,
                    44, 45, 46, 47, 48, 49, 50, 51, 52, 53,
                    54, 54, 54, 54, 54, 54, 54, 54, 54, 54,
                    55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
                    65, 65, 65, 65, 65, 65, 65, 65, 65, 65,
                    66, 67, 68, 69, 70, 71, 72, 73, 74, 75,
                    76, 76, 76, 76, 76, 76, 76, 76, 76, 76,
                    77, 78, 79, 80, 81, 82, 83, 84, 85, 86,
                    87, 87, 87, 87, 87, 87, 87, 87, 87, 87,
                    88, 89, 90, 91, 92, 93, 94, 95, 96, 97,
                    98, 98, 98, 98, 98, 98, 98, 98, 98, 98,
                    99,100,101,102,103,104,105,106,107,108,
                    109,109,109,109,109,109,109,109,109,109)
GraphicWidths <- c(2,1,1,1,1,1,1,1,1,1)
GraphicHeights <- c(1,0.25,1,0.25,1,0.25,1,0.25,1,0.25,1,0.25,1,0.25,1,0.25,1,0.25,1,0.25,1,0.25)
GraphicFormat <- layout(matrix(GraphicLayout, nrow = 22, ncol = 10, byrow = TRUE), widths = GraphicWidths, heights = GraphicHeights)
layout.show(GraphicFormat)

# 8 and 109 should be thick lines (code below)
abline(h=0.5, col="red", lwd=2)

# 11,21,32,43,54,65,76,87,98,109 should be thin lines (code below)
abline(h=0.5, col="red", lwd=1)

# Add text
text("Test Text", cex=2) # doesn't work
text<-paste("Test Text")
grid.arrange(text)

