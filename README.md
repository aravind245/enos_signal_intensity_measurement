# eNOS Signal Intensity Measurement

## Overview
This repository contains a MATLAB-based pipeline for analyzing **eNOS (endothelial nitric oxide synthase) signal intensity** in fluorescence microscopy images. The script processes `.tif` images, identifies the largest segmented area in each image, and extracts its mean intensity for quantitative analysis.

## Features
✅ Batch processes multiple `.tif` images.  
🔍 Automatically segments the **largest** connected region.  
📊 Extracts **mean intensity** of the segmented area.  
📂 Saves results as a `.csv` file for easy data analysis.  
🖼 Displays images for inspection (optional).  

## Folder Structure

📁 enos_signal_intensity_measurement │── 📂 results/ # Output folder for extracted intensity results │── 📄 intensity_multiple_files.m # Main script for image analysis │── 📄 intensities.csv # Output file containing intensity measurements │── 📄 README.md # This documentation


## Dependencies
- **MATLAB**
- **Image Processing Toolbox**

## Installation & Usage
### Clone the Repository
```sh
git clone https://github.com/aravind245/enos_signal_intensity_measurement.git
cd enos_signal_intensity_measurement

Run the MATLAB Script
Open MATLAB.
Set the working directory to the repository folder.
Run:
matlab
intensity_multiple_files

Results will be saved in /results and exported as intensities.csv.

Expected Output
Filename	Max Area Intensity
image1.tif	123.45
image2.tif	110.23


Citation
A. Sivakumar. (2025). eNOS Signal Intensity Measurement [Software]. GitHub. 
https://github.com/aravind245/enos_signal_intensity_measurement
C
ontributors
Aravind Sivakumar - MATLAB Script Development
Future Improvements
🔲 Enhance segmentation for low-signal images.
📈 Add visualization of intensity distribution.
🤖 Automate batch processing across multiple folders.

License
This project is licensed under the MIT License. See LICENSE for details.

