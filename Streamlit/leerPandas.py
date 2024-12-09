import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("dataset/traj_UNI_CORR_500_01.txt", 
                 skiprows=4, 
                 sep="\t", 
                 names=["ID", "frames", "X", "Y", "Z"])

print(df.head())

plt.hist(df["X"], bins=40)
plt.show()