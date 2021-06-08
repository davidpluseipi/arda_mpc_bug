# Advanced Research Drying Apparatus
## This collection of files by David Meissner
## Copyright 2021, Forest Concepts, LLC

1. As of 6/3/21, most of the files are in a "in development" status.
1. In the `\simulation` folder, `arda_sim.mlx` includes the development of 
a plant model for the thermal elements of the aRDA and the tuning of a 
controller for that plant and other plants which may differ slightly from
the first. Dot-mat files with simulation results are saved within a
a subfolder of the `\simulation` folder.
1. In the `\fan` folder, there is `calculate_flow_fan.m` which takes in
a power in Watts and outputs the flow_rate (ACFM) and velocity (m/s) (3 in.
diameter duct) for the currently selected blower/fan. The part and model
number are available in the .xlsx file and in the structure variable 
saved within fan_data.mat. 
1. The work folder contains a few files of note, including
    1. `aldo.m`: A demonstration of the system identification to controller
        workflow.
    1. `humidity_ratio.mlx`: Contains a formula for calculating humidity
        ratio.
    1. `other_equations.mlx`: Contains a way to calculate relative 
        humidity using the Clausius-Claperyron formulation.
    1. `thermal.mlx`: A "custom" Euler-Solver which would allow for a
        numerical solution to the ODEs that specify the dynamics of the 
        aRDA.
1. In the main directory, there is a file `roman.mlx` which allows the user
to calculate the moisture lost by a biomass sample by measuring change in
humidity.

Please forward any questions related to this content to:
[dmeissner@forestconcepts.com](mailto:dmeissner@forestconcepts.com)