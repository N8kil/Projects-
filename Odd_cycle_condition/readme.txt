# Odd Cycle Condition in Graphs using Reinforcement Learning

## 📌 Overview
This project explores **graph generation under the Odd Cycle Condition (OCC)** using **Reinforcement Learning (RL)**.  
The OCC states that in any connected component, **any two odd cycles without common vertices must be linked by at least one edge**.  

We model this as an RL problem:
- **State:** Graph adjacency matrix  
- **Action:** Add/remove edges  
- **Reward:** Positive for forming odd cycles, negative for invalid/self-loop edges  
- **Algorithm:** PPO (Proximal Policy Optimization)  

---

## ⚙️ Methodology
1. **Custom Gym Environment**
   - Implemented in `odd_cycle_env.py`
   - Handles graph initialization, edge updates, and reward shaping
2. **Training**
   - PPO agent trained with Stable-Baselines3
   - Rewards shaped to encourage valid odd cycles while avoiding isolated vertices
3. **Evaluation**
   - Odd cycles detected using `networkx.cycle_basis`
   - Graphs visualized with **NetworkX + Matplotlib**

---

## 📊 Results

The agent successfully generates graphs that satisfy the **Odd Cycle Condition**.  
Odd cycles are highlighted in **red**, and their lengths are shown explicitly.

![Final Graph](results/final_graph.png)

Example:  
- **Number of odd cycles:** 4  
- **Lengths of odd cycles:** [3, 3, 5, 3]  
- **Graph density:** ~0.44  

---

## 📈 Connectivity vs Vertices
We also studied the relationship between the **number of vertices** and the **ratio of odd cycles**.

![Connectivity Plot](results/intermediate_graphs/connectivity_plot.png)

---

## 📂 Repository Structure
- `src/` → environment, training, evaluation scripts  
- `notebooks/` → Jupyter notebook with experiments  
- `reports/` → project reports & presentation  
- `results/` → saved graphs and plots  

---

## 🚀 How to Run
```bash
# Install dependencies
pip install -r requirements.txt

# Train PPO agent
python src/train.py

# Evaluate trained model
python src/evaluate.py
