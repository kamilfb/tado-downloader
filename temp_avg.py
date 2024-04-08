import pandas as pd

df = pd.read_csv('parsed/zone1-weather.csv', usecols=[0,1,2], header=None, names=['startDatetime', 'endDateTime', 'value'])

avgs = df.groupby(pd.PeriodIndex(df['startDatetime'], freq="M"))['value'].mean()

print(avgs.to_string()) 