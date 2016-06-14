library(quantmod)
library(timeSeries)


startDate="1950-01-01";

getSymbols("^GSPC", from=startDate);

GSPC=Cl(GSPC);
SP500=log(as.vector(GSPC));

T=30*6;

money<-c(1000); #Start with 1000$

for (i in (T+2):(length(GSPC)-1)) {
  gamma=1;
  alpha=1;
  beta=1;

  m=1E9;
  sgn=1;
  for (s in 2:(T-1)) {
    candidate=abs((-SP500[i-s+2]+8*SP500[i-s+1]-8*SP500[i-s-1]+SP500[i-s-2])/(12))^alpha + abs(SP500[i-s]-SP500[i])^beta;
    if (candidate<m) {
      m=candidate;
      sgn=sign(-SP500[i-s]+SP500[i]);
    }
  }
  
  nextDay=SP500[i]+gamma*m*sgn;
  margin=0;
  if (nextDay>SP500[i]*(1+margin) & SP500[i]*0.01>m) {
    money<-c(money, money[length(money)]*as.numeric(GSPC[i+1])/as.numeric(GSPC[i]));
    cat("Buy. Money:" , money[length(money)], "\n");
  }
  else if (nextDay<SP500[i]*(1-margin) & SP500[i]*0.01>m) {
  
    money<-c(money, money[length(money)]*as.numeric(GSPC[i])/as.numeric(GSPC[i+1]));
    cat("Sell. Money:" , money[length(money)], "\n");
  }
  else {
    money<-c(money, money[length(money)]);
    cat("Stay still.\n")
  }
  
}

money.zoo<-zoo(money, time(GSPC)[(T+2):(length(GSPC)-1)]);
sp500.zoo<-zoo(1000*GSPC[(T+2):(length(GSPC)-1)]/as.numeric(GSPC[T+2]), time(GSPC)[(T+2):(length(GSPC)-1)])
z<-as.zoo(cbind(money.zoo, sp500.zoo))
plot(x = z, ylab = "Cumulative Return", main = "Cumulative Returns", screens=1, col=c("red", "blue"))
legend(x = "topleft", legend = c("Strategy", "Buy & hold"), 
       lty = 1,col = c("red", "blue"))
