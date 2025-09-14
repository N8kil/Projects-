# 🌸 Flower Segmentation using Deep Learning (Oxford Flower Dataset)

This project applies **deep learning methods** to perform **image segmentation** on the [Oxford Flower Dataset](https://www.robots.ox.ac.uk/~vgg/data/flowers/17/).  
It was developed as part of the University of Nottingham **Computer Vision Coursework (COMP3007/COMP4106, 2023-24).**

---

## 🚀 Project Overview
- Implemented **two segmentation approaches**:
  1. **Custom CNN built from scratch** (encoder–decoder style)
  2. **Pre-trained U-Net** (fine-tuned for flower segmentation)

- Input: 256×256 RGB flower images  
- Output: Segmented masks distinguishing **flower (1)** vs **background (3)**  
- Evaluated using **Accuracy, IoU, F1-score, Confusion Matrix**  

---

## 📊 Results

| Model            | Global Accuracy | Mean Accuracy | Mean IoU | Boundary F1 Score |
|------------------|-----------------|---------------|----------|--------------------|
| Pre-trained U-Net| **89.86%**      | 87.74%        | 79.18%   | 55.39%             |
| Custom CNN       | **95.67%**      | 95.35%        | 90.62%   | 83.86%             |

✅ Custom CNN achieved higher segmentation accuracy and better boundary detail compared to U-Net.

---

## 📂 Repository Structure
- `src/` – MATLAB implementations (`segmentationOwn.m`, `segmentationExist.m`)  
- `models/` – Trained networks (`segmentownnet.mat`, `segmentexistnet.mat`)  
- `report.pdf` – Final IEEE-style report  
- `results/` – Evaluation outputs (confusion matrices, IoU metrics, sample predictions)

---

## ⚙️ Setup & Usage
1. Clone this repo:
   ```bash
   git clone https://github.com/<your-username>/flower-segmentation-deep-learning.git
   cd flower-segmentation-deep-learning
