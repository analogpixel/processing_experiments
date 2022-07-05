#!/usr/bin/env python

from p5 import *
from itertools import accumulate

grid_size_x =20 
grid_size_y =20 
block_size=50
movement = {'d': [0,1], 'u': [0,-1], 'l': [-1,0], 'r': [1,0] }
key_move = {'w': 'u', 'a': 'l', 's': 'd', 'd': 'r'}
inv_dir = {'d': 'u', 'u': 'd', 'r': 'l', 'l': 'r' }
path = [[0,0]]


maze = [ [] for x in range(0, (grid_size_x * grid_size_y)) ]

clamp = lambda n, minn, maxn: max(min(maxn, n), minn)

def setup():
    size(grid_size_x*block_size, grid_size_y*block_size)


def neighbors(x,y):
    global maze
    n = []
    for _dir in ['u','d','l','r']:
        npt = [  clamp(x + movement[_dir][0], 0, grid_size_x-1   ), clamp(y + movement[_dir][1] , 0, grid_size_y-1) ]
        idx = npt[0] + (npt[1] * grid_size_x)
        if len(maze[idx]) == 0  and npt not in n and not npt == [x,y]:
            n.append([npt,_dir])
    return n

   
def solve(maze,path):

    while len(path) > 0:
        [x,y] = path[-1]
        n = neighbors(x,y)
        if n:
            path = path_move(path, n[0][1])
        else:
            path.pop()

def key_pressed():
    global path,maze

    k = str(key)
    if k in key_move:
        path = path_move( path, key_move[k])
    if k == 'p':
        solve(maze,path)

def path_move(path, _dir):
    global maze

    # get the current location we are at
    [cx,cy] = path[-1]

    # get the new x,y
    [nx,ny] = [  clamp(cx + movement[_dir][0], 0, grid_size_x-1   ), clamp(cy + movement[_dir][1] , 0, grid_size_y-1) ]

    # index in maze array
    idx = cx + (cy * grid_size_x)

    # the other side of the wall
    idx2 = nx + (ny * grid_size_x)

    # knock out the walls
    if not _dir in maze[idx]:
        maze[idx].append(_dir)
    if not inv_dir[_dir] in maze[idx2]:
        maze[idx2].append(inv_dir[_dir])

    # push the new location onto path
    path.append( [nx,ny] )

    return path


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

run(renderer="SkiaRenderer")
