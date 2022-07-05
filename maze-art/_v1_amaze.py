#!/usr/bin/env python

from p5 import *
from itertools import accumulate

grid_size_x =10 
grid_size_y =5 
block_size=100
movement = {'d': [0,1], 'u': [0,-1], 'l': [-1,0], 'r': [1,0] }
key_move = {'w': 'u', 'a': 'l', 's': 'd', 'd': 'r'}
inv_dir = {'d': 'u', 'u': 'd', 'r': 'l', 'l': 'r' }
#path = ['d','r','r','d','r']
path = []
maze = [ [] for x in range(0, (grid_size_x * grid_size_y)) ]
current_location = [0,0]
maze_list = []

clamp = lambda n, minn, maxn: max(min(maxn, n), minn)

def move(p, _dir):
    global grid_size_x, grid_size_y
    return [  clamp(p[0] + movement[_dir][0], 0, grid_size_x-1   ), clamp(p[1] + movement[_dir][1] , 0, grid_size_y-1) ]

def neigbors(p):
    global maze
    n = []
    for d in ['u','d','l','r']:
        npt = move(p, d)
        if npt not in maze and npt not in n:
            n.append([npt,d])
    return n

def remove_wall(pt, _dir):
    global grid_size_x, grid_size_y,maze

    # index in maze array
    idx = pt[0] + pt[1] * grid_size_x
    pt2 = move( pt, _dir)

    # the other side of the wall
    idx2 = pt2[0] + pt2[1] * grid_size_x

    maze[idx].append(_dir)
    maze[idx2].append(inv_dir[_dir])

def path_move(_dir):
    global current_location
    print( current_location, _dir)
    remove_wall( current_location , _dir)
    current_location = move(current_location, _dir)

def solve(map_list):

    # list is empty, we are done
    if len(map_list) == 0:
        return
    # get the next item in the list and try to walk around it
    else:
        n = neighbors( map_list.pop() )

        if len(n) == 0:
            solve(map_list)
        else:
            map_list( [n[0]] + map_list )


def key_pressed():
    k = str(key)
    if k in key_move:
        path_move( key_move[k])

def setup():
    size(grid_size_x*block_size, grid_size_y*block_size)

    # this finds the final position
    # tt = [sum(z) for z in zip(* [ move([0,0], x) for x in path])]
    # the more functional way of doing the next for loop over path
    # tt = [[0,0]] + list(accumulate( [ move([0,0],x) for x in path ], lambda x,y: [x[0]+y[0], x[1]+y[1]] ) )
    
    x=0
    y=0
    for p in path:
        print(x,y,p)
        remove_wall([x,y], p)
        [x,y] = move([x,y], p)

    print(maze)
    # print( neigbors( [0,0]) )

def draw():
    background(255)
    stroke(0)
    stroke_weight(30)
    for x in range(0, grid_size_x):
        for y in range(0, grid_size_y):
            idx = x + y * grid_size_x
            push_matrix()
            translate(x*block_size, y*block_size)
            if not 'd' in maze[idx]:
                line(x, y+block_size, x+block_size, y+block_size)
            if not 'u' in maze[idx]:
                line(x, y, x+block_size, y)
            if not 'r' in maze[idx]:
                line(x+block_size, y, x+block_size, y+block_size)
            if not 'l' in maze[idx]:
                line(x, y, x, y+block_size)
            pop_matrix()
run()
