# Assignment D4-V7: Search and Rescue – Victim Health and Treatment Constraints
The following assignment will look at how to plan actions for a robot to treat victims depending on the severity and diagnosis of their injury. After stabilizing the victim, the robot should then transport the victim from the location of the injury. Planning Domain Definition Language will be used to do create plans for this procedure. Initially, basic PDDL will be applied and then the task is expanded through the use of PDDL+. 

## Initializations
Certain parameters are set initially when trying to plan. 
The **locations** are:  
```text
Starting Location   (Initial position of robot)  
injury-site         (Initial position of victim)
hospital            (safe evacuation point to which the victim is transported)
```
The task is also separated for **two problems** with two different levels of injury with corresponding treatments:

```text
Mild Injury     - Minor Bleed  
Treatment       - Bandage 
Critical Injury - Major Bleed   
Treatment       - Tourniquet
```
Additionally, the task has been limited to **one** robot and **one** victim. 

## PDDL
When solving the task using the basic PDDL model the health of the victims are described by discrete levels. These span from:    
`critical` -> `serious` -> `moderate` -> `stable`   
The robot will reach the victim, diagnose them and treat them until the victim has progressed to the state `stable`. Only then can the robot transport the victim to the hospital. For the case of a mild injury this meant that the victim is initally in a state of `moderate` injury, whereas the critical injury implies a `critical` injury.

**RESULTS**  
After running the LAMA-FIRST planner on the mild injury the following plan was outputted:  
![pddl_mild](Plans/Pddl_Mild.png)
As the image depicts the robot uses 4 steps to get to the victim, diagnoze them, stabilize them and then transport them to the hospital.   

One can then look at the plan for the critical injury:
![pddl_critical](Plans/Pddl_Critical.png)
It becomes clear that a more severe injury requires more steps of stabilization. Here the process of getting the victim to the hospital requires 6 steps. 

Although the severity of the injury is large, the planner is able to find a solution which brings the victim safely to the hospital. However, this representation might not always be entirely realistic. This is when the expansion to PDDL+ can be helpful.

## PDDL +


## DISCUSSION

**LIMITATIONS**
diagnose is given directly in init
