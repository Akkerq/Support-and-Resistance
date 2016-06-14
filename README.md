# Differential equation that models the support and resistance strategy

See http://www.tulipquant.com/2016/06/14/differential-equation-that-models-the-support-and-resistance-strategy/ for a full description of the strategy.

This strategy uses a model of the support and resistance strategy, based on the following Differential Equation:

S'(t)=Gamma_t min (|S'(t-s)|^alpha + |S(t-s)-S(t)|^beta)

Where S(t) stands for the stock price, and Gamma_t, alpha, beta are constants. The differential equation was solved numerically, and then implemented in R. When applied to the S&P 500 index from 1950 to 2016, the cumulative returns when compared to the buy-and-hold strategy are shown in the following chart:

![alt text](https://raw.githubusercontent.com/bolorsociedad/Support-and-Resistance/master/returns.png "Returns of the strategy when compared to the Buy & Hold strategy")

As we see, the strategy’s performance was very similar in the 1950-1970 period; from 1970-1995, it outperformed the buy-and-hold strategy, but from 1995 to 2016 it actually underperformed.
