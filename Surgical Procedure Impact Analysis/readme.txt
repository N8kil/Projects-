# 🏥 Surgical Procedure Impact Analysis

## 📌 Overview
This project investigates whether **new surgical procedures reduce hospital stay length** compared to traditional methods.  
We used **paired t-test** on matched case-control data of 30 patients to evaluate the effectiveness.

---

## 📂 Project Structure
- `data/` → Contains the dataset (*Surgery_20590303.csv*).  
- `notebooks/` → R script with hypothesis testing and visualizations.  
- `report/` → PDF report with detailed findings.  
- `README.md` → Documentation.  

---

## ⚙️ Methods
- **Exploratory Data Analysis**: Summary stats, boxplots, scatterplots.  
- **Statistical Test**: Paired t-test comparing *Current Surgery* vs *New Surgery*.  
- **Confidence Interval**: 95% CI for mean difference.  

---

## 📊 Results
- Mean hospital stay reduction = **0.81 days**.  
- t-statistic = **6.04**, p-value = **1.42e-06**.  
- Conclusion: The new surgical procedure **significantly reduces** hospital stay (rejecting H0 at α=0.05).  



