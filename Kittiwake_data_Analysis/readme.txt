# 🐦 Kittiwake Data Analysis

## 📌 Overview
This project analyzes multiple datasets on **kittiwakes (a gull species)** to investigate population trends, subspecies differences, and environmental factors.  
It was carried out as part of the **MTHS4005 Coursework** at the University of Nottingham.

---

## 📂 Project Structure
- `data/` → All provided CSV datasets (observation, historical, measurement, location).  
- `notebooks/` → Scripts/notebooks for statistical analysis.  
- `report/` → Final coursework report.  
- `README.md` → Documentation.  

---

## ⚙️ Methods
1. **Observation Data**  
   - Exploratory analysis & visualization.  
   - Confidence interval (80%) for mean afternoon sightings.  

2. **Historical Data**  
   - Hypothesis test: decline independent of site?  
   - Prediction of breeding pairs at Site D in 2014.  

3. **Measurement Data**  
   - Visual summaries (weight, wingspan, culmen length).  
   - Independence tests (wingspan vs culmen length).  
   - Comparison of subspecies weights.  
   - Subspecies difference test.  

4. **Location Data**  
   - Linear regression models (raw + log-transformed).  
   - Model selection and covariate impact.  
   - Confidence interval (98%) for predictions.  

---

## 📊 Results
- Afternoon kittiwake sightings → mean CI constructed.  
- Significant decline in breeding pairs, partially site-dependent.  
- Red-legged vs Black-legged → measurable differences in weight and morphology.  
- Location factors such as **cliff height** and **sandeel concentration** strongly influenced breeding pair numbers.  

---

## 🚀 How to Run
1. Clone the repo:
   ```bash
   git clone https://github.com/<your-username>/Kittiwake-Data-Analysis.git
   cd Kittiwake-Data-Analysis
