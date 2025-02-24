# **Iceland Energy Transition Analysis**

## **Description**  
This repository contains a MATLAB-based analysis of Iceland's fuel consumption and its transition from fossil fuels to renewable electricity. The project uses real-world data to estimate electricity demand across transport sectors (cars, shipping, aviation) and compares different energy transition scenarios.

This study was conducted using data from the Icelandic Energy Authority (**Orkustofnun**) and other sources. The project includes calculations, visualizations, and scenario modeling to assess future energy needs.

## **Table of Contents**  
- [Installation](#installation)  
- [Usage](#usage)  
- [Features](#features)  
- [Project Structure](#project-structure)  
- [Data Sources](#data-sources)  
- [Results](#results)  

## **Installation**  

### **MATLAB Setup**  
1. Clone the repository:  
   ```bash
   git clone https://github.com/yourusername/Iceland-Energy-Transition.git
   cd Iceland-Energy-Transition
   ```
2. Ensure you have **MATLAB** installed.  
3. (If applicable) Download the required dataset (`OS-2019-T005-01.xlsx`).  
4. Run the main MATLAB script:  
   ```matlab
   run('Orkahop.m')
   ```

## **Usage**  
- The MATLAB script `Orkahop.m` reads energy consumption data, processes it, and generates bar charts comparing fossil fuel usage and required electricity demand for transition scenarios.  
- The program models multiple energy scenarios to evaluate the feasibility of an electricity-based transition in Iceland.  
- The generated bar charts are **automatically saved** in the `Images/` folder within the repository for further analysis.  

## **Features**  
- Reads real-world fuel consumption data.  
- Computes energy demands for different transport sectors.  
- Generates visual comparisons of fuel vs. electricity demand.  
- Saves graphs as image files in the `Images/` directory for reporting and analysis.  
- Supports multiple transition scenarios for sustainable energy planning.  

## **Project Structure**  
```
/Iceland-Energy-Transition
│── MATLAB/
│   │── Orkahop.m               # Main MATLAB script for energy analysis
│   │── Additional_Scripts.m    # Other MATLAB scripts
│
│── Data/
│   │── OS-2019-T005-01.xlsx    # Dataset (not included in repo, but required)
│
│── Images/
│   │── orkugraf1.png           # Saved graph for Scenario 1
│   │── orkugraf2.png           # Saved graph for Scenario 2
│   │── orkugraf3.png           # Saved graph for Scenario 3
│
│── README.md                   # Documentation
```

## **Data Sources**  
- **Orkustofnun (Icelandic Energy Authority):** [https://orkustofnun.is](https://orkustofnun.is)  
- **Statistics Iceland:** [https://hagstofa.is](https://hagstofa.is)  
- **Samgöngustofa (Icelandic Transport Authority):** [https://www.samgongustofa.is](https://www.samgongustofa.is)  

## **Results**  
This project produces bar charts comparing fuel consumption and electricity demand for different scenarios. The generated images are saved in the `Images/` directory for further use.

