import numpy as np

bimonthly_days = np.arange(0, 35000060)
base_date = np.datetime64('2017-01-01')


#np_alphabet = np.array(alphabet, dtype="|S1")
for i in range(10):
    birth_date = base_date + np.random.choice(bimonthly_days)
    print(str(birth_date))