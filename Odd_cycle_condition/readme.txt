🔗 Odd Cycle Graph Generation using Reinforcement Learning
📌 Project Overview

This project focuses on generating graphs that satisfy the Odd Cycle Condition using Reinforcement Learning (RL). The odd cycle condition ensures that:

Within any connected component of the graph,

Any two odd cycles without common vertices must be connected by at least one edge.

The solution leverages Proximal Policy Optimization (PPO) and reinforcement learning frameworks to iteratively construct valid graphs.

🎯 Objectives

Formulate graph generation as a combinatorial optimization problem.

Use Reinforcement Learning to build graphs step by step.

Ensure generated graphs always satisfy odd cycle condition.

Evaluate performance on different graph sizes (number of vertices).

⚙️ Methodology
1. Graph Representation

Nodes = vertices

Actions = adding an edge between two vertices

State = current partial graph

Reward = positive if odd cycle condition satisfied, negative otherwise

2. RL Setup

Environment: Custom Gymnasium environment for graph generation

Algorithm: Proximal Policy Optimization (PPO)

Libraries: NetworkX, Gymnasium, Stable-Baselines3

3. Training Flow

Start with an empty graph (given number of vertices).

RL agent chooses edges to add.

At each step, validate odd cycle condition.

Agent receives reward based on validity.

Repeat until graph is complete.

🧪 Experiments & Results

Generated graphs with 5–20 vertices under PPO.

Verified odd cycle condition using NetworkX cycle detection.

Reward function tuned for faster convergence.

Visualization: Graph plots show connected odd cycles satisfying conditions.

📈 Key Learnings

Reward shaping was critical to enforce structural graph properties.

PPO provided stable training compared to vanilla policy gradient methods.

Small graphs converged quickly, while larger graphs needed more exploration.

🔧 Tech Stack

Python

NetworkX

Gymnasium (Custom RL environment)

Stable-Baselines3 (PPO)

Matplotlib
