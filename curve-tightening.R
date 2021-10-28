library(pracma)
library(tikzDevice)

# upper bounds:
# 1500

expo1500 <- read.csv(file="gamma-1500-expo-plot.csv")
lin1500 <- read.csv(file="gamma-1500-linear-plot.csv")
ra1500 <- rationalfit(expo1500$gamma, expo1500$ratio, 9, 9)
p1500_1 <- ra1500$p1
p1500_2 <- ra1500$p2
ys1500 <- polyval(p1500_1,expo1500$gamma) / polyval(p1500_2,expo1500$gamma)

# 1000
expo1000 <- read.csv(file="gamma-1000-expo-plot.csv")
lin1000 <- read.csv(file="gamma-1000-linear-plot.csv")
ra1000 <- rationalfit(expo1000$gamma, expo1000$ratio, 9, 9)
p1000_1 <- ra1000$p1
p1000_2 <- ra1000$p2
ys1000 <- polyval(p1000_1,expo1000$gamma) / polyval(p1000_2,expo1000$gamma)

# 500
expo500 <- read.csv(file="gamma-500-expo-plot.csv")
lin500 <- read.csv(file="gamma-500-linear-plot.csv")
ra500 <- rationalfit(expo500$gamma, expo500$ratio, 9, 9)
p500_1 <- ra500$p1
p500_2 <- ra500$p2
ys500 <- polyval(p500_1,expo500$gamma) / polyval(p500_2,expo500$gamma)

# 100

expo100 <- read.csv(file="gamma-100-expo-plot.csv")
lin100 <- read.csv(file="gamma-100-linear-plot.csv")
ra100 <- rationalfit(expo100$gamma, expo100$ratio, 9, 9)
p100_1 <- ra100$p1
p100_2 <- ra100$p2
ys100 <- polyval(p100_1,expo100$gamma) / polyval(p100_2,expo100$gamma)

# lower bounds

# 1500
lb1500 <- read.csv(file="lb-1500-expo-plot.csv")
lbra1500 <- rationalfit(lb1500$gamma, lb1500$ratio, 12, 12)
lbp1500_1 <- lbra1500$p1
lbp1500_2 <- lbra1500$p2
lbys1500 <- polyval(lbp1500_1,lb1500$gamma) / polyval(lbp1500_2,lb1500$gamma)

# 1000
lb1000 <- read.csv(file="lb-1000-expo-plot.csv")
lbra1000 <- rationalfit(lb1000$gamma, lb1000$ratio, 10, 10)
lbp1000_1 <- lbra1000$p1
lbp1000_2 <- lbra1000$p2
lbys1000 <- polyval(lbp1000_1,lb1000$gamma) / polyval(lbp1000_2,lb1000$gamma)


# 500
lb500 <- read.csv(file="lb-500-expo-plot.csv")
lbra500 <- rationalfit(lb500$gamma, lb500$ratio, 10, 10)
lbp500_1 <- lbra500$p1
lbp500_2 <- lbra500$p2
lbys500 <- polyval(lbp500_1,lb500$gamma) / polyval(lbp500_2,lb500$gamma)

# 100

lb100 <- read.csv(file="lb-100-expo-plot.csv")
lbra100 <- rationalfit(lb100$gamma, lb100$ratio, 10, 10)
lbp100_1 <- lbra100$p1
lbp100_2 <- lbra100$p2
lbys100 <- polyval(lbp100_1,lb100$gamma) / polyval(lbp100_2,lb100$gamma)

# pdf(file="curve-tightening.pdf", width=16, height=6)
tikz(file = "curve-tightening2.tex", width=8, height=3, standAlone=TRUE)

# par(mar = c(4, 4, 0.3, 0.3))        # Reduce space around plots
par(mar = c(2.1, 3.0, 0.3, 0.3))        # Reduce space around plots

plot(expo1500$gamma,expo1500$ratio, xlim=c(2,3.2), ylim=c(3.8,4), xlab="gamma", ylab="ratio", las=1, xaxt="n", yaxt="n", col="deepskyblue4", pch=20)

axis(1,at=c(2.0, 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8, 2.868,2.9,3, 3.1),labels=
     c(2, 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8, 2.868, 2.9, 3, 3.1))
axis(2, at=c(4,3.9,3.869,3.861,3.817), labels=c(4,3.9,3.869,3.861,3.817), las=1)

# two gray lines for visualization
abline(h = 3.869, col="gray", lty="dashed")
abline(h = 3.861, col="gray", lty="dashed")
abline(1, 1, col="gray", lty="dashed")

# A label for 3.869
text(x=1.99, y=3.875, label="3.869")
text(x=2.845, y=3.805, label="x + 1")
# A label for y = x+1

# 1000
points(lin1000$gamma, lin1000$ratio, col="deepskyblue3",pch=20)
points(expo1000$gamma, expo1000$ratio, col="deepskyblue3",pch=20)
lines(expo1000$gamma, ys1000, col="deepskyblue3")

# 500
points(lin500$gamma, lin500$ratio, col="deepskyblue2", pch=20)
points(expo500$gamma, expo500$ratio, col="deepskyblue2", pch=20)
lines(expo500$gamma, ys500, col="deepskyblue2")

# 100
points(lin100$gamma, lin100$ratio, col="deepskyblue1",pch=20)
points(expo100$gamma, expo100$ratio, col="deepskyblue1",pch=20)
lines(expo100$gamma, ys100, col="deepskyblue1")

# 1500
points(lin1500$gamma, lin1500$ratio, col="deepskyblue4",pch=20)
lines(lin1500$gamma, lin1500$ratio, col="deepskyblue4")
lines(expo1500$gamma, ys1500, col="deepskyblue4")


# lower bounds drawing

# 1500
points(lb1500$gamma, lb1500$ratio, col="firebrick4", pch=18)
lines(lb1500$gamma, lbys1500, col="firebrick4",lty="dashed")


# 1000
points(lb1000$gamma, lb1000$ratio, col="firebrick3", pch=18)
lines(lb1000$gamma, lbys1000, col="firebrick3",lty="dashed")

# 500
points(lb500$gamma, lb500$ratio, col="firebrick2", pch=18)
lines(lb500$gamma, lbys500, col="firebrick2",lty="dashed")

# 100
points(lb100$gamma, lb100$ratio, col="firebrick1", pch=18)
lines(lb100$gamma, lbys100, col="firebrick1",lty="dashed")

dev.off()
