import re


output = """
occurs(object(robot,1),move(-1,0),1) 
occurs(object(robot,2),move(-1,0),1)
occurs(object(robot,1),move(-1,0),2)
occurs(object(robot,2),pickup,2)
occurs(object(robot,2),move(0,1),3)
occurs(object(robot,1),pickup,4)
occurs(object(robot,2),deliver(1,3,4),4)
occurs(object(robot,1),move(-1,0),5)
occurs(object(robot,2),move(0,-1),5)
occurs(object(robot,1),deliver(1,1,1),6)
occurs(object(robot,2),putdown,6)
occurs(object(robot,1),putdown,7)
occurs(object(robot,2),move(1,0),7)
occurs(object(robot,1),move(1,0),8)
occurs(object(robot,2),move(1,0),8)
occurs(object(robot,1),move(0,-1),9)
occurs(object(robot,2),pickup,9)
occurs(object(robot,1),pickup,10)
occurs(object(robot,2),move(0,-1),10)
occurs(object(robot,1),move(1,0),11)
occurs(object(robot,2),deliver(3,4,1),11)
occurs(object(robot,1),move(0,-1),12)
occurs(object(robot,2),move(1,0),12)
occurs(object(robot,1),deliver(2,2,1),13)
"""

action_list = output.split()
organized_actions = {}
for action_string in action_list:
    action_string = action_string + ';'
    timestep = re.search('\d*(?=\)\;)',action_string).group(0)
    robot_id = re.search('\d*(?=\)\,)',action_string).group(0)
    action = re.search('(?<=\)\,)\w\w',action_string).group(0)
    print(robot_id, timestep, action)
