import re

init = """
init(object(node,1),value(at,pair(1,1))).
init(object(node,2),value(at,pair(2,1))).
init(object(node,3),value(at,pair(3,1))).
init(object(node,4),value(at,pair(4,1))).
init(object(node,5),value(at,pair(1,2))).
init(object(node,6),value(at,pair(2,2))).
init(object(node,7),value(at,pair(3,2))).
init(object(node,8),value(at,pair(4,2))).
init(object(node,9),value(at,pair(1,3))).
init(object(node,10),value(at,pair(2,3))).
init(object(node,11),value(at,pair(3,3))).
init(object(node,12),value(at,pair(4,3))).
init(object(node,13),value(at,pair(1,4))).
init(object(node,14),value(at,pair(2,4))).
init(object(node,15),value(at,pair(3,4))).
init(object(node,16),value(at,pair(4,4))).
init(object(highway,4),value(at,pair(4,1))).
init(object(highway,8),value(at,pair(4,2))).
init(object(highway,12),value(at,pair(4,3))).
init(object(highway,13),value(at,pair(1,4))).
init(object(highway,14),value(at,pair(2,4))).
init(object(highway,15),value(at,pair(3,4))).
init(object(highway,16),value(at,pair(4,4))).
init(object(pickingStation,1),value(at,pair(1,3))).
init(object(pickingStation,2),value(at,pair(3,1))).
init(object(robot,1),value(at,pair(4,3))).
init(object(robot,2),value(at,pair(2,2))).
init(object(shelf,1),value(at,pair(3,3))).
init(object(shelf,2),value(at,pair(2,1))).
init(object(shelf,3),value(at,pair(2,3))).
init(object(shelf,4),value(at,pair(2,2))).
init(object(shelf,5),value(at,pair(3,2))).
init(object(shelf,6),value(at,pair(1,2))).
init(object(product,1),value(on,pair(3,1))).
init(object(product,2),value(on,pair(4,1))).
init(object(product,3),value(on,pair(6,4))).
init(object(product,4),value(on,pair(5,1))).
init(object(product,4),value(on,pair(6,1))).
init(object(order,1),value(pickingStation,1)).
init(object(order,1),value(line,pair(1,1))).
init(object(order,1),value(line,pair(3,4))).
init(object(order,2),value(pickingStation,2)).
init(object(order,2),value(line,pair(2,1))).
init(object(order,3),value(pickingStation,2)).
init(object(order,3),value(line,pair(4,1))).
"""

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

##################################################
# Parse
##################################################
# output
action_list = output.split()
organized_actions = {}
for action_string in action_list:
    action_string = action_string + ';'
    timestep = re.search('\d*(?=\)\;)',action_string).group(0)
    robot_id = re.search('\d*(?=\)\,)',action_string).group(0)
    action = re.search('(?<=\)\,)\w\w',action_string).group(0)
    action_params = [x for x in re.findall('-?\d*',action_string) if x != ''][1:-1]
    if timestep not in organized_actions:
        organized_actions[timestep] = []
    organized_actions[timestep].append({
        'robot_id':robot_id,
        'action':action,
        'action_params':action_params
    })

# init


##################################################
# Visualize
##################################################